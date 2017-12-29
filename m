Received: from eggs.gnu.org ([2001:4830:134:3::10]:50914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDU-0003Ho-80
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDR-0004pO-2K
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:28 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDQ-0004pB-SX
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:24 -0500
Received: by mail-pg0-x241.google.com with SMTP id q20so20713373pgv.2
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:34 -0800
Message-Id: <20171229063145.29167-28-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 27/38] target/hppa: Implement SYNCDMA insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2e3edf8957..00a8c26afa 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2303,7 +2303,8 @@ static const DisasInsn table_system[] = {
     { 0x000014a0u, 0xffffffe0u, trans_mfia },
     { 0x000004a0u, 0xffff1fe0u, trans_mfsp },
     { 0x000008a0u, 0xfc1fbfe0u, trans_mfctl },
-    { 0x00000400u, 0xffffffffu, trans_sync },
+    { 0x00000400u, 0xffffffffu, trans_sync },  /* sync */
+    { 0x00100400u, 0xffffffffu, trans_sync },  /* syncdma */
     { 0x000010a0u, 0xfc1f3fe0u, trans_ldsid },
 #ifndef CONFIG_USER_ONLY
     { 0x00000e60u, 0xfc00ffe0u, trans_rsm },
-- 
2.14.3
