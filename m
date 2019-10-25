Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5819CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBA52053B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBA52053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2mH-0001rX-6f
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ib-0004wW-MZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2iW-0002Ec-LT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34447 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iO2iW-0002DM-5u
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:36 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id BFD3D1A2233;
 Fri, 25 Oct 2019 18:44:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6C1F91A21CC;
 Fri, 25 Oct 2019 18:44:29 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] target/mips: msa: Split helpers for
 ILV<EV|OD|L|R>.<B|H|W|D>
Date: Fri, 25 Oct 2019 18:44:08 +0200
Message-Id: <1572021862-28273-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Achieves clearer code and slightly better performance.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1571826227-10583-7-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/helper.h     |  21 +-
 target/mips/msa_helper.c | 768 +++++++++++++++++++++++++----------------------
 target/mips/translate.c  |  76 ++++-
 3 files changed, 496 insertions(+), 369 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 6419bb8..f3df187 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -912,6 +912,23 @@ DEF_HELPER_4(msa_mod_s_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_mod_s_w, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_mod_s_d, void, env, i32, i32, i32)
 
+DEF_HELPER_4(msa_ilvev_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvev_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvev_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvev_d, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvod_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvod_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvod_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvod_d, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvl_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvl_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvl_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvl_d, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvr_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvr_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvr_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_ilvr_d, void, env, i32, i32, i32)
+
 DEF_HELPER_4(msa_and_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_nor_v, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_or_v, void, env, i32, i32, i32)
@@ -984,10 +1001,6 @@ DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(msa_ilvod_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 65df15d..499fcde 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2432,7 +2432,421 @@ void helper_msa_mod_u_d(CPUMIPSState *env,
  * +---------------+----------------------------------------------------------+
  */
 
-/* TODO: insert Interleave group helpers here */
+
+void helper_msa_ilvev_b(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->b[8]  = pws->b[9];
+    pwd->b[9]  = pwt->b[9];
+    pwd->b[10] = pws->b[11];
+    pwd->b[11] = pwt->b[11];
+    pwd->b[12] = pws->b[13];
+    pwd->b[13] = pwt->b[13];
+    pwd->b[14] = pws->b[15];
+    pwd->b[15] = pwt->b[15];
+    pwd->b[0]  = pws->b[1];
+    pwd->b[1]  = pwt->b[1];
+    pwd->b[2]  = pws->b[3];
+    pwd->b[3]  = pwt->b[3];
+    pwd->b[4]  = pws->b[5];
+    pwd->b[5]  = pwt->b[5];
+    pwd->b[6]  = pws->b[7];
+    pwd->b[7]  = pwt->b[7];
+#else
+    pwd->b[15] = pws->b[14];
+    pwd->b[14] = pwt->b[14];
+    pwd->b[13] = pws->b[12];
+    pwd->b[12] = pwt->b[12];
+    pwd->b[11] = pws->b[10];
+    pwd->b[10] = pwt->b[10];
+    pwd->b[9]  = pws->b[8];
+    pwd->b[8]  = pwt->b[8];
+    pwd->b[7]  = pws->b[6];
+    pwd->b[6]  = pwt->b[6];
+    pwd->b[5]  = pws->b[4];
+    pwd->b[4]  = pwt->b[4];
+    pwd->b[3]  = pws->b[2];
+    pwd->b[2]  = pwt->b[2];
+    pwd->b[1]  = pws->b[0];
+    pwd->b[0]  = pwt->b[0];
+#endif
+}
+
+void helper_msa_ilvev_h(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->h[4] = pws->h[5];
+    pwd->h[5] = pwt->h[5];
+    pwd->h[6] = pws->h[7];
+    pwd->h[7] = pwt->h[7];
+    pwd->h[0] = pws->h[1];
+    pwd->h[1] = pwt->h[1];
+    pwd->h[2] = pws->h[3];
+    pwd->h[3] = pwt->h[3];
+#else
+    pwd->h[7] = pws->h[6];
+    pwd->h[6] = pwt->h[6];
+    pwd->h[5] = pws->h[4];
+    pwd->h[4] = pwt->h[4];
+    pwd->h[3] = pws->h[2];
+    pwd->h[2] = pwt->h[2];
+    pwd->h[1] = pws->h[0];
+    pwd->h[0] = pwt->h[0];
+#endif
+}
+
+void helper_msa_ilvev_w(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->w[2] = pws->w[3];
+    pwd->w[3] = pwt->w[3];
+    pwd->w[0] = pws->w[1];
+    pwd->w[1] = pwt->w[1];
+#else
+    pwd->w[3] = pws->w[2];
+    pwd->w[2] = pwt->w[2];
+    pwd->w[1] = pws->w[0];
+    pwd->w[0] = pwt->w[0];
+#endif
+}
+
+void helper_msa_ilvev_d(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[1] = pws->d[0];
+    pwd->d[0] = pwt->d[0];
+}
+
+
+void helper_msa_ilvod_b(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->b[7]  = pwt->b[6];
+    pwd->b[6]  = pws->b[6];
+    pwd->b[5]  = pwt->b[4];
+    pwd->b[4]  = pws->b[4];
+    pwd->b[3]  = pwt->b[2];
+    pwd->b[2]  = pws->b[2];
+    pwd->b[1]  = pwt->b[0];
+    pwd->b[0]  = pws->b[0];
+    pwd->b[15] = pwt->b[14];
+    pwd->b[14] = pws->b[14];
+    pwd->b[13] = pwt->b[12];
+    pwd->b[12] = pws->b[12];
+    pwd->b[11] = pwt->b[10];
+    pwd->b[10] = pws->b[10];
+    pwd->b[9]  = pwt->b[8];
+    pwd->b[8]  = pws->b[8];
+#else
+    pwd->b[0]  = pwt->b[1];
+    pwd->b[1]  = pws->b[1];
+    pwd->b[2]  = pwt->b[3];
+    pwd->b[3]  = pws->b[3];
+    pwd->b[4]  = pwt->b[5];
+    pwd->b[5]  = pws->b[5];
+    pwd->b[6]  = pwt->b[7];
+    pwd->b[7]  = pws->b[7];
+    pwd->b[8]  = pwt->b[9];
+    pwd->b[9]  = pws->b[9];
+    pwd->b[10] = pwt->b[11];
+    pwd->b[11] = pws->b[11];
+    pwd->b[12] = pwt->b[13];
+    pwd->b[13] = pws->b[13];
+    pwd->b[14] = pwt->b[15];
+    pwd->b[15] = pws->b[15];
+#endif
+}
+
+void helper_msa_ilvod_h(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->h[3] = pwt->h[2];
+    pwd->h[2] = pws->h[2];
+    pwd->h[1] = pwt->h[0];
+    pwd->h[0] = pws->h[0];
+    pwd->h[7] = pwt->h[6];
+    pwd->h[6] = pws->h[6];
+    pwd->h[5] = pwt->h[4];
+    pwd->h[4] = pws->h[4];
+#else
+    pwd->h[0] = pwt->h[1];
+    pwd->h[1] = pws->h[1];
+    pwd->h[2] = pwt->h[3];
+    pwd->h[3] = pws->h[3];
+    pwd->h[4] = pwt->h[5];
+    pwd->h[5] = pws->h[5];
+    pwd->h[6] = pwt->h[7];
+    pwd->h[7] = pws->h[7];
+#endif
+}
+
+void helper_msa_ilvod_w(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->w[1] = pwt->w[0];
+    pwd->w[0] = pws->w[0];
+    pwd->w[3] = pwt->w[2];
+    pwd->w[2] = pws->w[2];
+#else
+    pwd->w[0] = pwt->w[1];
+    pwd->w[1] = pws->w[1];
+    pwd->w[2] = pwt->w[3];
+    pwd->w[3] = pws->w[3];
+#endif
+}
+
+void helper_msa_ilvod_d(CPUMIPSState *env,
+                        uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = pwt->d[1];
+    pwd->d[1] = pws->d[1];
+}
+
+
+void helper_msa_ilvl_b(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->b[7]  = pwt->b[15];
+    pwd->b[6]  = pws->b[15];
+    pwd->b[5]  = pwt->b[14];
+    pwd->b[4]  = pws->b[14];
+    pwd->b[3]  = pwt->b[13];
+    pwd->b[2]  = pws->b[13];
+    pwd->b[1]  = pwt->b[12];
+    pwd->b[0]  = pws->b[12];
+    pwd->b[15] = pwt->b[11];
+    pwd->b[14] = pws->b[11];
+    pwd->b[13] = pwt->b[10];
+    pwd->b[12] = pws->b[10];
+    pwd->b[11] = pwt->b[9];
+    pwd->b[10] = pws->b[9];
+    pwd->b[9]  = pwt->b[8];
+    pwd->b[8]  = pws->b[8];
+#else
+    pwd->b[0]  = pwt->b[8];
+    pwd->b[1]  = pws->b[8];
+    pwd->b[2]  = pwt->b[9];
+    pwd->b[3]  = pws->b[9];
+    pwd->b[4]  = pwt->b[10];
+    pwd->b[5]  = pws->b[10];
+    pwd->b[6]  = pwt->b[11];
+    pwd->b[7]  = pws->b[11];
+    pwd->b[8]  = pwt->b[12];
+    pwd->b[9]  = pws->b[12];
+    pwd->b[10] = pwt->b[13];
+    pwd->b[11] = pws->b[13];
+    pwd->b[12] = pwt->b[14];
+    pwd->b[13] = pws->b[14];
+    pwd->b[14] = pwt->b[15];
+    pwd->b[15] = pws->b[15];
+#endif
+}
+
+void helper_msa_ilvl_h(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->h[3] = pwt->h[7];
+    pwd->h[2] = pws->h[7];
+    pwd->h[1] = pwt->h[6];
+    pwd->h[0] = pws->h[6];
+    pwd->h[7] = pwt->h[5];
+    pwd->h[6] = pws->h[5];
+    pwd->h[5] = pwt->h[4];
+    pwd->h[4] = pws->h[4];
+#else
+    pwd->h[0] = pwt->h[4];
+    pwd->h[1] = pws->h[4];
+    pwd->h[2] = pwt->h[5];
+    pwd->h[3] = pws->h[5];
+    pwd->h[4] = pwt->h[6];
+    pwd->h[5] = pws->h[6];
+    pwd->h[6] = pwt->h[7];
+    pwd->h[7] = pws->h[7];
+#endif
+}
+
+void helper_msa_ilvl_w(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->w[1] = pwt->w[3];
+    pwd->w[0] = pws->w[3];
+    pwd->w[3] = pwt->w[2];
+    pwd->w[2] = pws->w[2];
+#else
+    pwd->w[0] = pwt->w[2];
+    pwd->w[1] = pws->w[2];
+    pwd->w[2] = pwt->w[3];
+    pwd->w[3] = pws->w[3];
+#endif
+}
+
+void helper_msa_ilvl_d(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[0] = pwt->d[1];
+    pwd->d[1] = pws->d[1];
+}
+
+
+void helper_msa_ilvr_b(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->b[8]  = pws->b[0];
+    pwd->b[9]  = pwt->b[0];
+    pwd->b[10] = pws->b[1];
+    pwd->b[11] = pwt->b[1];
+    pwd->b[12] = pws->b[2];
+    pwd->b[13] = pwt->b[2];
+    pwd->b[14] = pws->b[3];
+    pwd->b[15] = pwt->b[3];
+    pwd->b[0]  = pws->b[4];
+    pwd->b[1]  = pwt->b[4];
+    pwd->b[2]  = pws->b[5];
+    pwd->b[3]  = pwt->b[5];
+    pwd->b[4]  = pws->b[6];
+    pwd->b[5]  = pwt->b[6];
+    pwd->b[6]  = pws->b[7];
+    pwd->b[7]  = pwt->b[7];
+#else
+    pwd->b[15] = pws->b[7];
+    pwd->b[14] = pwt->b[7];
+    pwd->b[13] = pws->b[6];
+    pwd->b[12] = pwt->b[6];
+    pwd->b[11] = pws->b[5];
+    pwd->b[10] = pwt->b[5];
+    pwd->b[9]  = pws->b[4];
+    pwd->b[8]  = pwt->b[4];
+    pwd->b[7]  = pws->b[3];
+    pwd->b[6]  = pwt->b[3];
+    pwd->b[5]  = pws->b[2];
+    pwd->b[4]  = pwt->b[2];
+    pwd->b[3]  = pws->b[1];
+    pwd->b[2]  = pwt->b[1];
+    pwd->b[1]  = pws->b[0];
+    pwd->b[0]  = pwt->b[0];
+#endif
+}
+
+void helper_msa_ilvr_h(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->h[4] = pws->h[0];
+    pwd->h[5] = pwt->h[0];
+    pwd->h[6] = pws->h[1];
+    pwd->h[7] = pwt->h[1];
+    pwd->h[0] = pws->h[2];
+    pwd->h[1] = pwt->h[2];
+    pwd->h[2] = pws->h[3];
+    pwd->h[3] = pwt->h[3];
+#else
+    pwd->h[7] = pws->h[3];
+    pwd->h[6] = pwt->h[3];
+    pwd->h[5] = pws->h[2];
+    pwd->h[4] = pwt->h[2];
+    pwd->h[3] = pws->h[1];
+    pwd->h[2] = pwt->h[1];
+    pwd->h[1] = pws->h[0];
+    pwd->h[0] = pwt->h[0];
+#endif
+}
+
+void helper_msa_ilvr_w(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+#if defined(HOST_WORDS_BIGENDIAN)
+    pwd->w[2] = pws->w[0];
+    pwd->w[3] = pwt->w[0];
+    pwd->w[0] = pws->w[1];
+    pwd->w[1] = pwt->w[1];
+#else
+    pwd->w[3] = pws->w[1];
+    pwd->w[2] = pwt->w[1];
+    pwd->w[1] = pws->w[0];
+    pwd->w[0] = pwt->w[0];
+#endif
+}
+
+void helper_msa_ilvr_d(CPUMIPSState *env,
+                       uint32_t wd, uint32_t ws, uint32_t wt)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
+    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
+
+    pwd->d[1] = pws->d[0];
+    pwd->d[0] = pwt->d[0];
+}
 
 
 /*
@@ -3522,358 +3936,6 @@ MSA_FN_DF(vshf_df)
 #undef MSA_FN_DF
 
 
-void helper_msa_ilvev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
-                         uint32_t ws, uint32_t wt)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
-    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-
-    switch (df) {
-    case DF_BYTE:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->b[8]  = pws->b[9];
-        pwd->b[9]  = pwt->b[9];
-        pwd->b[10] = pws->b[11];
-        pwd->b[11] = pwt->b[11];
-        pwd->b[12] = pws->b[13];
-        pwd->b[13] = pwt->b[13];
-        pwd->b[14] = pws->b[15];
-        pwd->b[15] = pwt->b[15];
-        pwd->b[0]  = pws->b[1];
-        pwd->b[1]  = pwt->b[1];
-        pwd->b[2]  = pws->b[3];
-        pwd->b[3]  = pwt->b[3];
-        pwd->b[4]  = pws->b[5];
-        pwd->b[5]  = pwt->b[5];
-        pwd->b[6]  = pws->b[7];
-        pwd->b[7]  = pwt->b[7];
-#else
-        pwd->b[15] = pws->b[14];
-        pwd->b[14] = pwt->b[14];
-        pwd->b[13] = pws->b[12];
-        pwd->b[12] = pwt->b[12];
-        pwd->b[11] = pws->b[10];
-        pwd->b[10] = pwt->b[10];
-        pwd->b[9]  = pws->b[8];
-        pwd->b[8]  = pwt->b[8];
-        pwd->b[7]  = pws->b[6];
-        pwd->b[6]  = pwt->b[6];
-        pwd->b[5]  = pws->b[4];
-        pwd->b[4]  = pwt->b[4];
-        pwd->b[3]  = pws->b[2];
-        pwd->b[2]  = pwt->b[2];
-        pwd->b[1]  = pws->b[0];
-        pwd->b[0]  = pwt->b[0];
-#endif
-        break;
-    case DF_HALF:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->h[4] = pws->h[5];
-        pwd->h[5] = pwt->h[5];
-        pwd->h[6] = pws->h[7];
-        pwd->h[7] = pwt->h[7];
-        pwd->h[0] = pws->h[1];
-        pwd->h[1] = pwt->h[1];
-        pwd->h[2] = pws->h[3];
-        pwd->h[3] = pwt->h[3];
-#else
-        pwd->h[7] = pws->h[6];
-        pwd->h[6] = pwt->h[6];
-        pwd->h[5] = pws->h[4];
-        pwd->h[4] = pwt->h[4];
-        pwd->h[3] = pws->h[2];
-        pwd->h[2] = pwt->h[2];
-        pwd->h[1] = pws->h[0];
-        pwd->h[0] = pwt->h[0];
-#endif
-        break;
-    case DF_WORD:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->w[2] = pws->w[3];
-        pwd->w[3] = pwt->w[3];
-        pwd->w[0] = pws->w[1];
-        pwd->w[1] = pwt->w[1];
-#else
-        pwd->w[3] = pws->w[2];
-        pwd->w[2] = pwt->w[2];
-        pwd->w[1] = pws->w[0];
-        pwd->w[0] = pwt->w[0];
-#endif
-        break;
-    case DF_DOUBLE:
-        pwd->d[1] = pws->d[0];
-        pwd->d[0] = pwt->d[0];
-        break;
-    default:
-        assert(0);
-    }
-}
-
-void helper_msa_ilvod_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
-                         uint32_t ws, uint32_t wt)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
-    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-
-    switch (df) {
-    case DF_BYTE:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->b[7]  = pwt->b[6];
-        pwd->b[6]  = pws->b[6];
-        pwd->b[5]  = pwt->b[4];
-        pwd->b[4]  = pws->b[4];
-        pwd->b[3]  = pwt->b[2];
-        pwd->b[2]  = pws->b[2];
-        pwd->b[1]  = pwt->b[0];
-        pwd->b[0]  = pws->b[0];
-        pwd->b[15] = pwt->b[14];
-        pwd->b[14] = pws->b[14];
-        pwd->b[13] = pwt->b[12];
-        pwd->b[12] = pws->b[12];
-        pwd->b[11] = pwt->b[10];
-        pwd->b[10] = pws->b[10];
-        pwd->b[9]  = pwt->b[8];
-        pwd->b[8]  = pws->b[8];
-#else
-        pwd->b[0]  = pwt->b[1];
-        pwd->b[1]  = pws->b[1];
-        pwd->b[2]  = pwt->b[3];
-        pwd->b[3]  = pws->b[3];
-        pwd->b[4]  = pwt->b[5];
-        pwd->b[5]  = pws->b[5];
-        pwd->b[6]  = pwt->b[7];
-        pwd->b[7]  = pws->b[7];
-        pwd->b[8]  = pwt->b[9];
-        pwd->b[9]  = pws->b[9];
-        pwd->b[10] = pwt->b[11];
-        pwd->b[11] = pws->b[11];
-        pwd->b[12] = pwt->b[13];
-        pwd->b[13] = pws->b[13];
-        pwd->b[14] = pwt->b[15];
-        pwd->b[15] = pws->b[15];
-#endif
-        break;
-    case DF_HALF:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->h[3] = pwt->h[2];
-        pwd->h[2] = pws->h[2];
-        pwd->h[1] = pwt->h[0];
-        pwd->h[0] = pws->h[0];
-        pwd->h[7] = pwt->h[6];
-        pwd->h[6] = pws->h[6];
-        pwd->h[5] = pwt->h[4];
-        pwd->h[4] = pws->h[4];
-#else
-        pwd->h[0] = pwt->h[1];
-        pwd->h[1] = pws->h[1];
-        pwd->h[2] = pwt->h[3];
-        pwd->h[3] = pws->h[3];
-        pwd->h[4] = pwt->h[5];
-        pwd->h[5] = pws->h[5];
-        pwd->h[6] = pwt->h[7];
-        pwd->h[7] = pws->h[7];
-#endif
-        break;
-    case DF_WORD:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->w[1] = pwt->w[0];
-        pwd->w[0] = pws->w[0];
-        pwd->w[3] = pwt->w[2];
-        pwd->w[2] = pws->w[2];
-#else
-        pwd->w[0] = pwt->w[1];
-        pwd->w[1] = pws->w[1];
-        pwd->w[2] = pwt->w[3];
-        pwd->w[3] = pws->w[3];
-#endif
-        break;
-    case DF_DOUBLE:
-        pwd->d[0] = pwt->d[1];
-        pwd->d[1] = pws->d[1];
-        break;
-    default:
-        assert(0);
-    }
-}
-
-void helper_msa_ilvl_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
-                        uint32_t ws, uint32_t wt)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
-    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-
-    switch (df) {
-    case DF_BYTE:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->b[7]  = pwt->b[15];
-        pwd->b[6]  = pws->b[15];
-        pwd->b[5]  = pwt->b[14];
-        pwd->b[4]  = pws->b[14];
-        pwd->b[3]  = pwt->b[13];
-        pwd->b[2]  = pws->b[13];
-        pwd->b[1]  = pwt->b[12];
-        pwd->b[0]  = pws->b[12];
-        pwd->b[15] = pwt->b[11];
-        pwd->b[14] = pws->b[11];
-        pwd->b[13] = pwt->b[10];
-        pwd->b[12] = pws->b[10];
-        pwd->b[11] = pwt->b[9];
-        pwd->b[10] = pws->b[9];
-        pwd->b[9]  = pwt->b[8];
-        pwd->b[8]  = pws->b[8];
-#else
-        pwd->b[0]  = pwt->b[8];
-        pwd->b[1]  = pws->b[8];
-        pwd->b[2]  = pwt->b[9];
-        pwd->b[3]  = pws->b[9];
-        pwd->b[4]  = pwt->b[10];
-        pwd->b[5]  = pws->b[10];
-        pwd->b[6]  = pwt->b[11];
-        pwd->b[7]  = pws->b[11];
-        pwd->b[8]  = pwt->b[12];
-        pwd->b[9]  = pws->b[12];
-        pwd->b[10] = pwt->b[13];
-        pwd->b[11] = pws->b[13];
-        pwd->b[12] = pwt->b[14];
-        pwd->b[13] = pws->b[14];
-        pwd->b[14] = pwt->b[15];
-        pwd->b[15] = pws->b[15];
-#endif
-        break;
-    case DF_HALF:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->h[3] = pwt->h[7];
-        pwd->h[2] = pws->h[7];
-        pwd->h[1] = pwt->h[6];
-        pwd->h[0] = pws->h[6];
-        pwd->h[7] = pwt->h[5];
-        pwd->h[6] = pws->h[5];
-        pwd->h[5] = pwt->h[4];
-        pwd->h[4] = pws->h[4];
-#else
-        pwd->h[0] = pwt->h[4];
-        pwd->h[1] = pws->h[4];
-        pwd->h[2] = pwt->h[5];
-        pwd->h[3] = pws->h[5];
-        pwd->h[4] = pwt->h[6];
-        pwd->h[5] = pws->h[6];
-        pwd->h[6] = pwt->h[7];
-        pwd->h[7] = pws->h[7];
-#endif
-        break;
-    case DF_WORD:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->w[1] = pwt->w[3];
-        pwd->w[0] = pws->w[3];
-        pwd->w[3] = pwt->w[2];
-        pwd->w[2] = pws->w[2];
-#else
-        pwd->w[0] = pwt->w[2];
-        pwd->w[1] = pws->w[2];
-        pwd->w[2] = pwt->w[3];
-        pwd->w[3] = pws->w[3];
-#endif
-        break;
-    case DF_DOUBLE:
-        pwd->d[0] = pwt->d[1];
-        pwd->d[1] = pws->d[1];
-        break;
-    default:
-        assert(0);
-    }
-}
-
-void helper_msa_ilvr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
-                        uint32_t ws, uint32_t wt)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    wr_t *pws = &(env->active_fpu.fpr[ws].wr);
-    wr_t *pwt = &(env->active_fpu.fpr[wt].wr);
-
-    switch (df) {
-    case DF_BYTE:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->b[8]  = pws->b[0];
-        pwd->b[9]  = pwt->b[0];
-        pwd->b[10] = pws->b[1];
-        pwd->b[11] = pwt->b[1];
-        pwd->b[12] = pws->b[2];
-        pwd->b[13] = pwt->b[2];
-        pwd->b[14] = pws->b[3];
-        pwd->b[15] = pwt->b[3];
-        pwd->b[0]  = pws->b[4];
-        pwd->b[1]  = pwt->b[4];
-        pwd->b[2]  = pws->b[5];
-        pwd->b[3]  = pwt->b[5];
-        pwd->b[4]  = pws->b[6];
-        pwd->b[5]  = pwt->b[6];
-        pwd->b[6]  = pws->b[7];
-        pwd->b[7]  = pwt->b[7];
-#else
-        pwd->b[15] = pws->b[7];
-        pwd->b[14] = pwt->b[7];
-        pwd->b[13] = pws->b[6];
-        pwd->b[12] = pwt->b[6];
-        pwd->b[11] = pws->b[5];
-        pwd->b[10] = pwt->b[5];
-        pwd->b[9]  = pws->b[4];
-        pwd->b[8]  = pwt->b[4];
-        pwd->b[7]  = pws->b[3];
-        pwd->b[6]  = pwt->b[3];
-        pwd->b[5]  = pws->b[2];
-        pwd->b[4]  = pwt->b[2];
-        pwd->b[3]  = pws->b[1];
-        pwd->b[2]  = pwt->b[1];
-        pwd->b[1]  = pws->b[0];
-        pwd->b[0]  = pwt->b[0];
-#endif
-        break;
-    case DF_HALF:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->h[4] = pws->h[0];
-        pwd->h[5] = pwt->h[0];
-        pwd->h[6] = pws->h[1];
-        pwd->h[7] = pwt->h[1];
-        pwd->h[0] = pws->h[2];
-        pwd->h[1] = pwt->h[2];
-        pwd->h[2] = pws->h[3];
-        pwd->h[3] = pwt->h[3];
-#else
-        pwd->h[7] = pws->h[3];
-        pwd->h[6] = pwt->h[3];
-        pwd->h[5] = pws->h[2];
-        pwd->h[4] = pwt->h[2];
-        pwd->h[3] = pws->h[1];
-        pwd->h[2] = pwt->h[1];
-        pwd->h[1] = pws->h[0];
-        pwd->h[0] = pwt->h[0];
-#endif
-        break;
-    case DF_WORD:
-#if defined(HOST_WORDS_BIGENDIAN)
-        pwd->w[2] = pws->w[0];
-        pwd->w[3] = pwt->w[0];
-        pwd->w[0] = pws->w[1];
-        pwd->w[1] = pwt->w[1];
-#else
-        pwd->w[3] = pws->w[1];
-        pwd->w[2] = pwt->w[1];
-        pwd->w[1] = pws->w[0];
-        pwd->w[0] = pwt->w[0];
-#endif
-        break;
-    case DF_DOUBLE:
-        pwd->d[1] = pws->d[0];
-        pwd->d[0] = pwt->d[0];
-        break;
-    default:
-        assert(0);
-    }
-}
-
 void helper_msa_pckev_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
                          uint32_t ws, uint32_t wt)
 {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7a35c26..ea8b8f4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28770,6 +28770,70 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
+    case OPC_ILVEV_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_ilvev_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_ilvev_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_ilvev_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_ilvev_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_ILVOD_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_ilvod_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_ilvod_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_ilvod_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_ilvod_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_ILVL_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_ilvl_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_ilvl_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_ilvl_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_ilvl_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
+    case OPC_ILVR_df:
+        switch (df) {
+        case DF_BYTE:
+            gen_helper_msa_ilvr_b(cpu_env, twd, tws, twt);
+            break;
+        case DF_HALF:
+            gen_helper_msa_ilvr_h(cpu_env, twd, tws, twt);
+            break;
+        case DF_WORD:
+            gen_helper_msa_ilvr_w(cpu_env, twd, tws, twt);
+            break;
+        case DF_DOUBLE:
+            gen_helper_msa_ilvr_d(cpu_env, twd, tws, twt);
+            break;
+        }
+        break;
     case OPC_SLL_df:
         gen_helper_msa_sll_df(cpu_env, tdf, twd, tws, twt);
         break;
@@ -28842,21 +28906,9 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
     case OPC_ASUB_S_df:
         gen_helper_msa_asub_s_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_ILVL_df:
-        gen_helper_msa_ilvl_df(cpu_env, tdf, twd, tws, twt);
-        break;
     case OPC_ASUB_U_df:
         gen_helper_msa_asub_u_df(cpu_env, tdf, twd, tws, twt);
         break;
-    case OPC_ILVR_df:
-        gen_helper_msa_ilvr_df(cpu_env, tdf, twd, tws, twt);
-        break;
-    case OPC_ILVEV_df:
-        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
-        break;
-    case OPC_ILVOD_df:
-        gen_helper_msa_ilvod_df(cpu_env, tdf, twd, tws, twt);
-        break;
 
     case OPC_DOTP_S_df:
     case OPC_DOTP_U_df:
-- 
2.7.4


