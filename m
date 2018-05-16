Received: from eggs.gnu.org ([2001:4830:134:3::10]:53566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Ws-00030D-OW
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wp-0000i1-LJ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:52:02 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1Wp-0000ho-Dy
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:59 -0400
Received: by mail-wr0-x241.google.com with SMTP id v5-v6so2762288wrf.9
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:51:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:14 +0200
Message-Id: <20180516185146.30708-7-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 06/38] target-microblaze: Correct the PVR
 array size
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

Correct the PVR array size, there are 13 PVR registers.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 994496515f..2304c24b7d 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -277,7 +277,7 @@ struct CPUMBState {
     /* These fields are preserved on reset.  */
 
     struct {
-        uint32_t regs[16];
+        uint32_t regs[13];
     } pvr;
 };
 
-- 
2.14.1
