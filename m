Received: from eggs.gnu.org ([2001:4830:134:3::10]:50339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRZ-0007kP-0A
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRY-0003P5-88
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:01 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRY-0003OW-1M
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:00 -0400
Received: by mail-pg0-x244.google.com with SMTP id f127so7255914pgc.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:34 -0700
Message-Id: <20170604173509.29684-35-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 34/69] target/s390x: Implement CSPG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def | 1 +
 target/s390x/translate.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 4c91f30..f818437 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -838,6 +838,7 @@
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     D(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL)
+    D(0xb98a, CSPG,    RRE, DAT_ENH, r1_o, ra2, r1_P, 0, csp, 0, MO_TEQ)
 /* DIAGNOSE (KVM hypercall) */
     C(0x8300, DIAG,    RSI,   Z,   0, 0, 0, 0, diag, 0)
 /* INSERT STORAGE KEY EXTENDED */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a3fb324..4bd16d9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1195,6 +1195,7 @@ typedef enum DisasFacility {
     FAC_SFLE,               /* store facility list extended */
     FAC_ILA,                /* interlocked access facility 1 */
     FAC_LPP,                /* load-program-parameter */
+    FAC_DAT_ENH,            /* DAT-enhancement */
 } DisasFacility;
 
 struct DisasInsn {
-- 
2.9.4
