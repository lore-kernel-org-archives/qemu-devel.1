Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF241C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B413206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRBHEPdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B413206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssAh-0000Q1-IC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9e-0007FE-51
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9b-0002rG-Tr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id l17so103297wmj.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=30hwvcVTjxWR28SSoLeSTBeZ9ZqXCHegJB3hqs3TrJs=;
 b=mRBHEPdH+e3BxjJpLUpSCaHNV5/B45xIxeArbbYSZPpzCBU0Apw4MQkt38yTA73AHx
 JI7t8iLoqasrTY4JdvrcZJJtRKDjSMhrMA8/mEJoKkizLfmptBnvgUVdV8qiDrBSn/7L
 e0L9k3AknVa8jNNUGRlr9dZZQgHAmLnrBe6JkZP6vnMFc/uXzyXE9D3UahaX42uW7/VP
 IxhjgvcGeCfuXCROLz3NXGDtIL7wwWP2PS98m4qdOTb5Ywg8Ez1LGhGk6A1x41sitIrz
 cD5k8XxtdUQ4nR2UO9KKqhf0gwuLNazB7dcUkF3Y4D9col+Oa2AaccOUpIf/o2ZFeBJS
 1Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=30hwvcVTjxWR28SSoLeSTBeZ9ZqXCHegJB3hqs3TrJs=;
 b=FocPmpmCyd97e1eJAPsHrGmemE2E6Eue+/5M+de4YyCO2qN/NTeUMVaZX06JU4por7
 zHxe7DvVsMmSoBFFVDGaDXZ2kUoCrOjMUFe3L7lAiGZ4E4GEHai4px+H4LzaDGUdUJWw
 fK/lW9tmaIwYXoUpeHcz4FQlCQ1QqykkYnPdMkZrbdi5zonQ9FWoBFCNg+WnyntQQBCB
 9fZXtYgVRNasEp50fBufVHERaeUujUZt0bYYpvEajC2n6chg9BTAo58QQr2y5ifcpezM
 sLBBSUL6HJLAMtbgMPe7Q2z3ddQ4qkfLHtwgMWK0Jw5wSv32BAM2k6RbiKpBVY2R44ns
 36Kg==
X-Gm-Message-State: AOAM532ip5EtDDX/uOpr0ThtAHBwN8P0NqMep6cSsCtasGk6uXpQ2PJe
 0pk3Q/JKbcw0slJ4YlAsw/0U9hiO
X-Google-Smtp-Source: ABdhPJxyeodXXEP+sSEk162IvEsGARqMoTQo62tz9ZSG3tng5t0AVUO5flnrArGmMc6mPt0B/BFNhg==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr5675999wmh.77.1594145833376;
 Tue, 07 Jul 2020 11:17:13 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] AVR port
Date: Tue,  7 Jul 2020 20:16:38 +0200
Message-Id: <20200707181710.30950-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Possible false-positives from checkpatch:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-=
request' into staging (2020-07-06 11:40:10 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/avr-port-20200707

for you to fetch changes up to 0cdaf2f343491f60dbf7dd2a912cd88b5f9f899c:

  target/avr/disas: Fix store instructions display order (2020-07-07 20:14:15=
 +0200)

----------------------------------------------------------------
8bit AVR port from Michael Rolnik.

Michael started to work on the AVR port few years ago [*] and kept
improving the code over various series.

List of people who help him (in chronological order):
- Richard Henderson
- Sarah Harris and Edward Robbins
- Philippe Mathieu-Daud=C3=A9 and Aleksandar Markovic
- Pavel Dovgalyuk
- Thomas Huth

[*] The oldest contribution I could find on the list is from 2016:
https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg02985.html

Tests included:

$ avocado --show=3Dapp run -t arch:avr tests/acceptance/
Fetching asset from tests/acceptance/machine_avr6.py:AVR6Machine.test_freertos
 (1/1) tests/acceptance/machine_avr6.py:AVR6Machine.test_freertos: PASS (2.13=
 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANC=
EL 0
JOB TIME   : 2.35 s

$ make check-qtest-avr
  TEST    check-qtest-avr: tests/qtest/boot-serial-test
  TEST    check-qtest-avr: tests/qtest/cdrom-test
  TEST    check-qtest-avr: tests/qtest/device-introspect-test
  TEST    check-qtest-avr: tests/qtest/machine-none-test
  TEST    check-qtest-avr: tests/qtest/qmp-test
  TEST    check-qtest-avr: tests/qtest/qmp-cmd-test
  TEST    check-qtest-avr: tests/qtest/qom-test
  TEST    check-qtest-avr: tests/qtest/test-hmp
  TEST    check-qtest-avr: tests/qtest/qos-test

CI results:
. https://cirrus-ci.com/build/5697049146425344
. https://gitlab.com/philmd/qemu/-/pipelines/163985815
. https://travis-ci.org/github/philmd/qemu/builds/705817933
. https://app.shippable.com/github/philmd/qemu/runs/822/summary/console

----------------------------------------------------------------

Michael Rolnik (25):
  target/avr: Add basic parameters of the new platform
  target/avr: Introduce basic CPU class object
  target/avr: CPU class: Add interrupt handling support
  target/avr: CPU class: Add memory menagement support
  target/avr: CPU class: Add migration support
  target/avr: CPU class: Add GDB support
  target/avr: Introduce enumeration AVRFeature
  target/avr: Add definitions of AVR core types
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
  target/avr: Register AVR support with the rest of QEMU
  tests/machine-none: Add AVR support
  hw/char: avr: Add limited support for USART peripheral
  hw/timer: avr: Add limited support for 16-bit timer peripheral
  hw/misc: avr: Add limited support for power reduction device
  tests/boot-serial: Test some Arduino boards (AVR based)
  tests/acceptance: Test the Arduino MEGA2560 board

Philippe Mathieu-Daud=C3=A9 (6):
  hw/avr: Add support for loading ELF/raw binaries
  hw/avr: Add some ATmega microcontrollers
  hw/avr: Add limited support for some Arduino boards
  target/avr/cpu: Drop tlb_flush() in avr_cpu_reset()
  target/avr/cpu: Fix $PC displayed address
  target/avr/disas: Fix store instructions display order

Thomas Huth (1):
  target/avr: Add section into QEMU documentation

 docs/system/target-avr.rst       |   37 +
 docs/system/targets.rst          |    1 +
 configure                        |    7 +
 default-configs/avr-softmmu.mak  |    5 +
 qapi/machine.json                |    3 +-
 hw/avr/atmega.h                  |   48 +
 hw/avr/boot.h                    |   33 +
 include/disas/dis-asm.h          |   19 +
 include/elf.h                    |    4 +
 include/hw/char/avr_usart.h      |   93 +
 include/hw/misc/avr_power.h      |   46 +
 include/hw/timer/avr_timer16.h   |   94 +
 include/sysemu/arch_init.h       |    1 +
 target/avr/cpu-param.h           |   36 +
 target/avr/cpu-qom.h             |   54 +
 target/avr/cpu.h                 |  256 +++
 target/avr/helper.h              |   29 +
 target/avr/insn.decode           |  187 ++
 arch_init.c                      |    2 +
 hw/avr/arduino.c                 |  149 ++
 hw/avr/atmega.c                  |  458 +++++
 hw/avr/boot.c                    |  115 ++
 hw/char/avr_usart.c              |  320 ++++
 hw/misc/avr_power.c              |  113 ++
 hw/timer/avr_timer16.c           |  621 ++++++
 target/avr/cpu.c                 |  367 ++++
 target/avr/disas.c               |  246 +++
 target/avr/gdbstub.c             |   84 +
 target/avr/helper.c              |  342 ++++
 target/avr/machine.c             |  121 ++
 target/avr/translate.c           | 3061 ++++++++++++++++++++++++++++++
 tests/qtest/boot-serial-test.c   |   11 +
 tests/qtest/machine-none-test.c  |    1 +
 MAINTAINERS                      |   30 +
 gdb-xml/avr-cpu.xml              |   49 +
 hw/Kconfig                       |    1 +
 hw/avr/Kconfig                   |    9 +
 hw/avr/Makefile.objs             |    3 +
 hw/char/Kconfig                  |    3 +
 hw/char/Makefile.objs            |    1 +
 hw/misc/Kconfig                  |    3 +
 hw/misc/Makefile.objs            |    2 +
 hw/misc/trace-events             |    4 +
 hw/timer/Kconfig                 |    3 +
 hw/timer/Makefile.objs           |    2 +
 hw/timer/trace-events            |   12 +
 target/avr/Makefile.objs         |   34 +
 tests/acceptance/machine_avr6.py |   50 +
 tests/qtest/Makefile.include     |    2 +
 49 files changed, 7171 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/target-avr.rst
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/boot.h
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 include/hw/misc/avr_power.h
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/helper.h
 create mode 100644 target/avr/insn.decode
 create mode 100644 hw/avr/arduino.c
 create mode 100644 hw/avr/atmega.c
 create mode 100644 hw/avr/boot.c
 create mode 100644 hw/char/avr_usart.c
 create mode 100644 hw/misc/avr_power.c
 create mode 100644 hw/timer/avr_timer16.c
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/disas.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate.c
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 tests/acceptance/machine_avr6.py

--=20
2.21.3


