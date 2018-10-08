Received: from eggs.gnu.org ([2001:4830:134:3::10]:57905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4T-00050A-9a
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyo-000899-Q2
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:20 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cym-00087M-N7
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:16 -0400
Received: by mail-pl1-x644.google.com with SMTP id w14-v6so10606598plp.6
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:21:59 -0700
Message-Id: <20181008212205.17752-5-richard.henderson@linaro.org>
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/10] target/arm: Align cortex-r5 id_isar0
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

The missing nibble made it more difficult to read.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b7d9942aa3..ac46641541 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1397,7 +1397,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->id_mmfr1 = 0x00000000;
     cpu->id_mmfr2 = 0x01200000;
     cpu->id_mmfr3 = 0x0211;
-    cpu->id_isar0 = 0x2101111;
+    cpu->id_isar0 = 0x02101111;
     cpu->id_isar1 = 0x13112111;
     cpu->id_isar2 = 0x21232141;
     cpu->id_isar3 = 0x01112131;
-- 
2.17.1
