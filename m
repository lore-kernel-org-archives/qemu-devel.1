Received: from eggs.gnu.org ([2001:4830:134:3::10]:42547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kU9-0001YG-D6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kU8-0000bM-OX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e2kU8-0000b3-Id
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A53E7F41D
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 20:53:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Oct 2017 22:53:28 +0200
Message-Id: <20171012205330.29942-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171012205330.29942-1-marcandre.lureau@redhat.com>
References: <20171012205330.29942-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] vhost-user-bridge: Only process received
 packets on started queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Only process received packets if the queue has been started.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20171002191521.15748-3-dgilbert@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index f922cc75ae..d820033a72 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -277,6 +277,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
     DPRINT("    hdrlen =3D %d\n", hdrlen);
=20
     if (!vu_queue_enabled(dev, vq) ||
+        !vu_queue_started(dev, vq) ||
         !vu_queue_avail_bytes(dev, vq, hdrlen, 0)) {
         DPRINT("Got UDP packet, but no available descriptors on RX virtq=
.\n");
         return;
--=20
2.15.0.rc0.40.gaefcc5f6f
