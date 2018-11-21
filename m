Received: from eggs.gnu.org ([2001:4830:134:3::10]:51140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPag5-0005bR-DG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPag1-0003D0-DE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPag1-0003Ap-7w
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:53 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:33 +0400
Message-Id: <20181121220647.18844-17-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 16/30] slirp: replace some
 fprintf() with DEBUG_MISC
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

Remove some clutter, and avoids direct call to fprintf().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/slirp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 76b1f2f3e0..432adb02c4 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -163,9 +163,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
s_addr, void *cached_addr,
     if (!f)
         return -1;
=20
-#ifdef DEBUG
-    fprintf(stderr, "IP address of your DNS(s): ");
-#endif
+    DEBUG_MISC("IP address of your DNS(s): ");
     while (fgets(buff, 512, f) !=3D NULL) {
         if (sscanf(buff, "nameserver%*[ \t]%256s", buff2) =3D=3D 1) {
             char *c =3D strchr(buff2, '%');
@@ -187,15 +185,12 @@ static int get_dns_addr_resolv_conf(int af, void *p=
dns_addr, void *cached_addr,
                     *scope_id =3D if_index;
                 }
                 *cached_time =3D curtime;
+            } else {
+                DEBUG_MISC(", ");
             }
-#ifdef DEBUG
-            else
-                fprintf(stderr, ", ");
-#endif
+
             if (++found > 3) {
-#ifdef DEBUG
-                fprintf(stderr, "(more)");
-#endif
+                DEBUG_MISC("(more)");
                 break;
             }
 #ifdef DEBUG
@@ -205,7 +200,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
s_addr, void *cached_addr,
                 if (!res) {
                     res =3D "(string conversion error)";
                 }
-                fprintf(stderr, "%s", res);
+                DEBUG_MISC("%s", res);
             }
 #endif
         }
--=20
2.20.0.rc1
