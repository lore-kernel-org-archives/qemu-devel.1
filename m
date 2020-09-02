Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E54C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F61820767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHNPYsAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F61820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbg6-0003MO-FK
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUt-0003ow-RA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUr-0008T1-0T
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5lEhIAR4lhJcBlj3624y58w+ajDgHA2fODHeMYfo/o=;
 b=YHNPYsAOWelxQIVa7vIf29zrms/OH/Kng1nBnmzOVVUDR8Qj7Wr6sKHPiUpoAUaAt4CFdM
 HxwtLCYgCqIb3KuPE33FGNhF07UzbWaBg2MsUVQWuYk7l6z+HySG9RwwB5IFIrqu/fhTMG
 2kQJu+rj1LkZUj/wTQ2VA3sDPTCopgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-_pGig2m5NJCfbCfxH1xX8A-1; Wed, 02 Sep 2020 18:44:50 -0400
X-MC-Unique: _pGig2m5NJCfbCfxH1xX8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0685E1DE02
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:44:50 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAC2D5D9CC;
 Wed,  2 Sep 2020 22:44:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/63] can: Rename KVASER_PCI_DEV to KVASER_PCI
Date: Wed,  2 Sep 2020 18:42:42 -0400
Message-Id: <20200902224311.1321159-35-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 hw/net/can/can_kvaser_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 12d4f8df33..2143ed83f3 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -48,7 +48,7 @@
 #define TYPE_KVASER_PCI "kvaser_pci"
 
 typedef struct KvaserPCIState KvaserPCIState;
-DECLARE_INSTANCE_CHECKER(KvaserPCIState, KVASER_PCI_DEV,
+DECLARE_INSTANCE_CHECKER(KvaserPCIState, KVASER_PCI,
                          TYPE_KVASER_PCI)
 
 #ifndef KVASER_PCI_VENDOR_ID1
@@ -109,7 +109,7 @@ static void kvaser_pci_irq_handler(void *opaque, int irq_num, int level)
 
 static void kvaser_pci_reset(DeviceState *dev)
 {
-    KvaserPCIState *d = KVASER_PCI_DEV(dev);
+    KvaserPCIState *d = KVASER_PCI(dev);
     CanSJA1000State *s = &d->sja_state;
 
     can_sja_hardware_reset(s);
@@ -221,7 +221,7 @@ static const MemoryRegionOps kvaser_pci_xilinx_io_ops = {
 
 static void kvaser_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
-    KvaserPCIState *d = KVASER_PCI_DEV(pci_dev);
+    KvaserPCIState *d = KVASER_PCI(pci_dev);
     CanSJA1000State *s = &d->sja_state;
     uint8_t *pci_conf;
 
@@ -254,7 +254,7 @@ static void kvaser_pci_realize(PCIDevice *pci_dev, Error **errp)
 
 static void kvaser_pci_exit(PCIDevice *pci_dev)
 {
-    KvaserPCIState *d = KVASER_PCI_DEV(pci_dev);
+    KvaserPCIState *d = KVASER_PCI(pci_dev);
     CanSJA1000State *s = &d->sja_state;
 
     can_sja_disconnect(s);
@@ -279,7 +279,7 @@ static const VMStateDescription vmstate_kvaser_pci = {
 
 static void kvaser_pci_instance_init(Object *obj)
 {
-    KvaserPCIState *d = KVASER_PCI_DEV(obj);
+    KvaserPCIState *d = KVASER_PCI(obj);
 
     object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
                              (Object **)&d->canbus,
-- 
2.26.2


