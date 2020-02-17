Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798CC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640B2207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9GPf9p0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640B2207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3f0U-0004U5-Kg
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqU-0006kf-BL
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqT-0002Uu-9G
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:50 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqT-0002UQ-2e; Mon, 17 Feb 2020 06:45:49 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so19314973wrh.5;
 Mon, 17 Feb 2020 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uxynYOVPY9FVrupSLyC8th1oxyDcEka8bWnY9WEi7fw=;
 b=s9GPf9p0R2STFOzaGw4bh+SxG+CZMAZEgpgLIdIU9XAC4AEvm5hS8F/feqqDHfxwID
 70AkD/qLQf8dGKpYaAqiER9jDUa69eV1C4wU58tOLklbJ/RAAFXHU0DD/W7DIGhu4je2
 Gu0Z2SQ9vBp/RNfShBHCRn6abI5RJqUCunqcogJnIEqRLiVEDuE4X6IsOwq6TFMG63OR
 fLdOXA02uvfdLmCIzpSFtV/7+xlpI5ivr4Ud0sCmyxhnTxapWeOdrLAty7e4jtjZhfqe
 0pANuVJZPMTPR1kDJu6dNAMMCjOX4kCJ8QHB5vhpVRhIfnSL70VkhY+d6ZUBjd6sYagB
 k4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uxynYOVPY9FVrupSLyC8th1oxyDcEka8bWnY9WEi7fw=;
 b=sNY9Ah8TuQlZwbK2e1w6I1SJEqLLTcO+czX9bF4HZeBo5siDq3hxyi/gVkYpjUCX1g
 vGCRDo9vv8CdUjrrSUI6u8kMm02SLIttgFYDmXmT0nGFicbKiVjRzo4cKroQbRC7avDG
 wZs4SZ+6h3Rc+oHbJdlY1SVYwse2/BqyMqgAdjHMDIupRUAPMKcSunz8sJ4r7tQc58Jo
 S44Fon+3oPXz4IRk2ZhPtPfKOOrlp4vvKVAIr1PvBNDGv0GuTHQUexQZbR2LazKp7b2X
 TZogrQGNM2EhtmgL4L6eLG2V5t+zbNmyjPeKnnGo23HHr/95Cl3GmGo9FYvHeicpLV59
 /pwA==
X-Gm-Message-State: APjAAAVmbhrGNd9RmvC1R3LbVxdpEQLj0nA2u/Q/TczlrR0mq6skF+xy
 ToitXOOdKwwXDZFVeyhDhKiSF7OhHco=
X-Google-Smtp-Source: APXvYqxIlah5lIud2Jk/dYxX9uP1e3YzCLlDFhZtdJR4fhicmTqQF2oTBBFbfewB51UETJRMKqWPZA==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr21423847wrl.26.1581939947940; 
 Mon, 17 Feb 2020 03:45:47 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/13] hw/arm/bcm2836: Only provide "enabled-cpus" property
 to multicore SoCs
Date: Mon, 17 Feb 2020 12:45:29 +0100
Message-Id: <20200217114533.17779-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217114533.17779-1-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It makes no sense to set enabled-cpus=0 on single core SoCs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 3b95ad11e9..caaa4b625e 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -32,6 +32,9 @@ typedef struct BCM283XClass {
 #define BCM283X_GET_CLASS(obj) \
     OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
 
+static Property bcm2836_enabled_cores_property =
+    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus, 0);
+
 static void bcm2836_init(Object *obj)
 {
     BCM283XState *s = BCM283X(obj);
@@ -43,6 +46,10 @@ static void bcm2836_init(Object *obj)
                                 sizeof(s->cpu[n].core), bc->cpu_type,
                                 &error_abort, NULL);
     }
+    if (bc->core_count) {
+        qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
+        qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
+    }
 
     sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
                           TYPE_BCM2836_CONTROL);
@@ -154,12 +161,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property bcm2836_props[] = {
-    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
-                       BCM283X_NCPUS),
-    DEFINE_PROP_END_OF_LIST()
-};
-
 static void bcm283x_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -179,7 +180,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0xf;
     dc->realize = bcm2836_realize;
-    device_class_set_props(dc, bcm2836_props);
 };
 
 #ifdef TARGET_AARCH64
@@ -194,7 +194,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
-    device_class_set_props(dc, bcm2836_props);
 };
 #endif
 
-- 
2.21.1


