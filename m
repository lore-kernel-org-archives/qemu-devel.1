Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46466C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F5D2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbIPQQg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F5D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEib-0007hw-2p
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcx-0007k2-Sf
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:23 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:44199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcw-0003oB-77
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:22 -0400
Received: by mail-lf1-x136.google.com with SMTP id d22so2744332lfm.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KBuh5XtT3vvpSuwwP/oXkh8fEbk4QnxLl6WMFlm593E=;
 b=WbIPQQg9BH7E4IXWsisbm0S36p6JyMe15G06iAuUYCYGJ/KYm6GK7CVRDhiEHIWJMa
 QrzzVF+uzK/7p/hhUr30o7lKmsPi/DeLZMDAl5oiryzsa9jmnFS0tiyRK/AoVbNRlSjP
 +1uN/7OJGzOaIH5OiVWmpG9f71uMZVEwe45uSxMZ8/vkPd2DthnohGbBClXO+c1xn0Cw
 XylAocg99frX+xnrpRbT2DZxBCHkA/X4tuR/oXApfAVCvuot8WN9/VBrvAaLT31GU7kd
 rNjydQ9cFDqjroRTp/6FY6jN1jg7gBxYXFGtCcZUn7MEY9+x7yt9assI0m56TD3t6aAL
 O4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KBuh5XtT3vvpSuwwP/oXkh8fEbk4QnxLl6WMFlm593E=;
 b=sCQUZszu+eY8LxJ4JbZkxxUl6RFz2Q77Tdz+/Q/VlqU1mT+b6ZUow3lKpXxD9/YGJ5
 +2FexlrLC7wd0yDSI68KmOlKtTW+8Gn77uf7k7foUKrMW8/EuK7hFTLUtKy2tCCEoV32
 fCons0TjUGMG0HGcpxUqAbbOBo02xayuvKLUNETV0wzWtfdwQMAUYLrjQogTreXUua2q
 TZjO8Llw2B2D0bpHhBFef897ZJgagnxL4XaQcuZmB1uxhYkMnPdNPeinhayUO/+pJjOn
 UOy7pazQ6MFwBKbtPy1/g9GEeg0MinoEzJrZEVI9bXqn7pkIrIFFEEjiOUhtrC4BjwUC
 O86g==
X-Gm-Message-State: AOAM533C+tnsrZPJh7HsNmTUTNtMD+S3klUEolKnHgH8j0fzeSCv5qMw
 djTsq3nEUnJBH0QCOlQaqk2VakLoqH0=
X-Google-Smtp-Source: ABdhPJx4rNxQSn/ladKfvChx1xMenPQS6RTfV1KFDhwxWqGwM4wavhU2UwOEcz94kLa052gsw+6FIA==
X-Received: by 2002:a19:d:: with SMTP id 13mr3491868lfa.167.1589465660321;
 Thu, 14 May 2020 07:14:20 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id w29sm1963622lfc.4.2020.05.14.07.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:19 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 12/14] target/microblaze: gdb: Extend the number of
 registers presented to GDB
Date: Thu, 14 May 2020 16:14:00 +0200
Message-Id: <20200514141402.12498-13-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
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

Increase the number of Microblaze registers QEMU will report when
talking to GDB.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <1589393329-223076-2-git-send-email-komlodi@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c     |  2 +-
 target/microblaze/gdbstub.c | 52 ++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index aa9983069a..51e5c85b10 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -329,7 +329,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     dc->vmsd = &vmstate_mb_cpu;
     device_class_set_props(dc, mb_properties);
-    cc->gdb_num_core_regs = 32 + 5;
+    cc->gdb_num_core_regs = 32 + 27;
 
     cc->disas_set_info = mb_disas_set_info;
     cc->tcg_initialize = mb_tcg_init;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index f41ebf1f33..54cc7857d1 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -26,12 +26,37 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
 
+    /*
+     * GDB expects registers to be reported in this order:
+     * R0-R31
+     * PC-BTR
+     * PVR0-PVR11
+     * EDR-TLBHI
+     * SLR-SHR
+     */
     if (n < 32) {
         return gdb_get_reg32(mem_buf, env->regs[n]);
     } else {
-        return gdb_get_reg32(mem_buf, env->sregs[n - 32]);
+        n -= 32;
+        switch (n) {
+        case 0 ... 5:
+            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        /* PVR12 is intentionally skipped */
+        case 6 ... 17:
+            n -= 6;
+            return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
+        case 18 ... 24:
+            /* Add an offset of 6 to resume where we left off with SRegs */
+            n = n - 18 + 6;
+            return gdb_get_reg32(mem_buf, env->sregs[n]);
+        case 25:
+            return gdb_get_reg32(mem_buf, env->slr);
+        case 26:
+            return gdb_get_reg32(mem_buf, env->shr);
+        default:
+            return 0;
+        }
     }
-    return 0;
 }
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
@@ -50,7 +75,28 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < 32) {
         env->regs[n] = tmp;
     } else {
-        env->sregs[n - 32] = tmp;
+        n -= 32;
+        switch (n) {
+        case 0 ... 5:
+            env->sregs[n] = tmp;
+            break;
+        /* PVR12 is intentionally skipped */
+        case 6 ... 17:
+            n -= 6;
+            env->pvr.regs[n] = tmp;
+            break;
+        case 18 ... 24:
+            /* Add an offset of 6 to resume where we left off with SRegs */
+            n = n - 18 + 6;
+            env->sregs[n] = tmp;
+            break;
+        case 25:
+            env->slr = tmp;
+            break;
+        case 26:
+            env->shr = tmp;
+            break;
+        }
     }
     return 4;
 }
-- 
2.20.1


