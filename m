Received: from eggs.gnu.org ([2001:4830:134:3::10]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eRf19-0006tk-Ay
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eRf15-0007NA-2J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:06:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Dec 2017 15:06:18 +0100
Message-Id: <20171220140618.12701-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vnc: fix debug spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9f8d5a1b1f..7d537b5c6b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2255,7 +2255,7 @@ static int protocol_client_msg(VncState *vs, uint8_=
t *data, size_t len)
                 }
                 vs->as.nchannels =3D read_u8(data, 5);
                 if (vs->as.nchannels !=3D 1 && vs->as.nchannels !=3D 2) =
{
-                    VNC_DEBUG("Invalid audio channel coount %d\n",
+                    VNC_DEBUG("Invalid audio channel count %d\n",
                               read_u8(data, 5));
                     vnc_client_error(vs);
                     break;
--=20
2.15.1.355.g36791d7216
