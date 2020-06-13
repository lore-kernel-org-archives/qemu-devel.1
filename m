Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B285C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308C92074D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308C92074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk6YW-0000nf-Fg
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 09:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jk6TM-0002fY-4F; Sat, 13 Jun 2020 09:45:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47683)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jk6TK-0002ZK-DV; Sat, 13 Jun 2020 09:45:23 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DEC63748DD1;
 Sat, 13 Jun 2020 15:45:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2CA7C748DCF; Sat, 13 Jun 2020 15:45:00 +0200 (CEST)
Message-Id: <b80aec26effdb026b10394156d59611b47f807c6.1592055375.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592055375.git.balaton@eik.bme.hu>
References: <cover.1592055375.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 3/5] grackle: Set revision in PCI config to match hardware
Date: Sat, 13 Jun 2020 15:36:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 09:45:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/grackle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 4b3af0c704..48d11f13ab 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -130,7 +130,7 @@ static void grackle_pci_class_init(ObjectClass *klass, void *data)
     k->realize   = grackle_pci_realize;
     k->vendor_id = PCI_VENDOR_ID_MOTOROLA;
     k->device_id = PCI_DEVICE_ID_MOTOROLA_MPC106;
-    k->revision  = 0x00;
+    k->revision  = 0x40;
     k->class_id  = PCI_CLASS_BRIDGE_HOST;
     /*
      * PCI-facing part of the host bridge, not usable without the
-- 
2.21.3


