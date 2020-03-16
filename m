Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D29FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186AC20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+7nCIcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186AC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtnf-0007xY-6N
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRI-0000Xa-Rs
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRF-0007tf-KA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRF-0007io-6K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id b2so16025929wrj.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q+OUDDPHwOQka6zNvKnp9HDN8/R0WLXE1LB7BAeLwnM=;
 b=K+7nCIcCzrCrSwm6IZZU7SvkILfnyetgFiwhaMjIs2VjB1zU3szHuzlpvFnQQwDxks
 Vol5alyK5jBtsFnSbLS79m4a9TrdlMsgfkjmuYRIreK+opXrLiKRCd6rYYCyY5RkS0bQ
 z/OaBM5X0hr/Zs67vjfkyGs0s6wlQgz1kD8lOQmqeqJn6GrJZ7N2YuVQRVCKlf2scStI
 cva1tSgz/jU36IhS/wwAj5rYTyfSlFPAKmpDMLPWPKKPgL7EY5lxA2aHcNT6sCGXEryC
 GIL5wCNeOw7bJXCh1V5QqBnRI5emYz6r7dT0SE6Akg4nBIhhOYAGJObrABIJsJHx0E07
 8HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q+OUDDPHwOQka6zNvKnp9HDN8/R0WLXE1LB7BAeLwnM=;
 b=nPqZY11IFqZBkrL86FKi4YWECzziS9+9YwMZtrHc++BmyqAAyePLl0pifyx4jBjESd
 jvnsHFvr5vLnPHlBEPdSR6xusj1kKMWd3XJM6zpRvWJjgFFXnsVdFThYWLhHevLjh3Vd
 +UylaZRpNqisLxSzWfLxAg065T6zrifhf1t9yqSoopQAvRXRy1IVE6O3bHnbjKQ8r/hX
 Z4FN+NnqJo5N1pbKrC6NLyJGjbcLFemJxy1EVCgg7CVr380zXdAEA/UGMQdeM4ICTaEZ
 63fEQC0AsxR0ZfGhQNklH6nzrGqM0M1zgcTPuPkSVVUVpievF5wnHKWTPXFsMD3UsoHI
 o8KA==
X-Gm-Message-State: ANhLgQ0VY86QfoiXGwxzkPVeug2PB+WoCUyALJk5ANNrP/dJ/TGGSvYk
 ZoC8A1uH6Fj552qA6H0L0biaOA==
X-Google-Smtp-Source: ADFU+vuPtgVn1/6GjVtt85EO/iugNIzpyS2SyY4hCM65cOA6kkrRp+LvAtTsAN9Sq/FuWK6MaJUfTw==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr384959wrn.3.1584379320483;
 Mon, 16 Mar 2020 10:22:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm446523wmc.30.2020.03.16.10.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:21:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 271861FF7E;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/28 for 5.0] testing and gdbstub
Date: Mon, 16 Mar 2020 17:21:27 +0000
Message-Id: <20200316172155.971-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

This is the last chance to get any reviews in before I send a pull
request later today. To avoid having multiple PRs I've combined both
the testing changes and the gdbstub updates. In the end I had to drop
Gerd's vm updates as it cause problems with the acceptance testing.

The following patches still need review:
 - tests/tcg/aarch64: add test-sve-ioctl guest-debug test
 - tests/tcg/aarch64: add SVE iotcl test
 - tests/tcg/aarch64: add a gdbstub testcase for SVE registers
 - target/arm: generate xml description of our SVE registers
 - target/arm: prepare for multiple dynamic XMLs
 - target/i386: use gdb_get_reg helpers

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

Changbin Du (1):
  gdbstub: Fix single-step issue by confirming 'vContSupported+' feature
    to gdb

Damien Hedde (2):
  gdbstub: change GDBState.last_packet to GByteArray
  gdbstub: do not split gdb_monitor_write payload

Philippe Mathieu-Daudé (5):
  tests/docker: Install tools to cross-debug and build Linux kernels
  tests/docker: Update VirGL git repository URL
  tests/docker: Remove obsolete VirGL --with-glx configure option
  tests/docker: Update VirGL to v0.8.0
  travis.yml: Set G_MESSAGES_DEBUG do report GLib errors

 configure                                    |   9 +
 include/exec/gdbstub.h                       |  62 +-
 include/hw/core/cpu.h                        |   2 +-
 target/alpha/cpu.h                           |   2 +-
 target/arm/cpu.h                             |  31 +-
 target/cris/cpu.h                            |   4 +-
 target/hppa/cpu.h                            |   2 +-
 target/i386/cpu.h                            |   2 +-
 target/lm32/cpu.h                            |   2 +-
 target/m68k/cpu.h                            |   2 +-
 target/microblaze/cpu.h                      |   2 +-
 target/mips/internal.h                       |   2 +-
 target/openrisc/cpu.h                        |   2 +-
 target/ppc/cpu.h                             |   4 +-
 target/riscv/cpu.h                           |   2 +-
 target/s390x/internal.h                      |   2 +-
 target/sh4/cpu.h                             |   2 +-
 target/sparc/cpu.h                           |   2 +-
 target/xtensa/cpu.h                          |   2 +-
 gdbstub.c                                    | 936 +++++++++----------
 hw/core/cpu.c                                |   2 +-
 target/alpha/gdbstub.c                       |   2 +-
 target/arm/cpu.c                             |   7 +-
 target/arm/gdbstub.c                         | 173 +++-
 target/arm/gdbstub64.c                       |   2 +-
 target/arm/helper.c                          | 186 +++-
 target/cris/gdbstub.c                        |   4 +-
 target/hppa/gdbstub.c                        |   2 +-
 target/i386/gdbstub.c                        |  29 +-
 target/lm32/gdbstub.c                        |   2 +-
 target/m68k/gdbstub.c                        |   2 +-
 target/m68k/helper.c                         |  33 +-
 target/microblaze/gdbstub.c                  |   2 +-
 target/mips/gdbstub.c                        |   2 +-
 target/nios2/cpu.c                           |   2 +-
 target/openrisc/gdbstub.c                    |   2 +-
 target/ppc/gdbstub.c                         |  48 +-
 target/ppc/translate_init.inc.c              |  54 +-
 target/riscv/gdbstub.c                       |  20 +-
 target/s390x/gdbstub.c                       |  30 +-
 target/sh4/gdbstub.c                         |   2 +-
 target/sparc/gdbstub.c                       |   2 +-
 target/xtensa/gdbstub.c                      |   2 +-
 tests/tcg/aarch64/sve-ioctls.c               |  70 ++
 tests/tcg/aarch64/sysregs.c                  | 172 ++++
 .travis.yml                                  |   1 +
 tests/.gitignore                             |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   6 +-
 tests/docker/dockerfiles/debian10.docker     |   3 +
 tests/docker/dockerfiles/debian9.docker      |   3 +
 tests/guest-debug/run-test.py                |  57 ++
 tests/tcg/aarch64/Makefile.target            |  32 +
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py  |  82 ++
 tests/tcg/aarch64/gdbstub/test-sve.py        |  81 ++
 54 files changed, 1491 insertions(+), 701 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c
 create mode 100644 tests/tcg/aarch64/sysregs.c
 create mode 100755 tests/guest-debug/run-test.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

-- 
2.20.1


