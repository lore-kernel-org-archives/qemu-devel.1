Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54420C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D842085B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 17:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pG2qumaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D842085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWN2H-0007ZF-Or
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 13:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvW-0007hP-Hi; Sat, 24 Oct 2020 13:01:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:50851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWMvU-0005iu-MB; Sat, 24 Oct 2020 13:01:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id 13so5717667wmf.0;
 Sat, 24 Oct 2020 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HrxoAnGYxfMe8eF6utEpYOM4v9LoQV8M0tbNnH02kgc=;
 b=pG2qumaFcPgcRMjGI7ng8iRKO0J/Q9OUcVuBqPz/FABe2Xi1HBu3/LVR0FRKTHTbZw
 Z5XZ+/6GKznT0JCOnE9shwHK0LYkXVkfF2q1m3Ob45vf4T7JuCZw66bnSnlcap2uULsT
 xi49eFtbVFUghJvPbGX+HBskHrwtlVT/e7jTnyVCrZQ8kgMNeFlfxkB1e16pn2zheo0+
 XCwFSGyh2cEN+AsF3wq7pr9J2cRynMrjMDJZ1TC0O6ZlNZIntwGO5SflPNRd05p3tbBJ
 2OG5tMFkvi8WmbqvSDqK5FHhFMmPxtx4w1UOFBJRfD1CLHBfrNASws8D3sPlSRFIqTT0
 CeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HrxoAnGYxfMe8eF6utEpYOM4v9LoQV8M0tbNnH02kgc=;
 b=BAffil0e6+KvRPDz3exRBCMVgZdeZmbTO7kjGHQf+MDc1lde+6+PXOxzPkqQsDMJB8
 GrQ6OSho27GH7Tq1obN9eiDzoF9OMm9OajDOZAs3I8oy7jGHTGMw9a0XdE2EPmVuVmT3
 0d/pPeP16i6JzC0hQllQ1Yezx1iqYe3F/UUEqBDR2O2dMhZUVnCipbIZbTBFUfjCvSml
 tQDtjqCfakaAId963V6trJQcGnPTqJosSdT0B1LHI2s0K0wPHYxcaMa8jqDshRf8j9Uq
 CN9otkOZ0ePA/wvrCBEwPqj5JU+HWbt5Qn1u1XM2XgI8P3C1wpu9bApiAgg2eHnpl7NW
 PLaA==
X-Gm-Message-State: AOAM530T4W1mec5Xq3gzjFfr1R84ryB5gQ6Dlb5lgF3iNaAauVwayUuO
 PllUJ2V9OaQHFlyfJdBFY2qCu09fo2w=
X-Google-Smtp-Source: ABdhPJyUYC4hyaqDEJ0lrbr93QaI3r2fo5I75Z1Z/1o4AgX6EcAWSuRAiXpC53uG81+k+92CznjdWw==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr7869466wma.116.1603558914732; 
 Sat, 24 Oct 2020 10:01:54 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d20sm12841463wra.38.2020.10.24.10.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 10:01:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/9] hw/arm/bcm2836: Split out common realize() code
Date: Sat, 24 Oct 2020 19:01:23 +0200
Message-Id: <20201024170127.3592182-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024170127.3592182-1-f4bug@amsat.org>
References: <20201024170127.3592182-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x330.google.com
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

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index fcb2c9c3e73..7d975cf2f53 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -52,7 +52,10 @@ static void bcm2836_init(Object *obj)
         qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
     }
 
-    object_initialize_child(obj, "control", &s->control, TYPE_BCM2836_CONTROL);
+    if (bc->ctrl_base) {
+        object_initialize_child(obj, "control", &s->control,
+                                TYPE_BCM2836_CONTROL);
+    }
 
     object_initialize_child(obj, "peripherals", &s->peripherals,
                             TYPE_BCM2835_PERIPHERALS);
@@ -62,12 +65,11 @@ static void bcm2836_init(Object *obj)
                               "vcram-size");
 }
 
-static void bcm2836_realize(DeviceState *dev, Error **errp)
+static bool bcm283x_common_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     Object *obj;
-    int n;
 
     /* common peripherals from bcm2835 */
 
@@ -76,7 +78,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), errp)) {
-        return;
+        return false;
     }
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
@@ -84,6 +86,18 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
                             bc->peri_base, 1);
+    return true;
+}
+
+static void bcm2836_realize(DeviceState *dev, Error **errp)
+{
+    BCM283XState *s = BCM283X(dev);
+    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
+    int n;
+
+    if (!bcm283x_common_realize(dev, errp)) {
+        return;
+    }
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), errp)) {
-- 
2.26.2


