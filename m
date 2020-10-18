Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD17C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88072227E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTw7BVNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88072227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFPP-0003Mf-2c
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNa-0001dc-MS; Sun, 18 Oct 2020 16:34:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNY-0000xd-KX; Sun, 18 Oct 2020 16:34:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so9154030wrq.2;
 Sun, 18 Oct 2020 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JltEwXbGzmO7Iz477A1CNJvyjNGP/jwshVCvgGssOxI=;
 b=NTw7BVNemAHcvBRqoWTLshLu4jivqW5YakETFN99wdCcTKLZ6jH/BTv33U+nyWBrIv
 ka09/4NG1rqLvsg0NrKDmgykvh7hTIufA8Caq1FrrqLzvoePoP2KGasoPTP0v8v6BJJl
 VDVECrB9WCHdDee95IKbb6xVEnlVKzCLNHif69qGtvPv8sqSIiXles+4v+DO+MW/RDld
 K/bSOtU7AVWp2hgdJyDsxUPSrcW5FTpJs3FSymbK8wrSdzfxj1MpOFQkzpe8jw4SJpFe
 xdCygaRZ0tYPjfz1edSnVxOd8tTlnkTQRz6zOu+MfM05nhfyY93l0V5J+6mk2KL8e1Kf
 SNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JltEwXbGzmO7Iz477A1CNJvyjNGP/jwshVCvgGssOxI=;
 b=GGLt6e3A7why+12B8fOx5RSN4GSYE6BwO8bwL30hxNBS822nlAhYcb50oQXz1NMJy2
 qXLK3CrF+o6yWFg/MWBNoPYcW2uijYjnQCsJFbXw3KH6fvTfzibbLIxHSGB3c/6tBz8U
 xN4Mi85bhfoAJwynaEfrPVQo2SwC0GxPMEjA9/0HF/VoISeSPeV4nY/8Oh1Dj+I7IqGn
 3jSQKWFtv8LwVH+eY02PwyKc64IdnrQoWkxaFJzgGRWsOAFyZ4s8DOWTt+Q+L3+/O6dp
 Ems+XjP97wlCvCFyTQxPxlcqQ/aYZs82YUkQb5nt86SaYZLV37zGpBzv28yR2tIm2oC5
 l4Tw==
X-Gm-Message-State: AOAM530BuTvfLVstkajBNhQP3SVjwYBBxoEYuEDiD81FIl7ss4gbXLUL
 KkfpoSPJWZhilJBf1yr+3iLuJI/kIn4=
X-Google-Smtp-Source: ABdhPJzl/cpUUSyqCT4RVaRiQObPh5b8VF72su4Twl/WOxKA9meLc4tXPxcd1lhx0Bc0rs10gKPsgw==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr15831401wrr.290.1603053246274; 
 Sun, 18 Oct 2020 13:34:06 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id k16sm13828755wmi.5.2020.10.18.13.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:34:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] hw/arm/bcm2836: Restrict BCM283XInfo declaration to C
 source
Date: Sun, 18 Oct 2020 22:33:50 +0200
Message-Id: <20201018203358.1530378-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201018203358.1530378-1-f4bug@amsat.org>
References: <20201018203358.1530378-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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


