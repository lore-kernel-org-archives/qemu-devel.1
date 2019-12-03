Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDAEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3492320656
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rz4AFUJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3492320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icH8z-0006X9-W4
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH36-0002WJ-KZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH35-0006F8-36
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:40 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:43448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH32-0006B2-Um
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:53:38 -0500
Received: by mail-pf1-x42b.google.com with SMTP id h14so2562462pfe.10
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=5M+hNQ7PqoME350mKLj+u7s6uPF/0UJGDwjx2ryydPs=;
 b=rz4AFUJX/XK0drzcA7VkFar9Fa1fgRTQhuWrZozucAQ7MRGQuH7F2M0REfbFhh9mb9
 xXldjdlUTiMk2Vd4iNyP/gH1r/eP3RjtOQGKYp33rEAR+He6lN4sM/PBjw4ZO+01DVjo
 0G5YnokBqX7ZY7GcUYjzO1e2Fg7iGkzMWfJojufbQsuLVseCQHmeKOsT8Hr07N6Rt+V+
 jpbI+15lVkAkNlexI11B6GwSUxHpDV1jc0g1pxbQ8Y7I1sFU+VIVE+xlO+i8vvcRAiOt
 pW3RQSnTJaqjzOiohNaXrnIRUia+MXvYMaqi8Y5MqNDDSdkDeuJ+LKBsAZxMheW33ch8
 wp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=5M+hNQ7PqoME350mKLj+u7s6uPF/0UJGDwjx2ryydPs=;
 b=WX7IzALpujIVA3BHJcLpRBlShRRMZ6eAuWqHSjfYDMqmCP5YvDo6LIT21K5fL7NcUV
 mirZPk2/fkhLQDd99RZfp10uESB3Omq2zOBVzQ+AWyUqHR8fotPgLRxnikxV1t6gZnbl
 E86FAZYYZhH/P21E3PrODqLfxEvcLX5Mum6xdJifnjUOqJImrVzG7SbfklUc54f3bOUq
 BErbvQKC4kZYKYBPl1u/N7RIRNlh7Pqa0qMOB0/o1hXiAFFUo7oLFe3q7tRa0r0W45tW
 ptf0l2BGT4OPwrNaVzHSKeIC/UFgarEMrRQeOtUbBFynR73brj4g9283IMWpa9fXjihz
 AccA==
X-Gm-Message-State: APjAAAXM2yVPPNEBA3YhKjtYohFYrzQp2a88zZm67w/ow3Vk0IsV8QKA
 mJ5/rk5CAgtnYS75ynnjhoqBBegu7Do=
X-Google-Smtp-Source: APXvYqymMBJqAsu+uecgYzFN/UECHuuxVH6l36e17imn8O2/BkT1YvlCvjJBeF1JNoOpNdTwSDf0RQ==
X-Received: by 2002:aa7:8d03:: with SMTP id j3mr319461pfe.162.1575413615303;
 Tue, 03 Dec 2019 14:53:35 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] target/arm: Implement ARMv8.1-PAN + ARMv8.2-ATS1E1
Date: Tue,  3 Dec 2019 14:53:22 -0800
Message-Id: <20191203225333.17055-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20191203022937.1474-1-richard.henderson@linaro.org>
("target/arm: Implement ARMv8.1-VHE")

At least the PAN portion is supported in the Linux kernel,
and thus easily tested.  The ats1e1 extension is closely
related, reusing the same mmu_idx to implement.


r~


Richard Henderson (11):
  cputlb: Handle NB_MMU_MODES > TARGET_PAGE_BITS_MIN
  target/arm: Add arm_mmu_idx_is_stage1
  target/arm: Add mmu_idx for EL1 and EL2 w/ PAN enabled
  target/arm: Reduce CPSR_RESERVED
  target/arm: Add isar_feature tests for PAN + ATS1E1
  target/arm: Update MSR access for PAN
  target/arm: Update arm_mmu_idx_el for PAN
  target/arm: Enforce PAN semantics in get_S1prot
  target/arm: Set PAN bit as required on exception entry
  target/arm: Implement ATS1E1 system registers
  target/arm: Enable ARMv8.2-ATS1E1 in -cpu max

 target/arm/cpu-param.h     |   2 +-
 target/arm/cpu.h           |  74 +++++++++++---
 target/arm/internals.h     |  33 +++++++
 accel/tcg/cputlb.c         | 167 ++++++++++++++++++++++++-------
 target/arm/cpu.c           |   4 +
 target/arm/cpu64.c         |   5 +
 target/arm/helper.c        | 197 ++++++++++++++++++++++++++++++++-----
 target/arm/translate-a64.c |  16 +++
 target/arm/translate.c     |   6 ++
 9 files changed, 428 insertions(+), 76 deletions(-)

-- 
2.17.1


