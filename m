Received: from eggs.gnu.org ([2001:4830:134:3::10]:51399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gC0Ti-0007Mq-Nr
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gC0Tc-000177-KY
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:52:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35386 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gC0Ta-0000Th-DP
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:51:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 15 Oct 2018 12:50:32 +0200
Message-Id: <1539600633-17726-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539600633-17726-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539600633-17726-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/3] target/mips: Add a comment before each CP0
 register section in cpu.h
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

Add a comment before each CP0 register section in CPUMIPSState
definition, thus visually separating these sections.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cd54073..37703ea 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -304,10 +304,16 @@ struct CPUMIPSState {
  * 7   TagLo             TagHi                               KScratch<n>
  *
  */
+/*
+ * CP0 Register 0
+ */
     int32_t CP0_Index;
     /* CP0_MVP* are per MVP registers. */
     int32_t CP0_VPControl;
 #define CP0VPCtl_DIS    0
+/*
+ * CP0 Register 1
+ */
     int32_t CP0_Random;
     int32_t CP0_VPEControl;
 #define CP0VPECo_YSI	21
@@ -348,7 +354,13 @@ struct CPUMIPSState {
 #define CP0VPEOpt_DWX2	2
 #define CP0VPEOpt_DWX1	1
 #define CP0VPEOpt_DWX0	0
+/*
+ * CP0 Register 2
+ */
     uint64_t CP0_EntryLo0;
+/*
+ * CP0 Register 3
+ */
     uint64_t CP0_EntryLo1;
 #if defined(TARGET_MIPS64)
 # define CP0EnLo_RI 63
@@ -359,8 +371,14 @@ struct CPUMIPSState {
 #endif
     int32_t CP0_GlobalNumber;
 #define CP0GN_VPId 0
+/*
+ * CP0 Register 4
+ */
     target_ulong CP0_Context;
     target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
+/*
+ * CP0 Register 5
+ */
     int32_t CP0_PageMask;
     int32_t CP0_PageGrain_rw_bitmask;
     int32_t CP0_PageGrain;
@@ -398,6 +416,9 @@ struct CPUMIPSState {
 #define CP0SC2_XR       56
 #define CP0SC2_XR_MASK  (0xFFULL << CP0SC2_XR)
 #define CP0SC2_MASK     (CP0SC_1GMASK | (CP0SC_1GMASK << 16) | CP0SC2_XR_MASK)
+/*
+ * CP0 Register 6
+ */
     int32_t CP0_Wired;
     int32_t CP0_SRSConf0_rw_bitmask;
     int32_t CP0_SRSConf0;
@@ -428,16 +449,34 @@ struct CPUMIPSState {
 #define CP0SRSC4_SRS15	20
 #define CP0SRSC4_SRS14	10
 #define CP0SRSC4_SRS13	0
+/*
+ * CP0 Register 7
+ */
     int32_t CP0_HWREna;
+/*
+ * CP0 Register 8
+ */
     target_ulong CP0_BadVAddr;
     uint32_t CP0_BadInstr;
     uint32_t CP0_BadInstrP;
     uint32_t CP0_BadInstrX;
+/*
+ * CP0 Register 9
+ */
     int32_t CP0_Count;
+/*
+ * CP0 Register 10
+ */
     target_ulong CP0_EntryHi;
 #define CP0EnHi_EHINV 10
     target_ulong CP0_EntryHi_ASID_mask;
+/*
+ * CP0 Register 11
+ */
     int32_t CP0_Compare;
+/*
+ * CP0 Register 12
+ */
     int32_t CP0_Status;
 #define CP0St_CU3   31
 #define CP0St_CU2   30
@@ -479,6 +518,9 @@ struct CPUMIPSState {
 #define CP0SRSMap_SSV2 8
 #define CP0SRSMap_SSV1 4
 #define CP0SRSMap_SSV0 0
+/*
+ * CP0 Register 13
+ */
     int32_t CP0_Cause;
 #define CP0Ca_BD   31
 #define CP0Ca_TI   30
@@ -490,12 +532,21 @@ struct CPUMIPSState {
 #define CP0Ca_IP    8
 #define CP0Ca_IP_mask 0x0000FF00
 #define CP0Ca_EC    2
+/*
+ * CP0 Register 14
+ */
     target_ulong CP0_EPC;
+/*
+ * CP0 Register 15
+ */
     int32_t CP0_PRid;
     target_ulong CP0_EBase;
     target_ulong CP0_EBaseWG_rw_bitmask;
 #define CP0EBase_WG 11
     target_ulong CP0_CMGCRBase;
+/*
+ * CP0 Register 16
+ */
     int32_t CP0_Config0;
 #define CP0C0_M    31
 #define CP0C0_K23  28    /* 30..28 */
@@ -612,6 +663,9 @@ struct CPUMIPSState {
     uint64_t CP0_MAAR[MIPS_MAAR_MAX];
     int32_t CP0_MAARI;
     /* XXX: Maybe make LLAddr per-TC? */
+/*
+ * CP0 Register 17
+ */
     uint64_t lladdr;
     target_ulong llval;
     target_ulong llnewval;
@@ -620,11 +674,23 @@ struct CPUMIPSState {
     target_ulong llreg;
     uint64_t CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
+/*
+ * CP0 Register 18
+ */
     target_ulong CP0_WatchLo[8];
+/*
+ * CP0 Register 19
+ */
     int32_t CP0_WatchHi[8];
 #define CP0WH_ASID 16
+/*
+ * CP0 Register 20
+ */
     target_ulong CP0_XContext;
     int32_t CP0_Framemask;
+/*
+ * CP0 Register 23
+ */
     int32_t CP0_Debug;
 #define CP0DB_DBD  31
 #define CP0DB_DM   30
@@ -644,18 +710,40 @@ struct CPUMIPSState {
 #define CP0DB_DDBL 2
 #define CP0DB_DBp  1
 #define CP0DB_DSS  0
+/*
+ * CP0 Register 24
+ */
     target_ulong CP0_DEPC;
+/*
+ * CP0 Register 25
+ */
     int32_t CP0_Performance0;
+/*
+ * CP0 Register 26
+ */
     int32_t CP0_ErrCtl;
 #define CP0EC_WST 29
 #define CP0EC_SPR 28
 #define CP0EC_ITC 26
+/*
+ * CP0 Register 28
+ */
     uint64_t CP0_TagLo;
     int32_t CP0_DataLo;
+/*
+ * CP0 Register 29
+ */
     int32_t CP0_TagHi;
     int32_t CP0_DataHi;
+/*
+ * CP0 Register 30
+ */
     target_ulong CP0_ErrorEPC;
+/*
+ * CP0 Register 31
+ */
     int32_t CP0_DESAVE;
+
     /* We waste some space so we can handle shadow registers like TCs. */
     TCState tcs[MIPS_SHADOW_SET_MAX];
     CPUMIPSFPUContext fpus[MIPS_FPU_MAX];
-- 
2.7.4
