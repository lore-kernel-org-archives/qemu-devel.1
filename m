Received: from eggs.gnu.org ([2001:4830:134:3::10]:37257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytW-0006ue-5q
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytT-0002ze-8t
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:54 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytT-0002z6-2k
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:51 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so7569477wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:50 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:37 +0100
Message-Id: <1484779123-18968-25-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
2.7.2
