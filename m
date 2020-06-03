Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3502C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705C12072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/q0uTVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705C12072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI8k-0007s9-MG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyV-00040p-H2
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyP-0003Zm-CQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id b16so395832pfi.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lQUCdDSymie/7dQ1iavooQ03Mfu1YJhrKa9eVrF8VLk=;
 b=U/q0uTVoFwQhjnL9XwKPSwInTYw7BqC/t+ZGwi4JRUW/sPbFLP5A5TDNoSz6MTkBvb
 sgs0BUjzNzoB8LmB8YKm/6ZQJs/NGKZ+1R5pGrovVN+iMAKzyjFLFGDQaDlqEYiFZGj/
 ib41y5livE10QOUJLkkGuFlUPOscTndPf6Povg7tGl03wj5imEdYaYEDAjwoa8/Qgs+c
 ywnz91TtgvzVIDXjPaILVMYrIIfqIM66v3ycbganuzBIm/m2X3X7awbcqMbLf+Ltn8Kp
 +6sFQz0G9xLrXbRou2x9BeEVGzd7+JK5o5und6fnd6pYbBljpg89+5FDDYmZDebydoQw
 iRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lQUCdDSymie/7dQ1iavooQ03Mfu1YJhrKa9eVrF8VLk=;
 b=KvC7dZA5w1m+1HEk/jgqAuX6HwRz2GSFTJspohJmeDsWoAjb40Xxs9u4MY8HdcWVWC
 6CqenacNKxDnYw1lcfwT1S5sPq4InzHFZGaNcLK9ZyKEBdQ6OSWSJNO/D0KNEbzO1Xqp
 EGYzvFdvMPHiQJtOeVeuUDdEK0Bvkbd6HFF5RfI6R/HpgSs2PR9kC8btS7IpMgtDG2p4
 Ypz+JplCBmOXVM6rCl6NiazlrteGvnQa9pHmc/verMyF6GpUklsdNS77g1J1G9skd8qz
 vahMLdJd61Brl7NEA3Dl1+HRv4wq1cYX+iclhs+arQKxkwr91FawVdH7XaevExd3p5xl
 TRQg==
X-Gm-Message-State: AOAM5315FxOSAl2DCmR30tKF9wt53iRvsL4ZuARW523Opl/Sm0kpYEZ1
 X0kPOPBmKzwYgmI2A8tqmSQ6XP55aiY=
X-Google-Smtp-Source: ABdhPJweJcy9L2BN2eJViQIUDofbMLQTfj5PsoTP+63f77NAOiimesWlL4yX+cYxsoe3QxzbXTcAsQ==
X-Received: by 2002:a63:348:: with SMTP id 69mr25417768pgd.68.1591146819477;
 Tue, 02 Jun 2020 18:13:39 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 16/42] target/arm: Implement the STGP instruction
Date: Tue,  2 Jun 2020 18:12:51 -0700
Message-Id: <20200603011317.473934-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Handle atomicity, require pre-cleaned address.
v6: Fix constant offset shift, non-checked address, use pre-computed ata.
---
 target/arm/translate-a64.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0725c2ca07..2fc070ab90 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2681,7 +2681,7 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
  * +-----+-------+---+---+-------+---+-------+-------+------+------+
  *
  * opc: LDP/STP/LDNP/STNP        00 -> 32 bit, 10 -> 64 bit
- *      LDPSW                    01
+ *      LDPSW/STGP               01
  *      LDP/STP/LDNP/STNP (SIMD) 00 -> 32 bit, 01 -> 64 bit, 10 -> 128 bit
  *   V: 0 -> GPR, 1 -> Vector
  * idx: 00 -> signed offset with non-temporal hint, 01 -> post-index,
@@ -2706,6 +2706,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     bool is_signed = false;
     bool postindex = false;
     bool wback = false;
+    bool set_tag = false;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2718,6 +2719,14 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 
     if (is_vector) {
         size = 2 + opc;
+    } else if (opc == 1 && !is_load) {
+        /* STGP */
+        if (!dc_isar_feature(aa64_mte_insn_reg, s) || index == 0) {
+            unallocated_encoding(s);
+            return;
+        }
+        size = 3;
+        set_tag = true;
     } else {
         size = 2 + extract32(opc, 1, 1);
         is_signed = extract32(opc, 0, 1);
@@ -2758,7 +2767,7 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
         return;
     }
 
-    offset <<= size;
+    offset <<= (set_tag ? LOG2_TAG_GRANULE : size);
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
@@ -2768,8 +2777,22 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     if (!postindex) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
-    clean_addr = clean_data_tbi(s, dirty_addr);
 
+    if (set_tag) {
+        if (!s->ata) {
+             /*
+              * TODO: We could rely on the stores below, at least for
+              * system mode, if we arrange to add MO_ALIGN_16.
+              */
+            gen_helper_stg_stub(cpu_env, dirty_addr);
+        } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
+        } else {
+            gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
+        }
+    }
+
+    clean_addr = clean_data_tbi(s, dirty_addr);
     if (is_vector) {
         if (is_load) {
             do_fp_ld(s, rt, clean_addr, size);
-- 
2.25.1


