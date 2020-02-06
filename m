Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7FDC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6667F20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ZtxNzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6667F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW4N-0005om-Hl
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoP-0000nj-IA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoN-0003CS-9T
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:33 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoN-00036Y-2P; Wed, 05 Feb 2020 20:18:31 -0500
Received: by mail-wr1-x444.google.com with SMTP id w12so5157244wrt.2;
 Wed, 05 Feb 2020 17:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OGYngzYgREXVWzhCGP1KWkhVF6aFvpDG4pbFEluMwuQ=;
 b=e+ZtxNzraCnCFpA44qCYL1DhQ9sC+mCGzbpaRJu8oBsIvBs4PJJgueRGrM+gRfdTIK
 zq5MvIvyVcdWFhOTB9/iUgJr1xKkLL1irKqV3DI1zhGkoQBqKvG0qqu3Lev+Uih/1XW4
 fhH1x0SPOzGj/tQ5wrRz37c+zZEVjwSdtADQeXu0Ur6emYyqvP9RTApta9s+zI7rjzQx
 dq3iiCZzhGyTXZUhYUuiX7ssJ12l9IrnvNnCUakLoK1pS+c71GpWw2WlcMz73zyxxon1
 OpsycIvDCc992oGwqlacawG9abE/okknrjIOrEmg5Xt/8AzrLnZ/cvUYRrt++0Z2KaeP
 INxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OGYngzYgREXVWzhCGP1KWkhVF6aFvpDG4pbFEluMwuQ=;
 b=VgZYeBv8xzoclcwQNp4e6VsRY0CHwx9N/1reS1kxcPBl2pdigMPaLTLSwAgUANTUjd
 uWjwujiiI69pd2Ty9BDvYG1dLhTlToe3GAcUE85xYUy0LhNE2WMpXHQikOIY4t6pbN72
 jn+ah8oY+HREcCNXnIB7tkl6scHKKoV7pzqAUE7kcw/bSMKayiJnf9gAZf1rw78Ms5/J
 L6UD2Xu4mwMxZ39OeKKP5a9kY/MKjMAQ/zmVwbdLStvS6yuCn3yxj+Taby2MxJUJdSqs
 8sHOVGbHqCaTPMoCrStqQCtBppCFsDlZDeT9uC59npTfgky/6fOshwjCmeiGdiRKkqqI
 TPBA==
X-Gm-Message-State: APjAAAUbf6ZRNAWUmbVJefLkyHXMaPzPXP1hNkWobcYkMKzhNcfX/zQd
 JyI0au0JDbKdrmyHmFazBc2uKj5A
X-Google-Smtp-Source: APXvYqxI/NSpQzLw1fjm+zatnYpIlXWixmPO/M+DO7/Ww1/1hnXEFtX+mvU6cnlXaSMm1PAH+NYs7A==
X-Received: by 2002:adf:e542:: with SMTP id z2mr358528wrm.346.1580951909826;
 Wed, 05 Feb 2020 17:18:29 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/30] hw/arm/bcm2836: Restrict BCM283XClass declaration to
 C source
Date: Thu,  6 Feb 2020 02:17:40 +0100
Message-Id: <20200206011756.2413-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
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


