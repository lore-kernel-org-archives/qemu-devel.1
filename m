Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EF0C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3BA2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqzw4dpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3BA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5Sg-0006vg-Lm
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5QU-0004s4-EG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5QS-0002zt-Po
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:26 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5QS-0002xt-FS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:24 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z7so24752312wrl.13
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hLJ/BFRwgmTY0fBftGO4fFir5tGVTnnqvUClhbQxS6g=;
 b=hqzw4dpDHVTFj4lOha8n9zDymrFGKzDnxbdrVEJ3bk+i2Yz/n6nxUTJ6D8icqb7MlJ
 rKH8QC+vvW26Biwb7Ekfj7jNUwsf7eIxSev6CV1T+Irpw709898CtnaWKczI8BorKedk
 U7vcTQGwkqq0O5rzprIaV9QTNxWFKQLxlq+GX35Yxovf4mT6pWrQ4dCp5sTqdMtfbUuA
 6ZPO4nyAvks5qPlj5ajpKrQhsmBWenhuowF59mSUN3oEL+xOyF4WibLhveC73FOFhN2i
 3sHKzEMG7H8XjPnBWnDOJU5fKeIidp/q4htFZPI+IESIJwJV0PEaoPIz/L7cmu3AXFjk
 fz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hLJ/BFRwgmTY0fBftGO4fFir5tGVTnnqvUClhbQxS6g=;
 b=dgE8IXW4WGunf8i4RjtI5ZlYTB1thQ1fsVX3wVxyHxamttFZ/zO3lhqP224/+WZgtH
 bo8DuXkqq8iXZVubkYbJGiyLPGVdXVpYUWjmGaMS1oRZ/maYiyIwWcH/hcE4AYYqjAY1
 I0UgVZEtCY/0wnw6fInKSAyLEq/2L9BHcA/T8loR9J8ur1RcCItmcdiY29xtLIvxkZCV
 qojBRXkmmSx/Q3/3oNK2rMF4IpnQZFAQERukoCYFc5UaZMAV5mS1dSzpK+TG2iGtrrAx
 0rYi0o3OJfodg7Cs+4s8heOSaSMXkRf2+fI8PeXcmZ0FazgCSviAuwUkAVgEu4nCAoKy
 Kccw==
X-Gm-Message-State: APjAAAVWRfbezZQKxkqQ5lBVijehdh/tKMZpY7DIMhJm6Q2FBkV9AmZO
 iYskHS+RZb/YaQgJ0PDIZFtZbQ==
X-Google-Smtp-Source: APXvYqxJHwZvM+cK/ZPzYnbhrlEqx9UaqWVPVp8jc6r0Wn+iLiuFHYGzyODBt29fOwrfjQTtwglPvA==
X-Received: by 2002:adf:db84:: with SMTP id u4mr850022wri.317.1576083922645;
 Wed, 11 Dec 2019 09:05:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a84sm2977777wme.44.2019.12.11.09.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:21 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC1001FF87;
 Wed, 11 Dec 2019 17:05:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/20] gdbstub refactor and SVE support (+check-tcg tweaks)
Date: Wed, 11 Dec 2019 17:05:00 +0000
Message-Id: <20191211170520.7747-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

In this update of the SVE support I've addressed the review comments
as well expanding the test cases for SVE. I've included a few fixes
for check-tcg to allow for the inclusion of SVE enabled test cases.
This includes including the userspace ID register test as I needed to
do something similar for the SVE specific test.

I think this is ready to be merged once the tree re-opens.

The following patches need review
  08 - gdbstub extend GByteArray to read register helper
  09 - target arm prepare for multiple dynamic XMLs
  11 - target arm default SVE length to 64 bytes for lin
  12 - target arm generate xml description of our SVE re
  13 - tests tcg add a configure compiler check for ARMv
  14 - target arm don t bother with id_aa64pfr0_read for
  15 - tests tcg aarch64 userspace system register test
  16 - tests tcg ensure we re configure if configure.sh 
  17 - tests guest debug add a simple test runner
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
  gdbstub: extend GByteArray to read register helpers
  target/arm: prepare for multiple dynamic XMLs
  target/arm: explicitly encode regnum in our XML
  target/arm: default SVE length to 64 bytes for linux-user
  target/arm: generate xml description of our SVE registers
  tests/tcg: add a configure compiler check for ARMv8.1 and SVE
  target/arm: don't bother with id_aa64pfr0_read for USER_ONLY
  tests/tcg/aarch64: userspace system register test
  tests/tcg: ensure we re-configure if configure.sh is updated
  tests/guest-debug: add a simple test runner
  tests/tcg/aarch64: add a gdbstub testcase for SVE registers
  tests/tcg/aarch64: add SVE iotcl test
  tests/tcg/aarch64: add test-sve-ioctl guest-debug test

 include/exec/gdbstub.h                      |  49 +-
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
 gdbstub.c                                   | 903 ++++++++++----------
 hw/core/cpu.c                               |   2 +-
 target/alpha/gdbstub.c                      |   2 +-
 target/arm/cpu.c                            |   4 +-
 target/arm/gdbstub.c                        | 172 +++-
 target/arm/gdbstub64.c                      |   2 +-
 target/arm/helper.c                         | 182 +++-
 target/cris/gdbstub.c                       |   4 +-
 target/hppa/gdbstub.c                       |   2 +-
 target/i386/gdbstub.c                       |   2 +-
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
 tests/tcg/aarch64/sve-ioctls.c              |  77 ++
 tests/tcg/aarch64/sysregs.c                 | 172 ++++
 tests/.gitignore                            |   1 +
 tests/guest-debug/run-test.py               |  57 ++
 tests/tcg/Makefile.prereqs                  |   2 +-
 tests/tcg/aarch64/Makefile.target           |  10 +
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |  71 ++
 tests/tcg/aarch64/gdbstub/test-sve.py       |  75 ++
 tests/tcg/configure.sh                      |  14 +
 51 files changed, 1413 insertions(+), 658 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c
 create mode 100644 tests/tcg/aarch64/sysregs.c
 create mode 100755 tests/guest-debug/run-test.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

-- 
2.20.1


