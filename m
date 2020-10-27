Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D1C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9C5218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaXdeHsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9C5218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOF6-0001eF-6W
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPj-0001dJ-Kv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPe-0004cW-GX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id e17so1491984wru.12
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z0IGuHbFGwaxWrJpMKHNM34krP6abin3KFfFJns6pps=;
 b=qaXdeHsUJjNm/iv89ZI3aHFwwfu9+7mlE270FaeyxUQ3Wv7HsRYmHYagrJ61O5dTKv
 X/uQNQZ7nq/YOVwAOYcbs0iXUxhW9V/Si2jSLYrry91frTLFDSrfqVXB907iHQIEoDKX
 FHNgS0cltcpCHB/imMNbkr9FBv7cmPnXXU6l0vVO1OEALK8Oogt3vWZB8Wv+w8psk8Nh
 pHHPfNACI5rpS57zZ25bZG9Eib0LhqYqSBs01oAiIuOLWQoXuZyml/PcAEuGKoKVrLe5
 +a7HynF5VsrvLLUIlTtvWiLoXHxWOb0vfMZlg6EeEaWFuUPXjVRPJixASswmIOZCY5e5
 jxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z0IGuHbFGwaxWrJpMKHNM34krP6abin3KFfFJns6pps=;
 b=ejC2ti3cnqsCBUeelz6cL1DjOdu25lO8/cznJSVO5s9yL372lma7LzObz+nINCv64e
 xB6O8jfeSPrtb0IHnBDEUQ++v83iNKMefFH7r0qa4YxHaou/pXp+v0WO4aMISMqDm76n
 s6+B6FY3+09WnGgL6+PwAbg2Bi1PfugzZBvs1u/wuU27le6DFbgzoc6OgZDc95nd0aGE
 rQug6mLt2pvYEFDKTIN7NwJwqdAEq5olSVx7CAmQNPLUn01YflPFrfW7bgvlyVjGEzoY
 d+pP0MCoKlq7gOlExVlQpZcJzTFUx/Nrb5Lr0nELb9rBn6204CczB2ahDnzm+NL2GDbU
 p6Lg==
X-Gm-Message-State: AOAM531t6r6K+/4xeFgt3ICLAAzQG/Cy2lLQsNRsy4+CzBXyxIKNFn9o
 ouEB55D+0fSRFF0m9LDpkX/D1CJyiEEpBg==
X-Google-Smtp-Source: ABdhPJyGeV+6b1uvq0qz69oj76bmw7Iso3/Q6zKaHpGGNM20Fqx0ZkEH4GsKymVnpEvCEDkTXwrx4Q==
X-Received: by 2002:a5d:6845:: with SMTP id o5mr2273845wrw.87.1603799112634;
 Tue, 27 Oct 2020 04:45:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/48] hw/arm/bcm2836: Split out common realize() code
Date: Tue, 27 Oct 2020 11:44:15 +0000
Message-Id: <20201027114438.17662-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Message-id: 20201024170127.3592182-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


