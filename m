Received: from eggs.gnu.org ([2001:4830:134:3::10]:49623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEU-0005IC-IT
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlET-0003vt-Lx
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:52:59 +1000
Message-Id: <20180618035324.19907-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/28] target/ppc: drop empty #if/#endif block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit 9d6f106552fa moved the last line in this block to somewhere else,
but it forgot to remove the now useless #if/#endif.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0247c1f04c..a91f1a8777 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1300,8 +1300,6 @@ void ppc_store_ptcr(CPUPPCState *env, target_ulong =
value);
 void ppc_store_msr (CPUPPCState *env, target_ulong value);
=20
 void ppc_cpu_list (FILE *f, fprintf_function cpu_fprintf);
-#if defined(TARGET_PPC64)
-#endif
=20
 /* Time-base and decrementer management */
 #ifndef NO_CPU_IO_DEFS
--=20
2.17.1
