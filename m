Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE99C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764862074D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM2i9xGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764862074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBgo-000474-KA
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYU-0000eF-4E
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYS-00009s-0b
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYR-00009B-QC; Wed, 25 Mar 2020 15:19:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id b12so3821663wmj.3;
 Wed, 25 Mar 2020 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FLAg7xZQkFQ92vwN68WYTdAYbQO9ogHsGkYV8gRk1bg=;
 b=aM2i9xGPlxc7eiNKXcKUby7/ZlPXd+ZoPY3tUflSCFFLJjNxH7u/XyAwYjn2/zuLUD
 12fiaUWkLFIMzNunmhbWuJjNQDqUXacbAEiOwz7gFocslD+8ACOxJTFu4EcLBBP1Zv2k
 UJCrRUZS95pqFWH9bnkuf0xZ4d6pugF+IOuJajLtdwSkQFCfUh6YApTPd7SsMAuhcaHX
 NJKsKBJKyRyl3hVWK8juW/l7Itu0FeesPLePueykBBN6WRhLutNNPh2IR5eusoqjfw3F
 +pZoInKcPJuHu7Ta7jMn01ezdTHGSJbislTtHSaGDv8ZidIRO+RqCd8dXfjZAMLp8diY
 Y3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FLAg7xZQkFQ92vwN68WYTdAYbQO9ogHsGkYV8gRk1bg=;
 b=Js+8JV5jFpyru/8YUY9BZs7uz30L+/xCi0FBSUuDwSGe8wtjMxvNMBTwMkSqk6EEN4
 6MOtvlVs2sYENU2wZLMFFrv6rC2GnxEAwTDFr+nI3Qs4OTccrK7GgmtpxDF4PZwM758d
 pxy+VFVbbd039A2bChly2rqZHoVvewLvH9/dNLK2XNqwPpp11OC1RKPAtYWzfeOn4qbG
 DkwUDOKAWtNdJdRyaIPcXRTITMoj0JKDZfbQb39quA0vq7HHB2AuxP8Cd3MU2iQ1BvpB
 RUyCzhhuBnU5Qd1hYP40AWKnKw/tQYiR16Suro8QX2LLJP+CSOVZ5YjKzBMhZMLqLESx
 o+xA==
X-Gm-Message-State: ANhLgQ1RO90Y8uUhlRG38R4eo1z2qXtGYGdpck+8EXu3JF/pl/7oVCkG
 vBmsA3AbeKU6paNCJRS4dGmpcLsbP8c=
X-Google-Smtp-Source: ADFU+vsTDouuJFZhsaN9jpTOHaevaZOuYumtfWR76FoMQzD+z65DCgdk07CJDsio8mPDMbGyndXPiw==
X-Received: by 2002:a1c:bcc6:: with SMTP id m189mr5049600wmf.48.1585163946428; 
 Wed, 25 Mar 2020 12:19:06 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r17sm6345672wrx.46.2020.03.25.12.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 12:19:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 11/12] hw/net/xilinx_axienet: Add missing
 error-propagation code
Date: Wed, 25 Mar 2020 20:18:29 +0100
Message-Id: <20200325191830.16553-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325191830.16553-1-f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

  [[manual check required: error_propagate() might be missing in object_property_set_link() hw/net/xilinx_axienet.c:969:4]]

Add the missing error_propagate() after manual review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/xilinx_axienet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 704788811a..f11510a71e 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -948,39 +948,42 @@ static NetClientInfo net_xilinx_enet_info = {
 static void xilinx_enet_realize(DeviceState *dev, Error **errp)
 {
     XilinxAXIEnet *s = XILINX_AXI_ENET(dev);
     XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
     XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(
                                                             &s->rx_control_dev);
     Error *local_err = NULL;
 
     object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
                              (Object **) &ds->enet,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
                              &local_err);
     object_property_add_link(OBJECT(cs), "enet", "xlnx.axi-ethernet",
                              (Object **) &cs->enet,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
                              &local_err);
     if (local_err) {
         goto xilinx_enet_realize_fail;
     }
     object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &local_err);
+    if (local_err) {
+        goto xilinx_enet_realize_fail;
+    }
     object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &local_err);
     if (local_err) {
         goto xilinx_enet_realize_fail;
     }
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_enet_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     tdk_init(&s->TEMAC.phy);
     mdio_attach(&s->TEMAC.mdio_bus, &s->TEMAC.phy, s->c_phyaddr);
 
     s->TEMAC.parent = s;
 
     s->rxmem = g_malloc(s->c_rxmem);
     return;
-- 
2.21.1


