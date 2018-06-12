Received: from eggs.gnu.org ([2001:4830:134:3::10]:55452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSm9X-0001SP-2c
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSm9S-0003nH-Q4
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:14 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:33078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fSm9S-0003mW-JN
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 12:28:10 -0400
Received: from player778.ha.ovh.net (unknown [10.109.122.43])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 07E0B1A56E
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:28:08 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Jun 2018 18:27:54 +0200
Message-ID: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] target/ppc: drop empty #if/#endif block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Commit 9d6f106552fa moved the last line in this block to somewhere else,
but it forgot to remove the now useless #if/#endif.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/cpu.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0247c1f04c37..a91f1a8777eb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1300,8 +1300,6 @@ void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
 void ppc_store_msr (CPUPPCState *env, target_ulong value);
 
 void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
-#if defined(TARGET_PPC64)
-#endif
 
 /* Time-base and decrementer management */
 #ifndef NO_CPU_IO_DEFS
