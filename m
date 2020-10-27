Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0691C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5191420757
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+C4ZKBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5191420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXONH-0003DK-97
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPd-0001SI-4R
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPY-0004ZT-NW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id c16so1106300wmd.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4gCx4xWOWeuP/eeBiipCqMEXDn/OPGTanL7PvSO7bvQ=;
 b=K+C4ZKBHDuS4XgWKbNERQ3vgfxKFhhnns/b2Ap+T8stB+F2wCZJwnPGUofcRst86KQ
 khjDRxaZvuRONupuj0AZPyWTvycxcWYt8hcFfxfzm9bx+jPI5WOFP9pKhmHu2k74aOXT
 DgOK2Em6yoDQf0GcNm/WowXHPPmH5gFL3HGkKjHm7OLZbS9PEacndqEZppdAZWdtiRXV
 A21NKW/NnCwmMquLZBgn1T0n4blF1eO9PYMnEnCmYHe2ZBfgsC0fSqD4R0DHmSXoEuAt
 zVwo/YitZ9MUUCBmxsDvqa1/mOCpVlSsIWKHW6IPkqQnIrKder4zJlSg9Gq8wRil9vfE
 VDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4gCx4xWOWeuP/eeBiipCqMEXDn/OPGTanL7PvSO7bvQ=;
 b=Bk3+Sle0St8kA8gVpreRh9TILpkBMgPjep6/d/st1kp3YkGxf6ScEckxw2MzaQrMrP
 Fg6cxt4csUvDajlm5x3s5GYdoK7+9chwEXMbUMtDjfp9ygjIJtDBSlH2II2qhf7bXZnP
 U+Xv9nM5RSI/sylK4QywH+0XuN+WcD4tzDunvgyMoeLEOitvS1g61/lFQepFwkNFTHg9
 oGUxS98RohSIuqCHeLFs/zZ3SDW7QZpz00TAMC1hot87zI1kIoo35OlKaFGdstuqMEkw
 sYdVWefDCYYydNEYMXaMqt7q1rpSvgUEQMU4eNDRM53+oSmLI5H7+2fRWC0jqQBpWAA5
 Ey2g==
X-Gm-Message-State: AOAM530jmHhwHQtuuFLRtXA64KLALYADGK+zXOtpcziICLE7i5bepNWG
 3+eTt0bsuKNCrp+MhYkT7JEVEEoFUXAM1Q==
X-Google-Smtp-Source: ABdhPJzRr6YqGANSpWZ0zKcayAz1BJNE3YAbJLdFGqLGHAvLuUoCYSB/4vEXcVv8OqtGeFvKD9Bj7g==
X-Received: by 2002:a1c:980a:: with SMTP id a10mr361540wme.103.1603799107132; 
 Tue, 27 Oct 2020 04:45:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/48] hw/arm/bcm2836: Restrict BCM283XInfo declaration to C
 source
Date: Tue, 27 Oct 2020 11:44:11 +0000
Message-Id: <20201027114438.17662-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

No code out of bcm2836.c uses (or requires) the BCM283XInfo
declarations. Move it locally to the C source file.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201024170127.3592182-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


