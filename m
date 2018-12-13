Received: from eggs.gnu.org ([2001:4830:134:3::10]:50519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIC1-0003Z6-T3
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIBv-0001ug-Fr
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:02 +1100
Message-Id: <20181213040126.6768-4-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/27] spapr: drop redundant statement in
 spapr_populate_drconf_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ppc/spapr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b423db311e..051d080fe5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -889,8 +889,6 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
     /* ibm,associativity-lookup-arrays */
     buf_len =3D (nr_nodes * 4 + 2) * sizeof(uint32_t);
     cur_index =3D int_buf =3D g_malloc0(buf_len);
-
-    cur_index =3D int_buf;
     int_buf[0] =3D cpu_to_be32(nr_nodes);
     int_buf[1] =3D cpu_to_be32(4); /* Number of entries per associativit=
y list */
     cur_index +=3D 2;
--=20
2.19.2
