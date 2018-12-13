Received: from eggs.gnu.org ([2001:4830:134:3::10]:50482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIBz-0003Yr-EU
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXIBv-0001uf-G9
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:01:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:03 +1100
Message-Id: <20181213040126.6768-5-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/27] target/ppc: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
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

Because it is a recommended coding practice (see HACKING).

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 168d0cec28..03f1d34a97 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9081,13 +9081,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
             nb_tlb *=3D 2;
         switch (env->tlb_type) {
         case TLB_6XX:
-            env->tlb.tlb6 =3D g_malloc0(nb_tlb * sizeof(ppc6xx_tlb_t));
+            env->tlb.tlb6 =3D g_new0(ppc6xx_tlb_t, nb_tlb);
             break;
         case TLB_EMB:
-            env->tlb.tlbe =3D g_malloc0(nb_tlb * sizeof(ppcemb_tlb_t));
+            env->tlb.tlbe =3D g_new0(ppcemb_tlb_t, nb_tlb);
             break;
         case TLB_MAS:
-            env->tlb.tlbm =3D g_malloc0(nb_tlb * sizeof(ppcmas_tlb_t));
+            env->tlb.tlbm =3D g_new0(ppcmas_tlb_t, nb_tlb);
             break;
         }
         /* Pre-compute some useful values */
--=20
2.19.2
