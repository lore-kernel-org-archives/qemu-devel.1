Received: from eggs.gnu.org ([209.51.188.92]:35449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7T-000517-Ka
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjB7S-0001qg-1H
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:11 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjB7R-0001eV-Oz
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:54:09 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 23:53:03 +0100
Message-Id: <20190114225306.21569-63-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
References: <20190114225306.21569-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 62/65] slirp: set G_LOG_DOMAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

We are moving to g_log() facilities to log errors and probably debug
messages too. Let's have the "Slirp" prefix on messages slirp produces.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/Makefile.objs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 21653f69e9..959558c732 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -28,3 +28,5 @@ slirp.mo-objs =3D \
 	udp.o \
 	udp6.o \
 	$(NULL)
+
+slirp.mo-cflags =3D -DG_LOG_DOMAIN=3D\"Slirp\"
--=20
2.20.1
