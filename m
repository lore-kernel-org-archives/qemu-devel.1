Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0388BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C756320851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C756320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl8y-0000i7-4T
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:40:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hTkvN-0005zC-SE
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hTkvM-0001Vq-8H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hTkvK-0001RB-6Z
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07CDC308FEE2;
	Thu, 23 May 2019 10:26:09 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-162.sin2.redhat.com
	[10.67.116.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CCA956767F;
	Thu, 23 May 2019 10:25:48 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:54:44 +0530
Message-Id: <20190523102449.2642-3-pagupta@redhat.com>
In-Reply-To: <20190523102449.2642-1-pagupta@redhat.com>
References: <20190523102449.2642-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 23 May 2019 10:26:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/7] virtio-pci: Allow to specify additional
 interfaces for the base type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
	xiaoguangrong.eric@gmail.com, mst@redhat.com, pagupta@redhat.com,
	riel@surriel.com, david@redhat.com, armbru@redhat.com,
	ehabkost@redhat.com, lcapitulino@redhat.com, stefanha@redhat.com,
	pbonzini@redhat.com, imammedo@redhat.com,
	dan.j.williams@intel.com, nilal@redhat.com, dgilbert@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's allow to specify additional interfaces for the base type (e.g.
later TYPE_MEMORY_DEVICE), something that was possible before the
rework of virtio PCI device instantiation.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-pci.c | 1 +
 hw/virtio/virtio-pci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb44e19b67..0ac451ed0f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1939,6 +1939,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .class_init    = virtio_pci_base_class_init,
         .class_data    = (void *)t,
         .abstract      = true,
+        .interfaces    = t->interfaces,
     };
     TypeInfo generic_type_info = {
         .name = t->generic_name,
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 18581854ca..292275acb1 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -233,6 +233,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     size_t class_size;
     void (*instance_init)(Object *obj);
     void (*class_init)(ObjectClass *klass, void *data);
+    InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
 /* Register virtio-pci type(s).  @t must be static. */
-- 
2.14.5


