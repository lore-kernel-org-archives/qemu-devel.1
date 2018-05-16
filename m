Received: from eggs.gnu.org ([2001:4830:134:3::10]:53658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1X3-00038q-D3
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1X2-0000lV-N6
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:13 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1X2-0000lG-Gx
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:12 -0400
Received: by mail-wr0-x243.google.com with SMTP id p5-v6so2754185wre.12
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:52:12 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:22 +0200
Message-Id: <20180516185146.30708-15-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 14/38] target-microblaze: Name special
 registers we support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Name special registers we support.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a3cc1e0ef1..12cb345f64 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -105,8 +105,8 @@ static const char *regnames[] =
 
 static const char *special_regnames[] =
 {
-    "rpc", "rmsr", "sr2", "sr3", "sr4", "sr5", "sr6", "sr7",
-    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13"
+    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
+    "sr8", "sr9", "sr10", "rbtr", "sr12", "redr"
 };
 
 static inline void t_sync_flags(DisasContext *dc)
-- 
2.14.1
