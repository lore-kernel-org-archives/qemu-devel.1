Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF9CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43599217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43599217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54582 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAAU-0006UV-JQ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:23:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hUA19-0007cO-TE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hU9yI-0001VX-Gy
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hU9yI-0001Sl-9N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:10:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C2357BF08
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 13:10:43 +0000 (UTC)
Received: from localhost (ovpn-112-23.ams2.redhat.com [10.36.112.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1AFD27E5D2;
	Fri, 24 May 2019 13:10:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 15:09:41 +0200
Message-Id: <20190524130946.31736-5-marcandre.lureau@redhat.com>
In-Reply-To: <20190524130946.31736-1-marcandre.lureau@redhat.com>
References: <20190524130946.31736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 24 May 2019 13:10:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v9 4/9] util: compile drm.o on Linux
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

OpenGL isn't required to use DRM rendernodes. The following patches
uses it for 2d resources for ex.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index c27a923dbe..75e02cea12 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -53,7 +53,7 @@ util-obj-y +=3D systemd.o
 util-obj-y +=3D iova-tree.o
 util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
-util-obj-$(CONFIG_OPENGL) +=3D drm.o
+util-obj-$(CONFIG_LINUX) +=3D drm.o
 util-obj-y +=3D guest-random.o
=20
 stub-obj-y +=3D filemonitor-stub.o
--=20
2.22.0.rc1.1.g079e7d2849.dirty


