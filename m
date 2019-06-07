Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FE8C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F936208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F936208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEor-0000o7-Kp
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hZEm3-0007Nt-1o
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hZEm2-0005Dk-3f
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hZEm1-00057h-Te
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EF0D3082145
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 13:19:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61B0A68C71;
 Fri,  7 Jun 2019 13:19:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 10D7117535; Fri,  7 Jun 2019 15:19:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 15:18:59 +0200
Message-Id: <20190607131901.20107-4-kraxel@redhat.com>
In-Reply-To: <20190607131901.20107-1-kraxel@redhat.com>
References: <20190607131901.20107-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 07 Jun 2019 13:19:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/5] vfio/display: set dmabuf modifier field
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fill the new QemuDmaBuf->modifier field properly from plane info.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Message-id: 20190529072144.26737-3-kraxel@redhat.com
---
 hw/vfio/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 2c2d3e5b71d6..a5a608c5b226 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -248,6 +248,7 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDev=
ice *vdev,
     dmabuf->buf.height =3D plane.height;
     dmabuf->buf.stride =3D plane.stride;
     dmabuf->buf.fourcc =3D plane.drm_format;
+    dmabuf->buf.modifier =3D plane.drm_format_mod;
     dmabuf->buf.fd     =3D fd;
     if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
--=20
2.18.1


