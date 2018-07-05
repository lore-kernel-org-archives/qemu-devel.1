Received: from eggs.gnu.org ([2001:4830:134:3::10]:58440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T0-0006yS-Bm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1Sv-0004i1-BA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Jul 2018 12:25:59 +0200
Message-Id: <20180705102604.4986-8-kwolf@redhat.com>
In-Reply-To: <20180705102604.4986-1-kwolf@redhat.com>
References: <20180705102604.4986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 07/12] block/crypto: Fix memory leak in
 create error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Fixes: Coverity CID 1393782
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index 994172a3de..146d81c90a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -551,7 +551,7 @@ static int coroutine_fn block_crypto_co_create_opts_l=
uks(const char *filename,
     /* Create protocol layer */
     ret =3D bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        return ret;
+        goto fail;
     }
=20
     bs =3D bdrv_open(filename, NULL, NULL,
--=20
2.13.6
