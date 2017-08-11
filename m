Received: from eggs.gnu.org ([2001:4830:134:3::10]:45175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaN-0000Ch-Bz
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dgEaM-0007Tu-63
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:23:03 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 11 Aug 2017 11:19:22 -0700
Message-ID: <a970dcb0e2778db6af5ecb62bef234d50c20be66.1502474835.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1502474835.git.alistair.francis@xilinx.com>
References: <cover.1502474835.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 2/3] tcg/tcg-op: Expose the tcg_gen_ext_i*
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, qemu-arm@nongnu.org

Expose the tcg_gen_ext_i32() and tcg_gen_ext_i64() functions as we are
going to use them later.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 tcg/tcg-op.c | 4 ++--
 tcg/tcg-op.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 87f673ef49..d25e3003ef 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2709,7 +2709,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
 }
 
-static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
+void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
 {
     switch (opc & MO_SSIZE) {
     case MO_SB:
@@ -2730,7 +2730,7 @@ static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
     }
 }
 
-static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc)
+void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc)
 {
     switch (opc & MO_SSIZE) {
     case MO_SB:
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 5d3278f243..8c45b79a92 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -835,6 +835,8 @@ void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
+void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc);
+void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc);
 
 static inline void tcg_gen_qemu_ld8u(TCGv ret, TCGv addr, int mem_index)
 {
-- 
2.11.0
