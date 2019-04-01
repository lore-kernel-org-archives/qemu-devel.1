Received: from eggs.gnu.org ([209.51.188.92]:40308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43t-0000ml-BQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43p-0002zy-HO
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54124
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB43l-0002sV-KR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrWCB136226
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:31 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksx78tce-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:30 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:29 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:43 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-10-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/97] target/arm: Reformat integer register
 dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

With PC, there are 33 registers.  Three per line lines up nicely
without overflowing 80 columns.

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 3cb506a399854c481c2fd2efabecda0654700c47)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 45a6c2a3aa..358f169c75 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -137,14 +137,13 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
     int el =3D arm_current_el(env);
     const char *ns_status;
=20
-    cpu_fprintf(f, "PC=3D%016"PRIx64"  SP=3D%016"PRIx64"\n",
-            env->pc, env->xregs[31]);
-    for (i =3D 0; i < 31; i++) {
-        cpu_fprintf(f, "X%02d=3D%016"PRIx64, i, env->xregs[i]);
-        if ((i % 4) =3D=3D 3) {
-            cpu_fprintf(f, "\n");
+    cpu_fprintf(f, " PC=3D%016" PRIx64 " ", env->pc);
+    for (i =3D 0; i < 32; i++) {
+        if (i =3D=3D 31) {
+            cpu_fprintf(f, " SP=3D%016" PRIx64 "\n", env->xregs[i]);
         } else {
-            cpu_fprintf(f, " ");
+            cpu_fprintf(f, "X%02d=3D%016" PRIx64 "%s", i, env->xregs[i],
+                        (i + 2) % 3 ? " " : "\n");
         }
     }
=20
--=20
2.17.1
