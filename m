Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4E0C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC2D20663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpwGZqRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC2D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfX9F-0005O5-6q
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX2B-0007xQ-T3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX29-00048T-SD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX29-0003Bk-K9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so14307432wrs.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NSm3cZqHH/H9Xl/1qUBzg4MSsd8N7p36v5WOTsFnvFI=;
 b=DpwGZqRWkKIh6RUDNi9bb/rODZnY1AeMANICf9+oudzvbUU2W7PqG9qy7rLIjGztXY
 ytk3eqrySw17H7OA6+467a5Ci2ymuCHMgFpavcp8WfGYDNWfNgHTxN10VMW6dP9A0413
 g/WMqdXU0LmHvmM5+3I8vsko7XB428Vcnlviuo2mAMoNfb+NH22NlXXhbnS+eA0UQefz
 GEt/8zAZWoyV7W8jvh+g+BBAVWiTA9KWbcGxTuBX6FWghSTh15l1WF7+2Yiw3BR2Fyn0
 ZuD81zIr0u3TqIpT7OwqMnALDv0ONdIqrvlTF11X0zcIpp6kura2DY8HuKFa+IHe9kPW
 ffzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NSm3cZqHH/H9Xl/1qUBzg4MSsd8N7p36v5WOTsFnvFI=;
 b=hb1W3GFhd3hFVNW7Gq1obR/lWJfjD0yJC4+SRkTPRfqqAuhw2mWHRqZCdFX7TOwwko
 f6v16VM6719FiJJUmtj6t4Tj1fSxiV9SSX0PHfwg4a8BBQqkJYa4XWuBbi/Nku4+6L89
 zd1f103tBLAtWmvSFtlcuGUUIFaEkV7iSmSMIc8jjuyN86qqjKRQTeCLcvr6IY1N9UVd
 /FRSR2+8wxpnpMcQhhoIKra2y5KmWNX/N/cK1cOGecSbR4wih+DLNqcVMh6ci9twZDgv
 ruQKtw3dBaoBE9ewuY77Dw07O+CRcC22KoPHgbQe3Vj4APgUmntX7V+p9WfBa3wINiVp
 8hrg==
X-Gm-Message-State: APjAAAVxdiMVWXt+Xomua/T+cNskD5+whRv2hLEn9ws7eC2b/zArSpbN
 1tss+iV06U5sBuTTJOZlBuucVYkE
X-Google-Smtp-Source: APXvYqz5Wf1kOYa6V33yDPG0EK9jBkZI5wFT4Q8bCe/rBQXbcLVPbMeOdlYcxCh2CKoUD0u3L1kbbQ==
X-Received: by 2002:a05:6000:124a:: with SMTP id
 j10mr10330123wrx.191.1561413669297; 
 Mon, 24 Jun 2019 15:01:09 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:55 +0200
Message-Id: <20190624220056.25861-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 8/9] hw/sparc/sun4m: Simplify the RAM creation
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now than the empty_slot device can be overlapped, use it to cover
the maximum memory range.
We can simplify now the main RAM is created.
The TYPE_SUN4M_MEMORY is not migratable, simply remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/sun4m.c | 85 ++++++++----------------------------------------
 1 file changed, 13 insertions(+), 72 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0df5a8edfc..d55753d5cb 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -767,71 +767,6 @@ static const TypeInfo prom_info = {
     .class_init    = prom_class_init,
 };
 
-#define TYPE_SUN4M_MEMORY "memory"
-#define SUN4M_RAM(obj) OBJECT_CHECK(RamDevice, (obj), TYPE_SUN4M_MEMORY)
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
-    RamDevice *d = SUN4M_RAM(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-
-    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram",
-                                         d->size);
-    sysbus_init_mmio(sbd, &d->ram);
-}
-
-static void ram_init(hwaddr addr, ram_addr_t RAM_size,
-                     uint64_t max_mem)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    RamDevice *d;
-
-    /* allocate RAM */
-    if ((uint64_t)RAM_size > max_mem) {
-        error_report("Too much memory for this machine: %" PRId64 ","
-                     " maximum %" PRId64,
-                     RAM_size / MiB, max_mem / MiB);
-        exit(1);
-    }
-    dev = qdev_create(NULL, "memory");
-    s = SYS_BUS_DEVICE(dev);
-
-    d = SUN4M_RAM(dev);
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
-    dc->props = ram_properties;
-}
-
-static const TypeInfo ram_info = {
-    .name          = TYPE_SUN4M_MEMORY,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(RamDevice),
-    .class_init    = ram_class_init,
-};
-
 static void cpu_devinit(const char *cpu_type, unsigned int id,
                         uint64_t prom_addr, qemu_irq **cpu_irqs)
 {
@@ -872,6 +807,19 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     FWCfgState *fw_cfg;
     DeviceState *dev;
     SysBusDevice *s;
+    MemoryRegion ram;
+
+    if ((uint64_t)machine->ram_size > hwdef->max_mem) {
+        error_report("Too much memory for this machine: %" PRId64 ","
+                     " maximum %" PRId64,
+                     machine->ram_size / MiB, hwdef->max_mem / MiB);
+        exit(1);
+    }
+    memory_region_allocate_system_memory(&ram, OBJECT(machine), "sun4m.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(get_system_memory(), 0x00000000, &ram);
+    /* models without ECC don't trap when missing ram is accessed */
+    empty_slot_init(0x00000000, hwdef->max_mem);
 
     /* init CPUs */
     for(i = 0; i < smp_cpus; i++) {
@@ -881,13 +829,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     for (i = smp_cpus; i < MAX_CPUS; i++)
         cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
 
-
     /* set up devices */
-    ram_init(0, machine->ram_size, hwdef->max_mem);
-    /* models without ECC don't trap when missing ram is accessed */
-    if (!hwdef->ecc_base) {
-        empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
-    }
 
     prom_init(hwdef->slavio_base, bios_name);
 
@@ -1561,7 +1503,6 @@ static void sun4m_register_types(void)
     type_register_static(&idreg_info);
     type_register_static(&afx_info);
     type_register_static(&prom_info);
-    type_register_static(&ram_info);
 
     type_register_static(&ss5_type);
     type_register_static(&ss10_type);
-- 
2.19.1


