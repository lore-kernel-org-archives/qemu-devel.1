Received: from eggs.gnu.org ([2001:4830:134:3::10]:39561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszza-0000Pz-Hn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzZ-0000IE-I4
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:34 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:53294)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzZ-0000Hr-BX
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:33 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 29 Mar 2017 00:53:25 +0200
Message-Id: <20170328225327.16707-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
References: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] slirp: fix compilation errors with DEBUG set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Laurent Vivier <laurent@vivier.eu>

slirp/slirp.c: In function 'get_dns_addr_resolv_conf':
slirp/slirp.c:202:29: error: initialization discards 'const' qualifier fr=
om pointer target type [-Werror=3Ddiscarded-qualifiers]
                 char *res =3D inet_ntop(af, tmp_addr, s, sizeof(s));
                             ^~~~~~~~~
slirp/slirp.c:204:25: error: assignment discards 'const' qualifier from p=
ointer target type [-Werror=3Ddiscarded-qualifiers]
                     res =3D "(string conversion error)";

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 60539de7a3..5a94b06f5e 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -198,7 +198,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdn=
s_addr, void *cached_addr,
 #ifdef DEBUG
             else {
                 char s[INET6_ADDRSTRLEN];
-                char *res =3D inet_ntop(af, tmp_addr, s, sizeof(s));
+                const char *res =3D inet_ntop(af, tmp_addr, s, sizeof(s)=
);
                 if (!res) {
                     res =3D "(string conversion error)";
                 }
--=20
2.11.0
