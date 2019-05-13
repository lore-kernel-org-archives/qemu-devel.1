Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762FC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAA520578
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAA520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ59o-00071P-On
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 03:13:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ54F-0002RU-O2
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQ4pv-0002K2-3r
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:53:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQ4pt-0002Ia-4F
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EDC64E93D
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 06:53:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC75368D87;
	Mon, 13 May 2019 06:53:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 7B44EA213; Mon, 13 May 2019 08:53:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 08:53:10 +0200
Message-Id: <20190513065310.10263-8-kraxel@redhat.com>
In-Reply-To: <20190513065310.10263-1-kraxel@redhat.com>
References: <20190513065310.10263-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 13 May 2019 06:53:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/7] virtio-input: fix Kconfig dependency and
 Makefile
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

Make VIRTIO_INPUT_HOST depend on VIRTIO_INPUT.
Use CONFIG_VIRTIO_INPUT_HOST in Makefile.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20190510105137.17481-2-kraxel@redhat.com
---
 hw/input/Kconfig       | 2 +-
 hw/input/Makefile.objs | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 50e55e353847..889363d8aef1 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -27,7 +27,7 @@ config VIRTIO_INPUT
 config VIRTIO_INPUT_HOST
     bool
     default y
-    depends on VIRTIO && LINUX
+    depends on VIRTIO_INPUT && LINUX
=20
 config VHOST_USER_INPUT
     bool
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index 3eddf00f2bba..d1de30770854 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -9,9 +9,7 @@ common-obj-$(CONFIG_TSC2005) +=3D tsc2005.o
=20
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input.o
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-hid.o
-ifeq ($(CONFIG_LINUX),y)
-common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-host.o
-endif
+common-obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host.o
 common-obj-$(CONFIG_VHOST_USER_INPUT) +=3D vhost-user-input.o
=20
 obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
--=20
2.18.1


