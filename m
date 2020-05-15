Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE24C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7768520671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5r2vyxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7768520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbDs-0002Mp-H5
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbCv-0000bO-80
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:36066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbCu-0003rK-B4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id k13so1661856wrx.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aL6ItULe8uy/C+feP/tdNAy0BWvdReAXzNWosk7d33A=;
 b=Q5r2vyxQ8ge0ZWy8b8ROWYPNGUvz43I8u4UtyA3idBuQSmcBo7aJzCOAeA+wdVetX9
 TLeWNrrV4KlYoGRIWVRjfazsiIpX04rwypQ25nmgm8vroyHjfWA7psJado6Wf4EW3h9v
 YmsBaKuenMcxCbvisglyUP0yJRs9540EzEKav0ftnw2xdHBIH2n/T/cMB/Gfrt07Mp9p
 lSUXSEBf3jkkrgPA17Zf+iSdYIVBG6u861tkpaqlkx1D9PsCUDjTf9RTmrjZL+WrWH3m
 ju6LY3Amf5g5Cgabhk2eyMXWgEQSdcntgiPH8r1gnWDXAzEN629stmhe4zaxrGi7H6ay
 xpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aL6ItULe8uy/C+feP/tdNAy0BWvdReAXzNWosk7d33A=;
 b=V3d/5L4scIu0BADhbz8ZJWfdY1zUSWbECi3XOd4Wkldc3RjwGYPgc0gHpZv8+kwhwy
 uaP8k4IqiWen8GI+//7qjLZzy2eY/OQenvgaSXD4wa4QRJGAC47FbWPn68XZI0mvFjEU
 0KxmYgF5a86BoT2xNCCJhDEqlcz8Sg4YU/9CahbsI7bD0zn5CfjzqRR+aawogtxZlD5f
 GtBbDb+v1c3w7+vzVXrLyoNfhXHzV6PJVtJt/H+4QtLlCvsB88z9waPZKz0kIIQMv3eD
 Pjp9g47SBXNkwo92amgicqDkQdQ77z5HR72rI4YUkpiyJf4TgAZcEv6R87w2+i2lwQEy
 f1hQ==
X-Gm-Message-State: AOAM530y8dvHEQb4iEmQr4ZMqAJn30IiSS8vNEUAzqH+tbkAdVgEo96l
 EX5E05U6AXNN1sGjoT6xzVmr5g==
X-Google-Smtp-Source: ABdhPJzkyTt3prCoSAWuTpCA/7OxeH4Y3jixMEQTO6lAdAQi+b/+v1hzlYtih0CMeiZgSNsxJGfoUg==
X-Received: by 2002:adf:face:: with SMTP id a14mr4444256wrs.397.1589552458682; 
 Fri, 15 May 2020 07:20:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s14sm3738327wmh.18.2020.05.15.07.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:20:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/10] target/arm: Convert 2-reg-shift and 1-reg-imm Neon
 insns to decodetree
Date: Fri, 15 May 2020 15:20:46 +0100
Message-Id: <20200515142056.21346-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the Neon insns in the 2-register-and-shift-amount
and 1-register-and-modified-immediate groups to decodetree.

Patch 1 is a trivial dead-macro-deletion that got missed in
the 3-reg-same conversion.

thanks
-- PMM

Peter Maydell (10):
  target/arm: Remove unused GEN_NEON_INTEGER_OP macro
  target/arm: Convert Neon VSHL and VSLI 2-reg-shift insn to decodetree
  target/arm: Convert Neon VSHR 2-reg-shift insns to decodetree
  target/arm: Convert Neon VSRA, VSRI, VRSHR, VRSRA 2-reg-shift insns to
    decodetree
  target/arm: Convert VQSHLU, VQSHL 2-reg-shift insns to decodetree
  target/arm: Convert Neon narrowing shifts with op==8 to decodetree
  target/arm: Convert Neon narrowing shifts with op==9 to decodetree
  target/arm: Convert Neon VSHLL, VMOVL to decodetree
  target/arm: Convert VCVT fixed-point ops to decodetree
  target/arm: Convert Neon one-register-and-immediate insns to
    decodetree

 target/arm/neon-dp.decode       | 280 ++++++++++++++
 target/arm/translate-neon.inc.c | 662 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 511 +-----------------------
 3 files changed, 944 insertions(+), 509 deletions(-)

-- 
2.20.1


