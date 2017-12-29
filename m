Received: from eggs.gnu.org ([2001:4830:134:3::10]:50645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD5-0002uE-PM
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD4-0004ZZ-Vw
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:03 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:39279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoD4-0004ZI-Pj
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:02 -0500
Received: by mail-pg0-x241.google.com with SMTP id 81so1173983pgf.6
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:17 -0800
Message-Id: <20171229063145.29167-11-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/38] target/hppa: Adjust insn mask for mfctl,
 w
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

While the E bit is only used for pa2.0 mfctl,w from sar,
the otherwise reserved bit does not appear to be decoded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 62dd1600ef..2a61b6bc8d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2152,7 +2152,7 @@ static const DisasInsn table_system[] = {
     { 0x016018c0u, 0xffe0ffffu, trans_mtsarcm },
     { 0x000014a0u, 0xffffffe0u, trans_mfia },
     { 0x000004a0u, 0xffff1fe0u, trans_mfsp },
-    { 0x000008a0u, 0xfc1fffe0u, trans_mfctl },
+    { 0x000008a0u, 0xfc1fbfe0u, trans_mfctl },
     { 0x00000400u, 0xffffffffu, trans_sync },
     { 0x000010a0u, 0xfc1f3fe0u, trans_ldsid },
 #ifndef CONFIG_USER_ONLY
-- 
2.14.3
