Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF45C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 11:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BB12064A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 11:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9LNUXF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BB12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXjyb-0003nE-93
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 07:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXjxZ-0002XW-40
 for qemu-devel@nongnu.org; Sun, 10 May 2020 07:17:29 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXjxY-0002x4-5Z
 for qemu-devel@nongnu.org; Sun, 10 May 2020 07:17:28 -0400
Received: by mail-ed1-x543.google.com with SMTP id y24so5386002edo.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GN9Cz/Ixg2ZSCGxPvcfcPCSFErq8rzP3scUOcivKEmY=;
 b=T9LNUXF8e+L05mV5DijZNf2Khevo6//yDrVkhacqfJk04NeErt1KmgKKb+8O0kB+vu
 YtNhcx0j6b5rC/yH0jLWBOpmjEJwgJZwvnypXXBpUEJq+hGZLb8XzQpK4AX5LNMqaCzc
 T7P4ci84Z71zPtE815Q2aCs5qyKJmNJZ9Zfu2/x6Jaf+hGd2a8AGrsv1zWqROvIQf/PY
 9NQlB0gTBMCMqI1tSaxPdd0HXXorZKyab734Y6ip373pl28G1KRed9FsU1pbaXwzCgeO
 N3E4wBQWlhuh35n9kg/pgOmVboNsIBqJJvojqL/MgwyfSo2oX11fVMrM9rHVAI+mUFWA
 AH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=GN9Cz/Ixg2ZSCGxPvcfcPCSFErq8rzP3scUOcivKEmY=;
 b=a+0OrRtI2gNzLHCzVnmcsOBdeXGTm1pdGq82erJ7mKWevEiYKeBup8A1nLj0rXSemw
 dot0jAhCuo9nU6JeeohjHPwNKvlMAPZfFtbkYNG10G5hE/eBgdIv//zR3UzaCu98ubW6
 Zy0a/rP3V1JLzzLFI7rZzSeQTuPK0gXuqGLGDNTAPg+qwuKJIKXhYTosTB/dFnGAbpt7
 LHpul5nBAUoLOjQf+wBQm+dJosd3ab9WAz1kX3zojAZvYmpFh0aDcVaOVZbHtkAfk5ih
 19CxIckUDHNs4CLY8awpnfL1nx0yk4710Ra3PloVVriGyOayIlMxfCkpJVpr2vfALQxl
 4viw==
X-Gm-Message-State: AGi0Puard8mIJrHAqHv30KUw3Yg5BGjvfgWfJMnNeIweN0GAvmH1ibMu
 PVHKFZwNVoFiohhjVRkkwI9SQEvWMak=
X-Google-Smtp-Source: APiQypJxCIXqS8ES5OxPskQr5DNxIzNauIwZDbOTjSrx6nYvlo74HypdlovqUSqbghQly4UqI+ISlg==
X-Received: by 2002:a05:6402:1b0b:: with SMTP id
 by11mr9120119edb.269.1589109445604; 
 Sun, 10 May 2020 04:17:25 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id l18sm916050edf.82.2020.05.10.04.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 04:17:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/sparc64/sun4u: Use memdev backend for main RAM
Date: Sun, 10 May 2020 13:17:22 +0200
Message-Id: <20200510111722.4493-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_SUN4U_MEMORY does not do anything special.
Replace it by the generic memdev allocated MemoryRegion
and remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc64/sun4u.c | 65 +++-------------------------------------------
 1 file changed, 3 insertions(+), 62 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 6abfcb30f8..36a7e0c646 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -490,66 +490,6 @@ static const TypeInfo prom_info = {
     .class_init    = prom_class_init,
 };
 
-
-#define TYPE_SUN4U_MEMORY "memory"
-#define SUN4U_RAM(obj) OBJECT_CHECK(RamDevice, (obj), TYPE_SUN4U_MEMORY)
-
-typedef struct RamDevice {
-    SysBusDevice parent_obj;
-
-    MemoryRegion ram;
-    uint64_t size;
-} RamDevice;
-
-/* System RAM */
-static void ram_realize(DeviceState *dev, Error **errp)
-{
-    RamDevice *d = SUN4U_RAM(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-
-    memory_region_init_ram_nomigrate(&d->ram, OBJECT(d), "sun4u.ram", d->size,
-                           &error_fatal);
-    vmstate_register_ram_global(&d->ram);
-    sysbus_init_mmio(sbd, &d->ram);
-}
-
-static void ram_init(hwaddr addr, ram_addr_t RAM_size)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    RamDevice *d;
-
-    /* allocate RAM */
-    dev = qdev_create(NULL, TYPE_SUN4U_MEMORY);
-    s = SYS_BUS_DEVICE(dev);
-
-    d = SUN4U_RAM(dev);
-    d->size = RAM_size;
-    qdev_init_nofail(dev);
-
-    sysbus_mmio_map(s, 0, addr);
-}
-
-static Property ram_properties[] = {
-    DEFINE_PROP_UINT64("size", RamDevice, size, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void ram_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = ram_realize;
-    device_class_set_props(dc, ram_properties);
-}
-
-static const TypeInfo ram_info = {
-    .name          = TYPE_SUN4U_MEMORY,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(RamDevice),
-    .class_init    = ram_class_init,
-};
-
 static void sun4uv_init(MemoryRegion *address_space_mem,
                         MachineState *machine,
                         const struct hwdef *hwdef)
@@ -576,7 +516,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     qdev_init_nofail(iommu);
 
     /* set up devices */
-    ram_init(0, machine->ram_size);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     prom_init(hwdef->prom_addr, bios_name);
 
@@ -817,6 +757,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
     mc->ignore_boot_device_suffixes = true;
     mc->default_display = "std";
+    mc->default_ram_id = "sun4u.ram";
     fwc->get_dev_path = sun4u_fw_dev_path;
 }
 
@@ -841,6 +782,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
     mc->default_display = "std";
+    mc->default_ram_id = "sun4u.ram";
 }
 
 static const TypeInfo sun4v_type = {
@@ -854,7 +796,6 @@ static void sun4u_register_types(void)
     type_register_static(&power_info);
     type_register_static(&ebus_info);
     type_register_static(&prom_info);
-    type_register_static(&ram_info);
 
     type_register_static(&sun4u_type);
     type_register_static(&sun4v_type);
-- 
2.21.3


