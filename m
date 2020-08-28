Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC94C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86B0207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dML2YWPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86B0207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBffP-00054o-Tm
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFE-0001gT-UP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:44 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:39122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFD-0005LY-2t
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:44 -0400
Received: by mail-pg1-x52d.google.com with SMTP id v15so526369pgh.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RISUXOD2AWMs6jP2ZEWVEZMruhXXXQYxncqeH2DRHUM=;
 b=dML2YWPGGfyZ96nA+IZyV4k8asKs2lC9cWA8MKk5GozgCvzgPF3j4eeTkcJdnkEg//
 l02WhqmIXytKVqsdqLGMzuoHJgnU+uQewxA2HUvpkuQ380ciUvBuZzdGAqyB6bi22xzA
 DMQnkqkkjO2WJB+1mpWC9ucMG8XnL7XsRIiredsaIUYkefMnH5XuorPQ74sG/nEbiDV7
 4pQAdbazFB6RnCzoBvupFYzuskXX/eNKAqUi4O37Bz/Q+tG54QrvZF1LwHiMAHsw2Dm2
 DYF+kbsdxs39W1OZtQLTrJRF8WSsZ9ihcvUgQyi+DHyf6l/PfnJ2XnR/+eLAHwJrpWv0
 T2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RISUXOD2AWMs6jP2ZEWVEZMruhXXXQYxncqeH2DRHUM=;
 b=tMBHT281D/hW+/L0hmBqZyBrnQB2uT7kgDP8hcm6D3LLpLBOGTzlpwQ3v/kPG9EHWr
 6yvcfeh/wfWWoa0O27Y/AY3oasMaIN3tih7ELKlKqc98glsZx96Q4MDaRCHmHcl+s1DR
 FMWIA9mQfx0CXuFl84K5dW2mBpcLJqjrCdw/Z4/7HBTeYgzFJemQXZ1KLbC1X0bnprUX
 zT7YkTUZuksve2zFaeJgFakDe31Z5fm32oMFFMCL2SRkzOe85UOhtFfwY7qatqwZDmRg
 JG4Yjl+JaeA2LwcjpP2hzOeQ43FAk+bjagLUXyeK7A75+eFfYLYewM28h5OrkzHGQYJQ
 4fTQ==
X-Gm-Message-State: AOAM531Lov0JjkHvrFeEP7cuUi/GFguVaTcCftsfAB1kZ3EHyxZQQ0am
 sj649wqNetRCzlHjSDLgDFBybRqFiiXADA==
X-Google-Smtp-Source: ABdhPJyC/z03zO8OpM3Ka4AxfeZcbcvA3PTbwIzK4Iooky2uH5cpCQ0vzprDDLl4bBVtyufRlWuL4Q==
X-Received: by 2002:a63:3841:: with SMTP id h1mr1370545pgn.38.1598624441344;
 Fri, 28 Aug 2020 07:20:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 55/76] target/microblaze: Move bimm to BIMM_FLAG
Date: Fri, 28 Aug 2020 07:19:08 -0700
Message-Id: <20200828141929.77854-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

It makes sense to keep BIMM with D_FLAG, as they can be written
back to iflags at the same time.  BIMM_FLAG does not need to be
added to IFLAGS_TB_MASK because it does not affect the next TB,
only the exception path out of the current TB.  Renumber IMM_FLAG,
as the value 4 holds no particular significance; pack these two
flags at the bottom of the bitfield.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  4 ++--
 target/microblaze/helper.c    |  2 +-
 target/microblaze/translate.c | 12 +++++-------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 2fc7cf26f1..a5df1fa28f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -231,7 +231,6 @@ typedef struct CPUMBState CPUMBState;
 struct CPUMBState {
     uint32_t btaken;
     uint32_t btarget;
-    uint32_t bimm;
 
     uint32_t imm;
     uint32_t regs[32];
@@ -253,7 +252,8 @@ struct CPUMBState {
     uint32_t res_val;
 
     /* Internal flags.  */
-#define IMM_FLAG	4
+#define IMM_FLAG        (1 << 0)
+#define BIMM_FLAG       (1 << 1)
 /* MSR_EE               (1 << 8)  */
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f8e2ca12a9..06f4322e09 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -166,7 +166,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
                 /* Reexecute the branch.  */
                 env->regs[17] -= 4;
                 /* was the branch immprefixed?.  */
-                if (env->bimm) {
+                if (env->iflags & BIMM_FLAG) {
                     env->regs[17] -= 4;
                     log_cpu_state_mask(CPU_LOG_INT, cs, 0);
                 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index d2baa7db0e..97a436c8d5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1351,13 +1351,11 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 
 static void dec_setup_dslot(DisasContext *dc)
 {
-        TCGv_i32 tmp = tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG));
-
-        dc->delayed_branch = 2;
-        dc->tb_flags |= D_FLAG;
-
-        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, bimm));
-        tcg_temp_free_i32(tmp);
+    dc->delayed_branch = 2;
+    dc->tb_flags |= D_FLAG;
+    if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
+        dc->tb_flags |= BIMM_FLAG;
+    }
 }
 
 static void dec_bcc(DisasContext *dc)
-- 
2.25.1


