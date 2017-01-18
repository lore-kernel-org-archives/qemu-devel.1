Received: from eggs.gnu.org ([2001:4830:134:3::10]:36740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTysu-0006LL-S1
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTysu-0002Zw-A9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:17 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTysu-0002ZL-49
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:16 -0500
Received: by mail-wm0-x243.google.com with SMTP id d140so7555526wmd.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:15 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:18 +0100
Message-Id: <1484779123-18968-6-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 4c4c159..f65d8b5 100644
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
2.7.2
