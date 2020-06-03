Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9686C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A432072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQqRAbWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A432072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIDC-000828-PH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyo-0004vP-7c
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyn-0003fw-AW
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id t7so572871pgt.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dm0P0EGuKeATfeCtNBK49sionbdZGtbXaMOAetX5rZs=;
 b=bQqRAbWMVYn9fQvJ5IJIkMjuuJ0sEMoCMhU679pbtyLpBMtbafrB5d/aW0BJRyzqn5
 hStVgnyCxQYrnwNY1ZZ6qgb6nBeVQW3dvHgboc19u7T7vyB86zRptt8Ew09ilzyX6ZrK
 ZlQql5SFAs4OPiEYspvicmabBIxl55NyL2Qv1fmJ/WFrE+rBeKO2SB7iq0ZAOxKlxNID
 8EziWdMhA09LyMHZzCuc2wefDlfj5PbKOf/+DFpuwKqza6oIonvW1uiCEWJi3mcY8w8i
 hEqMt1b4LllyATNYCBhHEO9k0wfW8M+KRmLyIr4z2dXbbkW3NnqdG9+dx2y35AIBHtxf
 spCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dm0P0EGuKeATfeCtNBK49sionbdZGtbXaMOAetX5rZs=;
 b=Wnm6Hor4DnfaapxsfjZqrsubBYgtFq89ziqO3PMurJDxxnWy1nBe548IlrfbSxdzs4
 gEDhIS3ZuJEltt2zKf0/6EbFBQF2c1RtF94IgGYz6uZmcGnPR17UJdAfEk5TGJ7SK2l5
 fftYnxdexxjyWU9f3NVUyWfNsAG8wzch+ye8s/UWxMSaGQa/FwdhtRGaKpd36VM7eCqt
 NYZ3VpqRqrTPr5nCEW/kWIXrebXeu/nkUYqEwbAFgOW0fe6y2wETnSkEgJctPskYXyQs
 C6KGHR4R2R0Lg4joODjd7mwPqpcofR6nR0dW3XmtPckibUDGLRVAV6+Q3/yZ3jbEatzf
 svsA==
X-Gm-Message-State: AOAM5300buVKFmup8xBkRJVkJCy8yBvjuZ6g/tJm1Urtdnb3o9wrpbaz
 skS6bGmqfqaro8MdMtOirTL+iyEBMiU=
X-Google-Smtp-Source: ABdhPJy7sELhfw/5ZZivzDLaVB/cXRw1I3XFT+xXa/Uq83LUB9B5YUHi2hcgWIfPYXTkU6Aot/DcgA==
X-Received: by 2002:a17:90a:df16:: with SMTP id
 gp22mr2330595pjb.6.1591146843684; 
 Tue, 02 Jun 2020 18:14:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:14:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 34/42] target/arm: Handle TBI for sve scalar + int memory
 ops
Date: Tue,  2 Jun 2020 18:13:09 -0700
Message-Id: <20200603011317.473934-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

We still need to handle tbi for user-only when mte is inactive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 1 +
 target/arm/translate-a64.c | 2 +-
 target/arm/translate-sve.c | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index d0f2e131b3..548414d09f 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -40,6 +40,7 @@ TCGv_ptr get_fpstatus_ptr(bool);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
 bool sve_access_check(DisasContext *s);
+TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr);
 TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int log2_size);
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c7deeca86a..394633babd 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -215,7 +215,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
  * of the write-back address.
  */
 
-static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
+TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a1dc325104..e7ed48c418 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4534,9 +4534,8 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * For e.g. LD4, there are not enough arguments to pass all 4
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
-     * TODO: mte_n check here while callers are updated.
      */
-    if (mte_n && s->mte_active[0]) {
+    if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
@@ -4546,7 +4545,10 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
         desc = FIELD_DP32(desc, MTEDESC, TSIZE, mte_n << msz);
         desc <<= SVE_MTEDESC_SHIFT;
+    } else {
+        addr = clean_data_tbi(s, addr);
     }
+
     desc = simd_desc(vsz, vsz, zt | desc);
     t_desc = tcg_const_i32(desc);
     t_pg = tcg_temp_new_ptr();
-- 
2.25.1


