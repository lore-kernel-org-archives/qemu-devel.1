Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2w-0001yy-0z
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2s-0006to-L8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39452 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2s-0006ew-AJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:43 +0200
Message-Id: <1539779635-15445-16-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 15/27] target/mips: Add bit definitions for DSP
 R3 ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Stefan Markovic <smarkovic@wavecomp.com>

Add DSP R3 ASE related bit definition for insn_flags and hflags.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 1 +
 target/mips/mips-defs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3b3509c..7f4e6d0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -795,6 +795,7 @@ struct CPUMIPSState {
     /* MIPS DSP resources access. */
 #define MIPS_HFLAG_DSP   0x080000  /* Enable access to MIPS DSP resources. */
 #define MIPS_HFLAG_DSPR2 0x100000  /* Enable access to MIPS DSPR2 resources. */
+#define MIPS_HFLAG_DSPR3 0x20000000 /* Enable access to MIPS DSPR3 resources.*/
     /* Extra flag about HWREna register. */
 #define MIPS_HFLAG_HWRENA_ULR 0x200000 /* ULR bit from HWREna is set. */
 #define MIPS_HFLAG_SBRI  0x400000 /* R6 SDBBP causes RI excpt. in user mode */
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 66b7953..a23c4ed 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -53,6 +53,7 @@
 #define ASE_MDMX          0x0000000400000000ULL
 #define ASE_DSP           0x0000000800000000ULL
 #define ASE_DSPR2         0x0000001000000000ULL
+#define ASE_DSPR3         0x0000002000000000ULL
 #define ASE_MT            0x0000004000000000ULL
 #define ASE_SMARTMIPS     0x0000008000000000ULL
 #define ASE_MICROMIPS     0x0000010000000000ULL
-- 
2.7.4
