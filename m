Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A97207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfMJppeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A97207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYm4-00070t-3C
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkB-00044v-DT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkA-0007WI-Ey
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so20080763wru.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JSDexJUoRc6C2dBRPfkhG4h1BGjFFYK10Clp3IocDL8=;
 b=hfMJppeOHfs2XSDo401PBnMmW1ulSegyUL0Gb5YjynL0a1P1H8vRTP3d4ILbeLDZQm
 nzDykrSiuobROMTrr21CarIvcoOXOPZhltix+P318lUKddh5ugYAdZ4+7/BjuIzjHcom
 HZcL+IKO0rHmrfhIxVC6hD7XCOIgnRs88JijJAbur2Mj1MYkj4FHBHLvi/GYabdDGgPP
 oK/IYqSFGRSYZa8w7gfPwiRIdnIpDyudvVjIcAvoaYUDhPcjhLwoJA7inovTphwx2Znt
 cu9qYUiSP8GqRNbvbhcXiH0sH7DVwJNnqFfwV1a4Zt2KZFTdhhj4+FMItK1ufJEbi9xz
 9CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JSDexJUoRc6C2dBRPfkhG4h1BGjFFYK10Clp3IocDL8=;
 b=qT9SDqJp13GHD0Y3G3+W5A53+d10ffyP9BfdpxiqyugqnDh7Ic3xYnavRCnyzpCTA3
 MwRXfLENH6CjIAJSWPHuJ6BwU4cSrMIL7tOBwUGM2Pqxl3SN1JksERd5xxAkCEPpxUS5
 9vfqJ00NzfgD4YlQZKgiOz2b+gn/DGW9A00Sil5mLbjFhkZ/xW5EddKWiSsRwqzCTo14
 jmtA4eN0MlobKtWE5RUugncdJ3KsEUm4VtmImUunWtsMQW34JSaJQAgdT11+Idw2Zxyd
 NAnSE6+Ae3o7XkUqMzSIhFqHvXWHTYncFmM/z2Q1ulqK2KHI4kiL7LEZUNmsyRGlHtpj
 /Yag==
X-Gm-Message-State: AOAM533ddQ2D/B2F+HhteJPVPGmxKQiFzMInEXJhMXEP4rUn865CgysT
 pAgJ1Akc5EqcneCfcCgj2PF1F5mO
X-Google-Smtp-Source: ABdhPJy/Q+jV+z7FHe3WTmQZ7Z8YN7l/TTZKkWMkeIHxIusFi5cYikfKOP6MHIFHiKXZnVAwWE0LPQ==
X-Received: by 2002:adf:e749:: with SMTP id c9mr3113129wrn.25.1591687939666;
 Tue, 09 Jun 2020 00:32:19 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] hw/misc/empty_slot: Convert 'size' field as qdev property
Date: Tue,  9 Jun 2020 09:32:01 +0200
Message-Id: <20200609073214.14079-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200510152840.13558-4-f4bug@amsat.org>
---
 hw/core/empty_slot.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 5ab426e965..0df086fe98 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/empty_slot.h"
 
 //#define DEBUG_EMPTY_SLOT
@@ -57,17 +58,13 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
     if (slot_size > 0) {
         /* Only empty slots larger than 0 byte need handling. */
         DeviceState *dev;
-        SysBusDevice *s;
-        EmptySlot *e;
 
         dev = qdev_create(NULL, TYPE_EMPTY_SLOT);
-        s = SYS_BUS_DEVICE(dev);
-        e = EMPTY_SLOT(dev);
-        e->size = slot_size;
 
+        qdev_prop_set_uint64(dev, "size", slot_size);
         qdev_init_nofail(dev);
 
-        sysbus_mmio_map_overlap(s, 0, addr, -10000);
+        sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, addr, -10000);
     }
 }
 
@@ -80,11 +77,17 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
+static Property empty_slot_properties[] = {
+    DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void empty_slot_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = empty_slot_realize;
+    device_class_set_props(dc, empty_slot_properties);
 }
 
 static const TypeInfo empty_slot_info = {
-- 
2.21.3


