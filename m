Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B0FC2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07E720767
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07E720767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObPl-0008EG-RB
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz4-0002yR-2b
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOaz1-0002tJ-T0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayy-0002cd-G7; Wed, 15 Apr 2020 01:53:08 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 6018DBFDE1;
 Wed, 15 Apr 2020 05:52:32 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 39/48] pci: pass along the return value of dma_memory_rw
Date: Wed, 15 Apr 2020 07:51:31 +0200
Message-Id: <20200415055140.466900-40-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The nvme device needs to know the return value of dma_memory_rw to pass
block/011 from blktests. So pass it along instead of ignoring it.

There are no existing users of the return value, so this patch should be
safe.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 include/hw/pci/pci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cfedf5a995d7..da9057b8db97 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -784,8 +784,7 @@ static inline AddressSpace *pci_get_address_space(PCI=
Device *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir=
)
 {
-    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
-    return 0;
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir=
);
 }
=20
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
--=20
2.26.0


