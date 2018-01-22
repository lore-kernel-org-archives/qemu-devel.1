Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0I-0005OJ-5c
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0F-00069y-Uv
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:38 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:45716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0F-00068Q-P6
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:35 -0500
Received: by mail-pg0-x241.google.com with SMTP id c194so6077503pga.12
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:41:44 -0800
Message-Id: <20180122034217.19593-11-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/43] target/hppa: Adjust insn mask for mfctl, w
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

While the E bit is only used for pa2.0 mfctl,w from sar,
the otherwise reserved bit does not appear to be decoded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0408dbedf1..b201e5ace2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2151,7 +2151,7 @@ static const DisasInsn table_system[] = {
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
