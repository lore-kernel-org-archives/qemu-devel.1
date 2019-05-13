Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D2C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4876320989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4876320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ56y-0004Qz-Gr
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 03:11:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ54D-0002RU-HG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ4pv-0002Jx-3j
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:53:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQ4pt-0002I5-3r
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CD8DF74CD
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 06:53:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9F9C6B8C8;
	Mon, 13 May 2019 06:53:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 71DFCA212; Mon, 13 May 2019 08:53:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 08:53:09 +0200
Message-Id: <20190513065310.10263-7-kraxel@redhat.com>
In-Reply-To: <20190513065310.10263-1-kraxel@redhat.com>
References: <20190513065310.10263-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 13 May 2019 06:53:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/7] virtio-input-host-pci: cleanup types
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio input is virtio-1.0 only, so we don't need the -transitional and
-non-transitional variants.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20190510105137.17481-1-kraxel@redhat.com
---
 hw/virtio/virtio-input-host-pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-input-host-pci.c b/hw/virtio/virtio-input-h=
ost-pci.c
index 725a51ad30b4..124c4f344742 100644
--- a/hw/virtio/virtio-input-host-pci.c
+++ b/hw/virtio/virtio-input-host-pci.c
@@ -13,7 +13,7 @@
=20
 typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
=20
-#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci-base"
+#define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
 #define VIRTIO_INPUT_HOST_PCI(obj) \
         OBJECT_CHECK(VirtIOInputHostPCI, (obj), TYPE_VIRTIO_INPUT_HOST_P=
CI)
=20
@@ -31,10 +31,7 @@ static void virtio_host_initfn(Object *obj)
 }
=20
 static const VirtioPCIDeviceTypeInfo virtio_input_host_pci_info =3D {
-    .base_name             =3D TYPE_VIRTIO_INPUT_HOST_PCI,
-    .generic_name          =3D "virtio-input-host-pci",
-    .transitional_name     =3D "virtio-input-host-pci-transitional",
-    .non_transitional_name =3D "virtio-input-host-pci-non-transitional",
+    .generic_name  =3D TYPE_VIRTIO_INPUT_HOST_PCI,
     .parent        =3D TYPE_VIRTIO_INPUT_PCI,
     .instance_size =3D sizeof(VirtIOInputHostPCI),
     .instance_init =3D virtio_host_initfn,
--=20
2.18.1


