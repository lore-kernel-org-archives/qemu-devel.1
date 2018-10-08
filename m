Received: from eggs.gnu.org ([2001:4830:134:3::10]:45743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9WzM-0004Jc-Vi
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9WzG-0005MO-KJ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:58:27 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41828 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g9Wz6-0005HL-FR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:58:18 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  8 Oct 2018 16:56:27 +0200
Message-Id: <1539010596-30858-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 03/12] elf: Add Mips_elf_abiflags_v0
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Stefan Markovic <smarkovic@wavecomp.com>

Add Mips_elf_abiflags_v0 structure to elf.h. The source of information
is kernel header arch/mips/include/asm/elf.h.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/elf.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index eb5958d..75c60cc 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -96,6 +96,21 @@ typedef int64_t  Elf64_Sxword;
 #define MIPS_ABI_FP_64        0x6         /* -mips32r2 -mfp64                */
 #define MIPS_ABI_FP_64A       0x7         /* -mips32r2 -mfp64 -mno-odd-spreg */
 
+typedef struct mips_elf_abiflags_v0 {
+  uint16_t version;           /* Version of flags structure                  */
+  uint8_t isa_level;          /* The level of the ISA: 1-5, 32, 64           */
+  uint8_t isa_rev;            /* The revision of ISA: 0 for MIPS V and below,*/
+                              /* 1-n otherwise                               */
+  uint8_t gpr_size;           /* The size of general purpose registers       */
+  uint8_t cpr1_size;          /* The size of co-processor 1 registers        */
+  uint8_t cpr2_size;          /* The size of co-processor 2 registers        */
+  uint8_t fp_abi;             /* The floating-point ABI                      */
+  uint32_t isa_ext;           /* Mask of processor-specific extensions       */
+  uint32_t ases;              /* Mask of ASEs used                           */
+  uint32_t flags1;            /* Mask of general flags                       */
+  uint32_t flags2;
+} Mips_elf_abiflags_v0;
+
 /* These constants define the different elf file types */
 #define ET_NONE   0
 #define ET_REL    1
-- 
2.7.4
