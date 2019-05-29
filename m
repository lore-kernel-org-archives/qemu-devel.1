Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC6C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA82F21734
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA82F21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqPu-0006SE-Rj
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 00:42:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqOA-0005DC-Gh
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVqO9-00068L-JO
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVqO9-00064t-DC
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D49530833C1
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:40:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6835B7A430;
	Wed, 29 May 2019 04:40:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id BC65F17524; Wed, 29 May 2019 06:40:20 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 06:40:15 +0200
Message-Id: <20190529044020.27003-5-kraxel@redhat.com>
In-Reply-To: <20190529044020.27003-1-kraxel@redhat.com>
References: <20190529044020.27003-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 29 May 2019 04:40:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/9] util: compile drm.o on posix
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

OpenGL isn't required to use DRM rendernodes. The following patches
uses it for 2d resources for ex.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20190524130946.31736-5-marcandre.lureau@redhat.com

[ kraxel s/LINUX/POSIX/ (fixes openbsd build failure) ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index c27a923dbe08..38178201ff65 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -53,7 +53,7 @@ util-obj-y +=3D systemd.o
 util-obj-y +=3D iova-tree.o
 util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
-util-obj-$(CONFIG_OPENGL) +=3D drm.o
+util-obj-$(CONFIG_POSIX) +=3D drm.o
 util-obj-y +=3D guest-random.o
=20
 stub-obj-y +=3D filemonitor-stub.o
--=20
2.18.1


