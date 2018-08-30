Received: from eggs.gnu.org ([208.118.235.92]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSst-000139-9S
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvShy-0008MD-3u
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:34:26 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:17871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvShx-0008Lu-RO
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:34:22 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:12 -0400
Message-Id: <20180830193019.20104-3-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 2/9] target/mips: Add all MXU opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Adds all MXU opcodes to the opcode enum.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - NA
 v2
    - NA
 v3
    - Initial patch, split out from prior first patch
 v4
    - separate MXU opcodes into their own enum

 target/mips/translate.c | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 19b90c8735..a598f45558 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -368,6 +368,66 @@ enum {
     OPC_SDBBP    = 0x3F | OPC_SPECIAL2,
 };
 
+enum {
+    /* MXU */
+    OPC_MXU_S32MADD  = 0x00 | OPC_SPECIAL2,
+    OPC_MXU_S32MADDU = 0x01 | OPC_SPECIAL2,
+    OPC_MXU_D16MAX   = 0x03 | OPC_SPECIAL2,
+    OPC_MXU_S32MSUB  = 0x04 | OPC_SPECIAL2,
+    OPC_MXU_S32MSUBU = 0x05 | OPC_SPECIAL2,
+    OPC_MXU_D16AVG   = 0x06 | OPC_SPECIAL2,
+    OPC_MXU_D16CPS   = 0x07 | OPC_SPECIAL2,
+    OPC_MXU_D16MUL   = 0x08 | OPC_SPECIAL2,
+    OPC_MXU_D16MULF  = 0x09 | OPC_SPECIAL2,
+    OPC_MXU_D16MAC   = 0x0A | OPC_SPECIAL2,
+    OPC_MXU_D16MACF  = 0x0B | OPC_SPECIAL2,
+    OPC_MXU_D16MADL  = 0x0C | OPC_SPECIAL2,
+    OPC_MXU_S16MAD   = 0x0D | OPC_SPECIAL2,
+    OPC_MXU_Q16ADD   = 0x0E | OPC_SPECIAL2,
+    OPC_MXU_D16MACE  = 0x0F | OPC_SPECIAL2,
+    OPC_MXU_S32LDD   = 0x10 | OPC_SPECIAL2,
+    OPC_MXU_S32STD   = 0x11 | OPC_SPECIAL2,
+    OPC_MXU_S32LDDV  = 0x12 | OPC_SPECIAL2,
+    OPC_MXU_S32STDV  = 0x13 | OPC_SPECIAL2,
+    OPC_MXU_S32LDI   = 0x14 | OPC_SPECIAL2,
+    OPC_MXU_S32SDI   = 0x15 | OPC_SPECIAL2,
+    OPC_MXU_S32LDIV  = 0x16 | OPC_SPECIAL2,
+    OPC_MXU_S32SDIV  = 0x17 | OPC_SPECIAL2,
+    OPC_MXU_D32ADD   = 0x18 | OPC_SPECIAL2,
+    OPC_MXU_D32ACC   = 0x19 | OPC_SPECIAL2,
+    OPC_MXU_Q16ACC   = 0x1B | OPC_SPECIAL2,
+    OPC_MXU_Q8ADDE   = 0x1C | OPC_SPECIAL2,
+    OPC_MXU_Q8ACCE   = 0x1D | OPC_SPECIAL2,
+    OPC_MXU_S8LDD    = 0x22 | OPC_SPECIAL2,
+    OPC_MXU_S8STD    = 0x23 | OPC_SPECIAL2,
+    OPC_MXU_S8LDI    = 0x24 | OPC_SPECIAL2,
+    OPC_MXU_S8SDI    = 0x25 | OPC_SPECIAL2,
+    OPC_MXU_S32EXTR  = 0x26 | OPC_SPECIAL2,
+    OPC_MXU_D32SARW  = 0x27 | OPC_SPECIAL2,
+    OPC_MXU_LXB      = 0x28 | OPC_SPECIAL2,
+    OPC_MXU_S16LDD   = 0x2A | OPC_SPECIAL2,
+    OPC_MXU_S16STD   = 0x2B | OPC_SPECIAL2,
+    OPC_MXU_S16LDI   = 0x2C | OPC_SPECIAL2,
+    OPC_MXU_S16SDI   = 0x2D | OPC_SPECIAL2,
+    OPC_MXU_S32M2I   = 0x2E | OPC_SPECIAL2,
+    OPC_MXU_S32I2M   = 0x2F | OPC_SPECIAL2,
+    OPC_MXU_D32SLL   = 0x30 | OPC_SPECIAL2,
+    OPC_MXU_D32SLR   = 0x31 | OPC_SPECIAL2,
+    OPC_MXU_D32SARL  = 0x32 | OPC_SPECIAL2,
+    OPC_MXU_D32SAR   = 0x33 | OPC_SPECIAL2,
+    OPC_MXU_Q16SLL   = 0x34 | OPC_SPECIAL2,
+    OPC_MXU_Q16SLR   = 0x35 | OPC_SPECIAL2,
+    OPC_MXU_D32SLLV  = 0x36 | OPC_SPECIAL2,
+    OPC_MXU_Q16SAR   = 0x37 | OPC_SPECIAL2,
+    OPC_MXU_Q8MUL    = 0x38 | OPC_SPECIAL2,
+    OPC_MXU_Q8MOVZ   = 0x39 | OPC_SPECIAL2,
+    OPC_MXU_Q8MAC    = 0x3A | OPC_SPECIAL2,
+    OPC_MXU_Q16SCOP  = 0x3B | OPC_SPECIAL2,
+    OPC_MXU_Q8MADL   = 0x3C | OPC_SPECIAL2,
+    OPC_MXU_S32SFL   = 0x3D | OPC_SPECIAL2,
+    OPC_MXU_Q8SAD    = 0x3E | OPC_SPECIAL2,
+};
+
 /* Special3 opcodes */
 #define MASK_SPECIAL3(op)  MASK_OP_MAJOR(op) | (op & 0x3F)
 
-- 
2.18.0
