Received: from eggs.gnu.org ([2001:4830:134:3::10]:59036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1E-0006Iu-Cn
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1D-0007mB-BR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:04 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:40818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe1D-0007ko-4U
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: by mail-oi1-x234.google.com with SMTP id t204so3458047oie.7
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:20:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:23 -0600
Message-Id: <20181214031923.29527-34-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/32] xxhash: match output against the original
 xxhash32
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

Change the order in which we extract a/b and c/d to
match the output of the upstream xxhash32.

Tested with:
  https://github.com/cota/xxhash/tree/qemu

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/xxhash.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/xxhash.h b/include/qemu/xxhash.h
index fe35dde328..076f1f6054 100644
--- a/include/qemu/xxhash.h
+++ b/include/qemu/xxhash.h
@@ -55,10 +55,10 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
     uint32_t v2 = QEMU_XXHASH_SEED + PRIME32_2;
     uint32_t v3 = QEMU_XXHASH_SEED + 0;
     uint32_t v4 = QEMU_XXHASH_SEED - PRIME32_1;
-    uint32_t a = ab >> 32;
-    uint32_t b = ab;
-    uint32_t c = cd >> 32;
-    uint32_t d = cd;
+    uint32_t a = ab;
+    uint32_t b = ab >> 32;
+    uint32_t c = cd;
+    uint32_t d = cd >> 32;
     uint32_t h32;
 
     v1 += a * PRIME32_2;
-- 
2.17.2
