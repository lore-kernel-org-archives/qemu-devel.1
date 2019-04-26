Received: from eggs.gnu.org ([209.51.188.92]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Z-0005UU-Vp
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0004TT-IW
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:08 +1000
Message-Id: <20190426060627.18153-18-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/36] target/ppc: Style fixes for misc_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/misc_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index c65d1ade15..0a81e98ee9 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -210,10 +210,11 @@ void ppc_store_msr(CPUPPCState *env, target_ulong v=
alue)
     hreg_store_msr(env, value, 0);
 }
=20
-/* This code is lifted from MacOnLinux. It is called whenever
- * THRM1,2 or 3 is read an fixes up the values in such a way
- * that will make MacOS not hang. These registers exist on some
- * 75x and 74xx processors.
+/*
+ * This code is lifted from MacOnLinux. It is called whenever THRM1,2
+ * or 3 is read an fixes up the values in such a way that will make
+ * MacOS not hang. These registers exist on some 75x and 74xx
+ * processors.
  */
 void helper_fixup_thrm(CPUPPCState *env)
 {
--=20
2.20.1
