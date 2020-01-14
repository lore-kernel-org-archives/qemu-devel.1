Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77714C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9F3222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRUBlYpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9F3222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNrI-000777-RF
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpP-0004qJ-11
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpN-0007G5-I1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:09:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpN-0007EN-9O
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:09:57 -0500
Received: by mail-wm1-x32e.google.com with SMTP id d73so14187299wmd.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r0K1w1QmfVkrNiNl1Z2dCx4ETzD5ZKIQpkcAg/oN1BU=;
 b=tRUBlYpmBr2EZ15WQXj2zeeE/mwp3PPD9uHDxazkJ440chyIFb+psYRYvqMAnjhr07
 q0mEuGZcRLsHQpJIINQzOnHDmTGFFJmTzIdYx+4NuNheontBqSh/SzhN07WOfphPOZUH
 tyYmVNYsG7KVho0THiKoRAs6msz5AS8MbNH0UIfEA3eDUBGP9WwdYQNyqn5eek2OE7/6
 BJVyWwOfAMDUtoNd4dBUKPacprtwdIgrbWK3SuuKOyHqLlRRLlY8j9JXQIUFIpmN6A/6
 tnJhMqGTB5ATiiSfeVMHEYvMkO5VkQnXYlU/guaTu2xWvWbVgxFRP3PnNB7wR0c1+IKR
 rKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r0K1w1QmfVkrNiNl1Z2dCx4ETzD5ZKIQpkcAg/oN1BU=;
 b=oV6LhnHAFxLXNzDi6dpUcQTSIjHiRYUFLZAp2GQ+bPb/wBbypenaZu638o9StfVAxA
 DWrNpNuAm9ZdNm2/dDvRZXqVaXc5SeVuDklvxl4k2eLCnoh/cqJr4kVrofbahHOzk1cl
 t8EknpaiHmPXrUSnbEAnNJVYiZN8z6U+gppiSgFpIMH1mk1TRVYonyFeTMrE9hH9YIpZ
 tNyF+mfKnvv48fFWTcMDx0whRB+HCCgYBpjBBig6yKqXXkQzouDRGKLEhvYaADPFy2AU
 tcVnbPzxAbUbdZ19WQpHIlM5TnWRPhq/hyrD1lFwLwhj3YS6zaJAV87ATrafvuVeQ9ao
 A/hA==
X-Gm-Message-State: APjAAAWuJtFyl3e5j462UzX2lj/VM+Aquo6Qy02Z4q4mkdUWZPQrG+up
 0+7JVuVVb+v7+xLeEa6zzI51vw==
X-Google-Smtp-Source: APXvYqyON34hI3BFlTPdSLFpRjtgdVO4zOKDgJTYwrtsKXS03UpFhY4vsMHdT28tfvSeEFBp4Qodtg==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr28859995wmj.31.1579014595621; 
 Tue, 14 Jan 2020 07:09:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r62sm20452599wma.32.2020.01.14.07.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:09:54 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7F6CC1FF87;
 Tue, 14 Jan 2020 15:09:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/22] gdbstub refactor and SVE support (+check-tcg tweaks)
Date: Tue, 14 Jan 2020 15:09:31 +0000
Message-Id: <20200114150953.27659-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The main fixes are correcting the maths of the PPC re-swap code. I've
also finally plumbed in the gdbstub tests for SVE. These will also be
useful for adding tests for reverse-replay debug.

The following patches need review
  09 - target arm prepare for multiple dynamic XMLs
  12 - target arm generate xml description of our SVE re
  13 - tests tcg add a configure compiler check for ARMv
  15 - tests tcg aarch64 userspace system register test
  16 - configure allow user to specify what gdb to use
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
 tests/tcg/aarch64/Makefile.target           |  32 +
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |  79 ++
 tests/tcg/aarch64/gdbstub/test-sve.py       |  81 ++
 tests/tcg/configure.sh                      |  14 +
 51 files changed, 1468 insertions(+), 680 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c
 create mode 100644 tests/tcg/aarch64/sysregs.c
 create mode 100755 tests/guest-debug/run-test.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

-- 
2.20.1


