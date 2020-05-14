Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68132065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1rvc4d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68132065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEmo-0006tw-0V
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcy-0007l0-Jl
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:25 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcx-0003oV-SG
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:24 -0400
Received: by mail-lj1-x241.google.com with SMTP id u15so3717717ljd.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7FoM1+aW2rkN6WZGeGZa1NdTwyvt1XBX/M5a6guzNPc=;
 b=Z1rvc4d+iouPEPJFEGxRF7k5GZfcOjA7SOTurgq6CnZ39swZ8ibRCNr09ZmL9pywrz
 r+ne+HSrzZ1FKmp9ctJzlQoawp27d+fZgaRlOUSKtrxBEVmnnz0JGthzaMwztldS/6dA
 FFHOVnt4P8OJIZN1AM6EAaww2KR+b5cL1hsNhSdo77Eh1GD9dtm8X2dpSiX5eJk70wLt
 6hOlpRS6NGe/9S/yCSjsrsA6a2FAkhO11XTnDjQ0oX3OTJ5uhOWSIIZjtSbWuZd09llU
 Eq8p3NyoAd62QQ2HbatVirjm4mB/7grbqRUCIYdPgRdKQ/CBIa/6i9IruxtejwGN/LUf
 8l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7FoM1+aW2rkN6WZGeGZa1NdTwyvt1XBX/M5a6guzNPc=;
 b=m6doRPhgHmW2PR734eKiwwWqR7pnnirVtjDuw6BqSWKxTiFRZD2DLUBhJiEE0+wg3p
 C0XSIleGCcOiyzg0SltW8iHOHLA7eMU37fXmzXsCcAaGlDcoNxcrUax98rxnwXnYRLP/
 PPZLOCbPbHbPk6A3kwiZNT2KRbC+efRLOK2FocH+jbG0gfQ/maszdOwSrDOzy+Qtpw20
 sIb+zQehiTBAU041Svm7oTEFHs+TDP/2CPY+1SQDrIs0XxpJpoNPs3RS2174fGkp1tEB
 LJo20CFAnU7HDEkk430f7vUBHXoRH60mCUxBQ2WcUvg5Vf6gN2H7agMvv8NuYMb4fSO8
 xBgA==
X-Gm-Message-State: AOAM532J1V12aGP5L6zw6EZg5WdwzhYovW2VJqWlA41PLTl25ERUAzZB
 9R3cIZ3ztOgTbLHtAouNhcCXVVrdTGg=
X-Google-Smtp-Source: ABdhPJwsVWycX4KYMrtnKmcyEfJjqyfbHirrVzs42xxW0oi48lPv8r7u7QNtREKle+NbFidKbZu1GA==
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr3092933ljj.265.1589465661589; 
 Thu, 14 May 2020 07:14:21 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id z17sm1365436ljc.81.2020.05.14.07.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:20 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 13/14] target/microblaze: gdb: Fix incorrect SReg reporting
Date: Thu, 14 May 2020 16:14:01 +0200
Message-Id: <20200514141402.12498-14-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joe Komlodi <joe.komlodi@xilinx.com>

SRegs used to be reported to GDB by iterating over the SRegs array,
however we do not store them in an order that allows them to be
reported to GDB in that way.

To fix this, a simple map is used to map the register GDB wants to its
location in the SRegs array.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <1589393329-223076-3-git-send-email-komlodi@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/gdbstub.c | 59 ++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 54cc7857d1..73e8973597 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -25,6 +25,21 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
+    /*
+     * GDB expects SREGs in the following order:
+     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
+     * They aren't stored in this order, so make a map.
+     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
+     * map them to anything and return a value of 0 instead.
+     */
+    static const uint8_t sreg_map[6] = {
+        SR_PC,
+        SR_MSR,
+        SR_EAR,
+        SR_ESR,
+        SR_FSR,
+        SR_BTR
+    };
 
     /*
      * GDB expects registers to be reported in this order:
@@ -40,15 +55,16 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         n -= 32;
         switch (n) {
         case 0 ... 5:
-            return gdb_get_reg32(mem_buf, env->sregs[n]);
+            return gdb_get_reg32(mem_buf, env->sregs[sreg_map[n]]);
         /* PVR12 is intentionally skipped */
         case 6 ... 17:
             n -= 6;
             return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
-        case 18 ... 24:
-            /* Add an offset of 6 to resume where we left off with SRegs */
-            n = n - 18 + 6;
-            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        case 18:
+            return gdb_get_reg32(mem_buf, env->sregs[SR_EDR]);
+        /* Other SRegs aren't modeled, so report a value of 0 */
+        case 19 ... 24:
+            return gdb_get_reg32(mem_buf, 0);
         case 25:
             return gdb_get_reg32(mem_buf, env->slr);
         case 26:
@@ -66,29 +82,52 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUMBState *env = &cpu->env;
     uint32_t tmp;
 
+    /*
+     * GDB expects SREGs in the following order:
+     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
+     * They aren't stored in this order, so make a map.
+     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
+     * map them to anything.
+     */
+    static const uint8_t sreg_map[6] = {
+        SR_PC,
+        SR_MSR,
+        SR_EAR,
+        SR_ESR,
+        SR_FSR,
+        SR_BTR
+    };
+
     if (n > cc->gdb_num_core_regs) {
         return 0;
     }
 
     tmp = ldl_p(mem_buf);
 
+    /*
+     * GDB expects registers to be reported in this order:
+     * R0-R31
+     * PC-BTR
+     * PVR0-PVR11
+     * EDR-TLBHI
+     * SLR-SHR
+     */
     if (n < 32) {
         env->regs[n] = tmp;
     } else {
         n -= 32;
         switch (n) {
         case 0 ... 5:
-            env->sregs[n] = tmp;
+            env->sregs[sreg_map[n]] = tmp;
             break;
         /* PVR12 is intentionally skipped */
         case 6 ... 17:
             n -= 6;
             env->pvr.regs[n] = tmp;
             break;
-        case 18 ... 24:
-            /* Add an offset of 6 to resume where we left off with SRegs */
-            n = n - 18 + 6;
-            env->sregs[n] = tmp;
+        /* Only EDR is modeled in these indeces, so ignore the rest */
+        case 18:
+            env->sregs[SR_EDR] = tmp;
             break;
         case 25:
             env->slr = tmp;
-- 
2.20.1


