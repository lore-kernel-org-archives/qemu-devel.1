Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47126C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095C020767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBPbvNdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095C020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbhI-0005ty-5R
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUu-0003qC-9n
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUs-0008TB-6l
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vQVv/ucK+9L7zNUowwRBb6uytqXhgNHcK2BJwk//s+I=;
 b=HBPbvNdGlGaGWAdJ491mRhPuflQ3nJuGRt/7zFbqEgYQOa1nbS/vmZ43LgYoA1oUHeMXBo
 FmH2sbvmofsN2WJ7AtYJR6s/jd+o7T/RXCb7qTggOzPntDIYoLO1dAXXBsvyNk6S0mXZGV
 5CZHyn0y/XrmWdH02UqIK9xJx6wvlh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-58APLFPuNdirqGK9WpFAoA-1; Wed, 02 Sep 2020 18:44:51 -0400
X-MC-Unique: 58APLFPuNdirqGK9WpFAoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFDBD107464A
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:44:50 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0D5A5D9CC;
 Wed,  2 Sep 2020 22:44:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/63] can: Rename MIOe3680_PCI_DEV to MIOE3680_PCI
Date: Wed,  2 Sep 2020 18:42:43 -0400
Message-Id: <20200902224311.1321159-36-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Jason Wang <jasowang@redhat.com>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/net/can/can_mioe3680_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index b20e5451bf..9aaa9503c4 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -44,7 +44,7 @@
 #define TYPE_MIOE3680_PCI "mioe3680_pci"
 
 typedef struct Mioe3680PCIState Mioe3680PCIState;
-DECLARE_INSTANCE_CHECKER(Mioe3680PCIState, MIOe3680_PCI_DEV,
+DECLARE_INSTANCE_CHECKER(Mioe3680PCIState, MIOE3680_PCI,
                          TYPE_MIOE3680_PCI)
 
 /* the PCI device and vendor IDs */
@@ -76,7 +76,7 @@ struct Mioe3680PCIState {
 
 static void mioe3680_pci_reset(DeviceState *dev)
 {
-    Mioe3680PCIState *d = MIOe3680_PCI_DEV(dev);
+    Mioe3680PCIState *d = MIOE3680_PCI(dev);
     int i;
 
     for (i = 0 ; i < MIOe3680_PCI_SJA_COUNT; i++) {
@@ -156,7 +156,7 @@ static const MemoryRegionOps mioe3680_pci_sja2_io_ops = {
 
 static void mioe3680_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
-    Mioe3680PCIState *d = MIOe3680_PCI_DEV(pci_dev);
+    Mioe3680PCIState *d = MIOE3680_PCI(pci_dev);
     uint8_t *pci_conf;
     int i;
 
@@ -189,7 +189,7 @@ static void mioe3680_pci_realize(PCIDevice *pci_dev, Error **errp)
 
 static void mioe3680_pci_exit(PCIDevice *pci_dev)
 {
-    Mioe3680PCIState *d = MIOe3680_PCI_DEV(pci_dev);
+    Mioe3680PCIState *d = MIOE3680_PCI(pci_dev);
     int i;
 
     for (i = 0 ; i < MIOe3680_PCI_SJA_COUNT; i++) {
@@ -216,7 +216,7 @@ static const VMStateDescription vmstate_mioe3680_pci = {
 
 static void mioe3680_pci_instance_init(Object *obj)
 {
-    Mioe3680PCIState *d = MIOe3680_PCI_DEV(obj);
+    Mioe3680PCIState *d = MIOE3680_PCI(obj);
 
     object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
                              (Object **)&d->canbus[0],
-- 
2.26.2


