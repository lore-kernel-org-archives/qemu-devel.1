Received: from eggs.gnu.org ([2001:4830:134:3::10]:37451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7b-0007x9-Oc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7a-0001xK-H1
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 26 Apr 2017 23:29:14 -0400
Message-Id: <1493263764-18657-2-git-send-email-cota@braap.org>
In-Reply-To: <1493263764-18657-1-git-send-email-cota@braap.org>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 01/11] exec-all: export tb_htable_lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpu-exec.c              | 6 ++----
 include/exec/exec-all.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 63a56d0..5b181c1 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -309,10 +309,8 @@ static bool tb_cmp(const void *p, const void *d)
     return false;
 }
 
-static TranslationBlock *tb_htable_lookup(CPUState *cpu,
-                                          target_ulong pc,
-                                          target_ulong cs_base,
-                                          uint32_t flags)
+TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
+                                   target_ulong cs_base, uint32_t flags)
 {
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bcde1e6..87ae10b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -368,6 +368,8 @@ struct TranslationBlock {
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
+TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
+                                   target_ulong cs_base, uint32_t flags);
 
 #if defined(USE_DIRECT_JUMP)
 
-- 
2.7.4
