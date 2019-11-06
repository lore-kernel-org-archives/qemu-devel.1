Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E2C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E7A2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mvy5YVon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E7A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJay-0005gc-4Z
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZA-0003m2-7V
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZ8-0007Er-8h
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:33080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZ8-00079K-0A
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id a17so1364253wmb.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mhrOzofaCWIJFCVDwPiLXME5UaZdBlhyAX2UwDZp+B4=;
 b=Mvy5YVonUvB51+vNyUtkeTre4gws2fGfhO0Ypc0X+k66nP34FWk47sB8E5CeKBZ0zT
 gYRin7BD6OYoSKxrYxy4I/F9w7Y+ayZCPpaqYUj0VUC8ZxY1iHsUhM5hy7x1lMUniXeP
 e7+82v2KEyjmWrLyQmBgR7O9dNUIOqB7HCVBsaxdMONaScMKl7B9jffOV+ONle5l6A9k
 1ToC51VVgx01BQdPQqaYRLlno0VJ9UdbRXGA9eC/h39LMGFcv5L4KhhQIL2iZwBB2l5b
 bvL/VqR2SBuDnQdF5PpYiukv/xNFcPdXyeuqNEt6rlmQsnz0FSRQ/rtBgYTUcYguztyo
 4iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mhrOzofaCWIJFCVDwPiLXME5UaZdBlhyAX2UwDZp+B4=;
 b=gdETegZ+SnzYoCN9N7WPZFt2dLOVMCEQr8ZrXZOEUp9fU5WEKorGmThmW5AYNP45NS
 o1pqqcHVpu4ALpE9zGNWaVVg0P+/rlTzI904TnFB5vzHSRrbAIiT84UC3hjp5vsmnMU3
 5M2IU6BrUJDuzLxlh0OcL8fqpTG7ctGOrkED57CUhPaLyvLPZLbxDDrkNptO+atLpyH5
 Q2r9H+KJ/xCC2PTew0AxdJ4LR0abiEesjodh+Cv7Pel7WnrzvdgdpKrUa/p6cQfR+IP+
 jdwk51Zi4buSunYG4sGVbXiBe0oVVZcMHZ5zQExWS9XxVc+jlWKo9Z8IcZ18spNebaPO
 zzvg==
X-Gm-Message-State: APjAAAXVAyQpnnSPEr9VnybmiiM24AIV6CKZSncfqqXvhFHe2xRgteSE
 af/JBJ/XyNDubi3kDiR2yYi3fSa/fntZJQ==
X-Google-Smtp-Source: APXvYqx+GmIE4mDj9wTS7ur98bIGqPsTOHYaLsEE7juY0WlwnCo33inLc8VW6pBDUuIKKbjZwel9pg==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr2131605wmi.67.1573040010564;
 Wed, 06 Nov 2019 03:33:30 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] linux-user sparc fixes
Date: Wed,  6 Nov 2019 12:33:06 +0100
Message-Id: <20191106113318.10226-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes in v3:
  * Fix checkpatch errors in patches 5 and 8.
    There's lots more style errors left to clean up in
    these files, but this is enough for now.


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


