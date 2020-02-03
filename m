Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C53FC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A0E20838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzAX5rZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A0E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydAR-0001pK-86
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0i-000761-AA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0h-0003Lj-9i
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:36 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0g-0003L8-Jp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:35 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so18557027wru.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pbTFZCO7ADOXNmgFtzr7ygDnLBWMHSNndfGhWIzZQwI=;
 b=RzAX5rZP5/FBD+yNLHkwMSd679Kwq78O9fLcdmxWoX84EZT6LgKiqA+BqzMJ4v6yXv
 b4n7SPSFpeFUXYIF9Bn1Yxb7oL7FcNWfXgA39wPGPyhp2MR3nOcAc8HX0tkoMcGKy7d3
 Jw+/0xkPHTvbACleBLlk0m/dbNBC64+RBuwlYm6cAnPpR6eeKNp4d6axI9dSb5ramOf0
 bLRZUnUMJEZDF/GWGFH1iCDLsWILjHramcxVCvnE40vtrMI3N1poh3Tu4YmKWtFbX+53
 LycjB8ux8nVQO4zT7AHgzeLhlafnIgKW0A+SMqqLx0bCXrnBndbDHoEhyrEnuztORM4M
 OuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pbTFZCO7ADOXNmgFtzr7ygDnLBWMHSNndfGhWIzZQwI=;
 b=qCL63cgrNdhHl3bx18dTXeqMeXUY1dvOZMRQoFqv3bYCafzl+aRA6eyqZVclJQKEpA
 MOnkE4+td50geh2CTu7ZU8ZB4IHxCMKisti9wqoO8X1CkX73r/+yfq/D+OYqVMey8TNF
 f9gCbApxBQbOo7JTegAD7mmrnwpyjQY6ig7a2RioPQ9wZZME8sg3zsvfkXK//5y85gOl
 qEIQttWCRfRplTv7Mwt7PBFlLY6ol0EmUHZ/RdnWpuF6JdI09qPjTI7Ss/qb120JqBYq
 cpsVO9B33V1M6EX5FILzcDorLNfW5n8/ZpWdgzil6kgtusgOnWASt1oUjIGlEBqJ4Lm5
 6OKg==
X-Gm-Message-State: APjAAAVmYc2dmrfKIBJZ2BjwuLh6VXhFu3jfpUW2lNcnszn0ySrolq1r
 5WL3mW//mDtAFTloe7MIfY2/K4vljZUQ5g==
X-Google-Smtp-Source: APXvYqzG+CCELV5hLIIj8g4ne/4b7VD24A+RUsT87T/yAId+tY2iBh/KHpmO3qCjbX+Q9CX/TUHTaw==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr13585826wrm.89.1580741253484; 
 Mon, 03 Feb 2020 06:47:33 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/20] target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
Date: Mon,  3 Feb 2020 14:47:12 +0000
Message-Id: <20200203144716.32204-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes enablement of ARMv8.1-PAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 4 ++++
 target/arm/cpu64.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b0762a76c4..de733aceeb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2709,6 +2709,10 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
             cpu->isar.mvfr2 = t;
 
+            t = cpu->id_mmfr3;
+            t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
+            cpu->id_mmfr3 = t;
+
             t = cpu->id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             cpu->id_mmfr4 = t;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c80fb5fd43..57fbc5eade 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -673,6 +673,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -693,6 +694,10 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
+        u = cpu->id_mmfr3;
+        u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
+        cpu->id_mmfr3 = u;
+
         /*
          * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
          * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-- 
2.20.1


