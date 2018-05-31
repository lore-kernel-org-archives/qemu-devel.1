Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOTBc-0005Zf-RE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOTBZ-0001Bg-N8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:36 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOTBZ-0001As-GP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:33 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:24:19 +0200
Message-Id: <20180531192419.4592-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] slirp: Fix spurious error report when sending
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

When DEBUG is enabled, len needs to be updated.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index e2a71c9b04..3182477ff5 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -351,7 +351,7 @@ sosendoob(struct socket *so)
 
 	if (sb->sb_rptr < sb->sb_wptr) {
 		/* We can send it directly */
-		n = slirp_send(so, sb->sb_rptr, so->so_urgc, (MSG_OOB)); /* |MSG_DONTWAIT)); */
+		len = n = slirp_send(so, sb->sb_rptr, so->so_urgc, (MSG_OOB)); /* |MSG_DONTWAIT)); */
 	} else {
 		/*
 		 * Since there's no sendv or sendtov like writev,
-- 
2.17.0
