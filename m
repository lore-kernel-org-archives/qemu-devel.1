Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E143C433E1
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771A420720
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771A420720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5Fr-0000XX-Lb
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5Ez-00077Z-J6
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:33 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5Ew-0008Ho-JH
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:33 -0400
Received: by mail-ed1-f47.google.com with SMTP id a8so31063264edy.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1Ywi05azxPp982YY6N8WoRO7ZO2lbhNadvg8OBE+oKI=;
 b=nkzuCOoPqqOfU4C1bqzrYGYOVnlk7jfSkPyVeSspFau8EIJotivTmKGERsW52sqKgc
 uQt2lF/co5NSP1jwIoyBia+q3imitfbpW0e67IYkxDMp/HFJS/t61lPA6Id9c4AGFyBB
 Y6dt8BvxciAXLarOD6NhPs7HGzGnQ8vXv/drwq8g1B4WU/5TuJyMzdOVnzQ+uKUTVH8U
 61l45xpkjRhf3j9F1A1ld9QC7FZc4WjlOO8QOwncb0HQIXTUReF12k1fWkGWn/uC8812
 UDvUGD2ttKFQOOItMYWt78ZpT2jhxQHrwpiB1381DP72GXCypjwpOztOhoTjQ+r8gD2v
 NrvA==
X-Gm-Message-State: AOAM530EPyayfv4xVkHbjJEbMImrrhpTYPwpUgl+0VG+wC6ExQWxVzO4
 ShLYzc80kroR3Nz+gU4hihnoEcG/
X-Google-Smtp-Source: ABdhPJxo4sHEGdXxTOapDBnmJIgyrLXj2GV84nwBfWcnvquzd3G8f40oYGmgOfYQF6NfjBl9BfFx6A==
X-Received: by 2002:a05:6402:1a42:: with SMTP id
 bf2mr43236372edb.292.1593957808917; 
 Sun, 05 Jul 2020 07:03:28 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:28 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 00/30] target/avr merger
Date: Sun,  5 Jul 2020 16:02:45 +0200
Message-Id: <20200705140315.260514-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.47; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f47.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the AVR port from Michael, release (merge) candidate 6.

I've rebased rc5 to the current master branch, fixed the conflicts,
and updated the APIs where necessary (e.g. qdev_create() had to be
replaced).

These patches have been on the list for a long time. Let's try to
get them finally merged.

You can also find the patches in my repo here:

 https://gitlab.com/huth/qemu/-/tree/avr

rc6:
- Rebased to master, fixed conflicts
- Changed the object_initialize_child() and qdev_create() calls
  where necessary
- Converted the texi doc to Sphinx
- Dropped the travis.yml patch - the acceptance CI is currently moved
  to gitlab, so we should add it later there instead
- Dropped the patch to clean up MAINTAINERs - and do it correctly
  right from the start instead.

Michael Rolnik (26):
  target/avr: Add basic parameters of the new platform
  target/avr: Introduce basic CPU class object
  target/avr: CPU class: Add interrupt handling support
  target/avr: CPU class: Add memory menagement support
  target/avr: CPU class: Add migration support
  target/avr: CPU class: Add GDB support
  target/avr: Introduce enumeration AVRFeature
  target/avr: Add defintions of AVR core types
  target/avr: Add instruction helpers
  target/avr: Add instruction translation - Register definitions
  target/avr: Add instruction translation - Arithmetic and Logic
    Instructions
  target/avr: Add instruction translation - Branch Instructions
  target/avr: Add instruction translation - Data Transfer Instructions
  target/avr: Add instruction translation - Bit and Bit-test
    Instructions
  target/avr: Add instruction translation - MCU Control Instructions
  target/avr: Add instruction translation - CPU main translation
    function
  target/avr: Initialize TCG register variables
  target/avr: Add support for disassembling via option '-d in_asm'
  hw/char: avr: Add limited support for USART peripheral
  hw/timer: avr: Add limited support for 16-bit timer peripheral
  hw/misc: avr: Add limited support for power reduction device
  target/avr: Register AVR support with the rest of QEMU
  target/avr: Update build system
  tests/machine-none: Add AVR support
  tests/boot-serial: Test some Arduino boards (AVR based)
  tests/acceptance: Test the Arduino MEGA2560 board

Philippe Mathieu-Daudé (3):
  hw/avr: Add support for loading ELF/raw binaries
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add limited support for some Arduino boards

Thomas Huth (1):
  target/avr: Add section into QEMU documentation

 MAINTAINERS                      |   30 +
 arch_init.c                      |    2 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 docs/system/target-avr.rst       |   37 +
 docs/system/targets.rst          |    1 +
 gdb-xml/avr-cpu.xml              |   49 +
 hw/Kconfig                       |    1 +
 hw/avr/Kconfig                   |    9 +
 hw/avr/Makefile.objs             |    3 +
 hw/avr/arduino.c                 |  149 ++
 hw/avr/atmega.c                  |  458 +++++
 hw/avr/atmega.h                  |   48 +
 hw/avr/boot.c                    |  116 ++
 hw/avr/boot.h                    |   33 +
 hw/char/Kconfig                  |    3 +
 hw/char/Makefile.objs            |    1 +
 hw/char/avr_usart.c              |  320 ++++
 hw/misc/Kconfig                  |    3 +
 hw/misc/Makefile.objs            |    2 +
 hw/misc/avr_power.c              |  113 ++
 hw/misc/trace-events             |    4 +
 hw/timer/Kconfig                 |    3 +
 hw/timer/Makefile.objs           |    2 +
 hw/timer/avr_timer16.c           |  609 ++++++
 hw/timer/trace-events            |   12 +
 include/disas/dis-asm.h          |   19 +
 include/elf.h                    |    4 +
 include/hw/char/avr_usart.h      |   93 +
 include/hw/misc/avr_power.h      |   46 +
 include/hw/timer/avr_timer16.h   |   94 +
 include/sysemu/arch_init.h       |    1 +
 qapi/machine.json                |    2 +-
 target/avr/Makefile.objs         |   34 +
 target/avr/cpu-param.h           |   37 +
 target/avr/cpu-qom.h             |   54 +
 target/avr/cpu.c                 |  777 ++++++++
 target/avr/cpu.h                 |  256 +++
 target/avr/disas.c               |  246 +++
 target/avr/gdbstub.c             |   84 +
 target/avr/helper.c              |  342 ++++
 target/avr/helper.h              |   29 +
 target/avr/insn.decode           |  187 ++
 target/avr/machine.c             |  121 ++
 target/avr/translate.c           | 3073 ++++++++++++++++++++++++++++++
 tests/acceptance/machine_avr6.py |   50 +
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/boot-serial-test.c   |   11 +
 tests/qtest/machine-none-test.c  |    1 +
 49 files changed, 7582 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 docs/system/target-avr.rst
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmega.c
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/boot.c
 create mode 100644 hw/avr/boot.h
 create mode 100644 hw/char/avr_usart.c
 create mode 100644 hw/misc/avr_power.c
 create mode 100644 hw/timer/avr_timer16.c
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 include/hw/misc/avr_power.h
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/disas.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/helper.h
 create mode 100644 target/avr/insn.decode
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate.c
 create mode 100644 tests/acceptance/machine_avr6.py

-- 
2.26.2


