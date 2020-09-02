Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D3BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2424206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCqGg2dX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2424206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVnc-0006Hw-1j
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk3-0000Cn-6p
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:11 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk1-000570-BO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id k15so3126865pfc.12
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bvhdtXrSIM3NEnJbmmhCUh2leRjNnWI0Ll13IhtWA9I=;
 b=iCqGg2dXDJbM8pBaJgyTdelAIQes6j40WzrD7VOqHPF5b533DQzuCa66AkyTraUzk2
 J6+NZc7LSTXMwYxejOErvdlTuDDtyoifZdPyhnqSu1tZvwNGOffYMhF9n9QGW2d5JOLy
 HGhAe8AkESqLA7gCZ4WxNxX8NgG/9K1qRUzkDnYELHDoYDTAThze0fn1C5kUkmGtQ92O
 0PZyJrE9F23RmrQWPxEnJgKEmXZZKgzqSXUq9EZpeCm5RDOT5pH142+X9hxAFUwOUXjw
 kNRPzo8MZTvesdcFZjm55RggedgkTTnUOYA5wJsGjsvj6nDJng4Y+3Yj3Sq/Wfbj5TDt
 OYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bvhdtXrSIM3NEnJbmmhCUh2leRjNnWI0Ll13IhtWA9I=;
 b=uaAL+h2378/CrS52Dmsgmmoyfjehphko1bcWj2cKeyexeutEA+m9gGk+zvhXnNYNdd
 uUz4vPwiEPUIhzJR+u1z1vHpTSoTqard74f+Uvee2oXjcMmrmrDxUscBiWXR8uPnF8ce
 tZeUl+v5W7YwryZNS+I4rJ07Co0kSTOjErIN3yoww1QNXEdTDfD9kTRiyPklkERIeITA
 PyPFXM6zZSOlO5puqTls+fu/Op+4GcOaUW6G1vwtva7kR5wRootzCsr6He0P4o79uoIN
 pCO5k1v36k6cd+TCPrAJPflUyVCCEQiuRRvKoo1wfZyvQH/t5p2He540dwaSb0qzCuXy
 S+Bg==
X-Gm-Message-State: AOAM533LsNG0O5LtxjvPUvvm801OSleje9JlKRjuzSnow72S0PHG6hkH
 fpKsbwqy2RYLCp5F2QSTtWFv0iKn9ue6hg==
X-Google-Smtp-Source: ABdhPJxREbUjKki+iAqJyvUP2TFtnq/GWMzVHo2LwX9NWelEyu0/itEV2yrnFP2y1tKapGNBcwADBg==
X-Received: by 2002:a63:4503:: with SMTP id s3mr2558493pga.119.1599064567197; 
 Wed, 02 Sep 2020 09:36:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm4955441pjz.33.2020.09.02.09.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:36:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/microblaze: Force rtid, rted, rtbd to exit
Date: Wed,  2 Sep 2020 09:35:57 -0700
Message-Id: <20200902163559.1077728-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902163559.1077728-1-richard.henderson@linaro.org>
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@xilinx.com
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
index 459b25f8b9..a94f3e340e 100644
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


