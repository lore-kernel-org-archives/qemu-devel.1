Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83813C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 11:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE1A2082E
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 11:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQsKJz3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE1A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXkFV-0001er-A4
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 07:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXkEi-0001BB-GM
 for qemu-devel@nongnu.org; Sun, 10 May 2020 07:35:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXkEg-00056x-JQ
 for qemu-devel@nongnu.org; Sun, 10 May 2020 07:35:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id j5so7253243wrq.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1sGCszq4iNsnWpjkDa6PLbJ7mB9x9d8Hb21P4Y4Q2OM=;
 b=RQsKJz3Yntu05j41RriCGxx4fLDhXKBE62Rmz4R+Q94FaBhdUfvIG65x0Ym5dntEMb
 K9jaecsqx2Y28wG+zmPDiPwhDPd9FhLQcvcpcgsvC16UC01+zb/NdilIcoNqig6v/2oN
 b6YwnJ6VIohHqF7z7XZIkXoWOvGvafbMCmgUZrN7gx/oPov35/J6GzIHLZJNpDhUHEf7
 EJa8piIE9+JbBClSh+yN+bPwDEWlMnKAzLR+WKnu5gTuTrgaN/2lH/lUSJuXAeckn1YC
 ZtPa6dZyXQARz+ysd5B71Gl/QsZEhZYoiBnZRxuXfRZ3VzneuIhcrcHpU4skRiWJp564
 ID5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=1sGCszq4iNsnWpjkDa6PLbJ7mB9x9d8Hb21P4Y4Q2OM=;
 b=WzIVMLwCGKvyjD3+JkN8Yva6S2pYrq/HCYmMlegyfrvXh3C4yo2DjzUYeUA4lDlA74
 wsgCeQJGmVivB2xCYjiPyVkX8lXG/cwk6MlbAstFvSpQumG8RUKR0PxV4dHwPysjDEuU
 D5qFWntnqKVjPJyeVIUliEctjyEjuat3E6pL3xbEAKDtHKCS94+DE+uF3cBhiQWbG6yo
 lvo+LFIiKzUDfMiTsRyHbOPoVhI/60IzljTPc4ayTriJy97WmxlCNBJx+9lH3pLsOin7
 Wbc/Fj9rnP3s16PvohK3T9BAIgDlJ++z+MA5jutn5rtLVhzSASIAG26SH6ETS9v7Db07
 V2fw==
X-Gm-Message-State: AGi0PuYae9nFpx3h3MHEJS247+A2hsIHXH8rgRUJmoz7ZS/pYvnjtUgN
 2LohsAc2f/KB+fJoK6gSL9VDTKqHQ6M=
X-Google-Smtp-Source: APiQypJzo86kxc1IXAA2M1CAW09ERC5+NRro2ICqyw0rhBnuTbSDcICgN0WliFX7L2dwP1OZJrBRqg==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr13073485wrm.364.1589110508857; 
 Sun, 10 May 2020 04:35:08 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm4376297wra.36.2020.05.10.04.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 04:35:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] hw/sparc/sun4m: Use memdev backend for main RAM
Date: Sun, 10 May 2020 13:35:05 +0200
Message-Id: <20200510113505.10500-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

Since commit 82b911aaff3, machine_run_board_init() checks for
ram_memdev_id and consume it. As TYPE_SUN4M_MEMORY is no more
needed, replace it by the generic memdev allocated MemoryRegion
and remove it. This completes commit b2554752b1da7c8f.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc/sun4m.c | 54 ++----------------------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 36ee1a0a3d..9838c5a183 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -772,50 +772,6 @@ static const TypeInfo prom_info = {
     .class_init    = prom_class_init,
 };
 
-#define TYPE_SUN4M_MEMORY "memory"
-#define SUN4M_RAM(obj) OBJECT_CHECK(RamDevice, (obj), TYPE_SUN4M_MEMORY)
-
-typedef struct RamDevice {
-    SysBusDevice parent_obj;
-    HostMemoryBackend *memdev;
-} RamDevice;
-
-/* System RAM */
-static void ram_realize(DeviceState *dev, Error **errp)
-{
-    RamDevice *d = SUN4M_RAM(dev);
-    MemoryRegion *ram = host_memory_backend_get_memory(d->memdev);
-
-    sysbus_init_mmio(SYS_BUS_DEVICE(dev), ram);
-}
-
-static void ram_initfn(Object *obj)
-{
-    RamDevice *d = SUN4M_RAM(obj);
-    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
-                             (Object **)&d->memdev,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG, &error_abort);
-    object_property_set_description(obj, "memdev", "Set RAM backend"
-                                    "Valid value is ID of a hostmem backend",
-                                     &error_abort);
-}
-
-static void ram_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = ram_realize;
-}
-
-static const TypeInfo ram_info = {
-    .name          = TYPE_SUN4M_MEMORY,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(RamDevice),
-    .instance_init = ram_initfn,
-    .class_init    = ram_class_init,
-};
-
 static void cpu_devinit(const char *cpu_type, unsigned int id,
                         uint64_t prom_addr, qemu_irq **cpu_irqs)
 {
@@ -858,8 +814,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     SysBusDevice *s;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
-    Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
-                                                  TYPE_MEMORY_BACKEND, NULL);
 
     if (machine->ram_size > hwdef->max_mem) {
         error_report("Too much memory for this machine: %" PRId64 ","
@@ -876,11 +830,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     for (i = smp_cpus; i < MAX_CPUS; i++)
         cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
 
-    /* Create and map RAM frontend */
-    dev = qdev_create(NULL, "memory");
-    object_property_set_link(OBJECT(dev), ram_memdev, "memdev", &error_fatal);
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
+    /* RAM */
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /* models without ECC don't trap when missing ram is accessed */
     if (!hwdef->ecc_base) {
@@ -1575,7 +1526,6 @@ static void sun4m_register_types(void)
     type_register_static(&idreg_info);
     type_register_static(&afx_info);
     type_register_static(&prom_info);
-    type_register_static(&ram_info);
 
     type_register_static(&ss5_type);
     type_register_static(&ss10_type);
-- 
2.21.3


