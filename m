Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB105207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB105207BB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTsz4-0005K2-21
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 16:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTsvk-0000kQ-Lc; Sat, 17 Oct 2020 16:35:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:13779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTsvi-0004f4-US; Sat, 17 Oct 2020 16:35:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 11DD4747F1A;
 Sat, 17 Oct 2020 22:35:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6FACC74762D; Sat, 17 Oct 2020 22:35:46 +0200 (CEST)
Message-Id: <8b7f9f585a6d4e84e91d312093c80af544633eaf.1602965621.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1602965621.git.balaton@eik.bme.hu>
References: <cover.1602965621.git.balaton@eik.bme.hu>
Subject: [PATCH 6/6] m48t59: remove legacy m48t59_init() function
Date: Sat, 17 Oct 2020 22:13:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Herve Poussineau <hpoussin@reactos.org>,
 Philippe Mathieu-Daude <f4bug@amsat.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Now that all of the callers of this function have been switched to use qdev
properties, this legacy init function can now be removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/rtc/m48t59.c         | 35 -----------------------------------
 include/hw/rtc/m48t59.h |  4 ----
 2 files changed, 39 deletions(-)

diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 3108cf3d3f..e74716c491 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -564,41 +564,6 @@ const MemoryRegionOps m48t59_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-/* Initialisation routine */
-Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
-                   uint32_t io_base, uint16_t size, int base_year,
-                   int model)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(m48txx_sysbus_info); i++) {
-        if (m48txx_sysbus_info[i].size != size ||
-            m48txx_sysbus_info[i].model != model) {
-            continue;
-        }
-
-        dev = qdev_new(m48txx_sysbus_info[i].bus_name);
-        qdev_prop_set_int32(dev, "base-year", base_year);
-        s = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(s, &error_fatal);
-        sysbus_connect_irq(s, 0, IRQ);
-        if (io_base != 0) {
-            memory_region_add_subregion(get_system_io(), io_base,
-                                        sysbus_mmio_get_region(s, 1));
-        }
-        if (mem_base != 0) {
-            sysbus_mmio_map(s, 0, mem_base);
-        }
-
-        return NVRAM(s);
-    }
-
-    assert(false);
-    return NULL;
-}
-
 void m48t59_realize_common(M48t59State *s, Error **errp)
 {
     s->buffer = g_malloc0(s->size);
diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index 9defe578d1..d9b45eb161 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -47,8 +47,4 @@ struct NvramClass {
     void (*toggle_lock)(Nvram *obj, int lock);
 };
 
-Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
-                   uint32_t io_base, uint16_t size, int base_year,
-                   int type);
-
 #endif /* HW_M48T59_H */
-- 
2.21.3


