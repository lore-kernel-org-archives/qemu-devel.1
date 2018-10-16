Received: from eggs.gnu.org ([2001:4830:134:3::10]:59690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTP-00046Q-3p
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTK-0000zZ-LL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:33381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTK-0000gZ-CD
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 78-v6so9443564pfq.0
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:48:53 -0700
Message-Id: <20181016174911.9052-4-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/21] tcg: fix use of uninitialized variable
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

We forgot to initialize n in commit 15fa08f845 ("tcg: Dynamically
allocate TCGOps", 2017-12-29).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181010144853.13005-3-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.2
