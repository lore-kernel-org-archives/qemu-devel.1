Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A02C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D562074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAeEDz+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D562074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihYD-0003BD-44
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7R-0006L9-Os
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:44801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7P-00019O-Dv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id y17so22001805wrn.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wv2KqLsKtLWgYn/F47Dsu5RFT4XbMRK8m6vgpFpr7eM=;
 b=hAeEDz+yjEFxVDWqP/fo4y91j4/JEk+eu2Su7j1t/iY5djZ9N4OTeul1VSFIBaDrKc
 M+7ggmGsmMZ+gfgAxmKT8bggrDm1QstfNTKjlxsP/QrhCLEangw/Q7+7hy2EQKeDM15u
 dvw4vei5XfoDueBsUA3H6Wge9fiZ6WhYdnQ75Iy3omVbOIhzvHVlyHnmA11FefJoOhfk
 SZ5NUJuwr0KVtLAW4OrAyxr8Rg8bbgBy2GcHFi+bRc66N2kw74MfvcV+T6NTpohMsdcj
 DXEDrfcDERpN43j+C+Ntyjy1WGfD9P8in04ICC5im2wBlFv4KHFp0UtswS3lPWT1WLvX
 Aq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wv2KqLsKtLWgYn/F47Dsu5RFT4XbMRK8m6vgpFpr7eM=;
 b=Xwrsmm/0Y9ERxvkpjbHKMyR3nd363ln7gEV90L1gbfysYYHhyVghNh0S26lFPAjE0C
 R1al2uLc0gimjmY3Kc5H8E7SC695XDXlv9r/8D4XSWy+Ir2tA6E9v+w//EB3baD8TD5Z
 /HZ7Cc5Yx++3tCJ3pGbMjEWCEN8oCnAcY2Iv9m8908aUY0CaU+nstJzWrbEUrI2C276F
 xYEZPX56HZPbPFW5jY49bdmfB7iScurF2hZxbBqehuGa7N1IgfQD1Tup7C5QC8ijx+tL
 UbxhfjpriBmYZYBiB6BGmCggmjT3ms+hVRcZdVEaNhf9ac4D7emwZrG4uPPf3LUOpM7L
 EnUw==
X-Gm-Message-State: AOAM5336EK+na9VAGY19PTgi+dgr4O8s5LSUbGfN9OzLCL+idtSmw/Te
 cFi8/IIJMq2Qfo5YPF1GyWhtL3XD
X-Google-Smtp-Source: ABdhPJx1OlFi4u9uRgY9nZXk/C4zwtZ4e28TZtAnh5z0cDVLcbtCORN1UrTW9IMmbDQpcrKw3gfzbg==
X-Received: by 2002:adf:f582:: with SMTP id f2mr5833636wro.204.1591720133678; 
 Tue, 09 Jun 2020 09:28:53 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:53 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 19/20] target/mips: Add Loongson-3 CPU definition
Date: Tue,  9 Jun 2020 18:28:37 +0200
Message-Id: <1591720118-7378-20-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
Loongson-3A R4 is the newest and its ISA is almost the superset of all
others. To reduce complexity, we just define two CPU types:

1) "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
   suitable for TCG because Loongson-3A R1 has fewest ASE.
2) "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
   suitable for KVM because Loongson-3A R4 has the VZ ASE.

Loongson-3A has CONFIG6 and CONFIG7, so add their bit-fields as well.

[AM: Rearranged insn_flags, added comments, renamed lmi_helper.c,
improved commit message, fixed checkpatch warnings]

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1591065557-9174-3-git-send-email-chenhc@lemote.com>
---
 target/mips/cpu.h                           | 32 ++++++++++-
 target/mips/internal.h                      |  2 +
 target/mips/mips-defs.h                     | 45 ++++++++-------
 target/mips/{lmi_helper.c => lmmi_helper.c} |  0
 target/mips/translate.c                     |  2 +
 target/mips/translate_init.inc.c            | 86 +++++++++++++++++++++++++++++
 target/mips/Makefile.objs                   |  2 +-
 7 files changed, 146 insertions(+), 23 deletions(-)
 rename target/mips/{lmi_helper.c => lmmi_helper.c} (100%)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 94d01ea..7cf7f52 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -198,8 +198,8 @@ typedef struct mips_def_t mips_def_t;
  * 3   Config3                             WatchLo3          WatchHi
  * 4   Config4                             WatchLo4          WatchHi
  * 5   Config5                             WatchLo5          WatchHi
- * 6                                       WatchLo6          WatchHi
- * 7                                       WatchLo7          WatchHi
+ * 6   Config6                             WatchLo6          WatchHi
+ * 7   Config7                             WatchLo7          WatchHi
  *
  *
  *     Register 20       Register 21       Register 22       Register 23
@@ -940,7 +940,35 @@ struct CPUMIPSState {
 #define CP0C5_UFR          2
 #define CP0C5_NFExists     0
     int32_t CP0_Config6;
+    int32_t CP0_Config6_rw_bitmask;
+#define CP0C6_BPPASS          31
+#define CP0C6_KPOS            24
+#define CP0C6_KE              23
+#define CP0C6_VTLBONLY        22
+#define CP0C6_LASX            21
+#define CP0C6_SSEN            20
+#define CP0C6_DISDRTIME       19
+#define CP0C6_PIXNUEN         18
+#define CP0C6_SCRAND          17
+#define CP0C6_LLEXCEN         16
+#define CP0C6_DISVC           15
+#define CP0C6_VCLRU           14
+#define CP0C6_DCLRU           13
+#define CP0C6_PIXUEN          12
+#define CP0C6_DISBLKLYEN      11
+#define CP0C6_UMEMUALEN       10
+#define CP0C6_SFBEN           8
+#define CP0C6_FLTINT          7
+#define CP0C6_VLTINT          6
+#define CP0C6_DISBTB          5
+#define CP0C6_STPREFCTL       2
+#define CP0C6_INSTPREF        1
+#define CP0C6_DATAPREF        0
     int32_t CP0_Config7;
+    int64_t CP0_Config7_rw_bitmask;
+#define CP0C7_NAPCGEN       2
+#define CP0C7_UNIMUEN       1
+#define CP0C7_VFPUCGEN      0
     uint64_t CP0_LLAddr;
     uint64_t CP0_MAAR[MIPS_MAAR_MAX];
     int32_t CP0_MAARI;
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 684356e..7f159a9 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -36,7 +36,9 @@ struct mips_def_t {
     int32_t CP0_Config5;
     int32_t CP0_Config5_rw_bitmask;
     int32_t CP0_Config6;
+    int32_t CP0_Config6_rw_bitmask;
     int32_t CP0_Config7;
+    int32_t CP0_Config7_rw_bitmask;
     target_ulong CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
     int32_t SYNCI_Step;
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index a831bb4..0c12910 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -15,7 +15,7 @@
  * ------------------------------------------------
  */
 /*
- *   bits 0-31: MIPS base instruction sets
+ *   bits 0-23: MIPS base instruction sets
  */
 #define ISA_MIPS1         0x0000000000000001ULL
 #define ISA_MIPS2         0x0000000000000002ULL
@@ -34,30 +34,33 @@
 #define ISA_MIPS64R6      0x0000000000004000ULL
 #define ISA_NANOMIPS32    0x0000000000008000ULL
 /*
- *   bits 32-47: MIPS ASEs
+ *   bits 24-39: MIPS ASEs
  */
-#define ASE_MIPS16        0x0000000100000000ULL
-#define ASE_MIPS3D        0x0000000200000000ULL
-#define ASE_MDMX          0x0000000400000000ULL
-#define ASE_DSP           0x0000000800000000ULL
-#define ASE_DSP_R2        0x0000001000000000ULL
-#define ASE_DSP_R3        0x0000002000000000ULL
-#define ASE_MT            0x0000004000000000ULL
-#define ASE_SMARTMIPS     0x0000008000000000ULL
-#define ASE_MICROMIPS     0x0000010000000000ULL
-#define ASE_MSA           0x0000020000000000ULL
+#define ASE_MIPS16        0x0000000001000000ULL
+#define ASE_MIPS3D        0x0000000002000000ULL
+#define ASE_MDMX          0x0000000004000000ULL
+#define ASE_DSP           0x0000000008000000ULL
+#define ASE_DSP_R2        0x0000000010000000ULL
+#define ASE_DSP_R3        0x0000000020000000ULL
+#define ASE_MT            0x0000000040000000ULL
+#define ASE_SMARTMIPS     0x0000000080000000ULL
+#define ASE_MICROMIPS     0x0000000100000000ULL
+#define ASE_MSA           0x0000000200000000ULL
 /*
- *   bits 48-55: vendor-specific base instruction sets
+ *   bits 40-51: vendor-specific base instruction sets
  */
-#define INSN_LOONGSON2E   0x0001000000000000ULL
-#define INSN_LOONGSON2F   0x0002000000000000ULL
-#define INSN_VR54XX       0x0004000000000000ULL
-#define INSN_R5900        0x0008000000000000ULL
+#define INSN_VR54XX       0x0000010000000000ULL
+#define INSN_R5900        0x0000020000000000ULL
+#define INSN_LOONGSON2E   0x0000040000000000ULL
+#define INSN_LOONGSON2F   0x0000080000000000ULL
+#define INSN_LOONGSON3A   0x0000100000000000ULL
 /*
- *   bits 56-63: vendor-specific ASEs
+ *   bits 52-63: vendor-specific ASEs
  */
-#define ASE_MMI           0x0100000000000000ULL
-#define ASE_MXU           0x0200000000000000ULL
+#define ASE_MMI           0x0010000000000000ULL
+#define ASE_MXU           0x0020000000000000ULL
+#define ASE_LMMI          0x0040000000000000ULL
+#define ASE_LEXT          0x0080000000000000ULL
 
 /* MIPS CPU defines. */
 #define CPU_MIPS1       (ISA_MIPS1)
@@ -94,6 +97,8 @@
 /* Wave Computing: "nanoMIPS" */
 #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
 
+#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
+
 /*
  * Strictly follow the architecture standard:
  * - Disallow "special" instruction handling for PMON/SPIM.
diff --git a/target/mips/lmi_helper.c b/target/mips/lmmi_helper.c
similarity index 100%
rename from target/mips/lmi_helper.c
rename to target/mips/lmmi_helper.c
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 25b595a..2caf4cb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31206,7 +31206,9 @@ void cpu_state_reset(CPUMIPSState *env)
     env->CP0_Config5 = env->cpu_model->CP0_Config5;
     env->CP0_Config5_rw_bitmask = env->cpu_model->CP0_Config5_rw_bitmask;
     env->CP0_Config6 = env->cpu_model->CP0_Config6;
+    env->CP0_Config6_rw_bitmask = env->cpu_model->CP0_Config6_rw_bitmask;
     env->CP0_Config7 = env->cpu_model->CP0_Config7;
+    env->CP0_Config7_rw_bitmask = env->cpu_model->CP0_Config7_rw_bitmask;
     env->CP0_LLAddr_rw_bitmask = env->cpu_model->CP0_LLAddr_rw_bitmask
                                  << env->cpu_model->CP0_LLAddr_shift;
     env->CP0_LLAddr_shift = env->cpu_model->CP0_LLAddr_shift;
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index 6d145a9..ffae10d 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -802,6 +802,92 @@ const mips_def_t mips_defs[] =
         .mmu_type = MMU_TYPE_R4000,
     },
     {
+        .name = "Loongson-3A1000",
+        .CP0_PRid = 0x6305,
+        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
+                       (3 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA) |
+                       (3 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
+                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2 | (7 << CP0C2_SS) | (4 << CP0C2_SL) |
+                       (3 << CP0C2_SA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
+        .CP0_LLAddr_rw_bitmask = 0,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x74D8FFFF,
+        .CP0_PageGrain = (1 << CP0PG_ELPA),
+        .CP0_PageGrain_rw_bitmask = (1 << CP0PG_ELPA),
+        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64) |
+                    (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W) |
+                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 42,
+        .PABITS = 48,
+        .insn_flags = CPU_LOONGSON3A,
+        .mmu_type = MMU_TYPE_R4000,
+    },
+    {
+        .name = "Loongson-3A4000",
+        .CP0_PRid = 0x14C000,
+        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
+                       (2 << CP0C1_IS) | (5 << CP0C1_IL) | (3 << CP0C1_IA) |
+                       (2 << CP0C1_DS) | (5 << CP0C1_DL) | (3 << CP0C1_DA) |
+                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2 | (5 << CP0C2_SS) | (5 << CP0C2_SL) |
+                       (15 << CP0C2_SA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
+                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
+        .CP0_Config4_rw_bitmask = 0,
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_NFExists),
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
+                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
+                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
+        .CP0_Config6 = (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
+                       (1 << CP0C6_SFBEN) | (1 << CP0C6_VLTINT) |
+                       (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
+        .CP0_Config6_rw_bitmask = (1 << CP0C6_BPPASS) | (0x3f << CP0C6_KPOS) |
+                       (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY) |
+                       (1 << CP0C6_LASX) | (1 << CP0C6_SSEN) |
+                       (1 << CP0C6_DISDRTIME) | (1 << CP0C6_PIXNUEN) |
+                       (1 << CP0C6_SCRAND) | (1 << CP0C6_LLEXCEN) |
+                       (1 << CP0C6_DISVC) | (1 << CP0C6_VCLRU) |
+                       (1 << CP0C6_DCLRU) | (1 << CP0C6_PIXUEN) |
+                       (1 << CP0C6_DISBLKLYEN) | (1 << CP0C6_UMEMUALEN) |
+                       (1 << CP0C6_SFBEN) | (1 << CP0C6_FLTINT) |
+                       (1 << CP0C6_VLTINT) | (1 << CP0C6_DISBTB) |
+                       (3 << CP0C6_STPREFCTL) | (1 << CP0C6_INSTPREF) |
+                       (1 << CP0C6_DATAPREF),
+        .CP0_Config7 = 0,
+        .CP0_Config7_rw_bitmask = (1 << CP0C7_NAPCGEN) | (1 << CP0C7_UNIMUEN) |
+                                  (1 << CP0C7_VFPUCGEN),
+        .CP0_LLAddr_rw_bitmask = 1,
+        .SYNCI_Step = 16,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
+        .CP0_PageGrain = (1 << CP0PG_ELPA),
+        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
+                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
+        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64) |
+                    (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W) |
+                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 48,
+        .PABITS = 48,
+        .insn_flags = CPU_LOONGSON3A,
+        .mmu_type = MMU_TYPE_R4000,
+    },
+    {
         /* A generic CPU providing MIPS64 DSP R2 ASE features.
            FIXME: Eventually this should be replaced by a real CPU model. */
         .name = "mips64dspr2",
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index 91eb691..b820b3b 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,6 +1,6 @@
 obj-y += translate.o cpu.o gdbstub.o helper.o
 obj-y += op_helper.o cp0_helper.o fpu_helper.o
-obj-y += dsp_helper.o lmi_helper.o msa_helper.o
+obj-y += dsp_helper.o lmmi_helper.o msa_helper.o
 obj-$(CONFIG_SOFTMMU) += mips-semi.o
 obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
 obj-$(CONFIG_KVM) += kvm.o
-- 
2.7.4


