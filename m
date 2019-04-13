Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85794C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 20:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1CB20870
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 20:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLdVPsM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1CB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFPIW-0004F1-Dx
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 16:30:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hFPGp-0003FG-L0
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hFPGo-0000Rx-Ev
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:29:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hFPGm-0000Qn-Vw
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 16:29:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id h4so16416405wre.7
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2c164oGS8ZtkF6OOOIwevaANptGcjSdPkIDQwQn6lzo=;
	b=XLdVPsM4JBiUwLdFLCJby1s9ZbPXVJj32NpZWmSAB88oJm38Ynsscs/SE62Pt5mFZa
	xtzm2+dlWPsOQrQ/R9Jml1fMiMLsmcDNE4qDYsHPodVkPWd4i8h/6o+NYxu71D52GOj0
	pnI2j1wmU9YYJkG2QdyfAz9ahL+cXGN65bcuElnBEftBP2uGFYivYiD4Kvq217pKGf1/
	qZRKZuBB2pFsltWR5oj0AWgshi6sRO/EtsiafVjizpjW7ve07uqZcr5prUoLns8x9MW4
	pSFWWQSKFZvK88BiTR4aE45ibn/3XchCun1vg2+FEbX2qYXju9ev76hH0hODZ8Glnady
	yIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2c164oGS8ZtkF6OOOIwevaANptGcjSdPkIDQwQn6lzo=;
	b=Tk5Fe9sufw6+rvFmO9u3BkMqIizJKB1vCDPVczeXyz/1Ap3gdsF5C9yW9fYwO7PeFA
	mVZbh/QZYu2KIrnUfVNUQqt3G3HcQqkfHpxVLaxogsF2bI+hP8n2onrB2fKosVp03BPk
	9qKNrNogSUbq2QNZ9+oELJRC9sMbT5yEzU1ImOb9mOBL1xq1k+0srAJxLY2/jgeMqLxC
	6Tt39pJX0hyJHEBkhnYnNzQ6MlGidXPJgf+kcDhuV/Lm3Kz0JyBKyL7C8f4fUMA5JBgH
	Xebv1PhORWkL5o1h8ol+nGyiUFuIDsKvbJjGfJvYMq36TDSaMmKpxeXjEemyH5J88lAN
	HjoQ==
X-Gm-Message-State: APjAAAXWcqLrZo2oSTdBqKDYMmFRQlw57t+3Ep3QkjWOsW93dL18JfQN
	EDC4Yej8JXDvyAw/yMrADPRv985SJA==
X-Google-Smtp-Source: APXvYqw99E32zN8Tn1Mo68J6nlFGZJ3S8izv/yvmezAy+R5RB0WiAG3WjYX5nWEqlxGlQotbDJcmjg==
X-Received: by 2002:adf:97c5:: with SMTP id t5mr24511613wrb.252.1555187339573; 
	Sat, 13 Apr 2019 13:28:59 -0700 (PDT)
Received: from ninjahub.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	7sm153212361wrc.81.2019.04.13.13.28.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 13 Apr 2019 13:28:59 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Apr 2019 21:28:18 +0100
Message-Id: <20190413202818.13622-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413202818.13622-1-jbi.octave@gmail.com>
References: <20190413202818.13622-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v5 2/2] target/mips: realign comments to fix
 checkpatch warnings
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
Cc: arikalo@wavecomp.com, Jules Irenge <jbi.octave@gmail.com>,
	aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190413202818.hA44771XBRkvfFzQhHiUt5btsd09_gtZ9tmVjv8OSzQ@z>

  Realign comments to fix warnings issued by checkpatc.pl tool
 "WARNING: Block comments use a leading /* on a separate line"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 469f3eff26..5819cb95a3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -37,7 +37,8 @@ union fpr_t {
 /* FPU/MSA register mapping is not tested on big-endian hosts. */
     wr_t     wr;   /* vector data */
 };
-/* define FP_ENDIAN_IDX to access the same location
+/*
+ *define FP_ENDIAN_IDX to access the same location
  * in the fpr_t union regardless of the host endianness
  */
 #if defined(HOST_WORDS_BIGENDIAN)
@@ -976,9 +977,11 @@ struct CPUMIPSState {
     /* TMASK defines different execution modes */
 #define MIPS_HFLAG_TMASK  0x1F5807FF
 #define MIPS_HFLAG_MODE   0x00007 /* execution modes                    */
-    /* The KSU flags must be the lowest bits in hflags. The flag order
-       must be the same as defined for CP0 Status. This allows to use
-       the bits as the value of mmu_idx. */
+    /*
+     * The KSU flags must be the lowest bits in hflags. The flag order
+     * must be the same as defined for CP0 Status. This allows to use
+     * the bits as the value of mmu_idx.
+     */
 #define MIPS_HFLAG_KSU    0x00003 /* kernel/supervisor/user mode mask   */
 #define MIPS_HFLAG_UM     0x00002 /* user mode flag                     */
 #define MIPS_HFLAG_SM     0x00001 /* supervisor mode flag               */
@@ -988,18 +991,22 @@ struct CPUMIPSState {
 #define MIPS_HFLAG_CP0    0x00010 /* CP0 enabled                        */
 #define MIPS_HFLAG_FPU    0x00020 /* FPU enabled                        */
 #define MIPS_HFLAG_F64    0x00040 /* 64-bit FPU enabled                 */
-    /* True if the MIPS IV COP1X instructions can be used.  This also
-       controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
-       and RSQRT.D.  */
+    /*
+     * True if the MIPS IV COP1X instructions can be used.  This also
+     * controls the non-COP1X instructions RECIP.S, RECIP.D, RSQRT.S
+     * and RSQRT.D.
+     */
 #define MIPS_HFLAG_COP1X  0x00080 /* COP1X instructions enabled         */
 #define MIPS_HFLAG_RE     0x00100 /* Reversed endianness                */
 #define MIPS_HFLAG_AWRAP  0x00200 /* 32-bit compatibility address wrapping */
 #define MIPS_HFLAG_M16    0x00400 /* MIPS16 mode flag                   */
 #define MIPS_HFLAG_M16_SHIFT 10
-    /* If translation is interrupted between the branch instruction and
+    /*
+     * If translation is interrupted between the branch instruction and
      * the delay slot, record what type of branch it is so that we can
      * resume translation properly.  It might be possible to reduce
-     * this from three bits to two.  */
+     * this from three bits to two.
+     */
 #define MIPS_HFLAG_BMASK_BASE  0x803800
 #define MIPS_HFLAG_B      0x00800 /* Unconditional branch               */
 #define MIPS_HFLAG_BC     0x01000 /* Conditional branch                 */
@@ -1086,8 +1093,10 @@ void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 extern void cpu_wrdsp(uint32_t rs, uint32_t mask_num, CPUMIPSState *env);
 extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
 
-/* MMU modes definitions. We carefully match the indices with our
-   hflags layout. */
+/*
+ * MMU modes definitions. We carefully match the indices with our
+ * hflags layout.
+ */
 #define MMU_MODE0_SUFFIX _kernel
 #define MMU_MODE1_SUFFIX _super
 #define MMU_MODE2_SUFFIX _user
@@ -1110,7 +1119,8 @@ static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
 
 #include "exec/cpu-all.h"
 
-/* Memory access type :
+/*
+ * Memory access type :
  * may be needed for precise access rights control and precise exceptions.
  */
 enum {
-- 
2.20.1


