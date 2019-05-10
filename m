Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B3C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF5220989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF5220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3QT-0003Me-1M
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:10:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP383-0003ws-RQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP382-0000mt-UT
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP382-0000mk-Ou
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:51:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2472D308A94D
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:51:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B17460C81;
	Fri, 10 May 2019 10:51:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id B42C99D84; Fri, 10 May 2019 12:51:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:51:36 +0200
Message-Id: <20190510105137.17481-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 10 May 2019 10:51:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/2] virtio-input-host-pci: cleanup types
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio input is virtio-1.0 only, so we don't need the -transitional and
-non-transitional variants.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/virtio/virtio-input-host-pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-input-host-pci.c b/hw/virtio/virtio-input-host-pci.c
index 725a51ad30b4..124c4f344742 100644
--- a/hw/virtio/virtio-input-host-pci.c
+++ b/hw/virtio/virtio-input-host-pci.c
@@ -13,7 +13,7 @@
 
 typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
 
-#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci-base"
+#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
 #define VIRTIO_INPUT_HOST_PCI(obj) \
         OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_PCI)
 
@@ -31,10 +31,7 @@ static void virtio_host_initfn(Object *obj)
 }
 
 static const VirtioPCIDeviceTypeInfo virtio_input_host_pci_info = {
-    .base_name             = TYPE_VIRTIO_INPUT_HOST_PCI,
-    .generic_name          = "virtio-input-host-pci",
-    .transitional_name     = "virtio-input-host-pci-transitional",
-    .non_transitional_name = "virtio-input-host-pci-non-transitional",
+    .generic_name  = TYPE_VIRTIO_INPUT_HOST_PCI,
     .parent        = TYPE_VIRTIO_INPUT_PCI,
     .instance_size = sizeof(VirtIOInputHostPCI),
     .instance_init = virtio_host_initfn,
-- 
2.18.1


