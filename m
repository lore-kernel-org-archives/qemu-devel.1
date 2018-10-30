Received: from eggs.gnu.org ([2001:4830:134:3::10]:37863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHWCH-0002c4-DG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHWCE-0001rJ-AJ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51484 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHWCD-0008UB-PR
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:46 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 16:44:05 +0100
Message-Id: <1540914249-3392-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/5] target/mips: Rename MMI-related masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename MMI-related masks.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 51a5488..e38d50d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2159,7 +2159,7 @@ enum {
  *    7 111 |   *   |   *   |   *   |   *   | PSLLW |   *   | PSRLW | PS=
RAW
  */
=20
-#define MASK_TX79_MMI(op) (MASK_OP_MAJOR(op) | ((op) & 0x3F))
+#define MASK_MMI(op) (MASK_OP_MAJOR(op) | ((op) & 0x3F))
 enum {
     TX79_MMI_MADD       =3D 0x00 | TX79_CLASS_MMI, /* Same as OPC_MADD *=
/
     TX79_MMI_MADDU      =3D 0x01 | TX79_CLASS_MMI, /* Same as OPC_MADDU =
*/
@@ -2210,7 +2210,7 @@ enum {
  *    7 111 |   *   |   *   | PEXT5 | PPAC5
  */
=20
-#define MASK_TX79_MMI0(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+#define MASK_MMI0(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
     TX79_MMI0_PADDW  =3D (0x00 << 6) | TX79_MMI_CLASS_MMI0,
     TX79_MMI0_PSUBW  =3D (0x01 << 6) | TX79_MMI_CLASS_MMI0,
@@ -2261,7 +2261,7 @@ enum {
  *    7 111 |   *   |   *   |   *   |   *
  */
=20
-#define MASK_TX79_MMI1(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+#define MASK_MMI1(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
     TX79_MMI1_PABSW  =3D (0x01 << 6) | TX79_MMI_CLASS_MMI1,
     TX79_MMI1_PCEQW  =3D (0x02 << 6) | TX79_MMI_CLASS_MMI1,
@@ -2305,7 +2305,7 @@ enum {
  *    7 111 | PMULTH| PDIVBW| PEXEW | PROT3W
  */
=20
-#define MASK_TX79_MMI2(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+#define MASK_MMI2(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
     TX79_MMI2_PMADDW =3D (0x00 << 6) | TX79_MMI_CLASS_MMI2,
     TX79_MMI2_PSLLVW =3D (0x02 << 6) | TX79_MMI_CLASS_MMI2,
@@ -2353,7 +2353,7 @@ enum {
  *    7 111 |   *   |   *   | PEXCW |   *
  */
=20
-#define MASK_TX79_MMI3(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+#define MASK_MMI3(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
 enum {
     TX79_MMI3_PMADDUW =3D (0x00 << 6) | TX79_MMI_CLASS_MMI3,
     TX79_MMI3_PSRAVW  =3D (0x03 << 6) | TX79_MMI_CLASS_MMI3,
@@ -24683,7 +24683,7 @@ static void decode_opc_special3_legacy(CPUMIPSSta=
te *env, DisasContext *ctx)
=20
 static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
 {
-    uint32_t opc =3D MASK_TX79_MMI0(ctx->opcode);
+    uint32_t opc =3D MASK_MMI0(ctx->opcode);
=20
     switch (opc) {
     case TX79_MMI0_PADDW:     /* TODO: TX79_MMI0_PADDW */
@@ -24722,7 +24722,7 @@ static void decode_tx79_mmi0(CPUMIPSState *env, D=
isasContext *ctx)
=20
 static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
 {
-    uint32_t opc =3D MASK_TX79_MMI1(ctx->opcode);
+    uint32_t opc =3D MASK_MMI1(ctx->opcode);
=20
     switch (opc) {
     case TX79_MMI1_PABSW:     /* TODO: TX79_MMI1_PABSW */
@@ -24754,7 +24754,7 @@ static void decode_tx79_mmi1(CPUMIPSState *env, D=
isasContext *ctx)
=20
 static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
 {
-    uint32_t opc =3D MASK_TX79_MMI2(ctx->opcode);
+    uint32_t opc =3D MASK_MMI2(ctx->opcode);
=20
     switch (opc) {
     case TX79_MMI2_PMADDW:    /* TODO: TX79_MMI2_PMADDW */
@@ -24790,7 +24790,7 @@ static void decode_tx79_mmi2(CPUMIPSState *env, D=
isasContext *ctx)
=20
 static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
 {
-    uint32_t opc =3D MASK_TX79_MMI3(ctx->opcode);
+    uint32_t opc =3D MASK_MMI3(ctx->opcode);
=20
     switch (opc) {
     case TX79_MMI3_PMADDUW:    /* TODO: TX79_MMI3_PMADDUW */
@@ -24817,7 +24817,7 @@ static void decode_tx79_mmi3(CPUMIPSState *env, D=
isasContext *ctx)
=20
 static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
-    uint32_t opc =3D MASK_TX79_MMI(ctx->opcode);
+    uint32_t opc =3D MASK_MMI(ctx->opcode);
     int rs =3D extract32(ctx->opcode, 21, 5);
     int rt =3D extract32(ctx->opcode, 16, 5);
     int rd =3D extract32(ctx->opcode, 11, 5);
--=20
2.7.4
