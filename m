Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8310C204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8310C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKr7-0000qc-ON
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58821)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKOZ-0007Ua-5S
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKOY-0001Df-08
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiKOX-0001Cj-NJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:08:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7F9518DF7B;
 Tue,  2 Jul 2019 15:08:32 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5ED16F94F;
 Tue,  2 Jul 2019 15:08:23 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:08:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190626074815.19994-2-stefanha@redhat.com>
References: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 02 Jul 2019 15:08:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/22] libvhost-user: add vmsg_set_reply_u64()
 helper
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190702150820.AAX2oUNFwA9dnuU9efP8U4t5Tp2ckfdeMvf0W0ks_Pg@z>

From: Stefan Hajnoczi <stefanha@redhat.com>

The VhostUserMsg request is reused as the reply by message processing
functions.  This is risky since request fields may corrupt the reply if
the vhost-user message handler function forgets to re-initialize them.

Changing this practice would be very invasive but we can introduce a
helper function to make u64 payload replies safe.  This also eliminates
code duplication in message processing functions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190626074815.19994-2-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 443b7e08c3..a8657c7af2 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -216,6 +216,15 @@ vmsg_close_fds(VhostUserMsg *vmsg)
     }
 }
=20
+/* Set reply payload.u64 and clear request flags and fd_num */
+static void vmsg_set_reply_u64(VhostUserMsg *vmsg, uint64_t val)
+{
+    vmsg->flags =3D 0; /* defaults will be set by vu_send_reply() */
+    vmsg->size =3D sizeof(vmsg->payload.u64);
+    vmsg->payload.u64 =3D val;
+    vmsg->fd_num =3D 0;
+}
+
 /* A test to see if we have userfault available */
 static bool
 have_userfault(void)
@@ -1168,10 +1177,7 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUse=
rMsg *vmsg)
         features |=3D dev->iface->get_protocol_features(dev);
     }
=20
-    vmsg->payload.u64 =3D features;
-    vmsg->size =3D sizeof(vmsg->payload.u64);
-    vmsg->fd_num =3D 0;
-
+    vmsg_set_reply_u64(vmsg, features);
     return true;
 }
=20
@@ -1307,17 +1313,14 @@ out:
 static bool
 vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
 {
-    vmsg->payload.u64 =3D -1;
-    vmsg->size =3D sizeof(vmsg->payload.u64);
-
     if (dev->nregions) {
         vu_panic(dev, "Regions already registered at postcopy-listen");
+        vmsg_set_reply_u64(vmsg, -1);
         return true;
     }
     dev->postcopy_listening =3D true;
=20
-    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
-    vmsg->payload.u64 =3D 0; /* Success */
+    vmsg_set_reply_u64(vmsg, 0);
     return true;
 }
=20
@@ -1332,10 +1335,7 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg=
)
         DPRINT("%s: Done close\n", __func__);
     }
=20
-    vmsg->fd_num =3D 0;
-    vmsg->payload.u64 =3D 0;
-    vmsg->size =3D sizeof(vmsg->payload.u64);
-    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
+    vmsg_set_reply_u64(vmsg, 0);
     DPRINT("%s: exit\n", __func__);
     return true;
 }
--=20
MST


