Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B68FC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF086206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFYWtC4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF086206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eu3-0003PV-S3
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqV-0006nW-KK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqU-0002Vu-IA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:45:51 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3eqU-0002VA-BS; Mon, 17 Feb 2020 06:45:50 -0500
Received: by mail-wm1-x344.google.com with SMTP id a9so18104180wmj.3;
 Mon, 17 Feb 2020 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B1P152VP3CyxvJ0hiqDereblCgbtylimKSTziv7Dq7E=;
 b=BFYWtC4de4m57/QFzUEK6JRbESVVyU3dCcqMynOlC+14Um/fDzN7/eHLTijiInRmpa
 y4XxwmAnhs62s3qDtFV03qvyP5yQT+Pcx9hpuIJBa4EVh9r6fdXkAG94w/pmgJgUZtZm
 CfRaWMi2vRwDm/KROueDyMOUHKRYtAE1ycZbW6BbMlscTcCHO1D3qrkzrOWrRhgp9HqY
 b6IDFxFbaW2vkxoNLO3JGAVYP8WvYSn6MJa86H9jKuDrtJTPsyYkwPVdBr+l2hKC25kO
 KPTSxClVEQHifGyBwj6bLYuyaHuSlT8Vso6+UoG8EFl1U9eSMWfbzCxNLKahh8ZCJa2f
 tU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B1P152VP3CyxvJ0hiqDereblCgbtylimKSTziv7Dq7E=;
 b=h4O3iwXJixVs70qujGouUgwL1hMrsUDBL+djP2hFN5RYd32A3vOz3pcxwHzD4QZE5O
 WNER9jcVH24I78PQYjzEZDvDb12pS4E11uDm4G5OkBIlxUTZX8MwnMr4PtKHQigG+C33
 vdkHXbvMrT1sCAY3P5FZzogZVyFm+jEMMSK1JmbKf43TyPLeleYcEnxVSpu/SLs2nsPU
 lwLYTqAsXBBpFs5jpFHLCYf3Rjir+yrr3maoErZDSW60MehgSMA2GHaqYf8nW3D/psRM
 t8AHBnDXsFjRKMZGVXZ5X+VbLX26Ym5f0SNCSTVqZnox9fEtxX/9lyXQzKsfRkQVb9d2
 6SXA==
X-Gm-Message-State: APjAAAUDHfdzYTTDX+p1VdEj8IFLdlm/wYgj6Qh7OzAOK+XfJmb84wiO
 7g7NzhmzWfWoF9PxPrrdrAL7mt47Y84=
X-Google-Smtp-Source: APXvYqwTLOdVlajvmzABohMyhV1AvdvzW6qCSTDV65ExmenF5O4z/VndsqJXXoyGLwM7tExbAVV5qg==
X-Received: by 2002:a05:600c:2187:: with SMTP id
 e7mr21750318wme.11.1581939949211; 
 Mon, 17 Feb 2020 03:45:49 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i2sm268149wmb.28.2020.02.17.03.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 03:45:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/13] hw/arm/bcm2836: Split out common realize() code
Date: Mon, 17 Feb 2020 12:45:30 +0100
Message-Id: <20200217114533.17779-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217114533.17779-1-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

The realize() function is clearly composed of two parts,
each described by a comment:

  void realize()
  {
     /* common peripherals from bcm2835 */
     ...
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     ...
   }

Split the two part, so we can reuse the common part with other
SoCs from this family.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index caaa4b625e..2b6fe31139 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -51,8 +51,10 @@ static void bcm2836_init(Object *obj)
         qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
     }
 
-    sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
-                          TYPE_BCM2836_CONTROL);
+    if (bc->ctrl_base) {
+        sysbus_init_child_obj(obj, "control", &s->control,
+                              sizeof(s->control), TYPE_BCM2836_CONTROL);
+    }
 
     sysbus_init_child_obj(obj, "peripherals", &s->peripherals,
                           sizeof(s->peripherals), TYPE_BCM2835_PERIPHERALS);
@@ -62,13 +64,12 @@ static void bcm2836_init(Object *obj)
                               "vcram-size", &error_abort);
 }
 
-static void bcm2836_realize(DeviceState *dev, Error **errp)
+static void bcm283x_common_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     Object *obj;
     Error *err = NULL;
-    int n;
 
     /* common peripherals from bcm2835 */
 
@@ -100,6 +101,20 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
                             bc->peri_base, 1);
+}
+
+static void bcm2836_realize(DeviceState *dev, Error **errp)
+{
+    BCM283XState *s = BCM283X(dev);
+    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
+    Error *err = NULL;
+    int n;
+
+    bcm283x_common_realize(dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
-- 
2.21.1


