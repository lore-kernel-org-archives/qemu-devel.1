Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1166EC43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D477A2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMUhJ0aM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D477A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42767 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfUR-000218-8s
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQ8-0007Cf-72
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQ5-0002jU-GG
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQ5-0002hr-66
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:05 -0500
Received: by mail-wm1-x343.google.com with SMTP id t26so11295480wmi.4
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xcp3/CHlbhH4lfwxeXUOHv5G4pUx2CNyxu3i0EkeVg4=;
 b=JMUhJ0aMpu/I0Mk0bM/1Ll/UZ/Ooj9mFMgjrmFlNAhgGXU6Wvv0964RByFo2dbt1bs
 Qenre8+qMRiteSZcZrm4tmR2wfldK5BlEgGq+VcVVh2gh5eaMtX9xXWN1pTNL5n7NYBA
 VnT76tYQmPAIPeDstRpCNo12pWUrYukzIe6mwoV2odhJ7hqlU/mIO8VxVlAKj5uLkXX9
 7IVG+5T2YB6j2KNmjIAp2Xq2nCglafUldmXOOqqC5v2k2tF0BXbvT5E94F0O3dQwxHW2
 auxwjgJqx+4yzQjOD17pGiQHBb4BrnThDqCDCNzBXtgt906pxRJgQ7++CEizVp2kui2I
 UQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xcp3/CHlbhH4lfwxeXUOHv5G4pUx2CNyxu3i0EkeVg4=;
 b=NEn81SRjUe8ucn32Rab8zK/ogtcj08RRvn4mQfH/9YjQQULxPIngQHcy+hAWpDNwcE
 +BOpltgxYgKaxSYU2gscMGsfPIF27iVFthkIY2zggPSIKzC/3C+k+H+kqyWSyUmT9zdO
 XCsguGCShcJWgiFZtXnJbRbaSyNBhXdvwwFt/sAsex65EqTNaKoioK3zIoPOY/Tb1ACZ
 8YPTRyXatW6q5mTk4hmLn2mWj5Iobomcuqc0jFIRhfwm64e/v/AWWpD9v/9wtYndR7Sp
 iZxzbhhPDN7jspO2whnWpWf+RLneVX3A7PueA08UMFbVjf7ekDLkNrF38ZwxzARhe0YK
 bDSg==
X-Gm-Message-State: APjAAAX0JSjzR7GGX2ybQCZPtCBc0Vwx79x90o0m0hY96OQSXgg9srei
 KvJLnA0EdVEnPjaYui9pjI3zUw==
X-Google-Smtp-Source: APXvYqxnVyKY3G8NKK2QiV3mzCZWoyDF5NHykAAEAv/1yF83ldaAz0t05z0gCcn6S6tbA5SeFQWDjA==
X-Received: by 2002:a1c:1fca:: with SMTP id
 f193mr14881322wmf.173.1573839003817; 
 Fri, 15 Nov 2019 09:30:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s11sm11769241wrr.43.2019.11.15.09.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:01 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C7A3F1FF87;
 Fri, 15 Nov 2019 17:30:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  00/11] gdbstub re-factor and SVE support
Date: Fri, 15 Nov 2019 17:29:49 +0000
Message-Id: <20191115173000.21891-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

This RFC is for supporting SVE registers in QEMU's gdbstub.

However on the way to that there is a bunch of re-factoring to the
core gdbstub code to remove some of the hardcoded size limits from its
various buffers. By using dynamically sized buffers we are less likely
to trip up as we potentially push these large registers into the
staging memory before transmission. Ultimately we end up touching all
guest gdbstub register code to make them push bytes into a GByteArray
rather than directly poking memory. For the most part this is a
mechanical process although PPC makes it a little uglier as it can
dynamically change endianess and therefor has its own custom byte
swapping routine after the fact.

One other thing to note is that currently we don't match the existing
gdbstub XML (org.gnu.gdb.aarch64.sve) opting instead to send our own
register layout (org.qemu.gdb.aarch64.sve). The principle difference
is we report the registers in quads (e.g. z0p0 -> z0pN) depending on
the configured size of the machine. It could be changed easily enough
but I was having trouble getting gdbstub on the current master to work
so went with something I could understand more easily.

Alex Bennée (11):
  gdbstub: move allocation of GDBState to one place
  gdbstub: stop passing GDBState * around
  gdbstub: move str_buf to GDBState and use GString
  gdbstub: move mem_buf to GDBState and use GByteArray
  gdbstub: add helper for 128 bit registers
  target/arm: use gdb_get_reg helpers
  target/m68k: use gdb_get_reg helpers
  gdbstub: extend GByteArray to read register helpers
  target/arm: prepare for multiple dynamic XMLs
  target/arm: explicitly encode regnum in our XML
  target/arm: generate xml description of our SVE registers

 include/exec/gdbstub.h              |  41 ++-
 include/hw/core/cpu.h               |   2 +-
 target/alpha/cpu.h                  |   2 +-
 target/arm/cpu.h                    |  34 +-
 target/cris/cpu.h                   |   4 +-
 target/hppa/cpu.h                   |   2 +-
 target/i386/cpu.h                   |   2 +-
 target/lm32/cpu.h                   |   2 +-
 target/m68k/cpu.h                   |   2 +-
 target/microblaze/cpu.h             |   2 +-
 target/mips/internal.h              |   2 +-
 target/openrisc/cpu.h               |   2 +-
 target/ppc/cpu.h                    |   4 +-
 target/riscv/cpu.h                  |   2 +-
 target/s390x/internal.h             |   2 +-
 target/sh4/cpu.h                    |   2 +-
 target/sparc/cpu.h                  |   2 +-
 target/xtensa/cpu.h                 |   2 +-
 gdbstub.c                           | 520 +++++++++++++++-------------
 hw/core/cpu.c                       |   2 +-
 target/alpha/gdbstub.c              |   2 +-
 target/arm/gdbstub.c                | 137 +++++++-
 target/arm/gdbstub64.c              |   2 +-
 target/arm/helper.c                 | 108 ++++--
 target/cris/gdbstub.c               |   4 +-
 target/hppa/gdbstub.c               |   2 +-
 target/i386/gdbstub.c               |   2 +-
 target/lm32/gdbstub.c               |   2 +-
 target/m68k/gdbstub.c               |   2 +-
 target/m68k/helper.c                |  33 +-
 target/microblaze/gdbstub.c         |   2 +-
 target/mips/gdbstub.c               |   2 +-
 target/nios2/cpu.c                  |   2 +-
 target/openrisc/gdbstub.c           |   2 +-
 target/ppc/gdbstub.c                |  48 +--
 target/ppc/translate_init.inc.c     |  54 +--
 target/riscv/gdbstub.c              |  18 +-
 target/s390x/gdbstub.c              |  30 +-
 target/sh4/gdbstub.c                |   2 +-
 target/sparc/gdbstub.c              |   2 +-
 target/xtensa/gdbstub.c             |   2 +-
 tests/tcg/multiarch/float_helpers.c |   7 +-
 42 files changed, 659 insertions(+), 439 deletions(-)

-- 
2.20.1


