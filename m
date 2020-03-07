Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1764BC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 09:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0775206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 09:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0775206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAVYX-00056o-4p
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 04:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAVWX-0002Yl-RV
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 04:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAVWW-0003Ul-RC
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 04:13:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:37974
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAVWW-0003TT-L4
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 04:13:32 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=kentang.home) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAVWp-0006ZF-99; Sat, 07 Mar 2020 09:13:55 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	rth@twiddle.net,
	jsnow@redhat.com
Date: Sat,  7 Mar 2020 09:13:13 +0000
Message-Id: <20200307091313.24190-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200307091313.24190-1-mark.cave-ayland@ilande.co.uk>
References: <20200307091313.24190-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.162.6.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 2/2] cmd646: remove unused pci_cmd646_ide_init() function
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ide/cmd646.c  | 12 ------------
 include/hw/ide.h |  2 --
 2 files changed, 14 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 335c060673..d953932104 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -317,18 +317,6 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
     }
 }
 
-void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
-                         int secondary_ide_enabled)
-{
-    PCIDevice *dev;
-
-    dev = pci_create(bus, -1, "cmd646-ide");
-    qdev_prop_set_uint32(&dev->qdev, "secondary", secondary_ide_enabled);
-    qdev_init_nofail(&dev->qdev);
-
-    pci_ide_create_devs(dev, hd_table);
-}
-
 static Property cmd646_ide_properties[] = {
     DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/ide.h b/include/hw/ide.h
index 28d8a06439..0c7080ed92 100644
--- a/include/hw/ide.h
+++ b/include/hw/ide.h
@@ -12,8 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
                         DriveInfo *hd0, DriveInfo *hd1);
 
 /* ide-pci.c */
-void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
-                         int secondary_ide_enabled);
 PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
 PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
-- 
2.20.1


