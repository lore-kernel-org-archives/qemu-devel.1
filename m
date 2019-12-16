Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20EBC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8802082E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hY+zSFho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8802082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoQx-0004a3-SB
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFW-0007RR-86
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFS-0007YC-63
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:12 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFS-0007Xe-0C
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:10 -0500
Received: by mail-wr1-x444.google.com with SMTP id g17so6736382wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YMTEMJh/emKVxwbHbtHlnAEduqLFBKcxuqgnspTaEPo=;
 b=hY+zSFhon4ZaEkZild+FK7ostL8Qbx+iMZpglJVYtq2zuCIjGuu5VyDD9fWONGXsQi
 dkbAdLGYjjQO5VeSPy40oORjyRLZZjhGgs7apCUv4TuhWqkKAPeI1+vbIR5K94yg3Be9
 eUYb2qcZ6sF+ltSD+dWmOopZFcCoVb6ULsN/FbGhAPLB2eXz95OTMHmKxn2R0lTd4pnu
 uZOPSxD/MD9mtJD4dfuaG+jhnpxabztOWupemdkr6+rfAcs9SERu7KRpKD+cADdnti+t
 cPNY2JKh8pOtHYr/kySFtWtHn+/TvGnDtwBiicHxj6V+kvKpZopYf+L35oawIOm5XJLm
 Q6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YMTEMJh/emKVxwbHbtHlnAEduqLFBKcxuqgnspTaEPo=;
 b=EFktFZuI8/P3Owp1iVmQGeV+IxCdoH5uzb4bINhbgXqKaCJOCWZdX9Dr/kRgMYCxWN
 iK8/7ccUX7e6cvlY2KCXNb2xnEzbgvBVKfi2DfeyYW301UL2yL6RajmW7DvcgCu42StW
 upbYtC97itq81KAyxeVZ1IQfDoFrj4jjv57KA0TW9Z4x5aLa2PStEVm5fLkXAYMlWmi4
 shmui3704w/s7l4tHwCWlf2uO8sxyj2EsnWveWolf51GI5OvzGa1ZxuPjTEdzBzianK0
 kOhNAKlGuhI2PJ1Wn1+jeuYajj8Kf/jSZLiGcCjG5WZ6Dsdb6Tm9JO7Dr9TOi2j9GauR
 p1nA==
X-Gm-Message-State: APjAAAVGlRrt7yWJ/od+pJH0E3PqHWI8zwHSk0yvi26AfMNz2HqoXYTo
 VT7sr1r9elaJxbqo6Wnju7JWHLVIrPlWuA==
X-Google-Smtp-Source: APXvYqwBWbiuFRE4U4nFWbd61CsWHFQguruHt4PUcEF+OZJi320svn0rOGGp5hP5XR73hx2ndRApdQ==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr29450377wrw.311.1576494548852; 
 Mon, 16 Dec 2019 03:09:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/34] target/arm: Add support for cortex-m7 CPU
Date: Mon, 16 Dec 2019 11:08:31 +0000
Message-Id: <20191216110904.30815-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christophe Lyon <christophe.lyon@linaro.org>

This is derived from cortex-m4 description, adding DP support and FPv5
instructions with the corresponding flags in isar and mvfr2.

Checked that it could successfully execute
vrinta.f32 s15, s15
while cortex-m4 emulation rejects it with "illegal instruction".

Signed-off-by: Christophe Lyon <christophe.lyon@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20191025090841.10299-1-christophe.lyon@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339bf..dd51adac059 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1975,6 +1975,37 @@ static void cortex_m4_initfn(Object *obj)
     cpu->isar.id_isar6 = 0x00000000;
 }
 
+static void cortex_m7_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    set_feature(&cpu->env, ARM_FEATURE_VFP4);
+    cpu->midr = 0x411fc272; /* r1p2 */
+    cpu->pmsav7_dregion = 8;
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x12000011;
+    cpu->isar.mvfr2 = 0x00000040;
+    cpu->id_pfr0 = 0x00000030;
+    cpu->id_pfr1 = 0x00000200;
+    cpu->id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->id_mmfr0 = 0x00100030;
+    cpu->id_mmfr1 = 0x00000000;
+    cpu->id_mmfr2 = 0x01000000;
+    cpu->id_mmfr3 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01101110;
+    cpu->isar.id_isar1 = 0x02112000;
+    cpu->isar.id_isar2 = 0x20232231;
+    cpu->isar.id_isar3 = 0x01111131;
+    cpu->isar.id_isar4 = 0x01310132;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
+}
+
 static void cortex_m33_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -2559,6 +2590,8 @@ static const ARMCPUInfo arm_cpus[] = {
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m7",   .initfn = cortex_m7_initfn,
+                             .class_init = arm_v7m_class_init },
     { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
-- 
2.20.1


