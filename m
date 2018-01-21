Received: from eggs.gnu.org ([2001:4830:134:3::10]:36123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gh-0000Zj-80
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Ge-0007LJ-Pd
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 21 Jan 2018 16:33:46 +1100
Message-Id: <20180121053353.25970-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180121053353.25970-1-david@gibson.dropbear.id.au>
References: <20180121053353.25970-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/12] target/ppc: msgsnd and msgclr
 instructions need hypervisor privilege
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0ef21cce33..396f422cf4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6174,7 +6174,7 @@ static void gen_msgclr(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
-    CHK_SV;
+    CHK_HV;
     gen_helper_msgclr(cpu_env, cpu_gpr[rB(ctx->opcode)]);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
@@ -6184,7 +6184,7 @@ static void gen_msgsnd(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
-    CHK_SV;
+    CHK_HV;
     gen_helper_msgsnd(cpu_gpr[rB(ctx->opcode)]);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
--=20
2.14.3
