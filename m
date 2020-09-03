Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E856C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0991520678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbUCyK71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxLb-0003pT-7l
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwyr-0007TK-Hs
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:38145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDwym-0004al-N9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:41:16 -0400
Received: by mail-pg1-x52c.google.com with SMTP id l191so3164590pgd.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XhMSwJ2jkxWxuBTzeCmlaoUshyrdzQ2sWDC5rvAjlMw=;
 b=fbUCyK71YOSWuyozk4rmhaR+mgQzn6PTYzicPW2WJwUIlYN0XCHpvUl3c5flK5GtzU
 3u30FNI5Z5AshCtiqjot4nCgd3tTPAkTX5IdpUWysy2annB0xTtNg+MxCc8J2AfWv/Sn
 va7rd+ocBjm7q+5zyynog+PE0GwqP4YlBHo0PcmlcfPUOXALZoJMrxA33zeJYudab5HY
 ggFA74cdKdlWz5Se+Lp9WTDwzuJh2XtCanRg3rtvB+Mph+tx2rOlp4psptYRexemkBo0
 EtAHIkHqaBZHq9QehCI46fdH60EiDSoWfaHVxKIjrUW+J3n6iqMuh7y3WyV6GopXTMdw
 3XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XhMSwJ2jkxWxuBTzeCmlaoUshyrdzQ2sWDC5rvAjlMw=;
 b=LiMCzOB04keSnzHnC0A4iIdMd7LVmir/bnFI25nbTkP96+MT3M27Yemh5AFdKLLk/k
 KEj/Xb4lFFDdbYb1AJ5h0E9RtD/HSfTY5mT80h5jqHljnXXUWZTYmoGAzgT1FvSyFK0m
 +RVplJT/YGo+PnbaE2WDu3i/Uo0/4jXGXe1YqWU9JTiQgYBXCOV+dLSOCUlYWYOGzfI5
 9pU6jJ6NfrdaYWuPupORBk+i4Owa/jFvt2NADCH+iQeSxeyLLa0Om8clK5iF3W4EW9Lz
 +ZXvp9OA3HnOYlGs54HrahciNxflqMCiajQ/12T5o2/bHmkiRoiNktn9WYfCSy8Xhfrg
 0goA==
X-Gm-Message-State: AOAM5318tQLNxgy9X+dz0I4BW14StmZcIE8uER5bOlcxapvXPrw6DsYg
 1WL622NYobDN1cOIHofAfetLQ98QiTIxSw==
X-Google-Smtp-Source: ABdhPJyUyOCLK1s2Ur/M1ErMpX8tT3GnMLFycu0N1b7WGAJUMprdpvI+xLd8Zf3/bWtlWE+VZq6dfw==
X-Received: by 2002:a62:1d44:: with SMTP id d65mr5725038pfd.150.1599169270638; 
 Thu, 03 Sep 2020 14:41:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v17sm4113290pfn.24.2020.09.03.14.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:41:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
Date: Thu,  3 Sep 2020 14:41:01 -0700
Message-Id: <20200903214101.1746878-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903214101.1746878-1-richard.henderson@linaro.org>
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already support duplication of 128-bit blocks.  This extends
that support to 256-bit blocks.  This will be needed by SVE2.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 52 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index fcc25b04e6..7ebd9e8298 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1570,12 +1570,10 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             do_dup(vece, dofs, oprsz, maxsz, NULL, in, 0);
             tcg_temp_free_i64(in);
         }
-    } else {
+    } else if (vece == 4) {
         /* 128-bit duplicate.  */
-        /* ??? Dup to 256-bit vector.  */
         int i;
 
-        tcg_debug_assert(vece == 4);
         tcg_debug_assert(oprsz >= 16);
         if (TCG_TARGET_HAS_v128) {
             TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V128);
@@ -1601,6 +1599,54 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
         if (oprsz < maxsz) {
             expand_clr(dofs + oprsz, maxsz - oprsz);
         }
+    } else if (vece == 5) {
+        /* 256-bit duplicate.  */
+        int i;
+
+        tcg_debug_assert(oprsz >= 32);
+        tcg_debug_assert(oprsz % 32 == 0);
+        if (TCG_TARGET_HAS_v256) {
+            TCGv_vec in = tcg_temp_new_vec(TCG_TYPE_V256);
+
+            tcg_gen_ld_vec(in, cpu_env, aofs);
+            for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
+                tcg_gen_st_vec(in, cpu_env, dofs + i);
+            }
+            tcg_temp_free_vec(in);
+        } else if (TCG_TARGET_HAS_v128) {
+            TCGv_vec in0 = tcg_temp_new_vec(TCG_TYPE_V128);
+            TCGv_vec in1 = tcg_temp_new_vec(TCG_TYPE_V128);
+
+            tcg_gen_ld_vec(in0, cpu_env, aofs);
+            tcg_gen_ld_vec(in1, cpu_env, aofs + 16);
+            for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
+                tcg_gen_st_vec(in0, cpu_env, dofs + i);
+                tcg_gen_st_vec(in1, cpu_env, dofs + i + 16);
+            }
+            tcg_temp_free_vec(in0);
+            tcg_temp_free_vec(in1);
+        } else {
+            TCGv_i64 in[4];
+            int j;
+
+            for (j = 0; j < 4; ++j) {
+                in[j] = tcg_temp_new_i64();
+                tcg_gen_ld_i64(in[j], cpu_env, aofs + j * 8);
+            }
+            for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
+                for (j = 0; j < 4; ++j) {
+                    tcg_gen_st_i64(in[j], cpu_env, dofs + i + j * 8);
+                }
+            }
+            for (j = 0; j < 4; ++j) {
+                tcg_temp_free_i64(in[j]);
+            }
+        }
+        if (oprsz < maxsz) {
+            expand_clr(dofs + oprsz, maxsz - oprsz);
+        }
+    } else {
+        g_assert_not_reached();
     }
 }
 
-- 
2.25.1


