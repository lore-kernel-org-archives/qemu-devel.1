Received: from eggs.gnu.org ([2001:4830:134:3::10]:44805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiP-00034N-AM
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLiO-0003da-Hg
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:17 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLiO-0003dG-9u
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:09:16 -0400
Received: by mail-lf0-x244.google.com with SMTP id x81so15593025lfb.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:09:16 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 18:09:04 +0200
Message-Id: <1497974944-27050-8-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 7/7] target-microblaze: Add CPU version 10.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add CPU version 10.0.

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
