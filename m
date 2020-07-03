Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C36720760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U96guFZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C36720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP7j-0004uO-OJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxH-0004xa-9v
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxF-0005gj-Fj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id w3so22288991wmi.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iUQU2oplSMWnXTckOnwpuiVAWqwg6rxiHqd3JFEyT8I=;
 b=U96guFZBkr7NARRWba9BUEWURYSCfBM2X7oUjQqWA4jcfdTSNyuEWAM8YU01tHuqeZ
 kYvyWgG7ov8Y6wTn2+4QxHge860sOttrLlz/OHAyNrcS3eHD9N3EXzfA87+y3NR9MMA1
 0hQwyKw5pCFSxsP8IH7hTbjN8S8f3lN1UU40bkR1vAcc9yef0tyLT+So5bx/AoD0kft5
 5vhh0pmR10m7KhUsStMTPJexFrzRG8bFACkAoKPsUMvmkZP3yy9b3gDdE2/QfOIRGUzw
 gsHqaZrTa+eVtNSOeEC1IBtgn59opCj9JK0TmvjLAkl3gUIFA2kG6vbQGzNjJNEzoe9W
 +f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iUQU2oplSMWnXTckOnwpuiVAWqwg6rxiHqd3JFEyT8I=;
 b=GX+xyss67knSA0Y92mSelWm0AvJWv4kWy1SSl4RgXcTmqr85Dxz8+qDSJhtwJ2gjSd
 0Ze+MEY9NLdIg676yE889N0qSUB6xOUNu24t5Xhz859c2BZi7YN6cqBRWLvHKFi7lkQj
 88SrSLaH7R8ECX3ja4RL6sktlag0oeyki2U6VKizb71jCN5v1KN+1T/djfqntYGqBg/F
 FnNq4jk9azdGMv9PvCP6gcNGSugL3fCUBBvuR5KNkL6cEn9ViGhnrhNp3cTatLs8c9lP
 WfLy9jEuNtDzM2s2U+8pQ9NcoKKReStUBdAuIT8Ux9g/4KY/66KubvPr/x/8Szvhk7/8
 9b8w==
X-Gm-Message-State: AOAM532lFUfpJnQ5YglonvPrRls9hrocrSMvSIK+xWbbt5nR4rdqM70i
 PI8JxzZQYGMSNOhlS+YabVZ5MVI7Y30oAg==
X-Google-Smtp-Source: ABdhPJyAXhsbyx4NS9f8qH3gTOQfP7XLEVn84XabyA6qyITseT9r/yaWQQdpFVNt2wXDN25DY7IlnA==
X-Received: by 2002:a1c:2257:: with SMTP id i84mr36890908wmi.158.1593795263785; 
 Fri, 03 Jul 2020 09:54:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/34] target/arm: Fix temp double-free in sve ldr/str
Date: Fri,  3 Jul 2020 17:53:46 +0100
Message-Id: <20200703165405.17672-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The temp that gets assigned to clean_addr has been allocated with
new_tmp_a64, which means that it will be freed at the end of the
instruction.  Freeing it earlier leads to assertion failure.

The loop creates a complication, in which we allocate a new local
temp, which does need freeing, and the final code path is shared
between the loop and non-loop.

Fix this complication by adding new_tmp_a64_local so that the new
local temp is freed at the end, and can be treated exactly like
the non-loop path.

Fixes: bba87d0a0f4
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200702175605.1987125-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h | 1 +
 target/arm/translate-a64.c | 6 ++++++
 target/arm/translate-sve.c | 8 ++------
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 49e4865918d..647f0c74f62 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -30,6 +30,7 @@ void unallocated_encoding(DisasContext *s);
     } while (0)
 
 TCGv_i64 new_tmp_a64(DisasContext *s);
+TCGv_i64 new_tmp_a64_local(DisasContext *s);
 TCGv_i64 new_tmp_a64_zero(DisasContext *s);
 TCGv_i64 cpu_reg(DisasContext *s, int reg);
 TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 73d753f11fb..8c0764957c8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -461,6 +461,12 @@ TCGv_i64 new_tmp_a64(DisasContext *s)
     return s->tmp_a64[s->tmp_a64_count++] = tcg_temp_new_i64();
 }
 
+TCGv_i64 new_tmp_a64_local(DisasContext *s)
+{
+    assert(s->tmp_a64_count < TMP_A64_MAX);
+    return s->tmp_a64[s->tmp_a64_count++] = tcg_temp_local_new_i64();
+}
+
 TCGv_i64 new_tmp_a64_zero(DisasContext *s)
 {
     TCGv_i64 t = new_tmp_a64(s);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f318ca265f2..08f0fd15b28 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4372,9 +4372,8 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 
         /* Copy the clean address into a local temp, live across the loop. */
         t0 = clean_addr;
-        clean_addr = tcg_temp_local_new_i64();
+        clean_addr = new_tmp_a64_local(s);
         tcg_gen_mov_i64(clean_addr, t0);
-        tcg_temp_free_i64(t0);
 
         gen_set_label(loop);
 
@@ -4422,7 +4421,6 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         tcg_gen_st_i64(t0, cpu_env, vofs + len_align);
         tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(clean_addr);
 }
 
 /* Similarly for stores.  */
@@ -4463,9 +4461,8 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 
         /* Copy the clean address into a local temp, live across the loop. */
         t0 = clean_addr;
-        clean_addr = tcg_temp_local_new_i64();
+        clean_addr = new_tmp_a64_local(s);
         tcg_gen_mov_i64(clean_addr, t0);
-        tcg_temp_free_i64(t0);
 
         gen_set_label(loop);
 
@@ -4509,7 +4506,6 @@ static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
         }
         tcg_temp_free_i64(t0);
     }
-    tcg_temp_free_i64(clean_addr);
 }
 
 static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
-- 
2.20.1


