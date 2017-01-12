Received: from eggs.gnu.org ([2001:4830:134:3::10]:55703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZH-0000Kq-Q2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZG-0006rv-W3
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:47 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZG-0006ro-Sr
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:46 -0500
Received: by mail-qk0-x241.google.com with SMTP id a20so940567qkc.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:46 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:56:00 -0800
Message-Id: <20170112025606.27332-25-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 24/30] target-sparc: add more registers to
 dump_mmu
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <288f09c6282bf46af7ad8343fe63f7438a9f44a2.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/mmu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index fa70dc0..8b4664d 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -741,6 +741,8 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
                    PRId64 "\n",
                    env->dmmu.mmu_primary_context,
                    env->dmmu.mmu_secondary_context);
+    (*cpu_fprintf)(f, "DMMU Tag Access: %" PRIx64 ", TSB Tag Target: %" PRIx64
+                   "\n", env->dmmu.tag_access, env->dmmu.tsb_tag_target);
     if ((env->lsu & DMMU_E) == 0) {
         (*cpu_fprintf)(f, "DMMU disabled\n");
     } else {
-- 
2.9.3
