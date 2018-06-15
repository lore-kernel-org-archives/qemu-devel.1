Received: from eggs.gnu.org ([2001:4830:134:3::10]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTudt-0000NU-KU
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTuds-0002Vu-18
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:17 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTudr-0002VK-RC
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:15 -0400
Received: by mail-pf0-x244.google.com with SMTP id y8-v6so5326250pfm.10
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:44:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Jun 2018 09:43:43 -1000
Message-Id: <20180615194354.12489-9-richard.henderson@linaro.org>
In-Reply-To: <20180615194354.12489-1-richard.henderson@linaro.org>
References: <20180615194354.12489-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 08/19] translate-all: remove hole in PageDesc
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

Groundwork for supporting parallel TCG generation.

Move the hole to the end of the struct, so that a u32
field can be added there without bloating the struct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 52273e5846..b9c36a3e45 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -107,8 +107,8 @@ typedef struct PageDesc {
 #ifdef CONFIG_SOFTMMU
     /* in order to optimize self modifying code, we count the number
        of lookups we do to a given page to use a bitmap */
-    unsigned int code_write_count;
     unsigned long *code_bitmap;
+    unsigned int code_write_count;
 #else
     unsigned long flags;
 #endif
-- 
2.17.1
