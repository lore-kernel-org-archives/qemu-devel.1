Received: from eggs.gnu.org ([2001:4830:134:3::10]:54974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOp-0000nG-WC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOm-0004zr-0I
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:39 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAOl-0004zK-OD
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:35 -0400
Received: by mail-lf0-x241.google.com with SMTP id m18-v6so24926115lfb.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:35 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:18:59 +0200
Message-Id: <20180503091922.28733-7-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-1-edgar.iglesias@gmail.com>
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 06/29] target-microblaze: Correct the PVR
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Correct the PVR array size, there are 13 PVR registers.

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
