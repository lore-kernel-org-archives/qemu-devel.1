Received: from eggs.gnu.org ([2001:4830:134:3::10]:48690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5gt-0008Br-9m
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5gq-0003Rd-1w
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:39 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:32820 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5gn-0003HO-Jz
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:35 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:13 +0100
Message-Id: <1540812328-16163-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 05/20] target/mips: Add MXU decoding engine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add MXU decoding engine: add handlers for all instruction pools,
and main decode handler. The handlers, for now, for the purpose
of this patch, contain only sceleton in the form of a single
switch statement.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 1143 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1141 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 265fac6..699a7e7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23976,12 +23976,1151 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+/*
+ *
+ * Decode MXU pool00
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL00|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool00(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_S32MAX:
+        /* TODO: Implement emulation of S32MAX instruction. */
+        MIPS_INVAL("OPC_MXU_S32MAX");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32MIN:
+        /* TODO: Implement emulation of S32MIN instruction. */
+        MIPS_INVAL("OPC_MXU_S32MIN");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MAX:
+        /* TODO: Implement emulation of D16MAX instruction. */
+        MIPS_INVAL("OPC_MXU_D16MAX");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MIN:
+        /* TODO: Implement emulation of D16MIN instruction. */
+        MIPS_INVAL("OPC_MXU_D16MIN");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8MAX:
+        /* TODO: Implement emulation of Q8MAX instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MAX");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8MIN:
+        /* TODO: Implement emulation of Q8MIN instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MIN");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8SLT:
+        /* TODO: Implement emulation of Q8SLT instruction. */
+        MIPS_INVAL("OPC_MXU_Q8SLT");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8SLTU:
+        /* TODO: Implement emulation of Q8SLTU instruction. */
+        MIPS_INVAL("OPC_MXU_Q8SLTU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool01
+ *
+ *  S32SLT, D16SLT, D16AVG, D16AVGR, Q8AVG, Q8AVGR:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL01|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ *  Q8ADD:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+-----+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |en2|0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL01|
+ *  +-----------+---+-----+-----+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool01(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_S32SLT:
+        /* TODO: Implement emulation of S32SLT instruction. */
+        MIPS_INVAL("OPC_MXU_S32SLT");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16SLT:
+        /* TODO: Implement emulation of D16SLT instruction. */
+        MIPS_INVAL("OPC_MXU_D16SLT");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16AVG:
+        /* TODO: Implement emulation of D16AVG instruction. */
+        MIPS_INVAL("OPC_MXU_D16AVG");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16AVGR:
+        /* TODO: Implement emulation of D16AVGR instruction. */
+        MIPS_INVAL("OPC_MXU_D16AVGR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8AVG:
+        /* TODO: Implement emulation of Q8AVG instruction. */
+        MIPS_INVAL("OPC_MXU_Q8AVG");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8AVGR:
+        /* TODO: Implement emulation of Q8AVGR instruction. */
+        MIPS_INVAL("OPC_MXU_Q8AVGR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8ADD:
+        /* TODO: Implement emulation of Q8ADD instruction. */
+        MIPS_INVAL("OPC_MXU_Q8ADD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool02
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL02|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool02(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_S32CPS:
+        /* TODO: Implement emulation of S32CPS instruction. */
+        MIPS_INVAL("OPC_MXU_S32CPS");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16CPS:
+        /* TODO: Implement emulation of D16CPS instruction. */
+        MIPS_INVAL("OPC_MXU_D16CPS");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8ABD:
+        /* TODO: Implement emulation of Q8ABD instruction. */
+        MIPS_INVAL("OPC_MXU_Q8ABD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16SAT:
+        /* TODO: Implement emulation of Q16SAT instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SAT");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool03
+ *
+ *  D16MULF:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |x x|on2|0 0 0 0|  XRc  |  XRb  |  XRa  |MXU__POOL03|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ *  D16MULE:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |x x|on2|   Xd  |  XRc  |  XRb  |  XRa  |MXU__POOL03|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool03(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 24, 2);
+
+    switch (opcode) {
+    case OPC_MXU_D16MULF:
+        /* TODO: Implement emulation of D16MULF instruction. */
+        MIPS_INVAL("OPC_MXU_D16MULF");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MULE:
+        /* TODO: Implement emulation of D16MULE instruction. */
+        MIPS_INVAL("OPC_MXU_D16MULE");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool04
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |x|        s12        |  XRa  |MXU__POOL04|
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool04(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 20, 1);
+
+    switch (opcode) {
+    case OPC_MXU_S32LDD:
+        /* TODO: Implement emulation of S32LDD instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32LDDR:
+        /* TODO: Implement emulation of S32LDDR instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDDR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool05
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |x|        s12        |  XRa  |MXU__POOL05|
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool05(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 20, 1);
+
+    switch (opcode) {
+    case OPC_MXU_S32STD:
+        /* TODO: Implement emulation of S32STD instruction. */
+        MIPS_INVAL("OPC_MXU_S32STD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32STDR:
+        /* TODO: Implement emulation of S32STDR instruction. */
+        MIPS_INVAL("OPC_MXU_S32STDR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool06
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |    rc   |st2|x x x x|  XRa  |MXU__POOL06|
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool06(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+
+    switch (opcode) {
+    case OPC_MXU_S32LDDV:
+        /* TODO: Implement emulation of S32LDDV instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDDV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32LDDVR:
+        /* TODO: Implement emulation of S32LDDVR instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDDVR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool07
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |    rc   |st2|x x x x|  XRa  |MXU__POOL07|
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool07(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+
+    switch (opcode) {
+    case OPC_MXU_S32STDV:
+        /* TODO: Implement emulation of S32TDV instruction. */
+        MIPS_INVAL("OPC_MXU_S32TDV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32STDVR:
+        /* TODO: Implement emulation of S32TDVR instruction. */
+        MIPS_INVAL("OPC_MXU_S32TDVR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool08
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |x|        s12        |  XRa  |MXU__POOL08|
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *
+*/
+static void decode_opc_mxu__pool08(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 20, 1);
+
+    switch (opcode) {
+    case OPC_MXU_S32LDI:
+        /* TODO: Implement emulation of S32LDI instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32LDIR:
+        /* TODO: Implement emulation of S32LDIR instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDIR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool09
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |x|        s12        |  XRa  |MXU__POOL09|
+ *  +-----------+---------+-+-------------------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool09(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 5, 0);
+
+    switch (opcode) {
+    case OPC_MXU_S32SDI:
+        /* TODO: Implement emulation of S32SDI instruction. */
+        MIPS_INVAL("OPC_MXU_S32SDI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32SDIR:
+        /* TODO: Implement emulation of S32SDIR instruction. */
+        MIPS_INVAL("OPC_MXU_S32SDIR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool10
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |    rc   |st2|x x x x|  XRa  |MXU__POOL10|
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool10(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 5, 0);
+
+    switch (opcode) {
+    case OPC_MXU_S32LDIV:
+        /* TODO: Implement emulation of S32LDIV instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDIV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32LDIVR:
+        /* TODO: Implement emulation of S32LDIVR instruction. */
+        MIPS_INVAL("OPC_MXU_S32LDIVR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool11
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |    rc   |st2|x x x x|  XRa  |MXU__POOL11|
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool11(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 10, 4);
+
+    switch (opcode) {
+    case OPC_MXU_S32SDIV:
+        /* TODO: Implement emulation of S32SDIV instruction. */
+        MIPS_INVAL("OPC_MXU_S32SDIV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32SDIVR:
+        /* TODO: Implement emulation of S32SDIVR instruction. */
+        MIPS_INVAL("OPC_MXU_S32SDIVR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool12
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |an2|x x|   Xd  |  XRc  |  XRb  |  XRa  |MXU__POOL12|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool12(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_D32ACC:
+        /* TODO: Implement emulation of D32ACC instruction. */
+        MIPS_INVAL("OPC_MXU_D32ACC");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32ACCM:
+        /* TODO: Implement emulation of D32ACCM instruction. */
+        MIPS_INVAL("OPC_MXU_D32ACCM");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32ASUM:
+        /* TODO: Implement emulation of D32ASUM instruction. */
+        MIPS_INVAL("OPC_MXU_D32ASUM");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool13
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |en2|x x|0 0 0 0|  XRc  |  XRb  |  XRa  |MXU__POOL13|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool13(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q16ACC:
+        /* TODO: Implement emulation of Q16ACC instruction. */
+        MIPS_INVAL("OPC_MXU_Q16ACC");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16ACCM:
+        /* TODO: Implement emulation of Q16ACCM instruction. */
+        MIPS_INVAL("OPC_MXU_Q16ACCM");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16ASUM:
+        /* TODO: Implement emulation of Q16ASUM instruction. */
+        MIPS_INVAL("OPC_MXU_Q16ASUM");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool14
+ *
+ *  Q8ADDE, Q8ACCE:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL14|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ *  D8SUM, D8SUMC:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |en2|x x|0 0 0 0|  XRc  |  XRb  |  XRa  |MXU__POOL14|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool14(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q8ADDE:
+        /* TODO: Implement emulation of Q8ADDE instruction. */
+        MIPS_INVAL("OPC_MXU_Q8ADDE");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D8SUM:
+        /* TODO: Implement emulation of D8SUM instruction. */
+        MIPS_INVAL("OPC_MXU_D8SUM");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D8SUMC:
+        /* TODO: Implement emulation of D8SUMC instruction. */
+        MIPS_INVAL("OPC_MXU_D8SUMC");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool15
+ *
+ *  S32MUL, S32MULU, S32EXTRV:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *  |  SPECIAL2 |    rs   |    rt   |x x|  XRd  |  XRa  |MXU__POOL15|
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *
+ *  S32EXTR:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |   sft5  |x x|  XRd  |  XRa  |MXU__POOL15|
+ *  +-----------+---------+---------+---+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool15(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 14, 2);
+
+    switch (opcode) {
+    case OPC_MXU_S32MUL:
+        /* TODO: Implement emulation of S32MUL instruction. */
+        MIPS_INVAL("OPC_MXU_S32MUL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32MULU:
+        /* TODO: Implement emulation of S32MULU instruction. */
+        MIPS_INVAL("OPC_MXU_S32MULU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32EXTR:
+        /* TODO: Implement emulation of S32EXTR instruction. */
+        MIPS_INVAL("OPC_MXU_S32EXTR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32EXTRV:
+        /* TODO: Implement emulation of S32EXTRV instruction. */
+        MIPS_INVAL("OPC_MXU_S32EXTRV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool16
+ *
+ *  D32SARW:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ *  S32ALN:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |    rs   |x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ *  S32ALNI:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+-----+---+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |  s3 |0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+-----+---+-----+-------+-------+-------+-----------+
+ *
+ *  S32NOR, S32AND, S32OR, S32XOR:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL16|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ *  S32LUI:
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+-----+---+-----+-------+---------------+-----------+
+ *  |  SPECIAL2 |optn3|0 0|x x x|  XRc  |       s8      |MXU__POOL16|
+ *  +-----------+-----+---+-----+-------+---------------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool16(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_D32SARW:
+        /* TODO: Implement emulation of D32SARW instruction. */
+        MIPS_INVAL("OPC_MXU_D32SARW");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32ALN:
+        /* TODO: Implement emulation of S32ALN instruction. */
+        MIPS_INVAL("OPC_MXU_S32ALN");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32ALNI:
+        /* TODO: Implement emulation of S32ALNI instruction. */
+        MIPS_INVAL("OPC_MXU_S32ALNI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32NOR:
+        /* TODO: Implement emulation of S32NOR instruction. */
+        MIPS_INVAL("OPC_MXU_S32NOR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32AND:
+        /* TODO: Implement emulation of S32AND instruction. */
+        MIPS_INVAL("OPC_MXU_S32AND");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32OR:
+        /* TODO: Implement emulation of S32OR instruction. */
+        MIPS_INVAL("OPC_MXU_S32OR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32XOR:
+        /* TODO: Implement emulation of S32XOR instruction. */
+        MIPS_INVAL("OPC_MXU_S32XOR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32LUI:
+        /* TODO: Implement emulation of S32LUI instruction. */
+        MIPS_INVAL("OPC_MXU_S32LUI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool17
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |    rb   |x x x|  XRd  |  XRa  |0 0 0 0|MXU__POOL17|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool17(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_D32SLLV:
+        /* TODO: Implement emulation of D32SLLV instruction. */
+        MIPS_INVAL("OPC_MXU_D32SLLV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32SLRV:
+        /* TODO: Implement emulation of D32SLRV instruction. */
+        MIPS_INVAL("OPC_MXU_D32SLRV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32SARV:
+        /* TODO: Implement emulation of D32SARV instruction. */
+        MIPS_INVAL("OPC_MXU_D32SARV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16SLLV:
+        /* TODO: Implement emulation of Q16SLLV instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SLLV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16SLRV:
+        /* TODO: Implement emulation of Q16SLRV instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SLRV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16SARV:
+        /* TODO: Implement emulation of Q16SARV instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SARV");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool18
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL18|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool18(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q8MUL:
+        /* TODO: Implement emulation of Q8MUL instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MUL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8MULSU:
+        /* TODO: Implement emulation of Q8MULSU instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MULSU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool19
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL19|
+ *  +-----------+---------+-----+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool19(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 18, 3);
+
+    switch (opcode) {
+    case OPC_MXU_Q8MOVZ:
+        /* TODO: Implement emulation of Q8MOVZ instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MOVZ");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8MOVN:
+        /* TODO: Implement emulation of Q8MOVN instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MOVN");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MOVZ:
+        /* TODO: Implement emulation of D16MOVZ instruction. */
+        MIPS_INVAL("OPC_MXU_D16MOVZ");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MOVN:
+        /* TODO: Implement emulation of D16MOVN instruction. */
+        MIPS_INVAL("OPC_MXU_D16MOVN");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32MOVZ:
+        /* TODO: Implement emulation of S32MOVZ instruction. */
+        MIPS_INVAL("OPC_MXU_S32MOVZ");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32MOVN:
+        /* TODO: Implement emulation of S32MOVN instruction. */
+        MIPS_INVAL("OPC_MXU_S32MOVN");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+/*
+ *
+ * Decode MXU pool20
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *  |  SPECIAL2 |an2|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL20|
+ *  +-----------+---+---+-------+-------+-------+-------+-----------+
+ *
+ */
+static void decode_opc_mxu__pool20(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q8MAC:
+        /* TODO: Implement emulation of Q8MAC instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MAC");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8MACSU:
+        /* TODO: Implement emulation of Q8MACSU instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MACSU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
+
+/*
+ * Main MXU decoding function
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------------------------------------+-----------+
+ *  |  SPECIAL2 |                                       |x x x x x x|
+ *  +-----------+---------------------------------------+-----------+
+ *
+ */
 static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
 {
-    MIPS_INVAL("decode_opc_mxu");
-    generate_exception_end(ctx, EXCP_RI);
+    uint32_t opcode = extract32(ctx->opcode, 0, 6);
+
+    switch (opcode) {
+    case OPC_MXU_S32MADD:
+        /* TODO: Implement emulation of S32MADD instruction. */
+        MIPS_INVAL("OPC_MXU_S32MADD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32MADDU:
+        /* TODO: Implement emulation of S32MADDU instruction. */
+        MIPS_INVAL("OPC_MXU_S32MADDU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL00:
+        decode_opc_mxu__pool00(env, ctx);
+        break;
+    case OPC_MXU_S32MSUB:
+        /* TODO: Implement emulation of S32MSUB instruction. */
+        MIPS_INVAL("OPC_MXU_S32MSUB");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32MSUBU:
+        /* TODO: Implement emulation of S32MSUBU instruction. */
+        MIPS_INVAL("OPC_MXU_S32MSUBU");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL01:
+        decode_opc_mxu__pool01(env, ctx);
+        break;
+    case OPC_MXU__POOL02:
+        decode_opc_mxu__pool02(env, ctx);
+        break;
+    case OPC_MXU_D16MUL:
+        /* TODO: Implement emulation of D16MUL instruction. */
+        MIPS_INVAL("OPC_MXU_D16MUL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL03:
+        decode_opc_mxu__pool03(env, ctx);
+        break;
+    case OPC_MXU_D16MAC:
+        /* TODO: Implement emulation of D16MAC instruction. */
+        MIPS_INVAL("OPC_MXU_D16MAC");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MACF:
+        /* TODO: Implement emulation of D16MACF instruction. */
+        MIPS_INVAL("OPC_MXU_D16MACF");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MADL:
+        /* TODO: Implement emulation of D16MADL instruction. */
+        MIPS_INVAL("OPC_MXU_D16MADL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S16MAD:
+        /* TODO: Implement emulation of S16MAD instruction. */
+        MIPS_INVAL("OPC_MXU_S16MAD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16ADD:
+        /* TODO: Implement emulation of Q16ADD instruction. */
+        MIPS_INVAL("OPC_MXU_Q16ADD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D16MACE:
+        /* TODO: Implement emulation of D16MACE instruction. */
+        MIPS_INVAL("OPC_MXU_D16MACE");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL04:
+        decode_opc_mxu__pool04(env, ctx);
+        break;
+    case OPC_MXU__POOL05:
+        decode_opc_mxu__pool05(env, ctx);
+        break;
+    case OPC_MXU__POOL06:
+        decode_opc_mxu__pool06(env, ctx);
+        break;
+    case OPC_MXU__POOL07:
+        decode_opc_mxu__pool07(env, ctx);
+        break;
+    case OPC_MXU__POOL08:
+        decode_opc_mxu__pool08(env, ctx);
+        break;
+    case OPC_MXU__POOL09:
+        decode_opc_mxu__pool09(env, ctx);
+        break;
+    case OPC_MXU__POOL10:
+        decode_opc_mxu__pool10(env, ctx);
+        break;
+    case OPC_MXU__POOL11:
+        decode_opc_mxu__pool11(env, ctx);
+        break;
+    case OPC_MXU_D32ADD:
+        /* TODO: Implement emulation of D32ADD instruction. */
+        MIPS_INVAL("OPC_MXU_D32ADD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL12:
+        decode_opc_mxu__pool12(env, ctx);
+        break;
+    case OPC_MXU__POOL13:
+        decode_opc_mxu__pool13(env, ctx);
+        break;
+    case OPC_MXU__POOL14:
+        decode_opc_mxu__pool14(env, ctx);
+        break;
+    case OPC_MXU_Q8ACCE:
+        /* TODO: Implement emulation of Q8ACCE instruction. */
+        MIPS_INVAL("OPC_MXU_Q8ACCE");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S8LDD:
+        /* TODO: Implement emulation of S8LDD instruction. */
+        MIPS_INVAL("OPC_MXU_S8LDD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S8STD:
+        /* TODO: Implement emulation of S8STD instruction. */
+        MIPS_INVAL("OPC_MXU_S8STD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S8LDI:
+        /* TODO: Implement emulation of S8LDI instruction. */
+        MIPS_INVAL("OPC_MXU_S8LDI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S8SDI:
+        /* TODO: Implement emulation of S8SDI instruction. */
+        MIPS_INVAL("OPC_MXU_S8SDI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL15:
+        decode_opc_mxu__pool15(env, ctx);
+        break;
+    case OPC_MXU__POOL16:
+        decode_opc_mxu__pool16(env, ctx);
+        break;
+    case OPC_MXU_LXB:
+        /* TODO: Implement emulation of LXB instruction. */
+        MIPS_INVAL("OPC_MXU_LXB");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S16LDD:
+        /* TODO: Implement emulation of S16LDD instruction. */
+        MIPS_INVAL("OPC_MXU_S16LDD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S16STD:
+        /* TODO: Implement emulation of S16STD instruction. */
+        MIPS_INVAL("OPC_MXU_S16STD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S16LDI:
+        /* TODO: Implement emulation of S16LDI instruction. */
+        MIPS_INVAL("OPC_MXU_S16LDI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S16SDI:
+        /* TODO: Implement emulation of S16SDI instruction. */
+        MIPS_INVAL("OPC_MXU_S16SDI");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32M2I:
+        /* TODO: Implement emulation of S32M2I instruction. */
+        MIPS_INVAL("OPC_MXU_S32M2I");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32I2M:
+        /* TODO: Implement emulation of S32I2M instruction. */
+        MIPS_INVAL("OPC_MXU_S32I2M");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32SLL:
+        /* TODO: Implement emulation of D32SLL instruction. */
+        MIPS_INVAL("OPC_MXU_D32SLL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32SLR:
+        /* TODO: Implement emulation of D32SLR instruction. */
+        MIPS_INVAL("OPC_MXU_D32SLR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32SARL:
+        /* TODO: Implement emulation of D32SARL instruction. */
+        MIPS_INVAL("OPC_MXU_D32SARL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_D32SAR:
+        /* TODO: Implement emulation of D32SAR instruction. */
+        MIPS_INVAL("OPC_MXU_D32SAR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16SLL:
+        /* TODO: Implement emulation of Q16SLL instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SLL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q16SLR:
+        /* TODO: Implement emulation of Q16SLR instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SLR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL17:
+        decode_opc_mxu__pool17(env, ctx);
+        break;
+    case OPC_MXU_Q16SAR:
+        /* TODO: Implement emulation of Q16SAR instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SAR");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU__POOL18:
+        decode_opc_mxu__pool18(env, ctx);
+        break;
+    case OPC_MXU__POOL19:
+        decode_opc_mxu__pool19(env, ctx);
+        break;
+    case OPC_MXU__POOL20:
+        decode_opc_mxu__pool20(env, ctx);
+        break;
+    case OPC_MXU_Q16SCOP:
+        /* TODO: Implement emulation of Q16SCOP instruction. */
+        MIPS_INVAL("OPC_MXU_Q16SCOP");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8MADL:
+        /* TODO: Implement emulation of Q8MADL instruction. */
+        MIPS_INVAL("OPC_MXU_Q8MADL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_S32SFL:
+        /* TODO: Implement emulation of S32SFL instruction. */
+        MIPS_INVAL("OPC_MXU_S32SFL");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    case OPC_MXU_Q8SAD:
+        /* TODO: Implement emulation of Q8SAD instruction. */
+        MIPS_INVAL("OPC_MXU_Q8SAD");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        generate_exception_end(ctx, EXCP_RI);
+    }
 }
 
+
 static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd;
-- 
2.7.4
