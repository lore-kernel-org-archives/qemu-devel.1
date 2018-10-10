Received: from eggs.gnu.org ([2001:4830:134:3::10]:58918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnU-0002nw-MF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnP-0004bQ-Lv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gAFnP-0004aR-Fp
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 10 Oct 2018 10:48:51 -0400
Message-Id: <20181010144853.13005-3-cota@braap.org>
In-Reply-To: <20181010144853.13005-1-cota@braap.org>
References: <20181010144853.13005-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/4] tcg: fix use of uninitialized variable
 under CONFIG_PROFILER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

We forgot to initialize n in commit 15fa08f845 ("tcg: Dynamically
allocate TCGOps", 2017-12-29).

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f27b22bd3c..8f26916b99 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3430,7 +3430,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 
 #ifdef CONFIG_PROFILER
     {
-        int n;
+        int n = 0;
 
         QTAILQ_FOREACH(op, &s->ops, link) {
             n++;
-- 
2.17.1
