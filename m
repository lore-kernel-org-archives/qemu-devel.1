Received: from eggs.gnu.org ([209.51.188.92]:36429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0001cx-7P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdZ-0005Vv-3l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41186 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItdY-0004BG-TK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:57 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Apr 2019 13:29:38 +0200
Message-Id: <1556018982-3715-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/8] target/mips: Add * to comments and realign
 them to fix checkpatch warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Jules Irenge <jbi.octave@gmail.com>

Add * to comments and realign to fix warnings issued by checkpatch.pl
tool "WARNING: Block comments use a leading /* on a separate line"
within the file target/mips/cp0_timer.c.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190327181650.23992-1-jbi.octave@gmail.com>
---
 target/mips/cp0_timer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index 742f4b2..d80b007 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -42,8 +42,10 @@ uint32_t cpu_mips_get_random(CPUMIPSState *env)
 
     /* Don't return same value twice, so get another value */
     do {
-        /* Use a simple algorithm of Linear Congruential Generator
-         * from ISO/IEC 9899 standard. */
+        /*
+         * Use a simple algorithm of Linear Congruential Generator
+         * from ISO/IEC 9899 standard.
+         */
         seed = 1103515245 * seed + 12345;
         idx = (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
     } while (idx == prev_idx);
@@ -143,9 +145,11 @@ static void mips_timer_cb(void *opaque)
     if (env->CP0_Cause & (1 << CP0Ca_DC))
         return;
 
-    /* ??? This callback should occur when the counter is exactly equal to
-       the comparator value.  Offset the count by one to avoid immediately
-       retriggering the callback before any virtual time has passed.  */
+    /*
+     * ??? This callback should occur when the counter is exactly equal to
+     * the comparator value.  Offset the count by one to avoid immediately
+     * retriggering the callback before any virtual time has passed.
+     */
     env->CP0_Count++;
     cpu_mips_timer_expire(env);
     env->CP0_Count--;
-- 
2.7.4
