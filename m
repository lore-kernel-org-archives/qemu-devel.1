Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C09C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 02:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9EB21773
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 02:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6HrrMrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9EB21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56559 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTdq5-0006jj-BO
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 22:52:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTdoW-0005Qx-Ru
	for qemu-devel@nongnu.org; Wed, 22 May 2019 22:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTdgh-0001t3-PM
	for qemu-devel@nongnu.org; Wed, 22 May 2019 22:42:36 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:34879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTdgh-0001sk-K9
	for qemu-devel@nongnu.org; Wed, 22 May 2019 22:42:35 -0400
Received: by mail-yw1-xc41.google.com with SMTP id k128so1694639ywf.2
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=L3cNq6YyAPNbUfiuj9aFVufaRYm1fCVGRTm5ygWeeXI=;
	b=Q6HrrMrNJm0cOKjwpnwqAoomARUSCbZGpMi0xgXEFi7ApLzsyuwOUpM5iBvxQVZLjx
	q05Nm4mxKwjOIYIVVOIHxSaIGhQ4Rh2Lw8yoLxt0Qg3mvBARtO/wr9pu8I0iqSpTP8Ar
	9WIZxgf7N5p534yFFn/zq4h2cwr25/Oscq8HR/sHx/fofuiPiPrMmSmRPNR+MZ73hVJ2
	+aOMghSmJihsscwxiU436jekxvCOZZJMEIBLYg/Gbd+hG7ZCqnWkBUXbUKIJepFZ7kXM
	2cV5+EG/s1UUoRfg3PVawhn6SSHe2lzhcsOoj07qY1kdOo6aPtG+8Y4orAyFbCWGEkur
	RLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=L3cNq6YyAPNbUfiuj9aFVufaRYm1fCVGRTm5ygWeeXI=;
	b=Y5KofZMQaAH3oOg1mQzT+CiyQvy+yfBK8j6DuBVWO59guvWGhvymB3/MScJ8Awozr7
	ymnqY/6L1DtGpCXwOGSlqWAmGMI+S15dGLxjaE8yIeUPWjbZU6biuNB0hlFnT8yTqj4B
	xqsab/II0wgvcVLOAmgMnTFWFxjPh796G5/y2y0MIE5JCkeKwa4zNJIbWwAaY/GtJb4C
	+L0NJNRsUzAeCFiWtjBBCNcmCRguUlxFmHm6XRfUJ3KB3/d5J4HFYieHJivkVmM3pojC
	Glx4RmZvpV7Z8vGmtiHLbLSPCfDscwE7a0d61R3lMt6EAMZyvF1aA2njZ/xu8SblubjO
	kUkA==
X-Gm-Message-State: APjAAAWPeWN1tVZ+MB+vlDdhf4WEsVCv7U0jdO/7rFN7+l21C9xm+bvl
	PXrwvkAbK4wikTIFlqhlkibn6O2ZL2c=
X-Google-Smtp-Source: APXvYqwl0PwXnd7vcfExm2eDE+gnaGej1fmWtWLEkxffbAM8F7YL0vxesciyJKIv6HEIraBT1YvXVA==
X-Received: by 2002:a81:3c83:: with SMTP id
	j125mr21399048ywa.226.1558579354836; 
	Wed, 22 May 2019 19:42:34 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	n12sm7559320ywn.81.2019.05.22.19.42.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 19:42:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 22:42:29 -0400
Message-Id: <20190523024229.1158-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523024229.1158-1-richard.henderson@linaro.org>
References: <20190523024229.1158-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [PATCH 3/3] capstone: Enable disassembly for s390x
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.
Install a skipdata hook to keep capstone in sync with the
instruction stream for unknown opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile           |  1 +
 disas.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.c |  4 ++++
 3 files changed, 45 insertions(+)

diff --git a/Makefile b/Makefile
index 155f066a20..a37e872825 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
 CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
+CAP_CFLAGS += -DCAPSTONE_HAS_SYSZ
 CAP_CFLAGS += -DCAPSTONE_HAS_X86
 
 subdir-capstone: .git-submodule-status
diff --git a/disas.c b/disas.c
index 41ad0102e2..c1ecd2d769 100644
--- a/disas.c
+++ b/disas.c
@@ -179,6 +179,39 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
    to share this across calls and across host vs target disassembly.  */
 static __thread cs_insn *cap_insn;
 
+/*
+ * The capstone library always skips 2 bytes for S390X.
+ * This is less than ideal, since we can tell from the first two bits
+ * the size of the insn and thus stay in sync with the insn stream.
+ */
+static size_t CAPSTONE_API
+cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
+                      size_t offset, void *user_data)
+{
+    size_t ilen;
+
+    /* See get_ilen() in target/s390x/internal.h.  */
+    switch (code[offset] >> 6) {
+    case 0:
+        ilen = 2;
+        break;
+    case 1:
+    case 2:
+        ilen = 4;
+        break;
+    default:
+        ilen = 6;
+        break;
+    }
+
+    return ilen;
+}
+
+static const cs_opt_skipdata cap_skipdata_s390x = {
+    .mnemonic = ".byte",
+    .callback = cap_skipdata_s390x_cb
+};
+
 /* Initialize the Capstone library.  */
 /* ??? It would be nice to cache this.  We would need one handle for the
    host and one for the target.  For most targets we can reset specific
@@ -209,6 +242,10 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
 
     /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
     cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
+    if (info->cap_arch == CS_ARCH_SYSZ) {
+        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
+                  (uintptr_t)&cap_skipdata_s390x);
+    }
 
     /* Allocate temp space for cs_disasm_iter.  */
     if (cap_insn == NULL) {
@@ -551,6 +588,9 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_m68k;
 #elif defined(__s390__)
     print_insn = print_insn_s390;
+    s.info.cap_arch = CS_ARCH_SYSZ;
+    s.info.cap_insn_unit = 2;
+    s.info.cap_insn_split = 6;
 #elif defined(__hppa__)
     print_insn = print_insn_hppa;
 #endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b1df63d82c..553571d86b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -41,6 +41,7 @@
 #include "sysemu/sysemu.h"
 #endif
 #include "fpu/softfloat.h"
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -175,6 +176,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 6;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.17.1


