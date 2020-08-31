Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC3A2071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1SYjZbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC3A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCokA-0003Ux-Di
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojG-0001iW-MN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:30 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojE-0007DB-LL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:30 -0400
Received: by mail-pj1-x1041.google.com with SMTP id o16so283469pjr.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eKbkQ2gWYLZDojvyyJ6asnBPMQqGjh2G5aTiAzfJ7X0=;
 b=q1SYjZbcJU2yC1dHZiK3bZo8F8l200bPrQNtxu2EtTeSUDZ2+ilrH+o8CkxxQptXU2
 o9/rt5A+lVc99jVrb8cnQaCcrcq4oqZg0Dn3wdocIX0P0wlWIEBmX/zHKev3DoKrDflX
 u9I7i0x33WS3Rtj5bDNgMSDa8TYolWKNz6YBRARuQnQLlUqSCcI1CQovCGN4CYeLhQcO
 Rms3oWy8yuu7P8+FUzBpJHIdlzeVyf+F+cJhD0v8sRvD3HuNUMzFsp65IFI8rSX68veY
 b7M0KJyORaOKrRt7I2QB9ZWoixVuuM8IvDsBihEdFwja8bof/mEECIJ4IYUqaQR5nxX/
 1+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eKbkQ2gWYLZDojvyyJ6asnBPMQqGjh2G5aTiAzfJ7X0=;
 b=Q8m2r8qvc7rtfCgE+/eRi9C53Y6ZpOY3vVTHvi1tAqoUtJ87+UEM5jSBIfh0gjAJbC
 kYkgajFnQnixmS4WoGc+CVN3iImDCDiP5GR7rU21mB2DELbMb5CD4UUhhtIMwUUVyBpI
 pJ39VFp0BxfAM4/NHnrWdBFCsm5kapbtTcrYx5ILDqPay7GMOLYqxnzSuyzWCTP3nySB
 6dM80z+nuLwjcu5x+HFqSe/RtUdDbirL6xI4qWjhpL+WKDrd3Hfx/t3QTxGWXb9e/BDX
 SZM8c5UG8rw3fsoUZ9DzoJ+a216fVrx0sHhoxsBzEVUfwtZTOrPByyzB5u1o0nyfbUEP
 AKeA==
X-Gm-Message-State: AOAM531NAnorEGMI6t+KcM/Cn5yY5Ac870r1gF6ZaXoY7fn59UKtkh8S
 GAchEjrFSFVwVZdf9xcGpcYnoONQ+p/Hkw==
X-Google-Smtp-Source: ABdhPJxMSYbIcOVsWoZ9QdJ7HWy5wwpBtRZnkSyctyU4xGSfasSMHIRffmxRqV1oma6aDrrGyULRlQ==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr605544pjo.11.1598899226638; 
 Mon, 31 Aug 2020 11:40:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y195sm5757580pfc.137.2020.08.31.11.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 11:40:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] target/microblaze: Force rtid, rted, rtbd to exit
Date: Mon, 31 Aug 2020 11:40:17 -0700
Message-Id: <20200831184018.839906-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831184018.839906-1-richard.henderson@linaro.org>
References: <20200831184018.839906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These return-from-exception type instructions have modified
MSR to re-enable various forms of interrupt.  Force a return
to the main loop.

Consolidate the cleanup of tb_flags into mb_tr_translate_insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b116a0ce4f..8d02b07b73 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1518,7 +1518,6 @@ static void do_rti(DisasContext *dc)
     tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
 
     tcg_temp_free_i32(tmp);
-    dc->tb_flags &= ~DRTI_FLAG;
 }
 
 static void do_rtb(DisasContext *dc)
@@ -1531,7 +1530,6 @@ static void do_rtb(DisasContext *dc)
     tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
 
     tcg_temp_free_i32(tmp);
-    dc->tb_flags &= ~DRTB_FLAG;
 }
 
 static void do_rte(DisasContext *dc)
@@ -1545,7 +1543,6 @@ static void do_rte(DisasContext *dc)
     tcg_gen_or_i32(cpu_msr, cpu_msr, tmp);
 
     tcg_temp_free_i32(tmp);
-    dc->tb_flags &= ~DRTE_FLAG;
 }
 
 /* Insns connected to FSL or AXI stream attached devices.  */
@@ -1700,12 +1697,16 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
          * Finish finish any return-from branch.
          * TODO: Diagnose rtXd in delay slot of rtYd earlier.
          */
-        if (dc->tb_flags & DRTI_FLAG) {
-            do_rti(dc);
-        } else if (dc->tb_flags & DRTB_FLAG) {
-            do_rtb(dc);
-        } else if (dc->tb_flags & DRTE_FLAG) {
-            do_rte(dc);
+        uint32_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
+        if (unlikely(rt_ibe != 0)) {
+            dc->tb_flags &= ~(DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
+            if (rt_ibe & DRTI_FLAG) {
+                do_rti(dc);
+            } else if (rt_ibe & DRTB_FLAG) {
+                do_rtb(dc);
+            } else {
+                do_rte(dc);
+            }
         }
 
         /* Complete the branch, ending the TB. */
@@ -1723,8 +1724,12 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
              */
             break;
         case DISAS_NEXT:
-            /* Normal insn a delay slot.  */
-            dc->base.is_jmp = DISAS_JUMP;
+            /*
+             * Normal insn a delay slot.
+             * However, the return-from-exception type insns should
+             * return to the main loop, as they have adjusted MSR.
+             */
+            dc->base.is_jmp = (rt_ibe ? DISAS_EXIT_JUMP : DISAS_JUMP);
             break;
         case DISAS_EXIT_NEXT:
             /*
-- 
2.25.1


