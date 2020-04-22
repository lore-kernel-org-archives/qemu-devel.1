Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB05EC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9421320724
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mo7m2kRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9421320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4LE-0001zT-P7
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41m-0002Ge-CP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41f-0002oY-Eu
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:12 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:38861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41e-0002lx-VM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:07 -0400
Received: by mail-pg1-x536.google.com with SMTP id p8so257148pgi.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QfWAHFHlg6tn3+AwefIzGfld6vj/4nB9ZCqh/vx2MbY=;
 b=Mo7m2kRtMkhCAkad0lAxsMuokBvbCHMssHlfLzO8pq54bC1xHTfpJBknQRJOfLUtoW
 rOuiTJqoiWB7+i+YT0jTe/gkeSWCIlegKmO7e6nAhVSEv/fiO/+bIPe+MhyU9hGpwaHW
 GR6X0351nOXTtfSLyGVPQ6U5hTjj+EkR7ZqxlQxtz/UXpGXaQOnXaMwiaLdIEnFdqNQx
 JsCrXW2kNVGHDSFN5xznUk5frz0K0lHQOktzPwktMbHaQPmPDcXcL6E9P+gao/KwOLVZ
 5mudqOoY53EBJz4BcvT9r2oQxkkh4L6GSB6ETxnK0mnUfewCNM8inv8AnMwqLHgAiDxV
 9yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QfWAHFHlg6tn3+AwefIzGfld6vj/4nB9ZCqh/vx2MbY=;
 b=OG/wcy3pbCJZX/hMOFOpvs1iHbtW1lEsAiNjo5nOhN9WH9W2S2tBwYh0MzCsvvXrup
 XI7lnxkpOsYVSWwIzBpY0xBqM0Fm3jV5kROO5I0D7sWvaNfthmfESJjpCU6qUW73QHrD
 k0VcZ5mdPiuuUwNiyT04+m8kVDYRZQOOzYcLCoHjvtcc2QenRuu52NtDndoBFAPmJ9P0
 EQqNS7SZjrq/rP51VgUR/S4S2h5/4IF8lfrP7EKnbsvBFTA591FD3SccxUgEOkYAJ15y
 x5xvg1DrjAm0KS3g8Z1LBT3ss6lEN6SaPGQTpGnnuE39ges4cWZ9qIPgFJIQdaXPBbr1
 tigg==
X-Gm-Message-State: AGi0PuYgFR86L09/yDbKTXuQ0eBygPLhxW5k9NYHKD5s/ZJiX1c+DGhd
 v/2BGOllnReKscZGmgx/vhpX5CIA+Ag=
X-Google-Smtp-Source: APiQypLoTITqRgU5nuVvvwYmeT2SSMQIv33picunG3Aw44MgIu8gwsfaMV7SEV9bKEHY3qfrRp2YZg==
X-Received: by 2002:a63:1210:: with SMTP id h16mr23575196pgl.328.1587518285197; 
 Tue, 21 Apr 2020 18:18:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:18:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 33/36] tcg/aarch64: Implement INDEX_op_rotli_vec
Date: Tue, 21 Apr 2020 18:17:19 -0700
Message-Id: <20200422011722.13287-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::536
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

We can implement this in two instructions, using SLI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.opc.h |  1 +
 tcg/aarch64/tcg-target.inc.c | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
index 26bfd9c460..bce30accd9 100644
--- a/tcg/aarch64/tcg-target.opc.h
+++ b/tcg/aarch64/tcg-target.opc.h
@@ -12,3 +12,4 @@
  */
 
 DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
+DEF(aa64_sli_vec, 1, 2, 1, IMPLVEC)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 3b5a5d78c7..4bc9b30254 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -557,6 +557,7 @@ typedef enum {
     I3614_SSHR      = 0x0f000400,
     I3614_SSRA      = 0x0f001400,
     I3614_SHL       = 0x0f005400,
+    I3614_SLI       = 0x2f005400,
     I3614_USHR      = 0x2f000400,
     I3614_USRA      = 0x2f001400,
 
@@ -2402,6 +2403,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sari_vec:
         tcg_out_insn(s, 3614, SSHR, is_q, a0, a1, (16 << vece) - a2);
         break;
+    case INDEX_op_aa64_sli_vec:
+        tcg_out_insn(s, 3614, SLI, is_q, a0, a2, args[3] + (8 << vece));
+        break;
     case INDEX_op_shlv_vec:
         tcg_out_insn(s, 3616, USHL, is_q, vece, a0, a1, a2);
         break;
@@ -2488,6 +2492,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shlv_vec:
     case INDEX_op_bitsel_vec:
         return 1;
+    case INDEX_op_rotli_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
         return -1;
@@ -2508,13 +2513,23 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 {
     va_list va;
     TCGv_vec v0, v1, v2, t1;
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
@@ -2547,6 +2562,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
     static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
+    static const TCGTargetOpDef w_0_w = { .args_ct_str = { "w", "0", "w" } };
     static const TCGTargetOpDef w_w_wO = { .args_ct_str = { "w", "w", "wO" } };
     static const TCGTargetOpDef w_w_wN = { .args_ct_str = { "w", "w", "wN" } };
     static const TCGTargetOpDef w_w_wZ = { .args_ct_str = { "w", "w", "wZ" } };
@@ -2741,6 +2757,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w_wZ;
     case INDEX_op_bitsel_vec:
         return &w_w_w_w;
+    case INDEX_op_aa64_sli_vec:
+        return &w_0_w;
 
     default:
         return NULL;
-- 
2.20.1


