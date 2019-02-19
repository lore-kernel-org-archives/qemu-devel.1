Received: from eggs.gnu.org ([209.51.188.92]:42228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvxz7-0003vD-Im
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvxyv-0006u6-U9
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:30:24 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvxyu-0006tW-15
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:30:13 -0500
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so16255226ljd.12
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 21:30:10 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 21:29:51 -0800
Message-Id: <20190219052951.5591-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fixup test_mmuhifi_c3 overlay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

xtensa-modules part of the test_mmuhifi_c3 core is missing fixes that
returns XTENSA_UNDEFINED for undefined opcodes and marks all data
structures static. Run sed script from target/xtensa/import_core.sh on
it. This fixes test_sr tests for missing special registers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 .../core-test_mmuhifi_c3/xtensa-modules.inc.c      | 1322 ++++++++++----------
 1 file changed, 661 insertions(+), 661 deletions(-)

diff --git a/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c b/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c
index ef70f80f1d69..687631b8fb2f 100644
--- a/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c
+++ b/target/xtensa/core-test_mmuhifi_c3/xtensa-modules.inc.c
@@ -24159,2627 +24159,2627 @@ Opcode_ae_sbf_Slot_inst_encode (xtensa_insnbuf slotbuf)
   slotbuf[0] = 0xe7d014;
 }
 
-xtensa_opcode_encode_fn Opcode_excw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_excw_encode_fns[] = {
   Opcode_excw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rfe_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rfe_encode_fns[] = {
   Opcode_rfe_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rfde_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rfde_encode_fns[] = {
   Opcode_rfde_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_syscall_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_syscall_encode_fns[] = {
   Opcode_syscall_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_simcall_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_simcall_encode_fns[] = {
   Opcode_simcall_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_call12_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_call12_encode_fns[] = {
   Opcode_call12_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_call8_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_call8_encode_fns[] = {
   Opcode_call8_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_call4_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_call4_encode_fns[] = {
   Opcode_call4_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_callx12_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_callx12_encode_fns[] = {
   Opcode_callx12_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_callx8_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_callx8_encode_fns[] = {
   Opcode_callx8_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_callx4_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_callx4_encode_fns[] = {
   Opcode_callx4_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_entry_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_entry_encode_fns[] = {
   Opcode_entry_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_movsp_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movsp_encode_fns[] = {
   Opcode_movsp_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rotw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rotw_encode_fns[] = {
   Opcode_rotw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_retw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_retw_encode_fns[] = {
   Opcode_retw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_retw_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_retw_n_encode_fns[] = {
   0, 0, Opcode_retw_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rfwo_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rfwo_encode_fns[] = {
   Opcode_rfwo_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rfwu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rfwu_encode_fns[] = {
   Opcode_rfwu_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_l32e_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l32e_encode_fns[] = {
   Opcode_l32e_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_s32e_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_s32e_encode_fns[] = {
   Opcode_s32e_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_windowbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_windowbase_encode_fns[] = {
   Opcode_rsr_windowbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_windowbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_windowbase_encode_fns[] = {
   Opcode_wsr_windowbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_windowbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_windowbase_encode_fns[] = {
   Opcode_xsr_windowbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_windowstart_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_windowstart_encode_fns[] = {
   Opcode_rsr_windowstart_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_windowstart_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_windowstart_encode_fns[] = {
   Opcode_wsr_windowstart_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_windowstart_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_windowstart_encode_fns[] = {
   Opcode_xsr_windowstart_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_add_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_add_n_encode_fns[] = {
   0, Opcode_add_n_Slot_inst16a_encode, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_addi_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_addi_n_encode_fns[] = {
   0, Opcode_addi_n_Slot_inst16a_encode, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_beqz_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_beqz_n_encode_fns[] = {
   0, 0, Opcode_beqz_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_bnez_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bnez_n_encode_fns[] = {
   0, 0, Opcode_bnez_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ill_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ill_n_encode_fns[] = {
   0, 0, Opcode_ill_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_l32i_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l32i_n_encode_fns[] = {
   0, Opcode_l32i_n_Slot_inst16a_encode, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_mov_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_mov_n_encode_fns[] = {
   0, 0, Opcode_mov_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_movi_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movi_n_encode_fns[] = {
   0, 0, Opcode_movi_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_nop_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_nop_n_encode_fns[] = {
   0, 0, Opcode_nop_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ret_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ret_n_encode_fns[] = {
   0, 0, Opcode_ret_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_s32i_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_s32i_n_encode_fns[] = {
   0, Opcode_s32i_n_Slot_inst16a_encode, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_threadptr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_threadptr_encode_fns[] = {
   Opcode_rur_threadptr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_threadptr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_threadptr_encode_fns[] = {
   Opcode_wur_threadptr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_addi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_addi_encode_fns[] = {
   Opcode_addi_Slot_inst_encode, 0, 0, 0, Opcode_addi_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_addmi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_addmi_encode_fns[] = {
   Opcode_addmi_Slot_inst_encode, 0, 0, 0, Opcode_addmi_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_add_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_add_encode_fns[] = {
   Opcode_add_Slot_inst_encode, 0, 0, 0, Opcode_add_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_sub_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_sub_encode_fns[] = {
   Opcode_sub_Slot_inst_encode, 0, 0, 0, Opcode_sub_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_addx2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_addx2_encode_fns[] = {
   Opcode_addx2_Slot_inst_encode, 0, 0, 0, Opcode_addx2_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_addx4_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_addx4_encode_fns[] = {
   Opcode_addx4_Slot_inst_encode, 0, 0, 0, Opcode_addx4_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_addx8_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_addx8_encode_fns[] = {
   Opcode_addx8_Slot_inst_encode, 0, 0, 0, Opcode_addx8_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_subx2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_subx2_encode_fns[] = {
   Opcode_subx2_Slot_inst_encode, 0, 0, 0, Opcode_subx2_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_subx4_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_subx4_encode_fns[] = {
   Opcode_subx4_Slot_inst_encode, 0, 0, 0, Opcode_subx4_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_subx8_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_subx8_encode_fns[] = {
   Opcode_subx8_Slot_inst_encode, 0, 0, 0, Opcode_subx8_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_and_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_and_encode_fns[] = {
   Opcode_and_Slot_inst_encode, 0, 0, 0, Opcode_and_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_or_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_or_encode_fns[] = {
   Opcode_or_Slot_inst_encode, 0, 0, 0, Opcode_or_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_xor_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xor_encode_fns[] = {
   Opcode_xor_Slot_inst_encode, 0, 0, 0, Opcode_xor_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_beqi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_beqi_encode_fns[] = {
   Opcode_beqi_Slot_inst_encode, 0, 0, 0, Opcode_beqi_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bnei_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bnei_encode_fns[] = {
   Opcode_bnei_Slot_inst_encode, 0, 0, 0, Opcode_bnei_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bgei_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bgei_encode_fns[] = {
   Opcode_bgei_Slot_inst_encode, 0, 0, 0, Opcode_bgei_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_blti_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_blti_encode_fns[] = {
   Opcode_blti_Slot_inst_encode, 0, 0, 0, Opcode_blti_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bbci_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bbci_encode_fns[] = {
   Opcode_bbci_Slot_inst_encode, 0, 0, 0, Opcode_bbci_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bbsi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bbsi_encode_fns[] = {
   Opcode_bbsi_Slot_inst_encode, 0, 0, 0, Opcode_bbsi_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bgeui_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bgeui_encode_fns[] = {
   Opcode_bgeui_Slot_inst_encode, 0, 0, 0, Opcode_bgeui_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bltui_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bltui_encode_fns[] = {
   Opcode_bltui_Slot_inst_encode, 0, 0, 0, Opcode_bltui_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_beq_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_beq_encode_fns[] = {
   Opcode_beq_Slot_inst_encode, 0, 0, 0, Opcode_beq_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bne_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bne_encode_fns[] = {
   Opcode_bne_Slot_inst_encode, 0, 0, 0, Opcode_bne_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bge_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bge_encode_fns[] = {
   Opcode_bge_Slot_inst_encode, 0, 0, 0, Opcode_bge_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_blt_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_blt_encode_fns[] = {
   Opcode_blt_Slot_inst_encode, 0, 0, 0, Opcode_blt_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bgeu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bgeu_encode_fns[] = {
   Opcode_bgeu_Slot_inst_encode, 0, 0, 0, Opcode_bgeu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bltu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bltu_encode_fns[] = {
   Opcode_bltu_Slot_inst_encode, 0, 0, 0, Opcode_bltu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bany_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bany_encode_fns[] = {
   Opcode_bany_Slot_inst_encode, 0, 0, 0, Opcode_bany_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bnone_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bnone_encode_fns[] = {
   Opcode_bnone_Slot_inst_encode, 0, 0, 0, Opcode_bnone_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ball_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ball_encode_fns[] = {
   Opcode_ball_Slot_inst_encode, 0, 0, 0, Opcode_ball_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bnall_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bnall_encode_fns[] = {
   Opcode_bnall_Slot_inst_encode, 0, 0, 0, Opcode_bnall_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bbc_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bbc_encode_fns[] = {
   Opcode_bbc_Slot_inst_encode, 0, 0, 0, Opcode_bbc_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bbs_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bbs_encode_fns[] = {
   Opcode_bbs_Slot_inst_encode, 0, 0, 0, Opcode_bbs_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_beqz_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_beqz_encode_fns[] = {
   Opcode_beqz_Slot_inst_encode, 0, 0, 0, Opcode_beqz_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bnez_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bnez_encode_fns[] = {
   Opcode_bnez_Slot_inst_encode, 0, 0, 0, Opcode_bnez_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bgez_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bgez_encode_fns[] = {
   Opcode_bgez_Slot_inst_encode, 0, 0, 0, Opcode_bgez_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bltz_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bltz_encode_fns[] = {
   Opcode_bltz_Slot_inst_encode, 0, 0, 0, Opcode_bltz_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_call0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_call0_encode_fns[] = {
   Opcode_call0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_callx0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_callx0_encode_fns[] = {
   Opcode_callx0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_extui_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_extui_encode_fns[] = {
   Opcode_extui_Slot_inst_encode, 0, 0, 0, Opcode_extui_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ill_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ill_encode_fns[] = {
   Opcode_ill_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_j_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_j_encode_fns[] = {
   Opcode_j_Slot_inst_encode, 0, 0, 0, Opcode_j_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_jx_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_jx_encode_fns[] = {
   Opcode_jx_Slot_inst_encode, 0, 0, 0, Opcode_jx_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_l16ui_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l16ui_encode_fns[] = {
   Opcode_l16ui_Slot_inst_encode, 0, 0, 0, Opcode_l16ui_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_l16si_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l16si_encode_fns[] = {
   Opcode_l16si_Slot_inst_encode, 0, 0, 0, Opcode_l16si_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_l32i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l32i_encode_fns[] = {
   Opcode_l32i_Slot_inst_encode, 0, 0, 0, Opcode_l32i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_l32r_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l32r_encode_fns[] = {
   Opcode_l32r_Slot_inst_encode, 0, 0, 0, Opcode_l32r_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_l8ui_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l8ui_encode_fns[] = {
   Opcode_l8ui_Slot_inst_encode, 0, 0, 0, Opcode_l8ui_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_loop_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_loop_encode_fns[] = {
   Opcode_loop_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_loopnez_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_loopnez_encode_fns[] = {
   Opcode_loopnez_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_loopgtz_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_loopgtz_encode_fns[] = {
   Opcode_loopgtz_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_movi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movi_encode_fns[] = {
   Opcode_movi_Slot_inst_encode, 0, 0, 0, Opcode_movi_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_moveqz_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_moveqz_encode_fns[] = {
   Opcode_moveqz_Slot_inst_encode, 0, 0, 0, Opcode_moveqz_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_movnez_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movnez_encode_fns[] = {
   Opcode_movnez_Slot_inst_encode, 0, 0, 0, Opcode_movnez_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_movltz_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movltz_encode_fns[] = {
   Opcode_movltz_Slot_inst_encode, 0, 0, 0, Opcode_movltz_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_movgez_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movgez_encode_fns[] = {
   Opcode_movgez_Slot_inst_encode, 0, 0, 0, Opcode_movgez_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_neg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_neg_encode_fns[] = {
   Opcode_neg_Slot_inst_encode, 0, 0, 0, Opcode_neg_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_abs_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_abs_encode_fns[] = {
   Opcode_abs_Slot_inst_encode, 0, 0, 0, Opcode_abs_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_nop_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_nop_encode_fns[] = {
   Opcode_nop_Slot_inst_encode, 0, 0, Opcode_nop_Slot_ae_slot1_encode, Opcode_nop_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ret_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ret_encode_fns[] = {
   Opcode_ret_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_s16i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_s16i_encode_fns[] = {
   Opcode_s16i_Slot_inst_encode, 0, 0, 0, Opcode_s16i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_s32i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_s32i_encode_fns[] = {
   Opcode_s32i_Slot_inst_encode, 0, 0, 0, Opcode_s32i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_s8i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_s8i_encode_fns[] = {
   Opcode_s8i_Slot_inst_encode, 0, 0, 0, Opcode_s8i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ssr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ssr_encode_fns[] = {
   Opcode_ssr_Slot_inst_encode, 0, 0, 0, Opcode_ssr_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ssl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ssl_encode_fns[] = {
   Opcode_ssl_Slot_inst_encode, 0, 0, 0, Opcode_ssl_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ssa8l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ssa8l_encode_fns[] = {
   Opcode_ssa8l_Slot_inst_encode, 0, 0, 0, Opcode_ssa8l_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ssa8b_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ssa8b_encode_fns[] = {
   Opcode_ssa8b_Slot_inst_encode, 0, 0, 0, Opcode_ssa8b_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ssai_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ssai_encode_fns[] = {
   Opcode_ssai_Slot_inst_encode, 0, 0, 0, Opcode_ssai_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_sll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_sll_encode_fns[] = {
   Opcode_sll_Slot_inst_encode, 0, 0, 0, Opcode_sll_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_src_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_src_encode_fns[] = {
   Opcode_src_Slot_inst_encode, 0, 0, 0, Opcode_src_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_srl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_srl_encode_fns[] = {
   Opcode_srl_Slot_inst_encode, 0, 0, 0, Opcode_srl_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_sra_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_sra_encode_fns[] = {
   Opcode_sra_Slot_inst_encode, 0, 0, 0, Opcode_sra_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_slli_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_slli_encode_fns[] = {
   Opcode_slli_Slot_inst_encode, 0, 0, 0, Opcode_slli_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_srai_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_srai_encode_fns[] = {
   Opcode_srai_Slot_inst_encode, 0, 0, 0, Opcode_srai_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_srli_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_srli_encode_fns[] = {
   Opcode_srli_Slot_inst_encode, 0, 0, 0, Opcode_srli_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_memw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_memw_encode_fns[] = {
   Opcode_memw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_extw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_extw_encode_fns[] = {
   Opcode_extw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_isync_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_isync_encode_fns[] = {
   Opcode_isync_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsync_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsync_encode_fns[] = {
   Opcode_rsync_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_esync_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_esync_encode_fns[] = {
   Opcode_esync_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dsync_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dsync_encode_fns[] = {
   Opcode_dsync_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsil_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsil_encode_fns[] = {
   Opcode_rsil_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_lend_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_lend_encode_fns[] = {
   Opcode_rsr_lend_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_lend_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_lend_encode_fns[] = {
   Opcode_wsr_lend_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_lend_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_lend_encode_fns[] = {
   Opcode_xsr_lend_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_lcount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_lcount_encode_fns[] = {
   Opcode_rsr_lcount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_lcount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_lcount_encode_fns[] = {
   Opcode_wsr_lcount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_lcount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_lcount_encode_fns[] = {
   Opcode_xsr_lcount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_lbeg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_lbeg_encode_fns[] = {
   Opcode_rsr_lbeg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_lbeg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_lbeg_encode_fns[] = {
   Opcode_wsr_lbeg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_lbeg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_lbeg_encode_fns[] = {
   Opcode_xsr_lbeg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_sar_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_sar_encode_fns[] = {
   Opcode_rsr_sar_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_sar_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_sar_encode_fns[] = {
   Opcode_wsr_sar_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_sar_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_sar_encode_fns[] = {
   Opcode_xsr_sar_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_litbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_litbase_encode_fns[] = {
   Opcode_rsr_litbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_litbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_litbase_encode_fns[] = {
   Opcode_wsr_litbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_litbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_litbase_encode_fns[] = {
   Opcode_xsr_litbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_176_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_176_encode_fns[] = {
   Opcode_rsr_176_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_176_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_176_encode_fns[] = {
   Opcode_wsr_176_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_208_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_208_encode_fns[] = {
   Opcode_rsr_208_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_ps_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_ps_encode_fns[] = {
   Opcode_rsr_ps_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_ps_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_ps_encode_fns[] = {
   Opcode_wsr_ps_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_ps_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_ps_encode_fns[] = {
   Opcode_xsr_ps_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_epc1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_epc1_encode_fns[] = {
   Opcode_rsr_epc1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_epc1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_epc1_encode_fns[] = {
   Opcode_wsr_epc1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_epc1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_epc1_encode_fns[] = {
   Opcode_xsr_epc1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_excsave1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_excsave1_encode_fns[] = {
   Opcode_rsr_excsave1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_excsave1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_excsave1_encode_fns[] = {
   Opcode_wsr_excsave1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_excsave1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_excsave1_encode_fns[] = {
   Opcode_xsr_excsave1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_epc2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_epc2_encode_fns[] = {
   Opcode_rsr_epc2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_epc2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_epc2_encode_fns[] = {
   Opcode_wsr_epc2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_epc2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_epc2_encode_fns[] = {
   Opcode_xsr_epc2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_excsave2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_excsave2_encode_fns[] = {
   Opcode_rsr_excsave2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_excsave2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_excsave2_encode_fns[] = {
   Opcode_wsr_excsave2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_excsave2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_excsave2_encode_fns[] = {
   Opcode_xsr_excsave2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_eps2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_eps2_encode_fns[] = {
   Opcode_rsr_eps2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_eps2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_eps2_encode_fns[] = {
   Opcode_wsr_eps2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_eps2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_eps2_encode_fns[] = {
   Opcode_xsr_eps2_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_excvaddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_excvaddr_encode_fns[] = {
   Opcode_rsr_excvaddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_excvaddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_excvaddr_encode_fns[] = {
   Opcode_wsr_excvaddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_excvaddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_excvaddr_encode_fns[] = {
   Opcode_xsr_excvaddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_depc_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_depc_encode_fns[] = {
   Opcode_rsr_depc_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_depc_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_depc_encode_fns[] = {
   Opcode_wsr_depc_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_depc_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_depc_encode_fns[] = {
   Opcode_xsr_depc_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_exccause_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_exccause_encode_fns[] = {
   Opcode_rsr_exccause_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_exccause_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_exccause_encode_fns[] = {
   Opcode_wsr_exccause_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_exccause_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_exccause_encode_fns[] = {
   Opcode_xsr_exccause_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_misc0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_misc0_encode_fns[] = {
   Opcode_rsr_misc0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_misc0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_misc0_encode_fns[] = {
   Opcode_wsr_misc0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_misc0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_misc0_encode_fns[] = {
   Opcode_xsr_misc0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_misc1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_misc1_encode_fns[] = {
   Opcode_rsr_misc1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_misc1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_misc1_encode_fns[] = {
   Opcode_wsr_misc1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_misc1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_misc1_encode_fns[] = {
   Opcode_xsr_misc1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_prid_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_prid_encode_fns[] = {
   Opcode_rsr_prid_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_vecbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_vecbase_encode_fns[] = {
   Opcode_rsr_vecbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_vecbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_vecbase_encode_fns[] = {
   Opcode_wsr_vecbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_vecbase_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_vecbase_encode_fns[] = {
   Opcode_xsr_vecbase_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_mul16u_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_mul16u_encode_fns[] = {
   Opcode_mul16u_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_mul16s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_mul16s_encode_fns[] = {
   Opcode_mul16s_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_mull_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_mull_encode_fns[] = {
   Opcode_mull_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rfi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rfi_encode_fns[] = {
   Opcode_rfi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_waiti_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_waiti_encode_fns[] = {
   Opcode_waiti_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_interrupt_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_interrupt_encode_fns[] = {
   Opcode_rsr_interrupt_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_intset_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_intset_encode_fns[] = {
   Opcode_wsr_intset_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_intclear_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_intclear_encode_fns[] = {
   Opcode_wsr_intclear_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_intenable_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_intenable_encode_fns[] = {
   Opcode_rsr_intenable_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_intenable_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_intenable_encode_fns[] = {
   Opcode_wsr_intenable_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_intenable_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_intenable_encode_fns[] = {
   Opcode_xsr_intenable_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_break_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_break_encode_fns[] = {
   Opcode_break_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_break_n_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_break_n_encode_fns[] = {
   0, 0, Opcode_break_n_Slot_inst16b_encode, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_debugcause_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_debugcause_encode_fns[] = {
   Opcode_rsr_debugcause_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_debugcause_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_debugcause_encode_fns[] = {
   Opcode_wsr_debugcause_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_debugcause_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_debugcause_encode_fns[] = {
   Opcode_xsr_debugcause_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_icount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_icount_encode_fns[] = {
   Opcode_rsr_icount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_icount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_icount_encode_fns[] = {
   Opcode_wsr_icount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_icount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_icount_encode_fns[] = {
   Opcode_xsr_icount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_icountlevel_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_icountlevel_encode_fns[] = {
   Opcode_rsr_icountlevel_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_icountlevel_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_icountlevel_encode_fns[] = {
   Opcode_wsr_icountlevel_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_icountlevel_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_icountlevel_encode_fns[] = {
   Opcode_xsr_icountlevel_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_ddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_ddr_encode_fns[] = {
   Opcode_rsr_ddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_ddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_ddr_encode_fns[] = {
   Opcode_wsr_ddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_ddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_ddr_encode_fns[] = {
   Opcode_xsr_ddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rfdo_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rfdo_encode_fns[] = {
   Opcode_rfdo_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rfdd_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rfdd_encode_fns[] = {
   Opcode_rfdd_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_andb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_andb_encode_fns[] = {
   Opcode_andb_Slot_inst_encode, 0, 0, 0, Opcode_andb_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_andbc_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_andbc_encode_fns[] = {
   Opcode_andbc_Slot_inst_encode, 0, 0, 0, Opcode_andbc_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_orb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_orb_encode_fns[] = {
   Opcode_orb_Slot_inst_encode, 0, 0, 0, Opcode_orb_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_orbc_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_orbc_encode_fns[] = {
   Opcode_orbc_Slot_inst_encode, 0, 0, 0, Opcode_orbc_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_xorb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xorb_encode_fns[] = {
   Opcode_xorb_Slot_inst_encode, 0, 0, 0, Opcode_xorb_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_any4_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_any4_encode_fns[] = {
   Opcode_any4_Slot_inst_encode, 0, 0, 0, Opcode_any4_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_all4_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_all4_encode_fns[] = {
   Opcode_all4_Slot_inst_encode, 0, 0, 0, Opcode_all4_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_any8_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_any8_encode_fns[] = {
   Opcode_any8_Slot_inst_encode, 0, 0, 0, Opcode_any8_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_all8_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_all8_encode_fns[] = {
   Opcode_all8_Slot_inst_encode, 0, 0, 0, Opcode_all8_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bf_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bf_encode_fns[] = {
   Opcode_bf_Slot_inst_encode, 0, 0, 0, Opcode_bf_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_bt_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_bt_encode_fns[] = {
   Opcode_bt_Slot_inst_encode, 0, 0, 0, Opcode_bt_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_movf_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movf_encode_fns[] = {
   Opcode_movf_Slot_inst_encode, 0, 0, 0, Opcode_movf_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_movt_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_movt_encode_fns[] = {
   Opcode_movt_Slot_inst_encode, 0, 0, 0, Opcode_movt_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_br_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_br_encode_fns[] = {
   Opcode_rsr_br_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_br_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_br_encode_fns[] = {
   Opcode_wsr_br_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_br_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_br_encode_fns[] = {
   Opcode_xsr_br_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_ccount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_ccount_encode_fns[] = {
   Opcode_rsr_ccount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_ccount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_ccount_encode_fns[] = {
   Opcode_wsr_ccount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_ccount_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_ccount_encode_fns[] = {
   Opcode_xsr_ccount_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_ccompare0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_ccompare0_encode_fns[] = {
   Opcode_rsr_ccompare0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_ccompare0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_ccompare0_encode_fns[] = {
   Opcode_wsr_ccompare0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_ccompare0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_ccompare0_encode_fns[] = {
   Opcode_xsr_ccompare0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_ccompare1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_ccompare1_encode_fns[] = {
   Opcode_rsr_ccompare1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_ccompare1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_ccompare1_encode_fns[] = {
   Opcode_wsr_ccompare1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_ccompare1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_ccompare1_encode_fns[] = {
   Opcode_xsr_ccompare1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ipf_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ipf_encode_fns[] = {
   Opcode_ipf_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ihi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ihi_encode_fns[] = {
   Opcode_ihi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_iii_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_iii_encode_fns[] = {
   Opcode_iii_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_lict_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_lict_encode_fns[] = {
   Opcode_lict_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_licw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_licw_encode_fns[] = {
   Opcode_licw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_sict_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_sict_encode_fns[] = {
   Opcode_sict_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_sicw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_sicw_encode_fns[] = {
   Opcode_sicw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dhwb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dhwb_encode_fns[] = {
   Opcode_dhwb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dhwbi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dhwbi_encode_fns[] = {
   Opcode_dhwbi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_diwb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_diwb_encode_fns[] = {
   Opcode_diwb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_diwbi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_diwbi_encode_fns[] = {
   Opcode_diwbi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dhi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dhi_encode_fns[] = {
   Opcode_dhi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dii_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dii_encode_fns[] = {
   Opcode_dii_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dpfr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dpfr_encode_fns[] = {
   Opcode_dpfr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dpfw_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dpfw_encode_fns[] = {
   Opcode_dpfw_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dpfro_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dpfro_encode_fns[] = {
   Opcode_dpfro_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_dpfwo_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_dpfwo_encode_fns[] = {
   Opcode_dpfwo_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_sdct_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_sdct_encode_fns[] = {
   Opcode_sdct_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ldct_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ldct_encode_fns[] = {
   Opcode_ldct_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_ptevaddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_ptevaddr_encode_fns[] = {
   Opcode_wsr_ptevaddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_ptevaddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_ptevaddr_encode_fns[] = {
   Opcode_rsr_ptevaddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_ptevaddr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_ptevaddr_encode_fns[] = {
   Opcode_xsr_ptevaddr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_rasid_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_rasid_encode_fns[] = {
   Opcode_rsr_rasid_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_rasid_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_rasid_encode_fns[] = {
   Opcode_wsr_rasid_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_rasid_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_rasid_encode_fns[] = {
   Opcode_xsr_rasid_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_itlbcfg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_itlbcfg_encode_fns[] = {
   Opcode_rsr_itlbcfg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_itlbcfg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_itlbcfg_encode_fns[] = {
   Opcode_wsr_itlbcfg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_itlbcfg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_itlbcfg_encode_fns[] = {
   Opcode_xsr_itlbcfg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_dtlbcfg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_dtlbcfg_encode_fns[] = {
   Opcode_rsr_dtlbcfg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_dtlbcfg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_dtlbcfg_encode_fns[] = {
   Opcode_wsr_dtlbcfg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_dtlbcfg_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_dtlbcfg_encode_fns[] = {
   Opcode_xsr_dtlbcfg_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_idtlb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_idtlb_encode_fns[] = {
   Opcode_idtlb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_pdtlb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_pdtlb_encode_fns[] = {
   Opcode_pdtlb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rdtlb0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rdtlb0_encode_fns[] = {
   Opcode_rdtlb0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rdtlb1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rdtlb1_encode_fns[] = {
   Opcode_rdtlb1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wdtlb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wdtlb_encode_fns[] = {
   Opcode_wdtlb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_iitlb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_iitlb_encode_fns[] = {
   Opcode_iitlb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_pitlb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_pitlb_encode_fns[] = {
   Opcode_pitlb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ritlb0_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ritlb0_encode_fns[] = {
   Opcode_ritlb0_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ritlb1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ritlb1_encode_fns[] = {
   Opcode_ritlb1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_witlb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_witlb_encode_fns[] = {
   Opcode_witlb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ldpte_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ldpte_encode_fns[] = {
   Opcode_ldpte_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_hwwitlba_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_hwwitlba_encode_fns[] = {
   Opcode_hwwitlba_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_hwwdtlba_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_hwwdtlba_encode_fns[] = {
   Opcode_hwwdtlba_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_cpenable_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_cpenable_encode_fns[] = {
   Opcode_rsr_cpenable_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_cpenable_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_cpenable_encode_fns[] = {
   Opcode_wsr_cpenable_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_cpenable_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_cpenable_encode_fns[] = {
   Opcode_xsr_cpenable_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_clamps_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_clamps_encode_fns[] = {
   Opcode_clamps_Slot_inst_encode, 0, 0, 0, Opcode_clamps_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_min_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_min_encode_fns[] = {
   Opcode_min_Slot_inst_encode, 0, 0, 0, Opcode_min_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_max_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_max_encode_fns[] = {
   Opcode_max_Slot_inst_encode, 0, 0, 0, Opcode_max_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_minu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_minu_encode_fns[] = {
   Opcode_minu_Slot_inst_encode, 0, 0, 0, Opcode_minu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_maxu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_maxu_encode_fns[] = {
   Opcode_maxu_Slot_inst_encode, 0, 0, 0, Opcode_maxu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_nsa_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_nsa_encode_fns[] = {
   Opcode_nsa_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_nsau_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_nsau_encode_fns[] = {
   Opcode_nsau_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_sext_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_sext_encode_fns[] = {
   Opcode_sext_Slot_inst_encode, 0, 0, 0, Opcode_sext_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_l32ai_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_l32ai_encode_fns[] = {
   Opcode_l32ai_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_s32ri_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_s32ri_encode_fns[] = {
   Opcode_s32ri_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_s32c1i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_s32c1i_encode_fns[] = {
   Opcode_s32c1i_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_scompare1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_scompare1_encode_fns[] = {
   Opcode_rsr_scompare1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_scompare1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_scompare1_encode_fns[] = {
   Opcode_wsr_scompare1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_scompare1_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_scompare1_encode_fns[] = {
   Opcode_xsr_scompare1_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rsr_atomctl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rsr_atomctl_encode_fns[] = {
   Opcode_rsr_atomctl_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wsr_atomctl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wsr_atomctl_encode_fns[] = {
   Opcode_wsr_atomctl_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_xsr_atomctl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_xsr_atomctl_encode_fns[] = {
   Opcode_xsr_atomctl_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rer_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rer_encode_fns[] = {
   Opcode_rer_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wer_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wer_encode_fns[] = {
   Opcode_wer_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_ovf_sar_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_ovf_sar_encode_fns[] = {
   Opcode_rur_ae_ovf_sar_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_ovf_sar_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_ovf_sar_encode_fns[] = {
   Opcode_wur_ae_ovf_sar_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_bithead_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_bithead_encode_fns[] = {
   Opcode_rur_ae_bithead_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_bithead_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_bithead_encode_fns[] = {
   Opcode_wur_ae_bithead_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_ts_fts_bu_bp_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_ts_fts_bu_bp_encode_fns[] = {
   Opcode_rur_ae_ts_fts_bu_bp_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_ts_fts_bu_bp_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_ts_fts_bu_bp_encode_fns[] = {
   Opcode_wur_ae_ts_fts_bu_bp_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_sd_no_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_sd_no_encode_fns[] = {
   Opcode_rur_ae_sd_no_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_sd_no_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_sd_no_encode_fns[] = {
   Opcode_wur_ae_sd_no_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_overflow_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_overflow_encode_fns[] = {
   Opcode_rur_ae_overflow_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_overflow_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_overflow_encode_fns[] = {
   Opcode_wur_ae_overflow_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_sar_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_sar_encode_fns[] = {
   Opcode_rur_ae_sar_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_sar_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_sar_encode_fns[] = {
   Opcode_wur_ae_sar_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_bitptr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_bitptr_encode_fns[] = {
   Opcode_rur_ae_bitptr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_bitptr_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_bitptr_encode_fns[] = {
   Opcode_wur_ae_bitptr_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_bitsused_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_bitsused_encode_fns[] = {
   Opcode_rur_ae_bitsused_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_bitsused_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_bitsused_encode_fns[] = {
   Opcode_wur_ae_bitsused_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_tablesize_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_tablesize_encode_fns[] = {
   Opcode_rur_ae_tablesize_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_tablesize_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_tablesize_encode_fns[] = {
   Opcode_wur_ae_tablesize_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_first_ts_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_first_ts_encode_fns[] = {
   Opcode_rur_ae_first_ts_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_first_ts_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_first_ts_encode_fns[] = {
   Opcode_wur_ae_first_ts_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_nextoffset_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_nextoffset_encode_fns[] = {
   Opcode_rur_ae_nextoffset_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_nextoffset_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_nextoffset_encode_fns[] = {
   Opcode_wur_ae_nextoffset_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_rur_ae_searchdone_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_rur_ae_searchdone_encode_fns[] = {
   Opcode_rur_ae_searchdone_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_wur_ae_searchdone_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_wur_ae_searchdone_encode_fns[] = {
   Opcode_wur_ae_searchdone_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16f_i_encode_fns[] = {
   Opcode_ae_lp16f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16f_iu_encode_fns[] = {
   Opcode_ae_lp16f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16f_x_encode_fns[] = {
   Opcode_ae_lp16f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16f_xu_encode_fns[] = {
   Opcode_ae_lp16f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24_i_encode_fns[] = {
   Opcode_ae_lp24_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24_iu_encode_fns[] = {
   Opcode_ae_lp24_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24_x_encode_fns[] = {
   Opcode_ae_lp24_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24_xu_encode_fns[] = {
   Opcode_ae_lp24_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24f_i_encode_fns[] = {
   Opcode_ae_lp24f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24f_iu_encode_fns[] = {
   Opcode_ae_lp24f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24f_x_encode_fns[] = {
   Opcode_ae_lp24f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24f_xu_encode_fns[] = {
   Opcode_ae_lp24f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16x2f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16x2f_i_encode_fns[] = {
   Opcode_ae_lp16x2f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16x2f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16x2f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16x2f_iu_encode_fns[] = {
   Opcode_ae_lp16x2f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16x2f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16x2f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16x2f_x_encode_fns[] = {
   Opcode_ae_lp16x2f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16x2f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp16x2f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp16x2f_xu_encode_fns[] = {
   Opcode_ae_lp16x2f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp16x2f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2f_i_encode_fns[] = {
   Opcode_ae_lp24x2f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2f_iu_encode_fns[] = {
   Opcode_ae_lp24x2f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2f_x_encode_fns[] = {
   Opcode_ae_lp24x2f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2f_xu_encode_fns[] = {
   Opcode_ae_lp24x2f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2_i_encode_fns[] = {
   Opcode_ae_lp24x2_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2_iu_encode_fns[] = {
   Opcode_ae_lp24x2_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2_x_encode_fns[] = {
   Opcode_ae_lp24x2_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lp24x2_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lp24x2_xu_encode_fns[] = {
   Opcode_ae_lp24x2_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lp24x2_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16x2f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16x2f_i_encode_fns[] = {
   Opcode_ae_sp16x2f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16x2f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16x2f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16x2f_iu_encode_fns[] = {
   Opcode_ae_sp16x2f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16x2f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16x2f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16x2f_x_encode_fns[] = {
   Opcode_ae_sp16x2f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16x2f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16x2f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16x2f_xu_encode_fns[] = {
   Opcode_ae_sp16x2f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16x2f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2s_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2s_i_encode_fns[] = {
   Opcode_ae_sp24x2s_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2s_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2s_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2s_iu_encode_fns[] = {
   Opcode_ae_sp24x2s_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2s_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2s_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2s_x_encode_fns[] = {
   Opcode_ae_sp24x2s_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2s_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2s_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2s_xu_encode_fns[] = {
   Opcode_ae_sp24x2s_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2s_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2f_i_encode_fns[] = {
   Opcode_ae_sp24x2f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2f_iu_encode_fns[] = {
   Opcode_ae_sp24x2f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2f_x_encode_fns[] = {
   Opcode_ae_sp24x2f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24x2f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24x2f_xu_encode_fns[] = {
   Opcode_ae_sp24x2f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24x2f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16f_l_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16f_l_i_encode_fns[] = {
   Opcode_ae_sp16f_l_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16f_l_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16f_l_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16f_l_iu_encode_fns[] = {
   Opcode_ae_sp16f_l_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16f_l_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16f_l_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16f_l_x_encode_fns[] = {
   Opcode_ae_sp16f_l_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16f_l_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp16f_l_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp16f_l_xu_encode_fns[] = {
   Opcode_ae_sp16f_l_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp16f_l_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24s_l_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24s_l_i_encode_fns[] = {
   Opcode_ae_sp24s_l_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24s_l_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24s_l_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24s_l_iu_encode_fns[] = {
   Opcode_ae_sp24s_l_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24s_l_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24s_l_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24s_l_x_encode_fns[] = {
   Opcode_ae_sp24s_l_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24s_l_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24s_l_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24s_l_xu_encode_fns[] = {
   Opcode_ae_sp24s_l_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24s_l_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24f_l_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24f_l_i_encode_fns[] = {
   Opcode_ae_sp24f_l_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24f_l_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24f_l_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24f_l_iu_encode_fns[] = {
   Opcode_ae_sp24f_l_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24f_l_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24f_l_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24f_l_x_encode_fns[] = {
   Opcode_ae_sp24f_l_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24f_l_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sp24f_l_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sp24f_l_xu_encode_fns[] = {
   Opcode_ae_sp24f_l_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sp24f_l_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq56_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq56_i_encode_fns[] = {
   Opcode_ae_lq56_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq56_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq56_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq56_iu_encode_fns[] = {
   Opcode_ae_lq56_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq56_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq56_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq56_x_encode_fns[] = {
   Opcode_ae_lq56_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq56_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq56_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq56_xu_encode_fns[] = {
   Opcode_ae_lq56_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq56_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq32f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq32f_i_encode_fns[] = {
   Opcode_ae_lq32f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq32f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq32f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq32f_iu_encode_fns[] = {
   Opcode_ae_lq32f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq32f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq32f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq32f_x_encode_fns[] = {
   Opcode_ae_lq32f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq32f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lq32f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lq32f_xu_encode_fns[] = {
   Opcode_ae_lq32f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_lq32f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq56s_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq56s_i_encode_fns[] = {
   Opcode_ae_sq56s_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq56s_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq56s_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq56s_iu_encode_fns[] = {
   Opcode_ae_sq56s_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq56s_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq56s_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq56s_x_encode_fns[] = {
   Opcode_ae_sq56s_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq56s_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq56s_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq56s_xu_encode_fns[] = {
   Opcode_ae_sq56s_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq56s_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq32f_i_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq32f_i_encode_fns[] = {
   Opcode_ae_sq32f_i_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq32f_i_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq32f_iu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq32f_iu_encode_fns[] = {
   Opcode_ae_sq32f_iu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq32f_iu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq32f_x_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq32f_x_encode_fns[] = {
   Opcode_ae_sq32f_x_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq32f_x_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sq32f_xu_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sq32f_xu_encode_fns[] = {
   Opcode_ae_sq32f_xu_Slot_inst_encode, 0, 0, 0, Opcode_ae_sq32f_xu_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_zerop48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_zerop48_encode_fns[] = {
   0, 0, 0, Opcode_ae_zerop48_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movp48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movp48_encode_fns[] = {
   Opcode_ae_movp48_Slot_inst_encode, 0, 0, Opcode_ae_movp48_Slot_ae_slot1_encode, Opcode_ae_movp48_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_selp24_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_selp24_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_selp24_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_selp24_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_selp24_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_selp24_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_selp24_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_selp24_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_selp24_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_selp24_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_selp24_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_selp24_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movtp24x2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movtp24x2_encode_fns[] = {
   0, 0, 0, Opcode_ae_movtp24x2_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movfp24x2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movfp24x2_encode_fns[] = {
   0, 0, 0, Opcode_ae_movfp24x2_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movtp48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movtp48_encode_fns[] = {
   0, 0, 0, Opcode_ae_movtp48_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movfp48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movfp48_encode_fns[] = {
   0, 0, 0, Opcode_ae_movfp48_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movpa24x2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movpa24x2_encode_fns[] = {
   Opcode_ae_movpa24x2_Slot_inst_encode, 0, 0, 0, Opcode_ae_movpa24x2_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_truncp24a32x2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_truncp24a32x2_encode_fns[] = {
   Opcode_ae_truncp24a32x2_Slot_inst_encode, 0, 0, 0, Opcode_ae_truncp24a32x2_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvta32p24_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvta32p24_l_encode_fns[] = {
   Opcode_ae_cvta32p24_l_Slot_inst_encode, 0, 0, 0, Opcode_ae_cvta32p24_l_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvta32p24_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvta32p24_h_encode_fns[] = {
   Opcode_ae_cvta32p24_h_Slot_inst_encode, 0, 0, 0, Opcode_ae_cvta32p24_h_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_ll_encode_fns[] = {
   Opcode_ae_cvtp24a16x2_ll_Slot_inst_encode, 0, 0, 0, Opcode_ae_cvtp24a16x2_ll_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_lh_encode_fns[] = {
   Opcode_ae_cvtp24a16x2_lh_Slot_inst_encode, 0, 0, 0, Opcode_ae_cvtp24a16x2_lh_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_hl_encode_fns[] = {
   Opcode_ae_cvtp24a16x2_hl_Slot_inst_encode, 0, 0, 0, Opcode_ae_cvtp24a16x2_hl_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvtp24a16x2_hh_encode_fns[] = {
   Opcode_ae_cvtp24a16x2_hh_Slot_inst_encode, 0, 0, 0, Opcode_ae_cvtp24a16x2_hh_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_truncp24q48x2_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_truncp24q48x2_encode_fns[] = {
   0, 0, 0, Opcode_ae_truncp24q48x2_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_truncp16_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_truncp16_encode_fns[] = {
   0, 0, 0, Opcode_ae_truncp16_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsp24q48sym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsp24q48sym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsp24q48sym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsp24q48asym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsp24q48asym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsp24q48asym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsp16q48sym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsp16q48sym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsp16q48sym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsp16q48asym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsp16q48asym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsp16q48asym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsp16sym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsp16sym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsp16sym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsp16asym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsp16asym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsp16asym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_zeroq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_zeroq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_zeroq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movq56_encode_fns[] = {
   Opcode_ae_movq56_Slot_inst_encode, 0, 0, Opcode_ae_movq56_Slot_ae_slot1_encode, Opcode_ae_movq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movtq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movtq56_encode_fns[] = {
   Opcode_ae_movtq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_movtq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movfq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movfq56_encode_fns[] = {
   Opcode_ae_movfq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_movfq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvtq48a32s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvtq48a32s_encode_fns[] = {
   Opcode_ae_cvtq48a32s_Slot_inst_encode, 0, 0, 0, Opcode_ae_cvtq48a32s_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvtq48p24s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvtq48p24s_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_cvtq48p24s_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_cvtq48p24s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_cvtq48p24s_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_cvtq48p24s_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_satq48s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_satq48s_encode_fns[] = {
   0, 0, 0, Opcode_ae_satq48s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_truncq32_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_truncq32_encode_fns[] = {
   0, 0, 0, Opcode_ae_truncq32_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsq32sym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsq32sym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsq32sym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_roundsq32asym_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_roundsq32asym_encode_fns[] = {
   0, 0, 0, Opcode_ae_roundsq32asym_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_trunca32q48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_trunca32q48_encode_fns[] = {
   Opcode_ae_trunca32q48_Slot_inst_encode, 0, 0, 0, Opcode_ae_trunca32q48_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movap24s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movap24s_l_encode_fns[] = {
   Opcode_ae_movap24s_l_Slot_inst_encode, 0, 0, 0, Opcode_ae_movap24s_l_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_movap24s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_movap24s_h_encode_fns[] = {
   Opcode_ae_movap24s_h_Slot_inst_encode, 0, 0, 0, Opcode_ae_movap24s_h_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_trunca16p24s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_trunca16p24s_l_encode_fns[] = {
   Opcode_ae_trunca16p24s_l_Slot_inst_encode, 0, 0, 0, Opcode_ae_trunca16p24s_l_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_trunca16p24s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_trunca16p24s_h_encode_fns[] = {
   Opcode_ae_trunca16p24s_h_Slot_inst_encode, 0, 0, 0, Opcode_ae_trunca16p24s_h_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_addp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_addp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_addp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_subp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_subp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_subp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_negp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_negp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_negp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_absp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_absp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_absp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_maxp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_maxp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_maxp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_minp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_minp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_minp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_maxbp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_maxbp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_maxbp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_minbp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_minbp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_minbp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_addsp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_addsp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_addsp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_subsp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_subsp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_subsp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_negsp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_negsp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_negsp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_abssp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_abssp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_abssp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_andp48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_andp48_encode_fns[] = {
   0, 0, 0, Opcode_ae_andp48_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_nandp48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_nandp48_encode_fns[] = {
   0, 0, 0, Opcode_ae_nandp48_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_orp48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_orp48_encode_fns[] = {
   0, 0, 0, Opcode_ae_orp48_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_xorp48_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_xorp48_encode_fns[] = {
   0, 0, 0, Opcode_ae_xorp48_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_ltp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_ltp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_ltp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lep24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lep24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_lep24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_eqp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_eqp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_eqp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_addq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_addq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_addq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_subq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_subq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_subq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_negq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_negq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_negq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_absq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_absq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_absq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_maxq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_maxq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_maxq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_minq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_minq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_minq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_maxbq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_maxbq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_maxbq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_minbq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_minbq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_minbq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_addsq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_addsq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_addsq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_subsq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_subsq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_subsq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_negsq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_negsq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_negsq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_abssq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_abssq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_abssq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_andq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_andq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_andq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_nandq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_nandq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_nandq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_orq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_orq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_orq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_xorq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_xorq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_xorq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllip24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllip24_encode_fns[] = {
   0, 0, 0, Opcode_ae_sllip24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_srlip24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_srlip24_encode_fns[] = {
   0, 0, 0, Opcode_ae_srlip24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sraip24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sraip24_encode_fns[] = {
   0, 0, 0, Opcode_ae_sraip24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllsp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllsp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_sllsp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_srlsp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_srlsp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_srlsp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_srasp24_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_srasp24_encode_fns[] = {
   0, 0, 0, Opcode_ae_srasp24_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllisp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllisp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_sllisp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllssp24s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllssp24s_encode_fns[] = {
   0, 0, 0, Opcode_ae_sllssp24s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_slliq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_slliq56_encode_fns[] = {
   Opcode_ae_slliq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_slliq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_srliq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_srliq56_encode_fns[] = {
   Opcode_ae_srliq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_srliq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sraiq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sraiq56_encode_fns[] = {
   Opcode_ae_sraiq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_sraiq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllsq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllsq56_encode_fns[] = {
   Opcode_ae_sllsq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_sllsq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_srlsq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_srlsq56_encode_fns[] = {
   Opcode_ae_srlsq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_srlsq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_srasq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_srasq56_encode_fns[] = {
   Opcode_ae_srasq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_srasq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllaq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllaq56_encode_fns[] = {
   Opcode_ae_sllaq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_sllaq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_srlaq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_srlaq56_encode_fns[] = {
   Opcode_ae_srlaq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_srlaq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sraaq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sraaq56_encode_fns[] = {
   Opcode_ae_sraaq56_Slot_inst_encode, 0, 0, 0, Opcode_ae_sraaq56_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllisq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllisq56s_encode_fns[] = {
   Opcode_ae_sllisq56s_Slot_inst_encode, 0, 0, 0, Opcode_ae_sllisq56s_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllssq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllssq56s_encode_fns[] = {
   Opcode_ae_sllssq56s_Slot_inst_encode, 0, 0, 0, Opcode_ae_sllssq56s_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sllasq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sllasq56s_encode_fns[] = {
   Opcode_ae_sllasq56s_Slot_inst_encode, 0, 0, 0, Opcode_ae_sllasq56s_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_ltq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_ltq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_ltq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_leq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_leq56s_encode_fns[] = {
   0, 0, 0, Opcode_ae_leq56s_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_eqq56_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_eqq56_encode_fns[] = {
   0, 0, 0, Opcode_ae_eqq56_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_nsaq56s_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_nsaq56s_encode_fns[] = {
   Opcode_ae_nsaq56s_Slot_inst_encode, 0, 0, 0, Opcode_ae_nsaq56s_Slot_ae_slot0_encode
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfs32p16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfp24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfp24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfp24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulp24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulp24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulp24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfs32p16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfp24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfp24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfp24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulp24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulp24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulp24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfs32p16s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfp24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfp24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfp24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulp24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulp24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulp24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfs32p16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfs32p16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfp24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfp24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfp24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulp24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulp24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulp24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs32p16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafp24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafp24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafp24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulap24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulap24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulap24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs32p16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafp24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafp24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafp24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulap24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulap24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulap24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs32p16s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafp24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafp24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafp24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulap24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulap24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulap24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs32p16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs32p16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafp24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafp24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafp24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulap24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulap24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulap24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs32p16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfp24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsp24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsp24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsp24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs32p16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfp24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsp24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsp24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsp24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs32p16s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfp24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsp24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsp24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsp24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs32p16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs32p16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfp24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfp24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsp24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsp24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsp24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs56p24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulas56p24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs56p24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulas56p24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs56p24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulas56p24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafs56p24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafs56p24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulas56p24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulas56p24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs56p24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulss56p24s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs56p24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulss56p24s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs56p24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_hl_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_hl_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulss56p24s_hl_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfs56p24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfs56p24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulss56p24s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulss56p24s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16s_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfq32sp16s_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16s_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfq32sp16s_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16u_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16u_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfq32sp16u_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16u_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulfq32sp16u_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulfq32sp16u_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulq32sp16s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulq32sp16s_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulq32sp16s_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulq32sp16s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulq32sp16s_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulq32sp16s_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulq32sp16u_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulq32sp16u_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulq32sp16u_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulq32sp16u_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulq32sp16u_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulq32sp16u_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16s_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafq32sp16s_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16s_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafq32sp16s_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16u_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16u_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafq32sp16u_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16u_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulafq32sp16u_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulafq32sp16u_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16s_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaq32sp16s_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16s_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaq32sp16s_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16u_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16u_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaq32sp16u_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16u_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaq32sp16u_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaq32sp16u_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16s_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfq32sp16s_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16s_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfq32sp16s_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16u_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16u_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfq32sp16u_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16u_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsfq32sp16u_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsfq32sp16u_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16s_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16s_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsq32sp16s_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16s_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16s_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsq32sp16s_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16u_l_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16u_l_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsq32sp16u_l_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16u_h_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsq32sp16u_h_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsq32sp16u_h_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaaq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaaq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaaq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaaq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaaq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaaq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaaq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsaq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsaq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsaq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsaq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsaq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsaq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsaq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16s_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16s_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfq32sp16s_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16u_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16u_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfq32sp16u_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16s_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16s_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfq32sp16s_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16u_hh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16u_hh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfq32sp16u_hh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16s_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16s_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfq32sp16s_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16u_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfq32sp16u_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfq32sp16u_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaap24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaap24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaap24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaafp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaafp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaafp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzaap24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzaap24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzaap24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasfp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasfp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasfp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzasp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzasp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzasp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsap24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsap24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsap24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsafp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsafp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsafp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzsap24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzsap24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzsap24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssfp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssfp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssfp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulzssp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulzssp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulzssp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaafp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaafp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaafp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaap24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaap24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaap24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaafp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaafp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaafp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulaap24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulaap24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulaap24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulasfp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulasfp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulasfp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulasp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulasp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulasp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulasfp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulasfp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulasfp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulasp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulasp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulasp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsafp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsafp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsafp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsap24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsap24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsap24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsafp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsafp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsafp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulsap24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulsap24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulsap24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulssfp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulssfp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulssfp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulssp24s_hh_ll_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulssp24s_hh_ll_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulssp24s_hh_ll_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulssfp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulssfp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulssfp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_mulssp24s_hl_lh_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_mulssp24s_hl_lh_encode_fns[] = {
   0, 0, 0, Opcode_ae_mulssp24s_hl_lh_Slot_ae_slot1_encode, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sha32_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sha32_encode_fns[] = {
   Opcode_ae_sha32_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_vldl32t_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_vldl32t_encode_fns[] = {
   Opcode_ae_vldl32t_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_vldl16t_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_vldl16t_encode_fns[] = {
   Opcode_ae_vldl16t_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_vldl16c_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_vldl16c_encode_fns[] = {
   Opcode_ae_vldl16c_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_vldsht_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_vldsht_encode_fns[] = {
   Opcode_ae_vldsht_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lb_encode_fns[] = {
   Opcode_ae_lb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lbi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lbi_encode_fns[] = {
   Opcode_ae_lbi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lbk_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lbk_encode_fns[] = {
   Opcode_ae_lbk_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_lbki_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_lbki_encode_fns[] = {
   Opcode_ae_lbki_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_db_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_db_encode_fns[] = {
   Opcode_ae_db_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_dbi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_dbi_encode_fns[] = {
   Opcode_ae_dbi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_vlel32t_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_vlel32t_encode_fns[] = {
   Opcode_ae_vlel32t_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_vlel16t_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_vlel16t_encode_fns[] = {
   Opcode_ae_vlel16t_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sb_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sb_encode_fns[] = {
   Opcode_ae_sb_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sbi_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sbi_encode_fns[] = {
   Opcode_ae_sbi_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_vles16c_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_vles16c_encode_fns[] = {
   Opcode_ae_vles16c_Slot_inst_encode, 0, 0, 0, 0
 };
 
-xtensa_opcode_encode_fn Opcode_ae_sbf_encode_fns[] = {
+static xtensa_opcode_encode_fn Opcode_ae_sbf_encode_fns[] = {
   Opcode_ae_sbf_Slot_inst_encode, 0, 0, 0, 0
 };
 
@@ -30818,7 +30818,7 @@ Slot_inst_decode (const xtensa_insnbuf insn)
 	}
       break;
     }
-  return 0;
+  return XTENSA_UNDEFINED;
 }
 
 static int
@@ -30869,7 +30869,7 @@ Slot_inst16b_decode (const xtensa_insnbuf insn)
 	}
       break;
     }
-  return 0;
+  return XTENSA_UNDEFINED;
 }
 
 static int
@@ -30886,7 +30886,7 @@ Slot_inst16a_decode (const xtensa_insnbuf insn)
     case 11:
       return OPCODE_ADDI_N;
     }
-  return 0;
+  return XTENSA_UNDEFINED;
 }
 
 static int
@@ -31561,7 +31561,7 @@ Slot_ae_slot0_decode (const xtensa_insnbuf insn)
 	return OPCODE_BF;
       break;
     }
-  return 0;
+  return XTENSA_UNDEFINED;
 }
 
 static int
@@ -32279,7 +32279,7 @@ Slot_ae_slot1_decode (const xtensa_insnbuf insn)
 	return OPCODE_AE_MULZSSQ32SP16U_LL;
       break;
     }
-  return 0;
+  return XTENSA_UNDEFINED;
 }
 
 

-- 
2.11.0
