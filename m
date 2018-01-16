Received: from eggs.gnu.org ([2001:4830:134:3::10]:56727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLt6-0002Bj-8a
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLt1-0007m1-RK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:28 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:47118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ebLt1-0007l8-M5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:23 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id F1B28916F0
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:42:21 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 16 Jan 2018 08:41:56 +0100
Message-Id: <20180116074157.16886-3-clg@kaod.org>
In-Reply-To: <20180116074157.16886-1-clg@kaod.org>
References: <20180116074157.16886-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] target/ppc: msgsnd and msgclr instructions
 need hypervisor privilege
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 6d16a0b22d44..bcd36d53537f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6169,7 +6169,7 @@ static void gen_msgclr(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
-    CHK_SV;
+    CHK_HV;
     gen_helper_msgclr(cpu_env, cpu_gpr[rB(ctx->opcode)]);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
@@ -6179,7 +6179,7 @@ static void gen_msgsnd(DisasContext *ctx)
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
-    CHK_SV;
+    CHK_HV;
     gen_helper_msgsnd(cpu_gpr[rB(ctx->opcode)]);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
--=20
2.13.6
