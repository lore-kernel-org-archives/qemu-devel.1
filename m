Received: from eggs.gnu.org ([2001:4830:134:3::10]:44897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gPq1E-0003mw-U6
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gPq1B-00029u-Nk
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:31:48 -0500
Received: from 2.mo7.mail-out.ovh.net ([87.98.143.68]:55305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gPq1B-0001kR-Ha
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:31:45 -0500
Received: from player691.ha.ovh.net (unknown [10.109.159.136])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0F101E6FE9
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 15:31:41 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 22 Nov 2018 15:31:36 +0100
Message-ID: <154289709597.235079.13366613265527123490.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: drop redundant statement in
 spapr_populate_drconf_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9c41098b5781..7771a628f879 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -893,8 +893,6 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
     /* ibm,associativity-lookup-arrays */
     buf_len = (nr_nodes * 4 + 2) * sizeof(uint32_t);
     cur_index = int_buf = g_malloc0(buf_len);
-
-    cur_index = int_buf;
     int_buf[0] = cpu_to_be32(nr_nodes);
     int_buf[1] = cpu_to_be32(4); /* Number of entries per associativity list */
     cur_index += 2;
