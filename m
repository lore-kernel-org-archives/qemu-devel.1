Received: from eggs.gnu.org ([2001:4830:134:3::10]:47901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g8RvW-00007I-Fd
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g8RvU-0006fh-DQ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:22:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42722 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g8RvT-00068R-Rq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:22:00 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  5 Oct 2018 17:19:50 +0200
Message-Id: <1538752793-6875-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 4/7] target/mips: Add bit definitions for
 DSP R3 ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Stefan Markovic <smarkovic@wavecomp.com>

Add DSP R3 ASE related bit definition for insn_flags and hflags.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 1 +
 target/mips/mips-defs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 28af4d1..4160699 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -598,6 +598,7 @@ struct CPUMIPSState {
     /* MIPS DSP resources access. */
 #define MIPS_HFLAG_DSP   0x080000  /* Enable access to MIPS DSP resources. */
 #define MIPS_HFLAG_DSPR2 0x100000  /* Enable access to MIPS DSPR2 resources. */
+#define MIPS_HFLAG_DSPR3 0x20000000 /* Enable access to MIPS DSPR3 resources.*/
     /* Extra flag about HWREna register. */
 #define MIPS_HFLAG_HWRENA_ULR 0x200000 /* ULR bit from HWREna is set. */
 #define MIPS_HFLAG_SBRI  0x400000 /* R6 SDBBP causes RI excpt. in user mode */
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index c8e9979..b27b7ae 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -47,6 +47,7 @@
 #define   ASE_MDMX      0x00040000
 #define   ASE_DSP       0x00080000
 #define   ASE_DSPR2     0x00100000
+#define   ASE_DSPR3     0x02000000
 #define   ASE_MT        0x00200000
 #define   ASE_SMARTMIPS 0x00400000
 #define   ASE_MICROMIPS 0x00800000
-- 
2.7.4
