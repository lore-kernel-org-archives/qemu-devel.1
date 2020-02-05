Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6550C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AD32072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+CY90Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AD32072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izODR-0006VT-Ty
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCD-0004mX-Mn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCB-0004My-P6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOCB-0004Ck-GV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id p17so3754217wma.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XobWii0gyKEFpmpm8GRpoTXmHwcr6mpM28NZdoJS65A=;
 b=P+CY90LuJWyf0aOG+wP2NLpwrArkFwxAvcxV7o5m281cWoj52Pl1lIc7ssvYIv8cXI
 FlfFue6nsK8c5CeMhFnvsjw+81PZjlkBtl+qGFGreR26GB1iNjETGyjQm7wPOPKSi9hE
 EkubUi/kiYbYhvhrUEhJj6LKGaHa/8lPK4p8J2RfgtYria6iblxkRxrBJExASsS6u1zC
 HRUAZAgMqPi5DpWgmzaFEXfn/m5zE/VAJ1fF9gOfYJCAaH04FS9bz/vQsZdudfbiDd4M
 tzl0aOkKMNDqzwXjn0V2wuu4vhNHMTg3c17R0cWOLnM1vbhkZjbOmWH7RvA6t7o00B45
 DCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XobWii0gyKEFpmpm8GRpoTXmHwcr6mpM28NZdoJS65A=;
 b=bA0k6A1fPlUljIrsXweMzDY8JvGs7RsSvxpi6qfj+Hs41+/Iql1MVuxblVLDvE9UV6
 3CZf9dpG8iIeAFSR4LvcEcvuf+0X7O9+egnJDS3w/vRwEpYKLsYYfLQLSiowQIeuLtla
 gKNPKr3VC6f91QlSx3ax9pQP3qFxcxN6dTLjl+Lt+61dw84Ge40dUg/ZtvJO4EoSA6Zi
 bP5SI3JBFhicch4qzyIBgSMW36x9ZX1W0TU/9lAom9xb/XBHUiQW9xF73Mt11Xf+v8Y9
 GwWlUnP3eq47NA01W//TIziZE8muQJ7CyTOlZ4mXqnHdrA8la1DlqsoqZlBHp8Y/wPJB
 ItJg==
X-Gm-Message-State: APjAAAX7/7v5iiBDUjbylwu8BSYo/shWqXlH50Wt0KHJQeLKUsXJtmom
 a1SoigWbPlj1dCy8QSmHdSQODA==
X-Google-Smtp-Source: APXvYqy+TpK2QIdQQaZgxOc2g1FV7Kz+6CqI8xW4uNVmjo4ifUezUe0jHSU7CDN6FD4bjDefCKXsqA==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr6397678wmj.7.1580922633652;
 Wed, 05 Feb 2020 09:10:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm566112wru.50.2020.02.05.09.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:10:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87DFC1FF87;
 Wed,  5 Feb 2020 17:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 00/22] gdbstub refactor and SVE support
Date: Wed,  5 Feb 2020 17:10:09 +0000
Message-Id: <20200205171031.22582-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The main change for the last iteration is the re-introduction of the
VG pseudo register. I've also applied review tags from the last post.
All that really needs looking over is the tests.

Please note that if your local GDB doesn't work the test will skip if
it fails to connect. I have to build --with-gdb pointing at a
relatively recent multiarch build.

This series is available from:

  github.com:stsquad/qemu.git gdbstub/sve-registers-v6

and is currently based of the in-flight testing PR.

The following patches need review
  08 - target i386 use gdb_get_reg helpers
  10 - target arm prepare for multiple dynamic XMLs (1 ack)
  13 - target arm generate xml description of our SVE re (1 ack)
  18 - tests tcg aarch64 add a gdbstub testcase for SVE 
  19 - tests tcg aarch64 add SVE iotcl test
  20 - tests tcg aarch64 add test sve ioctl guest debug 

Alex Bennée (20):
  gdbstub: make GDBState static and have common init function
  gdbstub: stop passing GDBState * around and use global
  gdbstub: move str_buf to GDBState and use GString
  gdbstub: move mem_buf to GDBState and use GByteArray
  gdbstub: add helper for 128 bit registers
  target/arm: use gdb_get_reg helpers
  target/m68k: use gdb_get_reg helpers
  target/i386: use gdb_get_reg helpers
  gdbstub: extend GByteArray to read register helpers
  target/arm: prepare for multiple dynamic XMLs
  target/arm: explicitly encode regnum in our XML
  target/arm: default SVE length to 64 bytes for linux-user
  target/arm: generate xml description of our SVE registers
  target/arm: don't bother with id_aa64pfr0_read for USER_ONLY
  tests/tcg/aarch64: userspace system register test
  configure: allow user to specify what gdb to use
  tests/guest-debug: add a simple test runner
  tests/tcg/aarch64: add a gdbstub testcase for SVE registers
  tests/tcg/aarch64: add SVE iotcl test
  tests/tcg/aarch64: add test-sve-ioctl guest-debug test

Damien Hedde (2):
  gdbstub: change GDBState.last_packet to GByteArray
  gdbstub: do not split gdb_monitor_write payload

 configure                                   |   9 +
 include/exec/gdbstub.h                      |  62 +-
 include/hw/core/cpu.h                       |   2 +-
 target/alpha/cpu.h                          |   2 +-
 target/arm/cpu.h                            |  31 +-
 target/cris/cpu.h                           |   4 +-
 target/hppa/cpu.h                           |   2 +-
 target/i386/cpu.h                           |   2 +-
 target/lm32/cpu.h                           |   2 +-
 target/m68k/cpu.h                           |   2 +-
 target/microblaze/cpu.h                     |   2 +-
 target/mips/internal.h                      |   2 +-
 target/openrisc/cpu.h                       |   2 +-
 target/ppc/cpu.h                            |   4 +-
 target/riscv/cpu.h                          |   2 +-
 target/s390x/internal.h                     |   2 +-
 target/sh4/cpu.h                            |   2 +-
 target/sparc/cpu.h                          |   2 +-
 target/xtensa/cpu.h                         |   2 +-
 gdbstub.c                                   | 936 ++++++++++----------
 hw/core/cpu.c                               |   2 +-
 target/alpha/gdbstub.c                      |   2 +-
 target/arm/cpu.c                            |   4 +-
 target/arm/gdbstub.c                        | 173 +++-
 target/arm/gdbstub64.c                      |   2 +-
 target/arm/helper.c                         | 180 +++-
 target/cris/gdbstub.c                       |   4 +-
 target/hppa/gdbstub.c                       |   2 +-
 target/i386/gdbstub.c                       |  24 +-
 target/lm32/gdbstub.c                       |   2 +-
 target/m68k/gdbstub.c                       |   2 +-
 target/m68k/helper.c                        |  33 +-
 target/microblaze/gdbstub.c                 |   2 +-
 target/mips/gdbstub.c                       |   2 +-
 target/nios2/cpu.c                          |   2 +-
 target/openrisc/gdbstub.c                   |   2 +-
 target/ppc/gdbstub.c                        |  48 +-
 target/ppc/translate_init.inc.c             |  54 +-
 target/riscv/gdbstub.c                      |  18 +-
 target/s390x/gdbstub.c                      |  30 +-
 target/sh4/gdbstub.c                        |   2 +-
 target/sparc/gdbstub.c                      |   2 +-
 target/xtensa/gdbstub.c                     |   2 +-
 tests/tcg/aarch64/sve-ioctls.c              |  70 ++
 tests/tcg/aarch64/sysregs.c                 | 172 ++++
 tests/.gitignore                            |   1 +
 tests/guest-debug/run-test.py               |  57 ++
 tests/tcg/aarch64/Makefile.target           |  32 +
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |  79 ++
 tests/tcg/aarch64/gdbstub/test-sve.py       |  81 ++
 50 files changed, 1466 insertions(+), 694 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c
 create mode 100644 tests/tcg/aarch64/sysregs.c
 create mode 100755 tests/guest-debug/run-test.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

-- 
2.20.1


