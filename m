Received: from eggs.gnu.org ([2001:4830:134:3::10]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRG-00051f-BG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNLRF-0003yv-MR
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:34 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNLRF-0003yV-FL
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:51:33 -0400
Received: by mail-lf0-x243.google.com with SMTP id x81so15465955lfb.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:51:33 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Jun 2017 17:51:21 +0200
Message-Id: <1497973886-26257-4-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
References: <1497973886-26257-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 3/8] target-microblaze: Add CPU versions 9.4,
 9.5 and 9.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add CPU versions 9.4, 9.5 and 9.6.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 4bc77df..982cb61 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -64,6 +64,9 @@ static const struct {
     {"9.1", 0x1D},
     {"9.2", 0x1F},
     {"9.3", 0x20},
+    {"9.4", 0x21},
+    {"9.5", 0x22},
+    {"9.6", 0x23},
     {NULL, 0},
 };
 
-- 
2.7.4
