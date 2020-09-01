Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C667821707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hveNNSlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C667821707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Ki-0000qF-TV
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD84A-00014K-R1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD849-0006L8-3p
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id g4so1497150wrs.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uzjObAYNgbbOg5233R77daXvzkwZjkTSAH8Bwsy7iRw=;
 b=hveNNSlMTrfzgd9uk0Fisi/DoDqlHnT3DtvP8qGdle3Sq2vPZPlHMncDAxZeCmPJx8
 8TW6VixlLl5XoRJ3y6Ca3JxouwFIFL4I1jsJ7HGDlSAnm8KzknD3j7EYY+WFUeMiSu5V
 vWcRcebalRpa+Q+5fwJ6hBFyoyj1A6UQVHfS14f9ImD0VMALoYdJsAoUuT1VjlCSJ16/
 dhLmyrlyejRDwgY3xAQ+k5yERhDcx8DvEQH9nY7oifBln9I82DtW5IafylJoxAmWukD8
 n+wRL2e5tiIi9PgDuSjpKUo3SQuqfgy7ReJEWaG5c9+0Se6h5rwaS1z/sInSzfwoNmk/
 21dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uzjObAYNgbbOg5233R77daXvzkwZjkTSAH8Bwsy7iRw=;
 b=nFn2AQvRK0UT3lPLKBMXl0HJpp4IlTigSJjMZhOTehpeUV3yiR0Sq6+/KrzTlO6Oc1
 R48qAGJztCpxd1kUA4aC/2Z8MIEBH+P8hEGTSNqgO7Ul+kUEVuPWq9mF8fFLwn0X9TEO
 InAtot3DB+PO9cAGViot4bBFowaCsprHllVOXjLSHtao7puph3CmIOf+olEKvgSu3NBe
 IgyZMTod990wDu4o0Ybo2OD4lK/u5ufNX/SvFP1rTJ+IvNkTEd2aWICr4Hykt+EDa6uU
 HQgML2Gwog04WWrFL/JwfBZo2wazMoGFBjIqegoD29MZLIJ6n/6WXCPgOpkgavlWOaKy
 fhOg==
X-Gm-Message-State: AOAM532uyN5h+u6QhzRZcVStslAeCgl3j0FXPHPJMyx+YOcefZT3na1M
 motG5w2l8u/DFDDg/X3Sktzo6IcgkxHvI27v
X-Google-Smtp-Source: ABdhPJwN9fpeNQlnfxjJcnRQ9TsTjk1j4Tso5oikQLpVGhMZS8yzTv0aNX4gFvIVPHUeVd67EAYUfA==
X-Received: by 2002:adf:ab5a:: with SMTP id r26mr2407043wrc.194.1598973559547; 
 Tue, 01 Sep 2020 08:19:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/47] target/arm: Enable FP16 in '-cpu max'
Date: Tue,  1 Sep 2020 16:18:20 +0100
Message-Id: <20200901151823.29785-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set the MVFR1 ID register FPHP and SIMDHP fields to indicate
that our "-cpu max" has v8.2-FP16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-46-peter.maydell@linaro.org
---
 target/arm/cpu.c   |  3 ++-
 target/arm/cpu64.c | 10 ++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6b382fcd60e..c179e0752da 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2143,7 +2143,8 @@ static void arm_max_initfn(Object *obj)
             cpu->isar.id_isar6 = t;
 
             t = cpu->isar.mvfr1;
-            t = FIELD_DP32(t, MVFR1, FPHP, 2);     /* v8.0 FP support */
+            t = FIELD_DP32(t, MVFR1, FPHP, 3);     /* v8.2-FP16 */
+            t = FIELD_DP32(t, MVFR1, SIMDHP, 2);   /* v8.2-FP16 */
             cpu->isar.mvfr1 = t;
 
             t = cpu->isar.mvfr2;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dd696183dfb..3c2b3d95993 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -704,12 +704,10 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
         cpu->isar.id_dfr0 = u;
 
-        /*
-         * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
-         * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-         * but it is also not legal to enable SVE without support for FP16,
-         * and enabling SVE in system mode is more useful in the short term.
-         */
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, FPHP, 3);      /* v8.2-FP16 */
+        u = FIELD_DP32(u, MVFR1, SIMDHP, 2);    /* v8.2-FP16 */
+        cpu->isar.mvfr1 = u;
 
 #ifdef CONFIG_USER_ONLY
         /* For usermode -cpu max we can use a larger and more efficient DCZ
-- 
2.20.1


