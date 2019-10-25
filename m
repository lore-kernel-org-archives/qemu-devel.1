Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DCF2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POIA5b6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DCF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxyc-0001yc-0Z
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwJ-0006J2-Lb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwE-0006ab-TH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:28 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:37313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwD-0006ZQ-8T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:25 -0400
Received: by mail-qt1-x82d.google.com with SMTP id g50so2730797qtb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=NIiOTnpLAsLsvEotBsCW7qgxVpyPSjsxlfZ4hcOEqI0=;
 b=POIA5b6C8qFMsMRwKqAV420wgUOVo9d5OwI9je3J8dZHQMQJlWtvp6EvGOIswRCysq
 zo/aQDSVy7UdZu8n87OP5Q60p1Dh606E2rVA2GOaQlELMl/CI0QcCyklXykQJ7caBgV4
 jfeJypfTkPxfUw5ODy8ofwlX+25OAN8Vo/eHN7ZD9bwm301zGgrWt4YK+saXWdI/2TIs
 z9TOQK9bx/uzFSWJoym8C4TJpXZ8JywYc6uG8DxH2bF65h+caJmObXvjhnNyapMRoaHg
 dHcphIcoYwKKmeStz3sl2YGa746SXSxL0v9pSBT4dTkDFIF2jjhFGtHZAbTVTHknzaz6
 5aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NIiOTnpLAsLsvEotBsCW7qgxVpyPSjsxlfZ4hcOEqI0=;
 b=mJx46MqowIZsFkPdUIumfoXIsXyCk9swERsWkri1VFJPejnRdqJpD+KhKA/lR4B0so
 kpHRXnRtRaFTSuXavsZ5OlLtXhEwGnsvS5+uVCMda4kMxSYa0KqS79Ole5+M5cBzIKKO
 c5Epv+1gijASg+LVvZz5b1E01CpjRYC2lte+wBISn1+JTlncxX/676Zoro3L1ojy/gGL
 V2WiIRqpUyeXsj0/ZMi/xYGyX7RZWpYrfDsSTpTkg73grMqZ2CsxcgtCchmZJBhIxnEw
 i/TiRGgeUYBvp+F1i7xbthWtA2rCdTN+W/ar8YyCXuDYUPAWuM/7OW+/Msk+r6nQQr+5
 79Rw==
X-Gm-Message-State: APjAAAVmB1hnlXW9eiv3F9Bx8GShjOznYHSZYhFOz+wPt+07johXjMak
 Q5mhSg+6+o6sgbIN3vFAmmwSKJbmE88=
X-Google-Smtp-Source: APXvYqySqa8t9Pvpz4U5w3S+Y9GLE7s77qBB/z3Wafzaj7F7u3rED7v+88zhNJGLuGMV+JIl48oBvg==
X-Received: by 2002:ac8:72cf:: with SMTP id o15mr2447816qtp.27.1572003562973; 
 Fri, 25 Oct 2019 04:39:22 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] linux-user sparc fixes
Date: Fri, 25 Oct 2019 07:39:09 -0400
Message-Id: <20191025113921.9412-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82d
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a v2 update of 
  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04240.html

Some of the v1 patches have been merged, others reworked a bit.

This fixes most of tests/tcg/multiuser/linux-user for sparc64,
except for test_signal.  We're still missing an implementation
of setup_rt_frame.


r~


Richard Henderson (12):
  scripts/qemu-binfmt-conf: Update for sparc64
  tests/tcg/multiarch/linux-test: Fix error check for shmat
  target/sparc: Define an enumeration for accessing env->regwptr
  linux-user/sparc: Use WREG constants in sparc/target_cpu.h
  linux-user/sparc: Begin using WREG constants in sparc/signal.c
  linux-user/sparc: Use WREG_SP constant in sparc/signal.c
  linux-user/sparc: Fix WREG usage in setup_frame
  linux-user/sparc64: Fix target_signal_frame
  linux-user: Rename cpu_clone_regs to cpu_clone_regs_child
  linux-user: Introduce cpu_clone_regs_parent
  linux-user/sparc: Fix cpu_clone_regs_*
  linux-user/alpha: Set r20 secondary return value

 linux-user/aarch64/target_cpu.h    |   7 +-
 linux-user/alpha/target_cpu.h      |  16 ++++-
 linux-user/arm/target_cpu.h        |   7 +-
 linux-user/cris/target_cpu.h       |   7 +-
 linux-user/hppa/target_cpu.h       |   7 +-
 linux-user/i386/target_cpu.h       |   7 +-
 linux-user/m68k/target_cpu.h       |   7 +-
 linux-user/microblaze/target_cpu.h |   7 +-
 linux-user/mips/target_cpu.h       |   7 +-
 linux-user/nios2/target_cpu.h      |   7 +-
 linux-user/openrisc/target_cpu.h   |   8 ++-
 linux-user/ppc/target_cpu.h        |   7 +-
 linux-user/riscv/target_cpu.h      |   7 +-
 linux-user/s390x/target_cpu.h      |   7 +-
 linux-user/sh4/target_cpu.h        |   7 +-
 linux-user/sparc/target_cpu.h      |  64 ++++++++++++------
 linux-user/tilegx/target_cpu.h     |   7 +-
 linux-user/xtensa/target_cpu.h     |   8 ++-
 target/sparc/cpu.h                 |  33 ++++++++++
 linux-user/sparc/signal.c          | 100 ++++++++++-------------------
 linux-user/syscall.c               |   6 +-
 tests/tcg/multiarch/linux-test.c   |   3 +-
 scripts/qemu-binfmt-conf.sh        |   8 ++-
 23 files changed, 238 insertions(+), 106 deletions(-)

-- 
2.17.1


