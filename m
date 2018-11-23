Received: from eggs.gnu.org ([2001:4830:134:3::10]:45571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKSr-0007hD-AH
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQKSo-000294-3a
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQKSn-00025c-N1
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 18:02:17 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 23 Nov 2018 18:02:06 -0500
Message-Id: <20181123230206.12629-5-cota@braap.org>
In-Reply-To: <20181123230206.12629-1-cota@braap.org>
References: <20181123230206.12629-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 4/4] xxhash: match output against the original
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Change the order in which we extract a/b and c/d to
match the output of the upstream xxhash32.

Tested with:
  https://github.com/cota/xxhash/tree/qemu

Signed-off-by: Emilio G. Cota <cota@braap.org>
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
2.17.1
