Received: from eggs.gnu.org ([2001:4830:134:3::10]:52391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A2-0002EZ-9T
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49A1-0003YL-Ij
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:42 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:52539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49A1-0003Xq-CZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:41 -0400
Received: by mail-pg0-x22f.google.com with SMTP id a192so5918766pge.9
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:38 -0700
Message-Id: <20171016172609.23422-20-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 19/50] target/alpha: Avoid translate_init
 unless tcg_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b8a21f4e01..b52ebd7356 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -260,7 +260,9 @@ static void alpha_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     tlb_flush(cs);
 
-    alpha_translate_init();
+    if (tcg_enabled()) {
+        alpha_translate_init();
+    }
 
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
-- 
2.13.6
