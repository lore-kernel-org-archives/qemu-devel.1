Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXp-000235-W3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dSKXp-0000XW-9b
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:58 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dSKXp-0000Wi-2O
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:57 -0400
Received: by mail-lf0-x244.google.com with SMTP id t72so17250627lff.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:54:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  4 Jul 2017 11:54:35 +0200
Message-Id: <1499162088-1562-5-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 04/17] target-microblaze: Add CPU versions
 9.4, 9.5 and 9.6
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

Add CPU versions 9.4, 9.5 and 9.6.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
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
