Received: from eggs.gnu.org ([2001:4830:134:3::10]:59069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHISX-0005xg-LX
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHISW-00087K-Sz
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:25 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHISW-000879-MU
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:32:24 -0400
Received: by mail-pl0-x244.google.com with SMTP id c19-v6so4135366pls.6
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:32:08 -0700
Message-Id: <20180512003217.9105-3-richard.henderson@linaro.org>
In-Reply-To: <20180512003217.9105-1-richard.henderson@linaro.org>
References: <20180512003217.9105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 02/11] target/arm: Early exit after
 unallocated_encoding in disas_fp_int_conv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

No sense in emitting code after the exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5b8cf75e9f..11d8c07943 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5780,7 +5780,7 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
         default:
             /* all other sf/type/rmode combinations are invalid */
             unallocated_encoding(s);
-            break;
+            return;
         }
 
         if (!fp_access_check(s)) {
-- 
2.17.0
