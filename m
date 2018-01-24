Received: from eggs.gnu.org ([2001:4830:134:3::10]:51224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURi-0004rX-1L
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURh-0001yv-B0
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:10 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURh-0001yi-4n
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:09 -0500
Received: by mail-pg0-x243.google.com with SMTP id s9so3801844pgq.13
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:09 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:06 -0800
Message-Id: <20180124232625.30105-27-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 26/45] target/hppa: Implement SYNCDMA insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41e28ff64c..f3942b1baf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2312,7 +2312,8 @@ static const DisasInsn table_system[] = {
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
