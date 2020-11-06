Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E8AC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FCC20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb1ky7aZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FCC20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasVi-0001cG-F2
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRV-0004bF-Rv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:37 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRT-0006uu-61
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:37 -0500
Received: by mail-pf1-x443.google.com with SMTP id q10so66244pfn.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hAEMbLEJD/eBtWNiswR+L4HBV0VLxFFaL5IoMfIX6Q4=;
 b=Wb1ky7aZaeMc9ZSq/zJT7asggQ/Dsu6qsjq8mAcTxU+2nC7pzEtfu7ttl/u1as64UC
 7FvRh8VNYpLVomedrVsq5YszXmVg0FZA5Q/OTV2pgAFKQgbuyyA/WSlLn7SUjZnumBih
 y9OohcyXCcQajRKG9Lhw/LeyRzTBjg/nDQzwYpFMHdmsiRynw99zqLgfSUEacCCGa0Rb
 jTgmQq1ky0LVDY+YItLP8OZdXiGTPJ7+Lcj92rPEXPFRJghf/BZIuXUE9XHEePUwb7i4
 EO2KW9Ks8Ewtl0dlsvhbd25fdWarfQk/qXm16ShCkE589tfNmKQzN0xfAElbZkHTgaTS
 IWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hAEMbLEJD/eBtWNiswR+L4HBV0VLxFFaL5IoMfIX6Q4=;
 b=m1XjfRykn54RYJKjfVuWMhPVDBNYqu+RSk2qQdsCXIKXtCb4gPs2PTA9CsvilT7CLA
 YSzAOFel0bleoojsf+SRvzD1adGS7HUGgol6BR0ORZ2PgQS+JL8WBlDwyQSDN9FsL5U5
 ljK159t3phEumDeXQqsNjGa0l42pgYov3l52EUTM90iGF0iIFih5Qn22Td/6nqmY5NS9
 n9tuWt0H+I0WuAc0pulnd7eSyJD1T+jSnomujDaef1B+XqqJB3v5X2zveNfHxlcX09qS
 hIM8jmOkKRJfZ61l6WmMybE2L546Ecj/6QXozzXA9yMSjBnAjsViIyXu2h7lU/jRlB68
 DtEA==
X-Gm-Message-State: AOAM53226vwY9FC1ElJt5c3aMV027QYEhKUp7mCSJxGFbTGjwESFfGmF
 YLUI+GNNY9dWHuawP96rogMmIJG6YtzPpw==
X-Google-Smtp-Source: ABdhPJyPTzWtqtckewyZ/+MrCh77Nuv2dQhJ189dcXcaOYrfFu/1rp2/l5O/U5fb0u6xVVjmbprmNA==
X-Received: by 2002:aa7:8b0b:0:b029:152:900d:2288 with SMTP id
 f11-20020aa78b0b0000b0290152900d2288mr91746pfd.53.1604633373663; 
 Thu, 05 Nov 2020 19:29:33 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/41] tcg: Adjust tcg_out_label for const
Date: Thu,  5 Nov 2020 19:28:48 -0800
Message-Id: <20201106032921.600200-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify the arguments to always use s->code_ptr instead of
take it as an argument.  That makes it easy to ensure that
the value_ptr is always the rx version.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                 |  6 +++---
 tcg/i386/tcg-target.c.inc | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index d3eeea355c..e5d2208e88 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -301,11 +301,11 @@ static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
     QSIMPLEQ_INSERT_TAIL(&l->relocs, r, next);
 }
 
-static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
+static void tcg_out_label(TCGContext *s, TCGLabel *l)
 {
     tcg_debug_assert(!l->has_value);
     l->has_value = 1;
-    l->u.value_ptr = tcg_splitwx_to_rx(ptr);
+    l->u.value_ptr = tcg_splitwx_to_rx(s->code_ptr);
 }
 
 TCGLabel *gen_new_label(void)
@@ -4322,7 +4322,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
             break;
         case INDEX_op_set_label:
             tcg_reg_alloc_bb_end(s, s->reserved_regs);
-            tcg_out_label(s, arg_label(op->args[0]), s->code_ptr);
+            tcg_out_label(s, arg_label(op->args[0]));
             break;
         case INDEX_op_call:
             tcg_reg_alloc_call(s, op);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 095553ce28..0ac1ef3d82 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1452,7 +1452,7 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
     default:
         tcg_abort();
     }
-    tcg_out_label(s, label_next, s->code_ptr);
+    tcg_out_label(s, label_next);
 }
 #endif
 
@@ -1494,10 +1494,10 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 
         tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
         tcg_out_jxx(s, JCC_JMP, label_over, 1);
-        tcg_out_label(s, label_true, s->code_ptr);
+        tcg_out_label(s, label_true);
 
         tcg_out_movi(s, TCG_TYPE_I32, args[0], 1);
-        tcg_out_label(s, label_over, s->code_ptr);
+        tcg_out_label(s, label_over);
     } else {
         /* When the destination does not overlap one of the arguments,
            clear the destination first, jump if cond false, and emit an
@@ -1511,7 +1511,7 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
         tcg_out_brcond2(s, new_args, const_args+1, 1);
 
         tgen_arithi(s, ARITH_ADD, args[0], 1, 0);
-        tcg_out_label(s, label_over, s->code_ptr);
+        tcg_out_label(s, label_over);
     }
 }
 #endif
@@ -1525,7 +1525,7 @@ static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
         TCGLabel *over = gen_new_label();
         tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
         tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
-        tcg_out_label(s, over, s->code_ptr);
+        tcg_out_label(s, over);
     }
 }
 
-- 
2.25.1


