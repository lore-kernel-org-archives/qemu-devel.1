Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFFFC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B4021726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D53ykzNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B4021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRTU-0005zf-NZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:13:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQY-00047t-6K
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQQ-0001oa-AG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hCRPf-0000Mp-9W
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id z24so7843669wmi.5
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WHVNVRdz4ITDCkE6NMpCjuOMQ74U7RPYVINFoj4kcaI=;
	b=D53ykzNuvMhEb5IykZ4tx0Kyizeqda73pM8HojI1a5tqonQT5P/DdQNJs5Fb9RpTQw
	ZhpnSzj9mBg8vF5mKvBOp2QJ/tbrjFZ9YiN3CDKh7F3eFzzDm1f3rX1umlbIWfpkGKBD
	1sJj0HfeGKPQb6cJ4WczXUrksWN0IEX+sBwKZ6QkYBVyWgOeUYDj9lAw/ajpK8ZW6n14
	3vF4YmefqTlOnu1angL+ScKlm7oY3o1mFyx+fBsMPckxSzJtK7RDAy2hBOQgO+zW/GOB
	QA94gtWMHcdsJ/gvWebg1ij2gBBLrLgTl0vPLYpKhQSCnMnMt4G1nLFl8PlaErFsfY+9
	TKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WHVNVRdz4ITDCkE6NMpCjuOMQ74U7RPYVINFoj4kcaI=;
	b=IieqrrNeZMzDGdpuWDpC/9Rn8rGD1Q7anHWnS7VxSoAy3g5ooQSY/XmYmVtJXuHdv1
	KOVoLTaF8HppvGdkrg9BMF0oF9Ml8ZqFs4gwZ+IjGEfbZvwF1/A8tF1rcnAHGbrnZcxL
	VosXHqdw2jXbGSXlvRJFw8o3YwBMLplFcK0gJrTCEGppSMsglhksr0BTJ8mdN+YXlGkM
	EpBCjYhWA89qXMu3crJhH0KIgYSWSo85iJxlAlk31UG+LX4vWYvSOzoLPLqhcCE9B6Yw
	LsRICZT/hU7YQpD4QiKS8uy0ROnUB0WKDvb8O0Qpz57UmAh8kbAsRBBqIyFmh0kLAyp5
	hivw==
X-Gm-Message-State: APjAAAUDIEzPz6YL4OSUh+fYxFOgpXI9EALUcY7h6bDc0Dn0vK8whlho
	QF89TZM0BaGlXYYqzy/4rQ==
X-Google-Smtp-Source: APXvYqyn0bzkBSdA/+RRmjNVJQGdZQyotp6jvh+gOGmoWTAqDeGNs95u7JvVm1I/PWycq1OfE0v1Fg==
X-Received: by 2002:a1c:1a53:: with SMTP id a80mr8558371wma.15.1554480592564; 
	Fri, 05 Apr 2019 09:09:52 -0700 (PDT)
Received: from ninjatsu.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	z10sm2966029wmi.15.2019.04.05.09.09.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 09:09:52 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: amarkovic@wavecomp.com
Date: Fri,  5 Apr 2019 17:09:36 +0100
Message-Id: <20190405160938.27494-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405160938.27494-1-jbi.octave@gmail.com>
References: <20190405160938.27494-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 2/4] target/mips: add or remove space to fix
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
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405160936.9UL0ftApPimCwFf0oTob0hdP7mr9XaMkuLSIldDXWhM@z>

Add or remove space to fix errors issued by checkpatch.pl tool
"ERROR: spaces required around ..."
"ERROR: space required after that"
"ERROR: space required before the open parenthesis"
"ERROR: space prohibited between function name and open parenthesis"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5dd71dbe21..0d2718d7bf 100644
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
@@ -72,16 +72,16 @@ struct CPUMIPSFPUContext {
 #define FCR31_FS 24
 #define FCR31_ABS2008 19
 #define FCR31_NAN2008 18
-#define SET_FP_COND(num,env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while(0)
-#define CLEAR_FP_COND(num,env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while(0)
+#define SET_FP_COND(num, env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
+#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
 #define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | (((env).fcr31 >> 23) & 0x1))
 #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
 #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
 #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
-#define SET_FP_CAUSE(reg,v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while(0)
-#define SET_FP_ENABLE(reg,v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while(0)
-#define SET_FP_FLAGS(reg,v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while(0)
-#define UPDATE_FP_FLAGS(reg,v)   do { (reg) |= ((v & 0x1f) << 2); } while(0)
+#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while (0)
+#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while (0)
+#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while (0)
+#define UPDATE_FP_FLAGS(reg, v)   do { (reg) |= ((v & 0x1f) << 2); } while (0)
 #define FP_INEXACT        1
 #define FP_UNDERFLOW      2
 #define FP_OVERFLOW       4
@@ -1072,7 +1072,7 @@ static inline MIPSCPU *mips_env_get_cpu(CPUMIPSState *env)
 
 #define ENV_OFFSET offsetof(MIPSCPU, env)
 
-void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
+void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
 #define cpu_signal_handler cpu_mips_signal_handler
 #define cpu_list mips_cpu_list
@@ -1099,7 +1099,7 @@ static inline int hflags_mmu_index(uint32_t hflags)
     }
 }
 
-static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
+static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
 {
     return hflags_mmu_index(env->hflags);
 }
@@ -1107,7 +1107,7 @@ static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
 #include "exec/cpu-all.h"
 
 /*
- * Memory access type :
+ * Memory access type:
  * may be needed for precise access rights control and precise exceptions.
  */
 enum {
@@ -1192,7 +1192,7 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
 void itc_reconfigure(struct MIPSITUState *tag);
 
 /* helper.c */
-target_ulong exception_resume_pc (CPUMIPSState *env);
+target_ulong exception_resume_pc(CPUMIPSState *env);
 
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
-- 
2.20.1


