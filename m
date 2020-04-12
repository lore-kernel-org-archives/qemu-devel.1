Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A51C2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9089D206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBG9VeDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9089D206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlEl-00084b-LX
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDZ-0005SE-2D
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDX-00029l-LM
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDX-000292-DU; Sun, 12 Apr 2020 18:36:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id x4so7933224wmj.1;
 Sun, 12 Apr 2020 15:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fbbO9wzQMxUGK14/wPxC6NiQVlUq0AjU4R3hB3jLnV8=;
 b=IBG9VeDs6KuhWuSiS/ncAGzydeLPmsR1ivtE/b5e/e6gCEHisK+leT6TWVibKg0g66
 arkjFR6tKDwmAntIDxVF9Ygqub7YPVuJ/AZBoCgLTHk46h+YQ/lijjSXTUzwhLM/mN1v
 QycJjyy+zKT6DDmut3woKhrIyeWIHlOtWl4T0Y/hDqAAY9mnZvtkrG+HUzwHCQb35RoH
 eNd/Gn6ZnLGzK5XOH34cimYhdfXwHicxoiHw7VlE6/KFHXYl8FL+pEcSHl+xlrXQWLdv
 s7qCA/QnRM8bwHbMxrXXFsbnMFN77D+dIZnKHjBtIV5wpVxn3AObZ3oUX+NUrTql14Mu
 dh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fbbO9wzQMxUGK14/wPxC6NiQVlUq0AjU4R3hB3jLnV8=;
 b=nTpsVOtIaTn1+LqgmRx766OKFg/KuAjExFTTtSwvYbTEEbMKT+5oDlEl6ixraONSQ4
 N1kENVkZCzVa1zkTb+DfGHAombZDCeYjArzOT5j5wrjlhC9Y+Vo01mG6zoiEl7c3bSh5
 6wR1yyRvxyKVu5zaEc0e23fbyR8Tb+Z4yPSl7welDAQoq0JsQfSCweFqEuAuXe1vmk9j
 VD3T1t496IdXWhzFlFrTrkfbjX75uKIS99qSkvMv6b9N7dBoKPu4JWpYMvT+TtLE3VtB
 ETMK8PtvP7fEbAf9DXXMVsldO9XtoHvsOZ51X0VvysACB5BN2+kByl2FljS/ydduXZW5
 qV+g==
X-Gm-Message-State: AGi0PuZl3oVvEXfFkwOvIcEipkE8Z1bhg8Zy3nyq2PtHxgYnxw9FwweX
 zjrhuZxlRrkyg8lBoxY9sj0KxMZlIbXZxg==
X-Google-Smtp-Source: APiQypK9JGGIGGjTqJVRnRAwsiJr0sxKPjEx2ThlCYoPeSrj7SFEk9LG+R2ZKXSe7P2+0hkOLYuKrw==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr119951wma.91.1586731002127; 
 Sun, 12 Apr 2020 15:36:42 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:36:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 05/24] hw/arm/aspeed_ast2600: Move some code from
 realize() to init()
Date: Mon, 13 Apr 2020 00:36:00 +0200
Message-Id: <20200412223619.11284-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/aspeed_ast2600.c
  >>> possible moves from aspeed_soc_ast2600_init() to aspeed_soc_ast2600_realize() in ./hw/arm/aspeed_ast2600.c:243

Move the calls using &error_fatal which don't depend on input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Typo 'depend of' -> 'depend on' (eblake)
---
 hw/arm/aspeed_ast2600.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a860ab6a35..64512f95c9 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -114,6 +114,16 @@ static qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int ctrl)
     return qdev_get_gpio_in(DEVICE(&s->a7mpcore), sc->irqmap[ctrl]);
 }
 
+/*
+ * ASPEED ast2600 has 0xf as cluster ID
+ *
+ * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388e/CIHEBGFG.html
+ */
+static uint64_t aspeed_calc_affinity(int cpu)
+{
+    return (0xf << ARM_AFF1_SHIFT) | cpu;
+}
+
 static void aspeed_soc_ast2600_init(Object *obj)
 {
     AspeedSoCState *s = ASPEED_SOC(obj);
@@ -130,6 +140,13 @@ static void aspeed_soc_ast2600_init(Object *obj)
         object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
                                 sizeof(s->cpu[i]), sc->cpu_type,
                                 &error_abort, NULL);
+        object_property_set_int(OBJECT(&s->cpu[i]), QEMU_PSCI_CONDUIT_SMC,
+                                "psci-conduit", &error_abort);
+        object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affinity(i),
+                                "mp-affinity", &error_abort);
+
+        object_property_set_int(OBJECT(&s->cpu[i]), 1125000000, "cntfrq",
+                                &error_abort);
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
@@ -146,6 +163,9 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore,
                           sizeof(s->a7mpcore), TYPE_A15MPCORE_PRIV);
+    object_property_set_int(OBJECT(&s->a7mpcore),
+                            ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNAL,
+                            "num-irq", &error_abort);
 
     sysbus_init_child_obj(obj, "rtc", OBJECT(&s->rtc), sizeof(s->rtc),
                           TYPE_ASPEED_RTC);
@@ -230,16 +250,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
                           TYPE_SYSBUS_SDHCI);
 }
 
-/*
- * ASPEED ast2600 has 0xf as cluster ID
- *
- * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388e/CIHEBGFG.html
- */
-static uint64_t aspeed_calc_affinity(int cpu)
-{
-    return (0xf << ARM_AFF1_SHIFT) | cpu;
-}
-
 static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 {
     int i;
@@ -264,19 +274,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     for (i = 0; i < s->num_cpus; i++) {
-        object_property_set_int(OBJECT(&s->cpu[i]), QEMU_PSCI_CONDUIT_SMC,
-                                "psci-conduit", &error_abort);
         if (s->num_cpus > 1) {
             object_property_set_int(OBJECT(&s->cpu[i]),
                                     ASPEED_A7MPCORE_ADDR,
                                     "reset-cbar", &error_abort);
         }
-        object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affinity(i),
-                                "mp-affinity", &error_abort);
-
-        object_property_set_int(OBJECT(&s->cpu[i]), 1125000000, "cntfrq",
-                                &error_abort);
-
         /*
          * TODO: the secondary CPUs are started and a boot helper
          * is needed when using -kernel
@@ -292,9 +294,6 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* A7MPCORE */
     object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cpu",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore),
-                            ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNAL,
-                            "num-irq", &error_abort);
 
     object_property_set_bool(OBJECT(&s->a7mpcore), true, "realized",
                              &error_abort);
-- 
2.21.1


