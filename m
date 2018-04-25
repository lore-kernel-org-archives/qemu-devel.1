Received: from eggs.gnu.org ([2001:4830:134:3::10]:39249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBGp9-0000TZ-7E
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBGp5-0000W3-UJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:34:51 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:35036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fBGp5-0000R6-Nd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:34:47 -0400
Received: from player774.ha.ovh.net (unknown [10.109.122.108])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id C8984AF37C
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 11:34:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 25 Apr 2018 11:34:24 +0200
Message-Id: <20180425093424.18713-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: fix entry point for secondary CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Secondary CPUs do not start at SPAPR_ENTRY_POINT but at an address
given by the guest OS.

Fixes commit c79128c14c20 ("spapr: Make a helper to set up cpu entry
point state")

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 326b35d6ed23..f3e9b879b251 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -76,7 +76,7 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_=
ulong nip, target_ulong r
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env =3D &cpu->env;
=20
-    env->nip =3D SPAPR_ENTRY_POINT;
+    env->nip =3D nip;
     env->gpr[3] =3D r3;
     CPU(cpu)->halted =3D 0;
     /* Enable Power-saving mode Exit Cause exceptions */
--=20
2.13.6
