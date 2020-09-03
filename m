Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD87C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7912120716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlUkTuj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7912120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtcj-0001Hy-Fs
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtZD-0004Kk-Py
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtZB-0007TR-U7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=me9w61ar0TH6gyxD0WzBdEhPBFIHmwvGvRDskpl6aGA=;
 b=WlUkTuj+1dQB5le8I0BsY7bXDMKAs1aMTgN3rv/h6Q3zKmx+O/nXE/dmHfAViQLx4XPmGI
 vRydw6oKpTpP0pXwMm8ki0hPq0wlvgEzIkF2Jz2V+puCmEiQF+fYdr+LazSzLS5WcpuL5K
 NMnw5P/AdQMZeLnhEx9qmhYuUGnR+Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-dQRa0sMSPNSxVgZ0Fsi0pg-1; Thu, 03 Sep 2020 14:02:26 -0400
X-MC-Unique: dQRa0sMSPNSxVgZ0Fsi0pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ECDC1074654;
 Thu,  3 Sep 2020 18:02:25 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D95C481190;
 Thu,  3 Sep 2020 18:02:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 7/8] esp-pci: Rename PCI_ESP to AM53C974
Date: Thu,  3 Sep 2020 14:01:27 -0400
Message-Id: <20200903180128.1523959-8-ehabkost@redhat.com>
In-Reply-To: <20200903180128.1523959-1-ehabkost@redhat.com>
References: <20200903180128.1523959-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the type checking function to be consistent with the type
name constant (TYPE_AM53C974) and type name string ("am53c974").

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* New patch added to series v2
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: qemu-devel@nongnu.org
---
 hw/scsi/esp-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index e30a911b21..117383037e 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -38,7 +38,7 @@
 #define TYPE_AM53C974 "am53c974"
 
 typedef struct PCIESPState PCIESPState;
-DECLARE_INSTANCE_CHECKER(PCIESPState, PCI_ESP,
+DECLARE_INSTANCE_CHECKER(PCIESPState, AM53C974,
                          TYPE_AM53C974)
 
 #define DMA_CMD   0x0
@@ -305,7 +305,7 @@ static const MemoryRegionOps esp_pci_io_ops = {
 
 static void esp_pci_hard_reset(DeviceState *dev)
 {
-    PCIESPState *pci = PCI_ESP(dev);
+    PCIESPState *pci = AM53C974(dev);
     esp_hard_reset(&pci->esp);
     pci->dma_regs[DMA_CMD] &= ~(DMA_CMD_DIR | DMA_CMD_INTE_D | DMA_CMD_INTE_P
                               | DMA_CMD_MDL | DMA_CMD_DIAG | DMA_CMD_MASK);
@@ -352,7 +352,7 @@ static const struct SCSIBusInfo esp_pci_scsi_info = {
 
 static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
 {
-    PCIESPState *pci = PCI_ESP(dev);
+    PCIESPState *pci = AM53C974(dev);
     DeviceState *d = DEVICE(dev);
     ESPState *s = &pci->esp;
     uint8_t *pci_conf;
@@ -377,7 +377,7 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
 
 static void esp_pci_scsi_uninit(PCIDevice *d)
 {
-    PCIESPState *pci = PCI_ESP(d);
+    PCIESPState *pci = AM53C974(d);
 
     qemu_free_irq(pci->esp.irq);
 }
-- 
2.26.2


