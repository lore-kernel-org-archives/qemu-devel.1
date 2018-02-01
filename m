Received: from eggs.gnu.org ([2001:4830:134:3::10]:37826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehLfS-0000tv-Iu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehLeM-0003fK-2j
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:41:08 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:38493)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ehKq3-0002ed-KJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:48:03 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id EAD9FD41ED
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 20:47:53 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 01 Feb 2018 20:47:41 +0100
Message-ID: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: add missing break in
 h_get_cpu_characteristics()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

Detected by Coverity (CID 1385702). This fixes the recently added hypercall
to let guests properly apply Spectre and Meltdown workarounds.

Fixes: c59704b25473 "target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_hcall.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4d0e6eb0cf1d..596f58378a40 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1697,6 +1697,7 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
     switch (safe_indirect_branch) {
     case SPAPR_CAP_FIXED:
         characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
+        break;
     default: /* broken */
         assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
         break;
