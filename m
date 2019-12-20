Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5B8C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA182465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3RQ9f4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA182465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiH3L-0005yR-Hd
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1R-0004YL-PS
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1P-0007Ho-TB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:45 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiH1P-0007D3-Iy
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:43 -0500
Received: by mail-wr1-x432.google.com with SMTP id q10so9168472wrm.11
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=seZxIJJzrC8aUFeIHKs7Llt2Klfs5NAbt8G7XufUqSc=;
 b=A3RQ9f4+WDMTYxBWQnLzU1VlVY4mLxHrhqqx8v/sr4kCFvpi4kjsJV+ZiUuYGYPSfT
 Oe3XJCZce1zy8JpupLk7DfBqxJHnsBi3zClsiHCKE5RlZChoyQiuK203jzHC6C/jjh1J
 UtRyoIV4K7+bMzbQaYCE6/IB0xpuPQW3jlymKkwrJVycxrR7RA5Nf3tTu+ror3/9Hdel
 wGcPYSRY8q8DLma98V2BnHsBWgxpqkWHcAo2acz7eIV/DOxj6Jgcc7i3Ju4bX/OM7a1D
 AzsjE4fJV1HzYbXCbVW5PZlNZ62xJBfxFEESp/Z2PWiuTJZix7PmrbKNHejDQ0KqP+HH
 cRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=seZxIJJzrC8aUFeIHKs7Llt2Klfs5NAbt8G7XufUqSc=;
 b=HqmDueWv5IH7lVGm8DIS1EqOg1LN0rHV/hNOwmJ2LnsVg9b12DBl7y5gOhLn7ZmWtU
 mdERQJQBCsrEAodPgWNSTR4CcEj1wk5Kc5Pmn8Q+xHWm6JKScKDA6HazgYgSdDNa5apQ
 2S7frTXObWeq36F311eTfczKlNIQc1YFNaVdAKEP+lDmud23Rhw+hQuE6GHUUm0cnUEy
 ceJM+3aUdbmHyctWz9HPR3CpRAWgrvCrrZgqnVxKKUOY9+VvojXLf1xIa1W5UV6PQbQR
 jojyZKFNahXHxSnZyOeFGA61uFqgintuvH5FbN6q7HVw2LksgdYoLyIUR8U7uXfweCH+
 z6mw==
X-Gm-Message-State: APjAAAUkUmIhaB+NpV0Q8FsZx3FEGaq+8VAqhBbDFUi8fCf9uF0X5zJi
 1lfK9VPXolW4G1TMBQycu6RgQA==
X-Google-Smtp-Source: APXvYqxdR6zgmqIvREpux2s1AHcUIRprjFUjCi336LKlYzP34FZfv3/gyi13lB4gAFEMVQRwGYme2w==
X-Received: by 2002:adf:90e1:: with SMTP id i88mr14223975wri.95.1576843482265; 
 Fri, 20 Dec 2019 04:04:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm9597209wrq.22.2019.12.20.04.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:04:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D0F0E1FF87;
 Fri, 20 Dec 2019 12:04:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/21] gdbstub refactor and SVE support (+check-tcg tweaks)
Date: Fri, 20 Dec 2019 12:04:17 +0000
Message-Id: <20191220120438.16114-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: damien.hedde@greensocs.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current iteration of gdbstub refactoring and SVE support.
I've fixed a few of the bugs caught up in review and dropped the
pseudo VG register. You can still read the state of zcr_el1 via the
existing sysreg support (which doesn't allow writing). I've also
included a couple of Damian's fixes to the gdbstub which I'll include
in the final PR.

The following patches need review
  08 - gdbstub extend GByteArray to read register helper
  09 - target arm prepare for multiple dynamic XMLs
  12 - target arm generate xml description of our SVE re
  13 - tests tcg add a configure compiler check for ARMv
  15 - tests tcg aarch64 userspace system register test
  16 - tests guest debug add a simple test runner
  17 - tests tcg aarch64 add a gdbstub testcase for SVE 
  18 - tests tcg aarch64 add SVE iotcl test
  19 - tests tcg aarch64 add test sve ioctl guest debug 

Alex Bennée (19):
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
  tests/guest-debug: add a simple test runner
  tests/tcg/aarch64: add a gdbstub testcase for SVE registers
  tests/tcg/aarch64: add SVE iotcl test
  tests/tcg/aarch64: add test-sve-ioctl guest-debug test

Damien Hedde (2):
  gdbstub: change GDBState.last_packet to GByteArray
  gdbstub: do not split gdb_monitor_write payload

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
 gdbstub.c                                   | 936 ++++++++++----------
 hw/core/cpu.c                               |   2 +-
 target/alpha/gdbstub.c                      |   2 +-
 target/arm/cpu.c                            |   4 +-
 target/arm/gdbstub.c                        | 168 +++-
 target/arm/gdbstub64.c                      |   2 +-
 target/arm/helper.c                         | 174 +++-
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
 tests/tcg/aarch64/Makefile.target           |  10 +
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |  71 ++
 tests/tcg/aarch64/gdbstub/test-sve.py       |  75 ++
 tests/tcg/configure.sh                      |  14 +
 50 files changed, 1410 insertions(+), 680 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c
 create mode 100644 tests/tcg/aarch64/sysregs.c
 create mode 100755 tests/guest-debug/run-test.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

-- 
2.20.1


