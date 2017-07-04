Received: from eggs.gnu.org ([2001:4830:134:3::10]:41648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY6-0002O3-Hl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKY5-0000iI-5r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:14 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKY4-0000i2-V7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:55:13 -0400
Received: by mail-lf0-x241.google.com with SMTP id g21so17213120lfk.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:55:12 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:47 +0200
Message-Id: <1499162088-1562-17-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 16/17] target-microblaze: Add CPU version 10.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add CPU version 10.0.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6e27c3c..f85ff01 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -67,6 +67,7 @@ static const struct {
     {"9.4", 0x21},
     {"9.5", 0x22},
     {"9.6", 0x23},
+    {"10.0", 0x24},
     {NULL, 0},
 };
 
-- 
2.7.4
