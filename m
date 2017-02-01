Received: from eggs.gnu.org ([2001:4830:134:3::10]:39198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYwda-00008y-UU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYwdX-000203-Se
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:15:58 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cYwdX-0001zh-N9
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:15:55 -0500
Received: by mail-wm0-x230.google.com with SMTP id r141so42920102wmg.1
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 07:15:55 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  1 Feb 2017 15:05:50 +0000
Message-Id: <20170201150553.9381-23-alex.bennee@linaro.org>
In-Reply-To: <20170201150553.9381-1-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 22/25] target-arm/cpu.h: make ARM_CP defined
 consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

This is a purely mechanical change to make the ARM_CP flags neatly
align and use a consistent format so it is easier to see which bit
each flag is.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39bff86daf..d61793ca06 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1452,20 +1452,20 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
  * need to be surrounded by gen_io_start()/gen_io_end(). In particular,
  * registers which implement clocks or timers require this.
  */
-#define ARM_CP_SPECIAL 1
-#define ARM_CP_CONST 2
-#define ARM_CP_64BIT 4
-#define ARM_CP_SUPPRESS_TB_END 8
-#define ARM_CP_OVERRIDE 16
-#define ARM_CP_ALIAS 32
-#define ARM_CP_IO 64
-#define ARM_CP_NO_RAW 128
-#define ARM_CP_NOP (ARM_CP_SPECIAL | (1 << 8))
-#define ARM_CP_WFI (ARM_CP_SPECIAL | (2 << 8))
-#define ARM_CP_NZCV (ARM_CP_SPECIAL | (3 << 8))
-#define ARM_CP_CURRENTEL (ARM_CP_SPECIAL | (4 << 8))
-#define ARM_CP_DC_ZVA (ARM_CP_SPECIAL | (5 << 8))
-#define ARM_LAST_SPECIAL ARM_CP_DC_ZVA
+#define ARM_CP_SPECIAL         (1 << 0)
+#define ARM_CP_CONST           (1 << 1)
+#define ARM_CP_64BIT           (1 << 2)
+#define ARM_CP_SUPPRESS_TB_END (1 << 3)
+#define ARM_CP_OVERRIDE        (1 << 4)
+#define ARM_CP_ALIAS           (1 << 5)
+#define ARM_CP_IO              (1 << 6)
+#define ARM_CP_NO_RAW          (1 << 7)
+#define ARM_CP_NOP             (ARM_CP_SPECIAL | (1 << 8))
+#define ARM_CP_WFI             (ARM_CP_SPECIAL | (2 << 8))
+#define ARM_CP_NZCV            (ARM_CP_SPECIAL | (3 << 8))
+#define ARM_CP_CURRENTEL       (ARM_CP_SPECIAL | (4 << 8))
+#define ARM_CP_DC_ZVA          (ARM_CP_SPECIAL | (5 << 8))
+#define ARM_LAST_SPECIAL       ARM_CP_DC_ZVA
 /* Used only as a terminator for ARMCPRegInfo lists */
 #define ARM_CP_SENTINEL 0xffff
 /* Mask of only the flag bits in a type field */
-- 
2.11.0
