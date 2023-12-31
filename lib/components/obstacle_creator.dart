import 'dart:math';

import 'package:flame/components.dart';
import 'package:pinball/components/falling_component.dart';
import 'package:pinball/constants/levels_data.dart';
import 'package:pinball/game.dart';

class ObstacleCreator extends TimerComponent with HasGameRef<PinballGame> {
  final Random random = Random();
  final LevelData levelData;
  int _obstacleIndex = 0;
  List<FallingComponent> addedComponents = [];

  ObstacleCreator({required this.levelData})
      : super(period: levelData.period, repeat: true) {
    //print('ObstacleCreator ${levelData.obstacles[0].isHit}');
  }

  @override
  void onTick() {
    if (!game.levelManager.isPaused) {
      if (_obstacleIndex < levelData.obstacles.length) {
        ObstacleData obstacleData = levelData.obstacles[_obstacleIndex];
        FallingComponent fallingComponent = FallingComponent(
          pos: obstacleData.pos,
          type: obstacleData.type,
          speed: levelData.speed,
          obstacleRef: obstacleData,
        );
        add(fallingComponent);
        addedComponents.add(fallingComponent);
        _obstacleIndex++;
      }
    }
  }

  void onGameOver() {
    for (FallingComponent component in addedComponents) {
      if (!component.isRemoved) {
        remove(component);
      }
    }
    //remove(this);
  }
}
