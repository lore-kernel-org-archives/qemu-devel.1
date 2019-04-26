Received: from eggs.gnu.org ([209.51.188.92]:60160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0d-0005aE-6Z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0b-0004YP-B3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:55 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:12 +1000
Message-Id: <20190426060627.18153-22-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/36] target/ppc: Style fixes for monitor.c
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
 target/ppc/monitor.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 42e58163fc..ee9d6e81d2 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -27,32 +27,33 @@
 #include "monitor/hmp-target.h"
 #include "hmp.h"
=20
-static target_long monitor_get_ccr (const struct MonitorDef *md, int val=
)
+static target_long monitor_get_ccr(const struct MonitorDef *md, int val)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     unsigned int u;
     int i;
=20
     u =3D 0;
-    for (i =3D 0; i < 8; i++)
+    for (i =3D 0; i < 8; i++) {
         u |=3D env->crf[i] << (32 - (4 * (i + 1)));
+    }
=20
     return u;
 }
=20
-static target_long monitor_get_decr (const struct MonitorDef *md, int va=
l)
+static target_long monitor_get_decr(const struct MonitorDef *md, int val=
)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     return cpu_ppc_load_decr(env);
 }
=20
-static target_long monitor_get_tbu (const struct MonitorDef *md, int val=
)
+static target_long monitor_get_tbu(const struct MonitorDef *md, int val)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     return cpu_ppc_load_tbu(env);
 }
=20
-static target_long monitor_get_tbl (const struct MonitorDef *md, int val=
)
+static target_long monitor_get_tbl(const struct MonitorDef *md, int val)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     return cpu_ppc_load_tbl(env);
--=20
2.20.1
