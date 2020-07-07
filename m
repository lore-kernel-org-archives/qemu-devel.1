Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF42C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B047206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oakcWDUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B047206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsr29-0002ts-QO
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jsqec-00011b-Qr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:41:10 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:37934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jsqea-00058c-1e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:41:10 -0400
Received: by mail-ed1-x531.google.com with SMTP id n2so30034303edr.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=c6R4YraSjZRLmmtSSoq2xFbk8t8ZSJieQWBFNtUABUI=;
 b=oakcWDUrIdYUOwHKMiFbeN5AWC6Rbw261ztz1ocdGJHfUfIjQEqjj2tZEP5HV4ytmv
 DWy6N6uXxNaub/Aur10OeGhDs2TbJ+W+q7KQAenHFbStjSpyvVLqRPvFIIKr8BTaYQ4n
 bUEkUzymZGpNFYxmHEH8As4Uu6EiNuLog8V6Kmx/5gLsPnjLXIRvUOz4aCJhsH7Gj0hf
 pXlBYEsJr0QpqIt1QC9e0d5QDst8FldlpS8CN2gsAweMwHzvy194neZzmNdEu41JHybS
 xNiGIBJW4Iff4y3ERRpOGDvgdnmAww3pE+EwCz8okHBRx23CunczBK45Lbduy+/M9U+o
 xGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=c6R4YraSjZRLmmtSSoq2xFbk8t8ZSJieQWBFNtUABUI=;
 b=LwT8ChkQwWuHtTJmBEqSrb4x3/0xJtxbrCE2/fVtaIvUCUrcIDfI+E0XBcmRBbDDzN
 Eq+p9C4MtxpcaqJPR9LOjz4LhlhtFi8A/Jk24sd0kIl7ND5BNjr+aiDydZc7R4pXGy4A
 S95GurLs208x9rIrbWhPkbhMT1LgGZTiPyH1DyJVtt+aOq4FLgdHOzWcB+aUdyCJhM/c
 TqO9LEIDT18cE/f8Hzt9kMFpOknA3ifB/1FHW1oPQVFrnaQLeaGE9X9jZ2jd8LymRfGW
 UWhDJYdLlqp/Xvj0ncUvUB/vRtL10u91kAotf0w5KRZcOA8Onj8cBiK45DALjDNjPTb+
 vzqA==
X-Gm-Message-State: AOAM533t4Dk64JELPVFPgUCFcXR6yFePkXQUGnd2ki9auV1kqWIRC+2Z
 gyebU0cDBmbnaEIQKZvlHfqJ8n9G
X-Google-Smtp-Source: ABdhPJzgaVQljVxhaAgftRTVkMsqQaZ9+iAgC5Hgo9uTfUNpyvO5C+Gelab+jjXUVQxANDS/TtQMEQ==
X-Received: by 2002:a05:6402:1544:: with SMTP id
 p4mr63453972edx.334.1594140064036; 
 Tue, 07 Jul 2020 09:41:04 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm26428065edx.75.2020.07.07.09.41.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:41:03 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/3] MIPS + TCG Continuous Benchmarking queue for July 7th, 2020
Date: Tue,  7 Jul 2020 18:40:59 +0200
Message-Id: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 710fb08fd297d7a92163debce1959fae8f3b6ed7:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-06' into staging (2020-07-07 12:41:15 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-jul-07-2020

for you to fetch changes up to fa6e7da119b6da4067e757924e165bc737bb1260:

  scripts/performance: Add dissect.py script (2020-07-07 18:32:20 +0200)

----------------------------------------------------------------

MIPS + TCG Continuous Benchmarking queue for July 7th, 2020

  Highlights:

     - Fix for a regression in FPU emulation add.s.
     - Add Loongson 2F disassembler.
     - Add a script for a GSoC project.

  Note:

     - A checkpatch error and a checkpatch warning are known and
     should be ignored.

----------------------------------------------------------------

Ahmed Karaman (1):
  scripts/performance: Add dissect.py script

Alex Richardson (1):
  target/mips: fpu: Fix recent regression in add.s after 1ace099f2a

Stefan Brankovic (1):
  disas: mips: Add Loongson 2F disassembler

 configure                      |    1 +
 disas/loongson2f.h             | 2562 +++++++++++++
 include/disas/dis-asm.h        |    1 +
 include/exec/poison.h          |    1 +
 target/mips/cpu.c              |    6 +
 target/mips/fpu_helper.c       |    2 +-
 MAINTAINERS                    |    1 +
 disas/Makefile.objs            |    1 +
 disas/loongson2f.cpp           | 8154 ++++++++++++++++++++++++++++++++++++++++
 scripts/performance/dissect.py |  165 +
 10 files changed, 10893 insertions(+), 1 deletion(-)
 create mode 100644 disas/loongson2f.h
 create mode 100644 disas/loongson2f.cpp
 create mode 100755 scripts/performance/dissect.py

-- 
2.7.4


