Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00573C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90162077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90162077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItjs-00068J-0N
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:37:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0001dM-SH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdZ-0005WL-9C
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41167 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItdY-0004Av-TP
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 5621E1A2435;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 324861A242D;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 13:29:35 +0200
Message-Id: <1556018982-3715-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 1/8] target/mips: Add or remove space to fix
 checkpatch errors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423112935.-Kf8Ykh75NeV-x2bXgjaEUa914dzFUY_UmuVvELM2P0@z>

From: Jules Irenge <jbi.octave@gmail.com>

Add or remove space to fix errors issued by checkpatch.pl tool

"ERROR: spaces required around that..."
"ERROR: space required after that..."
"ERROR: space required before the open parenthesis"
"ERROR: space required after that..."
"ERROR: space prohibited between function name and open parenthesis"
"ERROR: code indent should never use tabs"
"ERROR: line over 90 characters"

within target/mips/cpu.h file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190413202818.13622-2-jbi.octave@gmail.com>
---
 target/mips/cpu.h | 177 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 95 insertions(+), 82 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a10eeb0..469f3ef 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -22,10 +22,10 @@ typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
 typedef union wr_t wr_t;
 union wr_t {
-    int8_t  b[MSA_WRLEN/8];
-    int16_t h[MSA_WRLEN/16];
-    int32_t w[MSA_WRLEN/32];
-    int64_t d[MSA_WRLEN/64];
+    int8_t  b[MSA_WRLEN / 8];
+    int16_t h[MSA_WRLEN / 16];
+    int32_t w[MSA_WRLEN / 32];
+    int64_t d[MSA_WRLEN / 64];
 };
 
 typedef union fpr_t fpr_t;
@@ -71,16 +71,29 @@ struct CPUMIPSFPUContext {
 #define FCR31_FS 24
 #define FCR31_ABS2008 19
 #define FCR31_NAN2008 18
-#define SET_FP_COND(num,env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while(0)
-#define CLEAR_FP_COND(num,env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while(0)
-#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | (((env).fcr31 >> 23) & 0x1))
+#define SET_FP_COND(num, env)     do { ((env).fcr31) |=                 \
+                                       ((num) ? (1 << ((num) + 24)) :   \
+                                                (1 << 23));             \
+                                     } while (0)
+#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &=                 \
+                                       ~((num) ? (1 << ((num) + 24)) :  \
+                                                 (1 << 23));            \
+                                     } while (0)
+#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) |        \
+                                 (((env).fcr31 >> 23) & 0x1))
 #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
 #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
 #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
-#define SET_FP_CAUSE(reg,v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while(0)
-#define SET_FP_ENABLE(reg,v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while(0)
-#define SET_FP_FLAGS(reg,v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while(0)
-#define UPDATE_FP_FLAGS(reg,v)   do { (reg) |= ((v & 0x1f) << 2); } while(0)
+#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | \
+                                               ((v & 0x3f) << 12);       \
+                                     } while (0)
+#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | \
+                                               ((v & 0x1f) << 7);        \
+                                     } while (0)
+#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | \
+                                               ((v & 0x1f) << 2);        \
+                                     } while (0)
+#define UPDATE_FP_FLAGS(reg, v)   do { (reg) |= ((v & 0x1f) << 2); } while (0)
 #define FP_INEXACT        1
 #define FP_UNDERFLOW      2
 #define FP_OVERFLOW       4
@@ -95,25 +108,25 @@ struct CPUMIPSFPUContext {
 typedef struct CPUMIPSMVPContext CPUMIPSMVPContext;
 struct CPUMIPSMVPContext {
     int32_t CP0_MVPControl;
-#define CP0MVPCo_CPA	3
-#define CP0MVPCo_STLB	2
-#define CP0MVPCo_VPC	1
-#define CP0MVPCo_EVP	0
+#define CP0MVPCo_CPA    3
+#define CP0MVPCo_STLB   2
+#define CP0MVPCo_VPC    1
+#define CP0MVPCo_EVP    0
     int32_t CP0_MVPConf0;
-#define CP0MVPC0_M	31
-#define CP0MVPC0_TLBS	29
-#define CP0MVPC0_GS	28
-#define CP0MVPC0_PCP	27
-#define CP0MVPC0_PTLBE	16
-#define CP0MVPC0_TCA	15
-#define CP0MVPC0_PVPE	10
-#define CP0MVPC0_PTC	0
+#define CP0MVPC0_M      31
+#define CP0MVPC0_TLBS   29
+#define CP0MVPC0_GS     28
+#define CP0MVPC0_PCP    27
+#define CP0MVPC0_PTLBE  16
+#define CP0MVPC0_TCA    15
+#define CP0MVPC0_PVPE   10
+#define CP0MVPC0_PTC    0
     int32_t CP0_MVPConf1;
-#define CP0MVPC1_CIM	31
-#define CP0MVPC1_CIF	30
-#define CP0MVPC1_PCX	20
-#define CP0MVPC1_PCP2	10
-#define CP0MVPC1_PCP1	0
+#define CP0MVPC1_CIM    31
+#define CP0MVPC1_CIF    30
+#define CP0MVPC1_PCX    20
+#define CP0MVPC1_PCP2   10
+#define CP0MVPC1_PCP1   0
 };
 
 typedef struct mips_def_t mips_def_t;
@@ -481,44 +494,44 @@ struct CPUMIPSState {
  */
     int32_t CP0_Random;
     int32_t CP0_VPEControl;
-#define CP0VPECo_YSI	21
-#define CP0VPECo_GSI	20
-#define CP0VPECo_EXCPT	16
-#define CP0VPECo_TE	15
-#define CP0VPECo_TargTC	0
+#define CP0VPECo_YSI    21
+#define CP0VPECo_GSI    20
+#define CP0VPECo_EXCPT  16
+#define CP0VPECo_TE     15
+#define CP0VPECo_TargTC 0
     int32_t CP0_VPEConf0;
-#define CP0VPEC0_M	31
-#define CP0VPEC0_XTC	21
-#define CP0VPEC0_TCS	19
-#define CP0VPEC0_SCS	18
-#define CP0VPEC0_DSC	17
-#define CP0VPEC0_ICS	16
-#define CP0VPEC0_MVP	1
-#define CP0VPEC0_VPA	0
+#define CP0VPEC0_M      31
+#define CP0VPEC0_XTC    21
+#define CP0VPEC0_TCS    19
+#define CP0VPEC0_SCS    18
+#define CP0VPEC0_DSC    17
+#define CP0VPEC0_ICS    16
+#define CP0VPEC0_MVP    1
+#define CP0VPEC0_VPA    0
     int32_t CP0_VPEConf1;
-#define CP0VPEC1_NCX	20
-#define CP0VPEC1_NCP2	10
-#define CP0VPEC1_NCP1	0
+#define CP0VPEC1_NCX    20
+#define CP0VPEC1_NCP2   10
+#define CP0VPEC1_NCP1   0
     target_ulong CP0_YQMask;
     target_ulong CP0_VPESchedule;
     target_ulong CP0_VPEScheFBack;
     int32_t CP0_VPEOpt;
-#define CP0VPEOpt_IWX7	15
-#define CP0VPEOpt_IWX6	14
-#define CP0VPEOpt_IWX5	13
-#define CP0VPEOpt_IWX4	12
-#define CP0VPEOpt_IWX3	11
-#define CP0VPEOpt_IWX2	10
-#define CP0VPEOpt_IWX1	9
-#define CP0VPEOpt_IWX0	8
-#define CP0VPEOpt_DWX7	7
-#define CP0VPEOpt_DWX6	6
-#define CP0VPEOpt_DWX5	5
-#define CP0VPEOpt_DWX4	4
-#define CP0VPEOpt_DWX3	3
-#define CP0VPEOpt_DWX2	2
-#define CP0VPEOpt_DWX1	1
-#define CP0VPEOpt_DWX0	0
+#define CP0VPEOpt_IWX7  15
+#define CP0VPEOpt_IWX6  14
+#define CP0VPEOpt_IWX5  13
+#define CP0VPEOpt_IWX4  12
+#define CP0VPEOpt_IWX3  11
+#define CP0VPEOpt_IWX2  10
+#define CP0VPEOpt_IWX1  9
+#define CP0VPEOpt_IWX0  8
+#define CP0VPEOpt_DWX7  7
+#define CP0VPEOpt_DWX6  6
+#define CP0VPEOpt_DWX5  5
+#define CP0VPEOpt_DWX4  4
+#define CP0VPEOpt_DWX3  3
+#define CP0VPEOpt_DWX2  2
+#define CP0VPEOpt_DWX1  1
+#define CP0VPEOpt_DWX0  0
 /*
  * CP0 Register 2
  */
@@ -625,33 +638,33 @@ struct CPUMIPSState {
 #define CP0PC_PSN       0     /*  5..0  */
     int32_t CP0_SRSConf0_rw_bitmask;
     int32_t CP0_SRSConf0;
-#define CP0SRSC0_M	31
-#define CP0SRSC0_SRS3	20
-#define CP0SRSC0_SRS2	10
-#define CP0SRSC0_SRS1	0
+#define CP0SRSC0_M      31
+#define CP0SRSC0_SRS3   20
+#define CP0SRSC0_SRS2   10
+#define CP0SRSC0_SRS1   0
     int32_t CP0_SRSConf1_rw_bitmask;
     int32_t CP0_SRSConf1;
-#define CP0SRSC1_M	31
-#define CP0SRSC1_SRS6	20
-#define CP0SRSC1_SRS5	10
-#define CP0SRSC1_SRS4	0
+#define CP0SRSC1_M      31
+#define CP0SRSC1_SRS6   20
+#define CP0SRSC1_SRS5   10
+#define CP0SRSC1_SRS4   0
     int32_t CP0_SRSConf2_rw_bitmask;
     int32_t CP0_SRSConf2;
-#define CP0SRSC2_M	31
-#define CP0SRSC2_SRS9	20
-#define CP0SRSC2_SRS8	10
-#define CP0SRSC2_SRS7	0
+#define CP0SRSC2_M      31
+#define CP0SRSC2_SRS9   20
+#define CP0SRSC2_SRS8   10
+#define CP0SRSC2_SRS7   0
     int32_t CP0_SRSConf3_rw_bitmask;
     int32_t CP0_SRSConf3;
-#define CP0SRSC3_M	31
-#define CP0SRSC3_SRS12	20
-#define CP0SRSC3_SRS11	10
-#define CP0SRSC3_SRS10	0
+#define CP0SRSC3_M      31
+#define CP0SRSC3_SRS12  20
+#define CP0SRSC3_SRS11  10
+#define CP0SRSC3_SRS10  0
     int32_t CP0_SRSConf4_rw_bitmask;
     int32_t CP0_SRSConf4;
-#define CP0SRSC4_SRS15	20
-#define CP0SRSC4_SRS14	10
-#define CP0SRSC4_SRS13	0
+#define CP0SRSC4_SRS15  20
+#define CP0SRSC4_SRS14  10
+#define CP0SRSC4_SRS13  0
 /*
  * CP0 Register 7
  */
@@ -1065,7 +1078,7 @@ static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
 
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
-void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
+void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
 #define cpu_signal_handler cpu_mips_signal_handler
 #define cpu_list mips_cpu_list
@@ -1090,7 +1103,7 @@ static inline int hflags_mmu_index(uint32_t hflags)
     }
 }
 
-static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
 {
     return hflags_mmu_index(env->hflags);
 }
@@ -1182,7 +1195,7 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 void itc_reconfigure(struct MIPSITUState *tag);
 
 /* helper.c */
-target_ulong exception_resume_pc (CPUMIPSState *env);
+target_ulong exception_resume_pc(CPUMIPSState *env);
 
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
-- 
2.7.4


