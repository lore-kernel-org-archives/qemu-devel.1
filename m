Received: from eggs.gnu.org ([2001:4830:134:3::10]:58759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EH-0000Vy-Gi
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EG-0004xI-KB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:13 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:50210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20EG-0004wz-EN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:12 -0400
Received: by mail-pf0-x233.google.com with SMTP id m63so18276906pfk.7
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:29:47 -0700
Message-Id: <20171010193003.28857-5-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 04/20] translate-all: make have_tb_lock static
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

It is only used by this object, and it's not exported to any other.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b3bfe65059..a7c1d4e3f2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -139,7 +139,7 @@ TCGContext tcg_ctx;
 bool parallel_cpus;
 
 /* translation block context */
-__thread int have_tb_lock;
+static __thread int have_tb_lock;
 
 static void page_table_config_init(void)
 {
-- 
2.13.6
