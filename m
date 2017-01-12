Received: from eggs.gnu.org ([2001:4830:134:3::10]:55411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYp-0007lz-Rb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYp-0006iY-2r
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:19 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVYo-0006iU-VH
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:19 -0500
Received: by mail-qt0-x242.google.com with SMTP id l7so831268qtd.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:18 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:41 -0800
Message-Id: <20170112025606.27332-6-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 05/30] target-sparc: add UltraSPARC T1 TLB
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
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <be9f2489b4857b637e7d4aaeb058dda11a55374e.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
