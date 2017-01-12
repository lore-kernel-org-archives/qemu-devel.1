Received: from eggs.gnu.org ([2001:4830:134:3::10]:55399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYn-0007jp-Jn
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYm-0006iA-QZ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:17 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVYm-0006hx-Lv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:16 -0500
Received: by mail-qt0-x242.google.com with SMTP id f4so837673qte.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:16 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:40 -0800
Message-Id: <20170112025606.27332-5-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 04/30] target-sparc: add UA2005 TTE bit #defines
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
Message-Id: <036aeab15d1b655352ec81abdd8696d5d3579938.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/cpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 687e158..b41f5c5 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -304,19 +304,36 @@ enum {
 #define TTE_W_OK_BIT        (1ULL <<  1)
 #define TTE_GLOBAL_BIT      (1ULL <<  0)
 
+#define TTE_NFO_BIT_UA2005  (1ULL << 62)
+#define TTE_USED_BIT_UA2005 (1ULL << 47)
+#define TTE_LOCKED_BIT_UA2005 (1ULL <<  61)
+#define TTE_SIDEEFFECT_BIT_UA2005 (1ULL <<  11)
+#define TTE_PRIV_BIT_UA2005 (1ULL <<  8)
+#define TTE_W_OK_BIT_UA2005 (1ULL <<  6)
+
 #define TTE_IS_VALID(tte)   ((tte) & TTE_VALID_BIT)
 #define TTE_IS_NFO(tte)     ((tte) & TTE_NFO_BIT)
 #define TTE_IS_USED(tte)    ((tte) & TTE_USED_BIT)
 #define TTE_IS_LOCKED(tte)  ((tte) & TTE_LOCKED_BIT)
 #define TTE_IS_SIDEEFFECT(tte) ((tte) & TTE_SIDEEFFECT_BIT)
+#define TTE_IS_SIDEEFFECT_UA2005(tte) ((tte) & TTE_SIDEEFFECT_BIT_UA2005)
 #define TTE_IS_PRIV(tte)    ((tte) & TTE_PRIV_BIT)
 #define TTE_IS_W_OK(tte)    ((tte) & TTE_W_OK_BIT)
+
+#define TTE_IS_NFO_UA2005(tte)     ((tte) & TTE_NFO_BIT_UA2005)
+#define TTE_IS_USED_UA2005(tte)    ((tte) & TTE_USED_BIT_UA2005)
+#define TTE_IS_LOCKED_UA2005(tte)  ((tte) & TTE_LOCKED_BIT_UA2005)
+#define TTE_IS_SIDEEFFECT_UA2005(tte) ((tte) & TTE_SIDEEFFECT_BIT_UA2005)
+#define TTE_IS_PRIV_UA2005(tte)    ((tte) & TTE_PRIV_BIT_UA2005)
+#define TTE_IS_W_OK_UA2005(tte)    ((tte) & TTE_W_OK_BIT_UA2005)
+
 #define TTE_IS_GLOBAL(tte)  ((tte) & TTE_GLOBAL_BIT)
 
 #define TTE_SET_USED(tte)   ((tte) |= TTE_USED_BIT)
 #define TTE_SET_UNUSED(tte) ((tte) &= ~TTE_USED_BIT)
 
 #define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
+#define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
 #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
 
 #define SFSR_NF_BIT         (1ULL << 24)   /* JPS1 NoFault */
-- 
2.9.3
