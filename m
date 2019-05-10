Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CA2C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848A521479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848A521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43903 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP67Q-0000Rh-Os
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:03:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65G-00075m-PS
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hP65F-00020P-OV
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hP65F-0001zx-EQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:01:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2995309E9B2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:01:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F059F1001E78;
	Fri, 10 May 2019 14:01:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3250EA1E4; Fri, 10 May 2019 16:01:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 16:00:56 +0200
Message-Id: <20190510140103.3834-2-kraxel@redhat.com>
In-Reply-To: <20190510140103.3834-1-kraxel@redhat.com>
References: <20190510140103.3834-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 10 May 2019 14:01:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/8] libvhost-user: fix
 -Waddress-of-packed-member
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
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c: In function=
 =E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:546:31: warn=
ing: taking address of packed member of =E2=80=98struct VhostUserMsg=E2=80=
=99 may result in an unaligned pointer value [-Waddress-of-packed-member]
  546 |     VhostUserMemory *memory =3D &vmsg->payload.memory;
      |                               ^~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c: In function=
 =E2=80=98vu_set_mem_table_exec=E2=80=99:
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:688:31: warn=
ing: taking address of packed member of =E2=80=98struct VhostUserMsg=E2=80=
=99 may result in an unaligned pointer value [-Waddress-of-packed-member]
  688 |     VhostUserMemory *memory =3D &vmsg->payload.memory;
      |                               ^~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c: In function=
 =E2=80=98vu_set_vring_addr_exec=E2=80=99:
/home/elmarco/src/qemu/contrib/libvhost-user/libvhost-user.c:817:36: warn=
ing: taking address of packed member of =E2=80=98struct VhostUserMsg=E2=80=
=99 may result in an unaligned pointer value [-Waddress-of-packed-member]
  817 |     struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
      |                                    ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20190503130034.24916-2-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index e08d6c7b9741..dcf4a969f238 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -542,7 +542,7 @@ static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
     dev->nregions =3D memory->nregions;
=20
     DPRINT("Nregions: %d\n", memory->nregions);
@@ -684,7 +684,7 @@ static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
=20
     for (i =3D 0; i < dev->nregions; i++) {
         VuDevRegion *r =3D &dev->regions[i];
@@ -813,7 +813,7 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
+    struct vhost_vring_addr addr =3D vmsg->payload.addr, *vra =3D &addr;
     unsigned int index =3D vra->index;
     VuVirtq *vq =3D &dev->vq[index];
=20
--=20
2.18.1


