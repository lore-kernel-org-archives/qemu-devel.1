Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B62F20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9EMf2Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B62F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwhX-00008i-L5
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:01:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU4-0004QQ-T1
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU2-000424-H8
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTz-0002pT-St
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id f9so3304550wre.12
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=wNEHwgukf5WI/ZuQacjhcTdXxd4lEFqyWVkk+y0IZC0=;
	b=j9EMf2NwkPeJmzEgzfvuUyB51g/EJRMPiYpORuQDdq4eCbShcS3tBMtCovlpMX3uYj
	CW/sDksKFru9nMLdeUWqOBIrzYSqLF1NOPi3tZUXWfs71wCVB3Ih4Uro84UJwLSrSbAz
	orZdxzqwRo8OXpoCobCBz59SJRJMRTV99ONa7kxnBacTVh8TkNkiae5PLb8CyjZw+l2P
	xcO0aUexzpSMsobGwiLudksQYHwtPrz651pFkd9ST/5Wdv/KTP+gNFHg2UXA3dopWIyz
	4T4xhRSS7FB6hSGZ/KYUCvGEISQK7tBQ64OrdaynenVLa+c70joe2nEQ/TMdeDMib3dY
	eYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=wNEHwgukf5WI/ZuQacjhcTdXxd4lEFqyWVkk+y0IZC0=;
	b=fG0diqsQVqBqjVIWJy2jf92IRELsWX6bw+u4fxHD/Lku8gio2F2eECB6X7U03hl6u3
	KBH/wyQ9138DnhYyFHkDAP4jZgpSX1FzvVg3RDGpeRk3RePd5wa+AJDIKRJfAzj7eTND
	bt+MjtuaFwrCAEVw5RCdFs6NGGRe7YLRVD1GoXSoc4m4twVPFDc6x35sbu7XGr2Ln3mS
	08Y41IxmSdeHojQge8Uv0X5to+0FVbt5cozRzzbu28lD23puQX/DngZGMYCc684IoEjF
	l9S3N3aFMr/9aAQAQk9hJICi43M9AqZjTxNHv6cfOiHR0ekxnc2GaabdhCeX9yRzILU6
	qs+Q==
X-Gm-Message-State: APjAAAWeaIMf1CZ+JVnLjwemfAwbUv79smPasA0Y6iyDko+RK7/DdRxu
	NjGHkKvvxz67bAv2C/IMYgfCWiyVDAJxYA==
X-Google-Smtp-Source: APXvYqwChzrIVQbVxudiR0nyWL6jb8rGmguMxUAh+binptojfe4/ERTcCqjJWXtDnsUZ+MA7gOf8LQ==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr15934727wrw.73.1559843176537; 
	Thu, 06 Jun 2019 10:46:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:32 +0100
Message-Id: <20190606174609.20487-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 05/42] target/arm: Explicitly enable VFP
 short-vectors for aarch32 -cpu max
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment our -cpu max for AArch32 supports VFP short-vectors
because we always implement them, even for CPUs which should
not have them. The following commits are going to switch to
using the correct ID-register-check to enable or disable short
vector support, so we need to turn it on explicitly for -cpu max,
because Cortex-A15 doesn't implement it.

We don't enable this for the AArch64 -cpu max, because the v8A
architecture never supports short-vectors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 044c4dd738b..3f06f6d1a20 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2022,6 +2022,10 @@ static void arm_max_initfn(Object *obj)
         kvm_arm_set_cpu_features_from_host(cpu);
     } else {
         cortex_a15_initfn(obj);
+
+        /* old-style VFP short-vector support */
+        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+
 #ifdef CONFIG_USER_ONLY
         /* We don't set these in system emulation mode for the moment,
          * since we don't correctly set (all of) the ID registers to
-- 
2.20.1


