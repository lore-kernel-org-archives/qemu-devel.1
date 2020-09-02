Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F46C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D8620767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq9hrXnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D8620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbfn-0002Wn-6n
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUs-0003lG-CI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUq-0008Ss-Gf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jA/6vuViTtTMvoLZZrK9G0/sx7nXcKvvJ77qPcmw+d8=;
 b=Uq9hrXntdfa1m68bS2CZdS1yb9ZPINyP+GZ+4ql9iKI+V5ruVR9h+LooLLALbLb7Jx52Ep
 dgwZ2FQxOjbzlKE03fMD3EcmPVPJPvmXAz7xUbg+HQY3Xv40O8q3P7mDcsZJmosQjxDNKF
 13KV4PBQhh5jZDqJqZEVzQ55EkOd+nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-WQMObirrPiieXZ1qKFOiMw-1; Wed, 02 Sep 2020 18:44:50 -0400
X-MC-Unique: WQMObirrPiieXZ1qKFOiMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 178E51074642
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:44:49 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1E7B7E670;
 Wed,  2 Sep 2020 22:44:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/63] net/can: Rename TYPE_CAN_CPI constants
Date: Wed,  2 Sep 2020 18:42:41 -0400
Message-Id: <20200902224311.1321159-34-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:06
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

Rename macros to names that are unique in the source tree, to
reduce confusion and make automated conversion of the code
easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/net/can/can_kvaser_pci.c   | 6 +++---
 hw/net/can/can_mioe3680_pci.c | 6 +++---
 hw/net/can/can_pcm3680_pci.c  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 168b3a620d..12d4f8df33 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -45,11 +45,11 @@
 #include "can_sja1000.h"
 #include "qom/object.h"
 
-#define TYPE_CAN_PCI_DEV "kvaser_pci"
+#define TYPE_KVASER_PCI "kvaser_pci"
 
 typedef struct KvaserPCIState KvaserPCIState;
 DECLARE_INSTANCE_CHECKER(KvaserPCIState, KVASER_PCI_DEV,
-                         TYPE_CAN_PCI_DEV)
+                         TYPE_KVASER_PCI)
 
 #ifndef KVASER_PCI_VENDOR_ID1
 #define KVASER_PCI_VENDOR_ID1     0x10e8    /* the PCI device and vendor IDs */
@@ -305,7 +305,7 @@ static void kvaser_pci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo kvaser_pci_info = {
-    .name          = TYPE_CAN_PCI_DEV,
+    .name          = TYPE_KVASER_PCI,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(KvaserPCIState),
     .class_init    = kvaser_pci_class_init,
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 7a79e2605a..b20e5451bf 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -41,11 +41,11 @@
 #include "can_sja1000.h"
 #include "qom/object.h"
 
-#define TYPE_CAN_PCI_DEV "mioe3680_pci"
+#define TYPE_MIOE3680_PCI "mioe3680_pci"
 
 typedef struct Mioe3680PCIState Mioe3680PCIState;
 DECLARE_INSTANCE_CHECKER(Mioe3680PCIState, MIOe3680_PCI_DEV,
-                         TYPE_CAN_PCI_DEV)
+                         TYPE_MIOE3680_PCI)
 
 /* the PCI device and vendor IDs */
 #ifndef MIOe3680_PCI_VENDOR_ID1
@@ -248,7 +248,7 @@ static void mioe3680_pci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo mioe3680_pci_info = {
-    .name          = TYPE_CAN_PCI_DEV,
+    .name          = TYPE_MIOE3680_PCI,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(Mioe3680PCIState),
     .class_init    = mioe3680_pci_class_init,
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 8ef4e74af0..530cd04a5d 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -41,11 +41,11 @@
 #include "can_sja1000.h"
 #include "qom/object.h"
 
-#define TYPE_CAN_PCI_DEV "pcm3680_pci"
+#define TYPE_PCM3680_PCI "pcm3680_pci"
 
 typedef struct Pcm3680iPCIState Pcm3680iPCIState;
 DECLARE_INSTANCE_CHECKER(Pcm3680iPCIState, PCM3680i_PCI_DEV,
-                         TYPE_CAN_PCI_DEV)
+                         TYPE_PCM3680_PCI)
 
 /* the PCI device and vendor IDs */
 #ifndef PCM3680i_PCI_VENDOR_ID1
@@ -249,7 +249,7 @@ static void pcm3680i_pci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo pcm3680i_pci_info = {
-    .name          = TYPE_CAN_PCI_DEV,
+    .name          = TYPE_PCM3680_PCI,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(Pcm3680iPCIState),
     .class_init    = pcm3680i_pci_class_init,
-- 
2.26.2


