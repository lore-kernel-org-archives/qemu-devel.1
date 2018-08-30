Received: from eggs.gnu.org ([2001:4830:134:3::10]:46808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvQ5a-0001kP-Bc
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPyY-000410-I6
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:39:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvPyY-00040m-DW
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 12:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E12687A7E5
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 16:39:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 18:38:31 +0200
Message-Id: <20180830163831.18586-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] libvhost-user: fix clang enum-conversion
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now that the VhostUserMsg.request field is used for both master &
slave requests, since commit d84599f56c820d8c1ac9928a76500dcdfbbf194d:

contrib/libvhost-user/libvhost-user.c:953:20: error: implicit conversion =
from enumeration type 'enum VhostUserSlaveRequest' to different enumerati=
on type 'VhostUserRequest' (aka 'enum VhostUserRequest') [-Werror,-Wenum-=
conversion]
        .request =3D VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 4aa55b4d2d..c0133b7f3f 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -145,7 +145,7 @@ typedef struct VhostUserVringArea {
 #endif
=20
 typedef struct VhostUserMsg {
-    VhostUserRequest request;
+    int request;
=20
 #define VHOST_USER_VERSION_MASK     (0x3)
 #define VHOST_USER_REPLY_MASK       (0x1 << 2)
--=20
2.19.0.rc0.48.gb9dfa238d5
