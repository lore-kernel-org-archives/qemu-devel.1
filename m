Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81686CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E61420820
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVlY4EB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E61420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyUY-0003lr-RZ
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRX-0000CS-LZ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRW-0005Yi-Bn
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRW-0005YR-5T; Sat, 19 Oct 2019 19:47:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id r17so11891983wme.0;
 Sat, 19 Oct 2019 16:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d5xrmfH+e2mZccuWjO5XF0mbQ+EhH/vkHED8BLcRG38=;
 b=pVlY4EB37uWVNGoluiIwCwW3AjejPjJayyXcfCFQJ+rAyo38S+ja3pZLq5XiWIpJpG
 P8bcRr1WP129QKPrN7lVX+L7LHLA3ulgYEQGSVx3c350oz+Wjzw9AsHlWPXJUkBxGfwd
 2ZkWA0jp0ranTUvkGzjXlczkFOvvoO7BL3RwNPZJaddQFfF6pw+S8qvfJkX7ddpOp3yQ
 8p7Kp7rVEx86N6BCmnY4AESibYXnr3D86kckYULDq7fy6um+SbDLQAe0dGEHXKOuG40t
 9RRV52GyvL4oOX4bdAX9aUrr3QUy/N9drIGxjprOdCQmy3ncZcIVtrdbFSdmP9nXSm6y
 VCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d5xrmfH+e2mZccuWjO5XF0mbQ+EhH/vkHED8BLcRG38=;
 b=ZskIJuPKs4oOeJ+tSa2fOLnHoIe0v7hWDf58PPGbybqHtv6tHoDnbDMTdz8wa7KQCz
 6hbc5oF5o6sMPyPFBGrlnDo99LjJC0aPHyK7/e7qDKrbjdtZSg0q40Jf0oSap/YWsBRj
 BFhYWSCs8lVI1/7nLItkm+pUaOstYVYg+NYFYr6PehRCY20AKOtO3fIH38icFCZouWdq
 Mc1oiq0I4mKeQCDZlb83arbJmUzA+jFxRWf/revf+9dVZpBHsv4VmXCVQDZooog6Vhcw
 QqqqiQ7AZZhQAQ6w01tUDH7AFpHVBTFUICR0KGS8wihAASlvoM/Bmm+Jk5RzMqy/bYjr
 TgHg==
X-Gm-Message-State: APjAAAVS89uDsldrueXH78cDwsK2kQP+OzBM3dTuyPJfIEZd5Uew6RLb
 7UaoZflN+LmiLRNv7L7R4o37ckjB
X-Google-Smtp-Source: APXvYqyNYrH9vj8ADz4k/pOV6UoyVdU0+ykvT4K3MYE/JlLHt2xs6W0ca1cUzIaH50iiIeLN4SHj9Q==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr12828743wmj.85.1571528848922; 
 Sat, 19 Oct 2019 16:47:28 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/16] hw/arm/bcm2836: Rename cpus[] as cpu[].core
Date: Sun, 20 Oct 2019 01:47:05 +0200
Message-Id: <20191019234715.25750-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we are going to add more core-specific fields, add a 'cpu'
structure and move the ARMCPU field there as 'core'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c         | 26 ++++++++++++++------------
 include/hw/arm/bcm2836.h |  4 +++-
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 019e67b906..221ff06895 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -51,8 +51,9 @@ static void bcm2836_init(Object *obj)
     int n;
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpus[n], sizeof(s->cpus[n]),
-                                info->cpu_type, &error_abort, NULL);
+        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
+                                sizeof(s->cpu[n].core), info->cpu_type,
+                                &error_abort, NULL);
     }
 
     sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
@@ -122,10 +123,10 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
         /* TODO: this should be converted to a property of ARM_CPU */
-        s->cpus[n].mp_affinity = (info->clusterid << 8) | n;
+        s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
-        object_property_set_int(OBJECT(&s->cpus[n]),
+        object_property_set_int(OBJECT(&s->cpu[n].core),
                                 info->peri_base,
                                 "reset-cbar", &err);
         if (err) {
@@ -134,14 +135,15 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         }
 
         /* start powered off if not enabled */
-        object_property_set_bool(OBJECT(&s->cpus[n]), n >= s->enabled_cpus,
+        object_property_set_bool(OBJECT(&s->cpu[n].core), n >= s->enabled_cpus,
                                  "start-powered-off", &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
 
-        object_property_set_bool(OBJECT(&s->cpus[n]), true, "realized", &err);
+        object_property_set_bool(OBJECT(&s->cpu[n].core), true,
+                                 "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -149,18 +151,18 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
         /* Connect irq/fiq outputs from the interrupt controller. */
         qdev_connect_gpio_out_named(DEVICE(&s->control), "irq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpus[n]), ARM_CPU_IRQ));
+                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_IRQ));
         qdev_connect_gpio_out_named(DEVICE(&s->control), "fiq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpus[n]), ARM_CPU_FIQ));
+                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_FIQ));
 
         /* Connect timers from the CPU to the interrupt controller */
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_PHYS,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_PHYS,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpnsirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_VIRT,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_VIRT,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntvirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_HYP,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_HYP,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cnthpirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_SEC,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
     }
 }
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 97187f72be..92a6544816 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -35,7 +35,9 @@ typedef struct BCM283XState {
     char *cpu_type;
     uint32_t enabled_cpus;
 
-    ARMCPU cpus[BCM283X_NCPUS];
+    struct {
+        ARMCPU core;
+    } cpu[BCM283X_NCPUS];
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
 } BCM283XState;
-- 
2.21.0


