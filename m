Received: from eggs.gnu.org ([2001:4830:134:3::10]:38494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzqy-0002Yi-Nv
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzqv-0005JJ-Li
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:15:44 -0500
Received: from mail.kernel.org ([198.145.29.136]:48650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzqv-0005IH-Eu
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:15:41 -0500
Date: Fri, 16 Dec 2016 23:15:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-2-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 1/9] tests/vhost-user-bridge: remove
 false comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Victor Kaplansky <victork@redhat.com>, Eric Blake <eblake@redhat.com>, Yuanhan Liu <yuanhan.liu@linux.intel.com>, stefanha@redhat.com

From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

dispatcher_remove() is in use.

Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vhost-user-bridge.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 775e031..e91279b 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -101,8 +101,6 @@ dispatcher_add(Dispatcher *dispr, int sock, void *ctx=
, CallbackFunc cb)
     return 0;
 }
=20
-/* dispatcher_remove() is not currently in use but may be useful
- * in the future. */
 static int
 dispatcher_remove(Dispatcher *dispr, int sock)
 {
--=20
MST
