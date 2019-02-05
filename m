Received: from eggs.gnu.org ([209.51.188.92]:42772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr5Tf-0005ej-Ef
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr5Tc-000622-4T
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:46 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:34864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gr5Tb-0005ZY-MC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:43 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Tue,  5 Feb 2019 20:28:45 +0200
Message-Id: <20190205182848.29887-30-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv3 29/32] slirp: remove slirp_instances list
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

Now that polling is done per-instance, we don't need a global list of
slirp instances.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index a0de8b711c..ecbb5c5b6c 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -48,9 +48,6 @@ static const uint8_t special_ethaddr[ETH_ALEN] =3D {
=20
 unsigned curtime;
=20
-static QTAILQ_HEAD(, Slirp) slirp_instances =3D
-    QTAILQ_HEAD_INITIALIZER(slirp_instances);
-
 static struct in_addr dns_addr;
 #ifndef _WIN32
 static struct in6_addr dns6_addr;
@@ -333,7 +330,6 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
 #ifdef WITH_QEMU
     slirp_state_register(slirp);
 #endif
-    QTAILQ_INSERT_TAIL(&slirp_instances, slirp, entry);
=20
     return slirp;
 }
@@ -348,7 +344,6 @@ void slirp_cleanup(Slirp *slirp)
         g_free(e);
     }
=20
-    QTAILQ_REMOVE(&slirp_instances, slirp, entry);
 #ifdef WITH_QEMU
     slirp_state_unregister(slirp);
 #endif
--=20
2.20.1
