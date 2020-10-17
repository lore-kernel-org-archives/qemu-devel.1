Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3F2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5BA207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5BA207BB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTszP-0006F4-9n
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 16:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTsvj-0000iO-2Y; Sat, 17 Oct 2020 16:35:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:13763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTsvf-0004ZO-M8; Sat, 17 Oct 2020 16:35:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E310B747E09;
 Sat, 17 Oct 2020 22:35:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5BACD74762C; Sat, 17 Oct 2020 22:35:46 +0200 (CEST)
Message-Id: <540c1f05cdd1c01ce45f46355d2829aa494e2adb.1602965621.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1602965621.git.balaton@eik.bme.hu>
References: <cover.1602965621.git.balaton@eik.bme.hu>
Subject: [PATCH 1/6] m48t59-isa: remove legacy m48t59_init_isa() function
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

This function is no longer used within the codebase.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/rtc/m48t59-isa.c     | 25 -------------------------
 include/hw/rtc/m48t59.h |  2 --
 2 files changed, 27 deletions(-)

diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index cae315e488..dc21fb10a5 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -58,31 +58,6 @@ static M48txxInfo m48txx_isa_info[] = {
     }
 };
 
-Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
-                       int base_year, int model)
-{
-    ISADevice *isa_dev;
-    DeviceState *dev;
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(m48txx_isa_info); i++) {
-        if (m48txx_isa_info[i].size != size ||
-            m48txx_isa_info[i].model != model) {
-            continue;
-        }
-
-        isa_dev = isa_new(m48txx_isa_info[i].bus_name);
-        dev = DEVICE(isa_dev);
-        qdev_prop_set_uint32(dev, "iobase", io_base);
-        qdev_prop_set_int32(dev, "base-year", base_year);
-        isa_realize_and_unref(isa_dev, bus, &error_fatal);
-        return NVRAM(dev);
-    }
-
-    assert(false);
-    return NULL;
-}
-
 static uint32_t m48txx_isa_read(Nvram *obj, uint32_t addr)
 {
     M48txxISAState *d = M48TXX_ISA(obj);
diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index 04abedf3b2..9defe578d1 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -47,8 +47,6 @@ struct NvramClass {
     void (*toggle_lock)(Nvram *obj, int lock);
 };
 
-Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
-                       int base_year, int type);
 Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
                    uint32_t io_base, uint16_t size, int base_year,
                    int type);
-- 
2.21.3


