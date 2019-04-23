Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC25C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B962177B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 13:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B962177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIvUL-0005VA-4w
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 09:29:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvMQ-00073R-E4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvMP-0005h8-E3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hIvMP-0005fx-8S
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88442309266B
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:21:20 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9005A5D71E;
	Tue, 23 Apr 2019 13:21:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 15:20:00 +0200
Message-Id: <20190423132004.13725-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190423132004.13725-1-marcandre.lureau@redhat.com>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 23 Apr 2019 13:21:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 07/11] util: compile drm.o on Linux
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
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423132000.q7nkm9LMn-lSQCAmNRBp6ODCoYyA8GeKG5eLZw2mvwI@z>

OpenGL isn't required to use DRM rendernodes. The following patches
uses it for 2d resources for ex.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index 835fcd69e2..119a3f9b25 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -52,6 +52,6 @@ util-obj-y +=3D systemd.o
 util-obj-y +=3D iova-tree.o
 util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
-util-obj-$(CONFIG_OPENGL) +=3D drm.o
+util-obj-$(CONFIG_LINUX) +=3D drm.o
=20
 stub-obj-y +=3D filemonitor-stub.o
--=20
2.21.0.313.ge35b8cb8e2


