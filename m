Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3227AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E999120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrVDOWe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E999120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbc2-0001s4-3l
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUT-0002w4-EF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUR-0008Og-Lc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSHmEGrAQPMPu/4JEtSptfteVriYua5heYz3/u5Gb3s=;
 b=XrVDOWe6GAhY0d3IZ9jbZZQkCEAKJQk5a18okmavrQV4I+rJ0GjdKBfFm1poRBOTaX3txA
 DDcD7iB4k4OPMNr5dDADqGZSeeWf/q7cW9r6BXpWm1QAzce1eJsz4cu4ix762y2jzR1j1u
 Q/L3NAtxkHdkarWAti422q9tHIrtzMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-BZC6z5O4OX6yrDVmJ0WEPQ-1; Wed, 02 Sep 2020 18:44:25 -0400
X-MC-Unique: BZC6z5O4OX6yrDVmJ0WEPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41E258030C7;
 Wed,  2 Sep 2020 22:44:24 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 416127E313;
 Wed,  2 Sep 2020 22:44:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/63] pxb: Rename TYPE_PXB_PCIE_DEVICE to TYPE_PXB_PCIE_DEV
Date: Wed,  2 Sep 2020 18:42:30 -0400
Message-Id: <20200902224311.1321159-23-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org
---
 hw/pci-bridge/pci_expander_bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 42e58d5850..1517ae5fa2 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -46,9 +46,9 @@ typedef struct PXBDev PXBDev;
 DECLARE_INSTANCE_CHECKER(PXBDev, PXB_DEV,
                          TYPE_PXB_DEV)
 
-#define TYPE_PXB_PCIE_DEVICE "pxb-pcie"
+#define TYPE_PXB_PCIE_DEV "pxb-pcie"
 DECLARE_INSTANCE_CHECKER(PXBDev, PXB_PCIE_DEV,
-                         TYPE_PXB_PCIE_DEVICE)
+                         TYPE_PXB_PCIE_DEV)
 
 struct PXBDev {
     /*< private >*/
@@ -360,7 +360,7 @@ static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo pxb_pcie_dev_info = {
-    .name          = TYPE_PXB_PCIE_DEVICE,
+    .name          = TYPE_PXB_PCIE_DEV,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PXBDev),
     .class_init    = pxb_pcie_dev_class_init,
-- 
2.26.2


