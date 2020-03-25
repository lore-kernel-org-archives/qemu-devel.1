Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF4C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334DC20719
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGPd1RDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334DC20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBgr-0004CD-Cq
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYQ-0000X3-Hn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYP-00007f-51
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYO-000077-UD; Wed, 25 Mar 2020 15:19:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id p10so4693473wrt.6;
 Wed, 25 Mar 2020 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9usvSGI/eVqKf05MvHpkRmaqSX5CGG2+AA8VX96K1ZM=;
 b=VGPd1RDB0/AJDx07lYAilZaavW0HriN10KKEQi57luf9qajxxahydp3lel1OVZF58k
 hDJ70tNf2E32isOLObgoh/RN52wCFJcGErCbJawZttA1CZBxr9u6/CavwWU/M7s3fQL3
 ogvVENbDNGAFztrVOnAPyeRnbxgFiOQZkz5n3EoDEdmZ9lyRI5dWFsyrILXxcsPimNv5
 GnvpEkXCI1fc+kx40rABmwiXoE2pqQBnnOv191dqd+SCf1UcEZW0C8CRdnEwVg6knsLS
 8Y653opcLUjr3pgOxIAe69+XAwxm5D51JZMLYihP7mbZqqthHrF4eZlcU8CJKJTV4EUw
 gbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9usvSGI/eVqKf05MvHpkRmaqSX5CGG2+AA8VX96K1ZM=;
 b=WWZh0nMrl/3CEsKbiZYJ1cPngRCHGgNa3qkCDhCnUWJegu2LuaU4Qb1RLGYD06uZ7B
 6DQU1yIX7i/0oiWYZd7sZt2ihr81pp1yvabhwHqLaWdJeUocvYMSveJiKUVf9gxyOFiR
 TlSuxJVPkq7TAd/66MhmspQ2E/W1xB2ODhxbNh4/RV5tygpPuhhuAl3aNDrOGUORvXwr
 ULm+PwiAwcBjmb0MibMiemKN4d1jZ9esUE5WmK1gJFGPtWib5S/60hT+MUhKvtjW0MM1
 2hwhozm6pjBA/3Fz5CMjR/KKOw/U6fevyHow1wBkF3VhLSQzAyffGCWTWPiixwcoQIMS
 pdeQ==
X-Gm-Message-State: ANhLgQ03dzI9kOao1MxG3QDVWDPmZjA4W9GQkFWQAtle87mz+TZ3UGOT
 1eG0oCBEYpka/Wt+qM1ywb02RSLWg98=
X-Google-Smtp-Source: ADFU+vv/rTw1f6skK2gM0CaK7KTQ/4o0yvyb5f4/dLQOpOFPD/j5JXqBWlajQ/oVDBS7+PJzWxSdtQ==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr5318535wrt.150.1585163943562; 
 Wed, 25 Mar 2020 12:19:03 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r17sm6345672wrx.46.2020.03.25.12.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 12:19:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 10/12] hw/misc/macio/macio: Add missing
 error-propagation code
Date: Wed, 25 Mar 2020 20:18:28 +0100
Message-Id: <20200325191830.16553-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325191830.16553-1-f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

  [[manual check required: error_propagate() might be missing in object_property_set_bool() hw/misc/macio/macio.c:350:8]]

Add the missing error_propagate() after manual review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/macio/macio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 79222192e8..fffb64a7d5 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -292,98 +292,102 @@ static const MemoryRegionOps timer_ops = {
 static void macio_newworld_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     NewWorldMacIOState *ns = NEWWORLD_MACIO(d);
     DeviceState *pic_dev = DEVICE(ns->pic);
     Error *err = NULL;
     SysBusDevice *sysbus_dev;
     MemoryRegion *timer_memory = NULL;
 
     macio_common_realize(d, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
 
     sysbus_dev = SYS_BUS_DEVICE(&s->escc);
     sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
                                                        NEWWORLD_ESCCB_IRQ));
     sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
                                                        NEWWORLD_ESCCA_IRQ));
 
     /* OpenPIC */
     sysbus_dev = SYS_BUS_DEVICE(ns->pic);
     memory_region_add_subregion(&s->bar, 0x40000,
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
     /* IDE buses */
     macio_realize_ide(s, &ns->ide[0],
                       qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_IRQ),
                       qdev_get_gpio_in(pic_dev, NEWWORLD_IDE0_DMA_IRQ),
                       0x16, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
 
     macio_realize_ide(s, &ns->ide[1],
                       qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_IRQ),
                       qdev_get_gpio_in(pic_dev, NEWWORLD_IDE1_DMA_IRQ),
                       0x1a, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
 
     /* Timer */
     timer_memory = g_new(MemoryRegion, 1);
     memory_region_init_io(timer_memory, OBJECT(s), &timer_ops, NULL, "timer",
                           0x1000);
     memory_region_add_subregion(&s->bar, 0x15000, timer_memory);
 
     if (ns->has_pmu) {
         /* GPIOs */
         sysbus_dev = SYS_BUS_DEVICE(&ns->gpio);
         object_property_set_link(OBJECT(&ns->gpio), OBJECT(pic_dev), "pic",
                                  &error_abort);
         memory_region_add_subregion(&s->bar, 0x50,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
         object_property_set_bool(OBJECT(&ns->gpio), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
 
         /* PMU */
         object_initialize_child(OBJECT(s), "pmu", &s->pmu, sizeof(s->pmu),
                                 TYPE_VIA_PMU, &error_abort, NULL);
         object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "gpio",
                                  &error_abort);
         qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
         qdev_set_parent_bus(DEVICE(&s->pmu), BUS(&s->macio_bus));
 
         object_property_set_bool(OBJECT(&s->pmu), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
         sysbus_dev = SYS_BUS_DEVICE(&s->pmu);
         sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
                                                            NEWWORLD_PMU_IRQ));
         memory_region_add_subregion(&s->bar, 0x16000,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
     } else {
         /* CUDA */
         object_initialize_child(OBJECT(s), "cuda", &s->cuda, sizeof(s->cuda),
                                 TYPE_CUDA, &error_abort, NULL);
         qdev_set_parent_bus(DEVICE(&s->cuda), BUS(&s->macio_bus));
         qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                              s->frequency);
 
         object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
         sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
         sysbus_connect_irq(sysbus_dev, 0, qdev_get_gpio_in(pic_dev,
                                                            NEWWORLD_CUDA_IRQ));
         memory_region_add_subregion(&s->bar, 0x16000,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
     }
 }
-- 
2.21.1


