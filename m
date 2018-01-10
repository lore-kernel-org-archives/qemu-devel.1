Received: from eggs.gnu.org ([2001:4830:134:3::10]:58464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ9xJ-0000pi-Qz
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZ9xH-0007MZ-5c
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:45 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZ9xH-0007LR-0c
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 01:33:43 -0500
Received: by mail-pl0-x244.google.com with SMTP id q3so1386236plr.8
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 22:33:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  9 Jan 2018 22:33:37 -0800
Message-Id: <20180110063337.21538-3-richard.henderson@linaro.org>
In-Reply-To: <20180110063337.21538-1-richard.henderson@linaro.org>
References: <20180110063337.21538-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Add fp16 support to
 vfp_expand_imm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e03cd3801a..4fe9d82a55 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5035,6 +5035,11 @@ static uint64_t vfp_expand_imm(int size, uint8_t imm8)
             (extract32(imm8, 0, 6) << 3);
         imm <<= 16;
         break;
+    case MO_16:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3000 : 0x4000) |
+            (extract32(imm8, 0, 6) << 6);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.13.6
