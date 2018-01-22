Received: from eggs.gnu.org ([2001:4830:134:3::10]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0e-0005lp-Q7
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0c-0006dg-Qy
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:00 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:46221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0c-0006dK-KF
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:58 -0500
Received: by mail-pf0-x241.google.com with SMTP id y5so6066960pff.13
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:42:00 -0800
Message-Id: <20180122034217.19593-27-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 26/43] target/hppa: Implement SYNCDMA insn
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b207ae192a..a311a464bf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2301,7 +2301,8 @@ static const DisasInsn table_system[] = {
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
