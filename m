Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6404C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CAF206D6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSwQdtms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CAF206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j32y2-0006C8-Ka
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32ux-0008Mv-Nc
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uw-0004HE-Lz
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:15:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32uw-0004Gn-Eg; Sat, 15 Feb 2020 14:15:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id a6so14372084wme.2;
 Sat, 15 Feb 2020 11:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OGYngzYgREXVWzhCGP1KWkhVF6aFvpDG4pbFEluMwuQ=;
 b=BSwQdtmsMyoVXmvvjYpnuCj5l/+40G0pK0HDakhwOrTkgbAPecdCCtKo2NfHTs6I9F
 OPmrbI6auTNEuV4/xI8u/zmpZEFVfRrDE9xdGkV0W3uxXcprOR7QI4CeDonyKb4rEEpt
 YzL6ar89nfytbxiTnj+kGoCwa7hgP3wnfLgDHCHGSzgItmQaLOHSdjxzih6Wz8Xxyv/k
 hvLqY3dA8CD5d+VB/29reb6rOHNFQdVG0UWSKjz7ED0UbngWSeysOy7YUQLXPBOCkg48
 TI0ZnitQCtH42k3SUe58Mxezw+WHqxTxasYVW81oOVft0BooCkEZrDP0IjEVlaOISy0d
 3oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OGYngzYgREXVWzhCGP1KWkhVF6aFvpDG4pbFEluMwuQ=;
 b=ZIWc0NSrq0YXZ7D7CRTnXOFIYlqnkWGOltulqLWnPlNeMsv404jIYePk9cLTtRbuWH
 mkC6AHpPcgzPPHk6pboOiE29Qu6lRLik5E3I4ae9drgsqGbdCFxaqgu+FdkiwlaZwTnC
 4n6kcm8oGUAUZVzehg4wX/Gmbk5oXYV09e9DC/1Y2h+xXW/yO+4DwLTsiJPJRfPIRUVe
 wIbjjDu8AkHOq851URqRhJpyyHZ9ZlHhF0E5ssZlhai0DWlb/JRB50vUkjXPS/EtIz3m
 vlvaCXvHDbCTtkuug0iV8vdkvrtQKGgock9BIJWXl11tdKzqz5GZHDj5NO3LAlKypYQc
 9/nQ==
X-Gm-Message-State: APjAAAVIvNx2uEiBeuvpZXuFPsSVnBbzdd2SmOeoKHhNl2ASywYF7JYX
 bn+/jcYWbQva9Te09OylTY70lkwoTdU=
X-Google-Smtp-Source: APXvYqw7iqUSvswH7UqTR9IJcEvaQXVG0hQhID1/vck1MLmct0izTwOkPmvAcbEA9KxacJwBkOMziA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr11699582wmj.96.1581794153317; 
 Sat, 15 Feb 2020 11:15:53 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:15:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] hw/arm/bcm2836: Restrict BCM283XClass declaration to C
 source
Date: Sat, 15 Feb 2020 20:15:36 +0100
Message-Id: <20200215191543.3235-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215191543.3235-1-f4bug@amsat.org>
References: <20200215191543.3235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No code out of bcm2836.c uses (or requires) this declarations.
Move it locally to the C source file.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h | 12 ------------
 hw/arm/bcm2836.c         | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 92a6544816..acc75bf553 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -42,16 +42,4 @@ typedef struct BCM283XState {
     BCM2835PeripheralState peripherals;
 } BCM283XState;
 
-typedef struct BCM283XInfo BCM283XInfo;
-
-typedef struct BCM283XClass {
-    DeviceClass parent_class;
-    const BCM283XInfo *info;
-} BCM283XClass;
-
-#define BCM283X_CLASS(klass) \
-    OBJECT_CLASS_CHECK(BCM283XClass, (klass), TYPE_BCM283X)
-#define BCM283X_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
-
 #endif /* BCM2836_H */
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 38e2941bab..24109fef1d 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,6 +16,15 @@
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
@@ -24,6 +33,11 @@ struct BCM283XInfo {
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
2.21.1


