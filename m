Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0822C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB582085B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwzJh/5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB582085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWMzp-0004Kl-En
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvE-0007H1-DT; Sat, 24 Oct 2020 13:01:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvB-0005hB-QP; Sat, 24 Oct 2020 13:01:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id n6so6435658wrm.13;
 Sat, 24 Oct 2020 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JltEwXbGzmO7Iz477A1CNJvyjNGP/jwshVCvgGssOxI=;
 b=GwzJh/5HvIMW1HN/x+/u1vbdXDls3UbtgIv9AuP4kGrCnbou9hLYR8d4YvmCJRYXpv
 VXP7PE7EPk38lVmbvSExFhND/2l6IxIxImJX4UKYH5iSCmcYhqxrWFG8hKMRVsr7Cuum
 odKSxvIQn7XP6tIlw2O9NQk86zzyIGGoqjfT5dTFWwNbXCp2alM3WHRhLL1TrUgISpAq
 DCSuV2yU42az2baWrrx1vfrrP4/TMwMueCBz16T8VsvAcJNXnU3a4qJ5+4AgYS9op3eb
 SixzTLQiev/1sRhMnYZHjZCqwZpLOaic1J7mqkIQtm7M45hDr2PtlavkyrmxNMn7ujLm
 7XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JltEwXbGzmO7Iz477A1CNJvyjNGP/jwshVCvgGssOxI=;
 b=O/JK5RKF2OYcAKJ2cp0bjnalDhSPTT8zXAZscFkwa82ec/llIDZ3jvL/T4+gaDVWvy
 4KcysnNbqelD5FwbQODnjyTd776glLiusnk6M8+CQjPuFgZylLN9YVXyi7Yv1CGBeBAi
 eQS4HuOdSW3l5Ha9VreRAogYeXRBd0u2pHfLZ2YJ7OEpRIGZohbZ0SRnsqmvKQ5r0BUX
 jrqaW0hBOoFC2dFkZZ2sKh/TLC1Occ+HoAka73+Ex1L5fcynU23rm80Q6VSHYX7DsyPW
 sgxmzZF9r8r5Qnpo2PTUwK77fCklcuG8ExjzKjFud6w0+K3CblbnrcNEB/iyY3T9NMW9
 rTFg==
X-Gm-Message-State: AOAM530rgTN5VN016Isd0c9EpASwoIkYZWL5UlRApdRYj8A34vLBko1c
 /1o/+k2O5znQ22LUvx9z/emXDWLYcns=
X-Google-Smtp-Source: ABdhPJxIMeyJQrJINxobfBB/6PSTQH2Jk+bKOwynBJmuLLuecA+/z95+RbCLVJM4h57tnZ42TJEEnA==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr9226262wrw.229.1603558895163; 
 Sat, 24 Oct 2020 10:01:35 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q5sm13581801wrs.54.2020.10.24.10.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 10:01:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/9] hw/arm/bcm2836: Restrict BCM283XInfo declaration to C
 source
Date: Sat, 24 Oct 2020 19:01:19 +0200
Message-Id: <20201024170127.3592182-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024170127.3592182-1-f4bug@amsat.org>
References: <20201024170127.3592182-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No code out of bcm2836.c uses (or requires) the BCM283XInfo
declarations. Move it locally to the C source file.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h |  8 --------
 hw/arm/bcm2836.c         | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 428c15d316e..43e9f8cd0ef 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -43,12 +43,4 @@ struct BCM283XState {
     BCM2835PeripheralState peripherals;
 };
 
-typedef struct BCM283XInfo BCM283XInfo;
-
-struct BCM283XClass {
-    DeviceClass parent_class;
-    const BCM283XInfo *info;
-};
-
-
 #endif /* BCM2836_H */
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index f15cc3b4053..e7cc2c930d9 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -17,6 +17,15 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 
+typedef struct BCM283XInfo BCM283XInfo;
+
+typedef struct BCM283XClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+    const BCM283XInfo *info;
+} BCM283XClass;
+
 struct BCM283XInfo {
     const char *name;
     const char *cpu_type;
@@ -25,6 +34,11 @@ struct BCM283XInfo {
     int clusterid;
 };
 
+#define BCM283X_CLASS(klass) \
+    OBJECT_CLASS_CHECK(BCM283XClass, (klass), TYPE_BCM283X)
+#define BCM283X_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
+
 static const BCM283XInfo bcm283x_socs[] = {
     {
         .name = TYPE_BCM2836,
-- 
2.26.2


