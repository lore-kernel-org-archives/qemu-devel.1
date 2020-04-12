Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358BBC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEB0206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU4DzG8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEB0206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjuw-0004fy-1S
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjrp-0008SX-MA
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjro-00059Q-0n
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:10:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjrn-00058n-QE; Sun, 12 Apr 2020 17:10:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so406744wmh.3;
 Sun, 12 Apr 2020 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WI0uWQVZOcYqeJp2uBcJ0303+lu8M+R0XXUdzA9Q1p0=;
 b=cU4DzG8kqqs2TjXHLis6XOLzgrHN02vjMnOKSSYfhhMP5l2oHzFAmyge2FXQqc0/1i
 N6yLdtTkguIoUJcfLqkaoRKNXonCZ8hf4DgB1/xooDdxVwjG6CPclbRsrHZRtqVI87sR
 tCXasUn8FS1JgRT+D72CoZgi/gx/QS7dzvZkJNQ6zgX06fXEFNAcWY2tqCfVvh5rRXnB
 VRgijZIy9TYGoUwOZnZwFAwJs+W/cdTZqJpo1FCu2F4tdTKGNfSl++HIcDcanPqtqOhz
 2GzCk4XvwggWeph1f0Se74nYxhgV2VuJ8WTt09Upfu813qdRiWl+q6FS8CL78q2yO/Wr
 x6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WI0uWQVZOcYqeJp2uBcJ0303+lu8M+R0XXUdzA9Q1p0=;
 b=JTZVblf85vXiNEg6mwoouiXue/I3GW5EjuAHH3eRJ/tFpQT46EkEpHJj4g5n//pIOL
 uApZo3Idm+Dlj2KaCRBswKi630oxnQ83gy6IFUMW4U7ghziAVKRqVVOOiW3KD9zbvxJk
 dZ/OtcOtm+S60iHtzNrznak8ewnhmDUAcJDZMKuTcwv7cUL6Jdi9hYR6RYrIFIFjHA1J
 7la0W9eB51SoC+QmL5yGIRZ0cqh4uYLIY0BL18nmYzI37veLd6nMQgujFgrIoDSYxTEd
 Ny6u6NslXim2e5rFkNUZq2ZVhiuNTYnlsDbk1fMjvKsm+pSRpMbkrk+QGA/xC11mbxs6
 rfjA==
X-Gm-Message-State: AGi0PuZwOScgqyinBPmgoMsD/P9TJIShBPR3SC7ECR8+ZPJQhqi1cSKK
 /NBjzCrtSHDZrJOuzDHVQpBj4acBTm4=
X-Google-Smtp-Source: APiQypIrq14R99vJly/PYAexLmQqsxEa8wp1zM7rRr5lpI2rH6ZjOKGWrjdugVpiztcSWyteedvnlA==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr15496465wmz.21.1586725809996;
 Sun, 12 Apr 2020 14:10:09 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o16sm12553602wrs.44.2020.04.12.14.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 14:10:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 3/3] hw: Remove unnecessary DEVICE() cast
Date: Sun, 12 Apr 2020 23:09:54 +0200
Message-Id: <20200412210954.32313-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412210954.32313-1-f4bug@amsat.org>
References: <20200412210954.32313-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DEVICE() macro is defined as:

  #define DEVICE(obj) OBJECT_CHECK(DeviceState, (obj), TYPE_DEVICE)

Remove unnecessary DEVICE() casts.

Patch created mechanically using spatch with this script:

  @@
  typedef DeviceState;
  DeviceState *s;
  @@
  -   DEVICE(s)
  +   s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c         | 2 +-
 hw/display/cg3.c            | 2 +-
 hw/display/sm501.c          | 2 +-
 hw/display/tcx.c            | 4 ++--
 hw/display/vga-isa.c        | 2 +-
 hw/i2c/imx_i2c.c            | 2 +-
 hw/i2c/mpc_i2c.c            | 2 +-
 hw/ide/piix.c               | 2 +-
 hw/misc/macio/pmu.c         | 2 +-
 hw/net/ftgmac100.c          | 3 +--
 hw/net/imx_fec.c            | 2 +-
 hw/nubus/nubus-device.c     | 2 +-
 hw/pci-host/bonito.c        | 2 +-
 hw/ppc/spapr.c              | 2 +-
 hw/sh4/sh_pci.c             | 2 +-
 hw/xen/xen-legacy-backend.c | 2 +-
 16 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 753dbb9a77..7e2a4556bd 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1353,7 +1353,7 @@ static void artist_realizefn(DeviceState *dev, Error **errp)
     s->cursor_height = 32;
     s->cursor_width = 32;
 
-    s->con = graphic_console_init(DEVICE(dev), 0, &artist_ops, s);
+    s->con = graphic_console_init(dev, 0, &artist_ops, s);
     qemu_console_resize(s->con, s->width, s->height);
 }
 
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index a1ede10394..f7f1c199ce 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -321,7 +321,7 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
-    s->con = graphic_console_init(DEVICE(dev), 0, &cg3_ops, s);
+    s->con = graphic_console_init(dev, 0, &cg3_ops, s);
     qemu_console_resize(s->con, s->width, s->height);
 }
 
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index de0ab9d977..2a564889bd 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1839,7 +1839,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
                                 &s->twoD_engine_region);
 
     /* create qemu graphic console */
-    s->con = graphic_console_init(DEVICE(dev), 0, &sm501_ops, s);
+    s->con = graphic_console_init(dev, 0, &sm501_ops, s);
 }
 
 static const VMStateDescription vmstate_sm501_state = {
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 76de16e8ea..1fb45b1aab 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -868,9 +868,9 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 
     if (s->depth == 8) {
-        s->con = graphic_console_init(DEVICE(dev), 0, &tcx_ops, s);
+        s->con = graphic_console_init(dev, 0, &tcx_ops, s);
     } else {
-        s->con = graphic_console_init(DEVICE(dev), 0, &tcx24_ops, s);
+        s->con = graphic_console_init(dev, 0, &tcx24_ops, s);
     }
     s->thcmisc = 0;
 
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 0633ed382c..3aaeeeca1e 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -74,7 +74,7 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
                                         0x000a0000,
                                         vga_io_memory, 1);
     memory_region_set_coalescing(vga_io_memory);
-    s->con = graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
+    s->con = graphic_console_init(dev, 0, s->hw_ops, s);
 
     memory_region_add_subregion(isa_address_space(isadev),
                                 VBE_DISPI_LFB_PHYSICAL_ADDRESS,
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 30b9aea247..2e02e1c4fa 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -305,7 +305,7 @@ static void imx_i2c_realize(DeviceState *dev, Error **errp)
                           IMX_I2C_MEM_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
-    s->bus = i2c_init_bus(DEVICE(dev), NULL);
+    s->bus = i2c_init_bus(dev, NULL);
 }
 
 static void imx_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 0aa1be3ce7..9a724f3a3e 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -332,7 +332,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
                           "mpc-i2c", 0x14);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
-    i2c->bus = i2c_init_bus(DEVICE(dev), "i2c");
+    i2c->bus = i2c_init_bus(dev, "i2c");
 }
 
 static void mpc_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 3b2de4c312..b402a93636 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -193,7 +193,7 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux)
             blk_unref(blk);
         }
     }
-    qdev_reset_all(DEVICE(dev));
+    qdev_reset_all(dev);
     return 0;
 }
 
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index b8466a4a3f..4b7def9096 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -758,7 +758,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
 
     if (s->has_adb) {
         qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
-                            DEVICE(dev), "adb.0");
+                            dev, "adb.0");
         s->adb_poll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, pmu_adb_poll, s);
         s->adb_poll_mask = 0xffff;
         s->autopoll_rate_ms = 20;
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 041ed21017..25ebee7ec2 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1035,8 +1035,7 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_ftgmac100_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), DEVICE(dev)->id,
-                          s);
+                          object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index a35c33683e..7adcc9df65 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1323,7 +1323,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&imx_eth_net_info, &s->conf,
                           object_get_typename(OBJECT(dev)),
-                          DEVICE(dev)->id, s);
+                          dev->id, s);
 
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 01ccad9e8e..ffe78a8823 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -156,7 +156,7 @@ void nubus_register_rom(NubusDevice *dev, const uint8_t *rom, uint32_t size,
 
 static void nubus_device_realize(DeviceState *dev, Error **errp)
 {
-    NubusBus *nubus = NUBUS_BUS(qdev_get_parent_bus(DEVICE(dev)));
+    NubusBus *nubus = NUBUS_BUS(qdev_get_parent_bus(dev));
     NubusDevice *nd = NUBUS_DEVICE(dev);
     char *name;
     hwaddr slot_offset;
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index cc6545c8a8..f212796044 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -606,7 +606,7 @@ static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
     BonitoState *bs = BONITO_PCI_HOST_BRIDGE(dev);
 
     memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
-    phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
+    phb->bus = pci_register_root_bus(dev, "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
                                      dev, &bs->pci_mem, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..3337f5e79c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4031,7 +4031,7 @@ static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     /* hotplug hooks should check it's enabled before getting this far */
     assert(drc);
 
-    spapr_drc_attach(drc, DEVICE(dev), &local_err);
+    spapr_drc_attach(drc, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 08f2fc1dde..0a3e86f949 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -129,7 +129,7 @@ static void sh_pci_device_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
-    phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
+    phb->bus = pci_register_root_bus(dev, "pci",
                                      sh_pci_set_irq, sh_pci_map_irq,
                                      s->irq,
                                      get_system_memory(),
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 4a373b2373..f9d013811a 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -705,7 +705,7 @@ int xen_be_init(void)
 
     xen_sysdev = qdev_create(NULL, TYPE_XENSYSDEV);
     qdev_init_nofail(xen_sysdev);
-    xen_sysbus = qbus_create(TYPE_XENSYSBUS, DEVICE(xen_sysdev), "xen-sysbus");
+    xen_sysbus = qbus_create(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
     qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);
 
     return 0;
-- 
2.21.1


