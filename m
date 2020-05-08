Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E387C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85EC20736
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIhHJCeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85EC20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4jq-0002qk-1y
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eZ-0002bQ-Be
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:07 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:35219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eY-00042m-7X
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:06 -0400
Received: by mail-pj1-x1033.google.com with SMTP id ms17so4369226pjb.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ttVl6jOSw63HNdDDKNW/a5GZXc6b0Nu+B39Nrdhmmqk=;
 b=nIhHJCebSLcm7z5/g0cfooKLlp3XHQGAgAk/W5Lhq234u8TQgs0XdPtdpCekanGBD3
 2rpXjBSi6nCtenXzcF6xvMsC4xkJw2kOpYjYPut8IziLgTcfsJv+9V8xCFCl/J26CuG/
 ikwBojyyiBUE+Kqb4BHO9OMV+T24VHkIOQvd0i/PojvJ2UOjpq9+fJ3c4SPkn68emmoi
 c6OPf+vmtwdsYaCTteiOVL8TcPh3gzFsLjbdkvdYCLthsmbtNV2g6sVnmbPB7NA5LjIa
 lKgc4UMUtF2WsG+WSFUGjEp0o4hCstXxvh1XS7yFkmswomnaXs+wdhZi24UYGBGKKvJ6
 MeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttVl6jOSw63HNdDDKNW/a5GZXc6b0Nu+B39Nrdhmmqk=;
 b=kFH2a8LR2Ne2pGq3O3zQjWAmKHdUSUTFSmCH5ex5by9NTuBDhqVCoBSrDlHVcQrYgp
 EE5DnTzE3zzlnSzyhIdQWbn69eGtMa5NrXG2rLw3IDfRGLF8QiaHuJXZ1ldfwv9w+QyB
 ZX0RjxiIu3s/KuOwrqNd38BSOjl+G6XAhl2pqbdgmz1HQyDmq8QhDwo3G5NlrY0IAIYb
 O6/5MF2SYgzs0jDrZ5kvgpk+ri8wO+LHlw/aN3oMVM5wqNmbVLVzX7Br8x3hAJukQSW3
 GW6IXFJ59U5+PYNlqoQmqDpI4GXBPDexZu8s9pJfry2M1owuwLzjtfaxiZj1suTwwRv5
 +WLw==
X-Gm-Message-State: AGi0PuZn3xL6+CRVHMna3D5iP7ofmdQG4LFLHGIMnpdGHRZhHZoEg6O4
 zQC5cta9vSKx3OYFoHHW2E8g8LIfo9w=
X-Google-Smtp-Source: APiQypI7GvTfzGY+2a6SLmvulF+U/peuJmsgHimN+Yz+ngo9IPYLrEuWiHF3VDluqOm3WNmA+RP1mw==
X-Received: by 2002:a17:90a:258a:: with SMTP id
 k10mr6510947pje.231.1588950664455; 
 Fri, 08 May 2020 08:11:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d13sm1557562pga.64.2020.05.08.08.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:11:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/10] tcg/aarch64: Implement INDEX_op_rotl{i,v}_vec
Date: Fri,  8 May 2020 08:10:51 -0700
Message-Id: <20200508151055.5832-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151055.5832-1-richard.henderson@linaro.org>
References: <20200508151055.5832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For immediate rotate , we can implement this in two instructions,
using SLI.  For variable rotate, the oddness of aarch64 right-shift-
as-negative-left-shift means a backend-specific expansion works best.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.opc.h |  1 +
 tcg/aarch64/tcg-target.inc.c | 53 ++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
index 26bfd9c460..bce30accd9 100644
--- a/tcg/aarch64/tcg-target.opc.h
+++ b/tcg/aarch64/tcg-target.opc.h
@@ -12,3 +12,4 @@
  */
 
 DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
+DEF(aa64_sli_vec, 1, 2, 1, IMPLVEC)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 843fd0ca69..760b0e742d 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -557,6 +557,7 @@ typedef enum {
     I3614_SSHR      = 0x0f000400,
     I3614_SSRA      = 0x0f001400,
     I3614_SHL       = 0x0f005400,
+    I3614_SLI       = 0x2f005400,
     I3614_USHR      = 0x2f000400,
     I3614_USRA      = 0x2f001400,
 
@@ -2411,6 +2412,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sari_vec:
         tcg_out_insn(s, 3614, SSHR, is_q, a0, a1, (16 << vece) - a2);
         break;
+    case INDEX_op_aa64_sli_vec:
+        tcg_out_insn(s, 3614, SLI, is_q, a0, a2, args[3] + (8 << vece));
+        break;
     case INDEX_op_shlv_vec:
         tcg_out_insn(s, 3616, USHL, is_q, vece, a0, a1, a2);
         break;
@@ -2498,8 +2502,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shlv_vec:
     case INDEX_op_bitsel_vec:
         return 1;
+    case INDEX_op_rotli_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
         return -1;
     case INDEX_op_mul_vec:
     case INDEX_op_smax_vec:
@@ -2517,14 +2524,24 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGv_vec v0, v1, v2, t1;
+    TCGv_vec v0, v1, v2, t1, t2;
+    TCGArg a2;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
     v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-    v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a2 = va_arg(va, TCGArg);
+    v2 = temp_tcgv_vec(arg_temp(a2));
 
     switch (opc) {
+    case INDEX_op_rotli_vec:
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_shri_vec(vece, t1, v1, -a2 & ((8 << vece) - 1));
+        vec_gen_4(INDEX_op_aa64_sli_vec, type, vece,
+                  tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(v1), a2);
+        tcg_temp_free_vec(t1);
+        break;
+
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
         /* Right shifts are negative left shifts for AArch64.  */
@@ -2537,6 +2554,35 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         tcg_temp_free_vec(t1);
         break;
 
+    case INDEX_op_rotlv_vec:
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_dupi_vec(vece, t1, 8 << vece);
+        tcg_gen_sub_vec(vece, t1, v2, t1);
+        /* Right shifts are negative left shifts for AArch64.  */
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
+        tcg_gen_or_vec(vece, v0, v0, t1);
+        tcg_temp_free_vec(t1);
+        break;
+
+    case INDEX_op_rotrv_vec:
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t1, v2);
+        tcg_gen_dupi_vec(vece, t2, 8 << vece);
+        tcg_gen_add_vec(vece, t2, t1, t2);
+        /* Right shifts are negative left shifts for AArch64.  */
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t2),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t2));
+        tcg_gen_or_vec(vece, v0, t1, t2);
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+        break;
+
     default:
         g_assert_not_reached();
     }
@@ -2557,6 +2603,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
     static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
+    static const TCGTargetOpDef w_0_w = { .args_ct_str = { "w", "0", "w" } };
     static const TCGTargetOpDef w_w_wO = { .args_ct_str = { "w", "w", "wO" } };
     static const TCGTargetOpDef w_w_wN = { .args_ct_str = { "w", "w", "wN" } };
     static const TCGTargetOpDef w_w_wZ = { .args_ct_str = { "w", "w", "wZ" } };
@@ -2751,6 +2798,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w_wZ;
     case INDEX_op_bitsel_vec:
         return &w_w_w_w;
+    case INDEX_op_aa64_sli_vec:
+        return &w_0_w;
 
     default:
         return NULL;
-- 
2.20.1


