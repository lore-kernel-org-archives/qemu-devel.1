Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D625C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4892137B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxs7mjyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4892137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7ve-0004t7-95
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7T9-0004DD-Mp; Tue, 01 Sep 2020 10:41:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7T8-0008Rc-9U; Tue, 01 Sep 2020 10:41:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so1414041wmm.2;
 Tue, 01 Sep 2020 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=euJaN/gf4+eh8HEs7Y0AxRG4hxPSo1ZS1DUgn6b7SL8=;
 b=uxs7mjyLDJPlzC1SMB1NsAN4AjZFqJecdwaXbvbY58lmcKhoNUuSwUCxzaSQW+INOR
 HOVE/xby/QdhADWlOvZv0IGm8bcgzLAL9ONLecKOXwawuKihItXER8nXo9yM3OZIO/nL
 +w8oqVwf+iQmuTLdubMGdHbaUQ5rwEJQj6fQMYkhvCl7my/INSdNvFBNbIcJvfzZCwy1
 Y5TBrFNhPGIkzqYJQsPuaZ1ePMlNISVjzNrd5b++Q+RzN+NrpKVcl2tdQZ7kbvfrsSfw
 M4sve7a55NdZlvOiBqHLg83/apAfpHMHwq7P1bbZwDCEeONKXP7kQq7Z55d5L/4pVt2G
 fmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=euJaN/gf4+eh8HEs7Y0AxRG4hxPSo1ZS1DUgn6b7SL8=;
 b=oq3df9gX8vqZz1IlD39MIKjRE7PjUn9xcF8maYONcVSzLo8RtTF7jWP7xuDCm0oVYE
 0ahmR89e9zsS/wW15Y5bZu/1aeRwjyFYLU+vrU0AF1//peC7mynGEuvdpp/KYn4ahdmo
 O1uWKDO3V54Q6iHRXZvmQrIRxftCC095qRkXo2Ms7H6ideEpgR5tmdB71iBdNkCsD86S
 1rhHyTBvBAp4AQPbd14FP5k9bLm59L5RdmueU/2Lu+pS0ZE60lNVM/oNe+X0eG8eVoI5
 +qUf5tAHnLdxerj4gX+l7ksv5gpZjXRZDGtLzGIaQtqfO3UlMqOZZSUdty14gnnTeXen
 wnkg==
X-Gm-Message-State: AOAM531a+TagHXSlEKD9vjAWY05HlHmCZiTM7t9VqZt1XHoCNJrxz9mI
 1ABlNBfQh9Gydi5WRBfoLRfTCWo/2w4=
X-Google-Smtp-Source: ABdhPJy4Iqv7ig2e0CWczw1PiG+e5PfVlpB9y++O/kdFr9+NvuaTHnLAbE0fI7quwRodBFRb15HFhg==
X-Received: by 2002:a1c:105:: with SMTP id 5mr2227939wmb.83.1598971264123;
 Tue, 01 Sep 2020 07:41:04 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a82sm2213204wmc.45.2020.09.01.07.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:41:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/misc/a9scu: Do not allow invalid CPU count
Date: Tue,  1 Sep 2020 16:40:57 +0200
Message-Id: <20200901144100.116742-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901144100.116742-1-f4bug@amsat.org>
References: <20200901144100.116742-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the datasheet (DDI0407 r2p0):

  "The SCU connects one to four Cortex-A9 processors to
   the memory system through the AXI interfaces."

Change the instance_init() handler to a device_realize()
one so we can verify the property is in range, and return
an error to the caller if not.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/a9scu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 324371a1c00..915f127761e 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -12,8 +12,11 @@
 #include "hw/misc/a9scu.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 
+#define A9_SCU_CPU_MAX  4
+
 static uint64_t a9_scu_read(void *opaque, hwaddr offset,
                             unsigned size)
 {
@@ -105,12 +108,17 @@ static void a9_scu_reset(DeviceState *dev)
     s->control = 0;
 }
 
-static void a9_scu_init(Object *obj)
+static void a9_scu_realize(DeviceState *dev, Error **errp)
 {
-    A9SCUState *s = A9_SCU(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    A9SCUState *s = A9_SCU(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    memory_region_init_io(&s->iomem, obj, &a9_scu_ops, s,
+    if (!s->num_cpu || s->num_cpu > A9_SCU_CPU_MAX) {
+        error_setg(errp, "Illegal CPU count: %u", s->num_cpu);
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &a9_scu_ops, s,
                           "a9-scu", 0x100);
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -138,13 +146,13 @@ static void a9_scu_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, a9_scu_properties);
     dc->vmsd = &vmstate_a9_scu;
     dc->reset = a9_scu_reset;
+    dc->realize = a9_scu_realize;
 }
 
 static const TypeInfo a9_scu_info = {
     .name          = TYPE_A9_SCU,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(A9SCUState),
-    .instance_init = a9_scu_init,
     .class_init    = a9_scu_class_init,
 };
 
-- 
2.26.2


