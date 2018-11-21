Received: from eggs.gnu.org ([2001:4830:134:3::10]:51005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafv-0005UH-3A
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafp-0002uD-5j
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPafn-0002oP-6D
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:31 +0400
Message-Id: <20181121220647.18844-15-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 14/30] slirp: set G_LOG_DOMAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

We are moving to g_log() facilities to log errors and probably debug
messages too. Let's have the "Slirp" prefix on messages slirp produces.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.20.0.rc1
