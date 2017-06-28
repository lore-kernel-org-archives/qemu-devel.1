Received: from eggs.gnu.org ([2001:4830:134:3::10]:41096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIFC-0005rQ-If
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIF7-0000Lh-MI
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIF7-0000LO-Fp
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:03:13 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:47 +0100
Message-Id: <20170628190047.26159-30-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 29/29] vhost-user: Claim support for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Tell QEMU we understand the protocol features needed for postcopy.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index c1716d1a62..1c46aecfb3 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -797,7 +797,8 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+    uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
+                        1ULL << VHOST_USER_PROTOCOL_F_POSTCOPY;
 
     if (dev->iface->get_protocol_features) {
         features |= dev->iface->get_protocol_features(dev);
-- 
2.13.0
