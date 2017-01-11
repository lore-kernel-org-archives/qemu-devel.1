Received: from eggs.gnu.org ([2001:4830:134:3::10]:54893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPO2-0006Rl-0p
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPNy-0000xN-3s
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:46 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:35683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPNx-0000xF-Oy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:42 -0500
Received: by mail-wj0-x244.google.com with SMTP id ey1so13025975wjd.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:41 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:36 +0100
Message-Id: <be9f2489b4857b637e7d4aaeb058dda11a55374e.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 05/30] target-sparc: add UltraSPARC T1 TLB
 #defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b41f5c5..f2e923d 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -336,6 +336,10 @@ enum {
 #define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
 #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
 
+/* UltraSPARC T1 specific */
+#define TLB_UST1_IS_REAL_BIT   (1ULL << 9)  /* Real translation entry */
+#define TLB_UST1_IS_SUN4V_BIT  (1ULL << 10) /* sun4u/sun4v TTE format switch */
+
 #define SFSR_NF_BIT         (1ULL << 24)   /* JPS1 NoFault */
 #define SFSR_TM_BIT         (1ULL << 15)   /* JPS1 TLB Miss */
 #define SFSR_FT_VA_IMMU_BIT (1ULL << 13)   /* USIIi VA out of range (IMMU) */
-- 
1.8.3.1
