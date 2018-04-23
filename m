Received: from eggs.gnu.org ([2001:4830:134:3::10]:41858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAeHY-0007H3-7P
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAeHX-0000q7-Du
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:25:36 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAeHX-0000py-9y
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:25:35 -0400
Received: by mail-qt0-x243.google.com with SMTP id s2-v6so18369282qti.2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:25:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 23 Apr 2018 13:25:22 -0300
Message-Id: <20180423162523.6392-2-f4bug@amsat.org>
In-Reply-To: <20180423162523.6392-1-f4bug@amsat.org>
References: <20180423162523.6392-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/2] bswap.h: Fix ldl_he_p() signedness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

As per the "Load and Store APIs" documentation (docs/devel/loads-stores.rst),
"No signed load operations are provided."
Update lduw_he_p() to return as unsigned.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/bswap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 3f28f661b1..613978f838 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -330,9 +330,9 @@ static inline void stw_he_p(void *ptr, uint16_t v)
     memcpy(ptr, &v, sizeof(v));
 }
 
-static inline int ldl_he_p(const void *ptr)
+static inline uint32_t ldl_he_p(const void *ptr)
 {
-    int32_t r;
+    uint32_t r;
     memcpy(&r, ptr, sizeof(r));
     return r;
 }
-- 
2.17.0
