Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A89C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE60420737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWH2PyZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE60420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjgH-0007C6-VL
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeH-0002D2-Hu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:09 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeF-0001mh-In
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id m8so1587125pfh.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7UoRMIgCTJBIlKqoLjr+lb+MPy+eDOOMr1BDXkFiVtI=;
 b=iWH2PyZ55ZxTiJrZ8yfXzeJ3Dtooe8cL63QOIeLpPRStuUqvfChsl0g/hgyQFdeC5f
 4WXsuZYebIAalcV10OFyX3RNdq/VrgD+5g8LwGO5FBlTIdNGqqdVZVvvxhBhO6vrbQ6o
 woyQixptNEH0bIflvQXxZkwIb8FYIKJJ2QObwqgFORluxR90+jt/+Dx0YpGbseuySHdq
 Se5uon+MsKbg8d7EQPbO9xkHhmIlKzzjdRuPDGgYqceEWd37DG5V+wuu7W6jHTLHlbwV
 EAbhnKXvxHTEbKQA3yju9AaqNuzOeWyVCd50114/IOr6KHR4GS5ySZZu3PtJDLFnNT6I
 ncsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7UoRMIgCTJBIlKqoLjr+lb+MPy+eDOOMr1BDXkFiVtI=;
 b=KxT924GDybegcf6M9h01MQam57q2oTO7/ctDkb4s+knHqR7bLMuDY51VEATUYRcq6n
 Ma3M8Qd+ImUvIWcs3m0Nn9fE5Rq8wke4YadqHwc3/ZZ+ryA5Z+JC15/ZUt79BCHGxRXf
 2b/0UXAz9Fs+VqsWRJZORQdh05+of/yNTPWZBz2qUnaSdAj+i6KY0vSNQyTd8xbHQUiT
 9MW26STnwbaSeBi+12YO2kusLm9h+ruyEY1cUzmOCUIB4QeVLl7DA62cBf5O97dDnM3h
 iT4QEpm5e/XvOBIQpzD5xvszAoeEFXSeO9459ChcCCcsXXzezyaCbQsfGo8zMoti+xSu
 HR6A==
X-Gm-Message-State: AOAM532GsEuc+6Tq+oYvhPFgySH2txV+WXglvf3/a8rEdDzu5+HIdO1M
 Tb2IAiFgMQ6b2x5xZzSO1do06+t47fHcCg==
X-Google-Smtp-Source: ABdhPJxmxA5LfOgZvo7H+qDgxh0UIv658ln2vE4MsW0TzIVZRV4uHxV396LV1yKHZoJNQ41CBt/nwg==
X-Received: by 2002:a17:902:720a:: with SMTP id
 ba10mr2564628plb.41.1599118025951; 
 Thu, 03 Sep 2020 00:27:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x185sm1930229pfc.188.2020.09.03.00.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:27:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] target/microblaze: Force rtid, rted, rtbd to exit
Date: Thu,  3 Sep 2020 00:26:48 -0700
Message-Id: <20200903072650.1360454-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903072650.1360454-1-richard.henderson@linaro.org>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These return-from-exception type instructions have modified
MSR to re-enable various forms of interrupt.  Force a return
to the main loop.

Consolidate the cleanup of tb_flags into mb_tr_translate_insn.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 608d413c83..da84fdb20b 100644
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
          * Finish any return-from branch.
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


