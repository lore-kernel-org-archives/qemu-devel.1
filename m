Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE0C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFBF2177B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFBF2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44049 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6H7-0001c3-A0
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:13:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65L-0007AH-Pr
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65K-00023l-S1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP65K-00023E-MU
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A14880082
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:01:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 834525C69A;
	Fri, 10 May 2019 14:01:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 81F759D84; Fri, 10 May 2019 16:01:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 16:01:03 +0200
Message-Id: <20190510140103.3834-9-kraxel@redhat.com>
In-Reply-To: <20190510140103.3834-1-kraxel@redhat.com>
References: <20190510140103.3834-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 10 May 2019 14:01:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 8/8] virtio-input: fix Kconfig dependency and
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


