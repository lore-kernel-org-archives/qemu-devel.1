Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2869AC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B3620732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQFEbHKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B3620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayQX-0005AO-ER
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOG-0002xd-D1
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOE-0003BA-Oi
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:08 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayOE-00039b-HN
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:06 -0500
Received: by mail-wm1-x344.google.com with SMTP id g206so16308970wme.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LAfp5wEVFKlFvtQUxkFov81nSLAkjFHfewxk/LJDvm0=;
 b=DQFEbHKpLjtWChA6M0Zl4U3wMaQsFkib29hmhp/bLn/BsqziVhNjd9KSeiLm0nvevr
 uXVFjRI+KesL6yDd/Nuq3dueyQMfJhtBoVoxUtQPn3gX4xolv7kY3wDr3mRlOIih3LmT
 hUk+obin1nUkhqH4hu8vR5tbmubqM8PZQRZjCBTnzgUF8eCbLVmS6w61TzqT8VsxhSCA
 l7Z+S3rqeO0oiPlOMVTsyvJY0GwqP8CF5bRXqmYEvc+WhZ+6v+MmMAX1+5BSH3OjxnuA
 im5bFd1NTi+Hj3Amdr5KkdqipVUQPU41YNZ2bbtJLnLZqp0L+M/E3dnhsir19mMAUI56
 Fckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LAfp5wEVFKlFvtQUxkFov81nSLAkjFHfewxk/LJDvm0=;
 b=dYab6sMKtuQJNTI/p04FvxlGMDyUrCdNjSJAwlnaTkNRe0bgxaIHrENDR4sq6BahoU
 YgDTvNIl2U8ejWfxTx2rVYJTtMU7K9dAcmns6vdD/tqze5ww/bdnvUUqsu7PRZt4q0jL
 1CpvVXYB/CCMIwl8kzYjxMXze6M/Wml+mSuz5GE+UAMpc4yqjEez1/qbxf/Lq9oFZH7o
 2ezT7+6elDJNlQIAaVYmNfWz7x8+dGVDgr1CCYMOSkukTF1Zoja3ggGZ6MXkM6upKSrq
 jeqZJcruqZCa+ePEaiMaoG9uFFI7VkwRfJKWyVDOhOSnn0LhOfoeNGNu+wmZ1jP6OTeq
 0X+w==
X-Gm-Message-State: APjAAAUXgsk439QwbFt3BeNDQOzgMYiCVmfqcpEySgCzSH/Z+ClHI38U
 P91C++gf0i2DGp0tPiU7mJznVQ==
X-Google-Smtp-Source: APXvYqwDrO6cRyD+1dKu2RTHpCY6+uNwhxYjvH25Pon68QpLsBSlT1i0cgoihiHLbbuX/hywPLk8cQ==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr17880241wmh.82.1575103564832; 
 Sat, 30 Nov 2019 00:46:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v188sm5782426wma.10.2019.11.30.00.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:46:03 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6AA61FF87;
 Sat, 30 Nov 2019 08:46:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/14] gdbstub refactor and SVE support
Date: Sat, 30 Nov 2019 08:45:48 +0000
Message-Id: <20191130084602.10818-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

So this is the first fully working version of the SVE gdbstub
implementation. As before the first set of patches are mostly
re-factoring of the gdbstub register interface. I include a new patch
to default the SVE size to a more reasonable number for linux-user to
mirror what the Linux kernel actually does. Finally the XML that QEMU
generates is closer to that of GDB in terms of the nesting of the
union and keeping all registers intact. If you enable the maximum VQ
you still end up with pages of text if you examine the vector
registers.

Finally I've added a bit more test harness for running gdbstub tests
and included a basic smoke test for SVE itself. It's still not plumbed
into the main test harness yet though as there are complications
caused by the available version of gdb. However I hope I can hide
these in the run-test.py script later and just skip tests that we know
won't work.

Alex Bennée (14):
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
  tests/guest-debug: add a simple test runner
  tests/tcg: add a gdbstub testcase for SVE registers

 include/exec/gdbstub.h                |  49 +-
 include/hw/core/cpu.h                 |   2 +-
 target/alpha/cpu.h                    |   2 +-
 target/arm/cpu.h                      |  34 +-
 target/cris/cpu.h                     |   4 +-
 target/hppa/cpu.h                     |   2 +-
 target/i386/cpu.h                     |   2 +-
 target/lm32/cpu.h                     |   2 +-
 target/m68k/cpu.h                     |   2 +-
 target/microblaze/cpu.h               |   2 +-
 target/mips/internal.h                |   2 +-
 target/openrisc/cpu.h                 |   2 +-
 target/ppc/cpu.h                      |   4 +-
 target/riscv/cpu.h                    |   2 +-
 target/s390x/internal.h               |   2 +-
 target/sh4/cpu.h                      |   2 +-
 target/sparc/cpu.h                    |   2 +-
 target/xtensa/cpu.h                   |   2 +-
 gdbstub.c                             | 892 +++++++++++++-------------
 hw/core/cpu.c                         |   2 +-
 target/alpha/gdbstub.c                |   2 +-
 target/arm/cpu64.c                    |   3 +
 target/arm/gdbstub.c                  | 169 ++++-
 target/arm/gdbstub64.c                |   2 +-
 target/arm/helper.c                   | 151 ++++-
 target/cris/gdbstub.c                 |   4 +-
 target/hppa/gdbstub.c                 |   2 +-
 target/i386/gdbstub.c                 |   2 +-
 target/lm32/gdbstub.c                 |   2 +-
 target/m68k/gdbstub.c                 |   2 +-
 target/m68k/helper.c                  |  33 +-
 target/microblaze/gdbstub.c           |   2 +-
 target/mips/gdbstub.c                 |   2 +-
 target/nios2/cpu.c                    |   2 +-
 target/openrisc/gdbstub.c             |   2 +-
 target/ppc/gdbstub.c                  |  48 +-
 target/ppc/translate_init.inc.c       |  54 +-
 target/riscv/gdbstub.c                |  18 +-
 target/s390x/gdbstub.c                |  30 +-
 target/sh4/gdbstub.c                  |   2 +-
 target/sparc/gdbstub.c                |   2 +-
 target/xtensa/gdbstub.c               |   2 +-
 tests/.gitignore                      |   1 +
 tests/guest-debug/run-test.py         |  57 ++
 tests/tcg/aarch64/gdbstub/test-sve.py |  75 +++
 45 files changed, 1038 insertions(+), 644 deletions(-)
 create mode 100755 tests/guest-debug/run-test.py
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

-- 
2.20.1


