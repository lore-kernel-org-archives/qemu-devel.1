Received: from eggs.gnu.org ([2001:4830:134:3::10]:40894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORJ-0000We-IQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORD-00058P-T5
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:09 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORD-0004vU-0E
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:07 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:29 +0100
Message-Id: <20181218230442.27887-52-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 51/64] slirp: replace some fprintf() with
 DEBUG_MISC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Remove some clutter, and avoids direct call to fprintf().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 91210dc00a..84f6b05974 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -164,9 +164,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
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
@@ -188,15 +186,12 @@ static int get_dns_addr_resolv_conf(int af, void *p=
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
@@ -206,7 +201,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
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
2.19.2
