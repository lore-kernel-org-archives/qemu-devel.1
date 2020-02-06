Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D22C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED1220661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnEPlkg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED1220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izVy6-00065n-9u
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoW-0000vl-5U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoT-0003bU-3w
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoS-0003Y5-U1; Wed, 05 Feb 2020 20:18:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id m16so5105046wrx.11;
 Wed, 05 Feb 2020 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uxynYOVPY9FVrupSLyC8th1oxyDcEka8bWnY9WEi7fw=;
 b=DnEPlkg9gxk004kUnFnkYNnpchTdTY70nFkLVQf17Ok8GoDrK2VBLesZMOqp6oGtJJ
 yIJFfw9bhsZNOidY2KeAxdYIYz8SG4h+djyZmf/yWOJvqve/q+/mwrBPYPUQtk8247CD
 reOj6azRk8iomiRILRJqmN8rLXMQCNM3v7vSUdVq/g/X25IGNwOCzlFXqHWNeIZlhBQi
 VgGPHz7GeYpwDziQpNQq4FxGxvQqW9J4nlmcxftn193CO4+fy9WyKfyTF2vfGTPuhXpy
 DLbzgYbLNQrj687oNGwVQRCw97vvCdW5kp2/zu1dR4rqtevjIqBSYP/2Qh59D71ukNYP
 7fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uxynYOVPY9FVrupSLyC8th1oxyDcEka8bWnY9WEi7fw=;
 b=YwkZriaUYv7RpADFNPI6Cdan2haL+7gT1Vua0EEWgvYnUgapvvE+ZxtUFTi6jMEoUH
 TYQwUgixAUTPt9mjvClVjfEjdYUCxwkQASQQTMXOhpzEfBbUoTY16xwzT3SRqNiPtC77
 cnuS9tGw6/YXkLwu8bDG0ag4dwp34NUkfThwoa7Yk6aKx8LRy6b/BiaVpCt1xQsuG43T
 HIF0WIi6SpYfT6fR7PGZqYBLdBN7D6hTeydFbmDaYttovXxA+R5MN/RHnd4M85nhZHWy
 kaaxZjVOdmUOFaI6ftZQQi3Y1iPYrb3OngDd3neXfvoJPmXd5YF3dwILgSCc55Cu6Lzy
 lRPA==
X-Gm-Message-State: APjAAAVtAO3D6pOTsgRAsQvlnrJjk5DIWT/7EydiKuJR1b/Mw3gD2RDx
 3hoveRnQV7JxOPRgq/xpAOOqpuzb
X-Google-Smtp-Source: APXvYqxyW65fEG0rV9O9MaKaeTFetznCcAKCzshX/jNDViAOaGHbwUnr6xk3h9rv7N9ntCU7VqExtw==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr362951wrv.316.1580951915866;
 Wed, 05 Feb 2020 17:18:35 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/30] hw/arm/bcm2836: Only provide "enabled-cpus" property
 to multicore SoCs
Date: Thu,  6 Feb 2020 02:17:43 +0100
Message-Id: <20200206011756.2413-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


