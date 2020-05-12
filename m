Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B127DC2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D75220722
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNkpzGLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D75220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY3p-0008N6-MI
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw6-0006PZ-3D
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:18 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw4-00066Z-Rz
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id l17so2744068wrr.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yPOdog2d2dwbfs28fCvHLLSNJsF30PqsU53nWUWzmY4=;
 b=iNkpzGLPqI/BguCb4PU0EiKPZ1SzO9fFeH/STZkGC1996Mnh4EAul17bthAghjtTqq
 i77JbCi0X79uEGcy26oHCu2lz1EIUml5KvMYDzQf27MdzSoWAJgeWxASN83XkMEZaxeQ
 45KcsNRWhVjgje4PPZrs+qslSm68hNUgvkONMVXiWRhHsd6f0zLtQZygWFLKj9pOfIMc
 DdvLGJwOVzya/roaY1TalX/gwSHAgihQxk27CtrR2MH0sq+nbKR9XDa3Tn7wRYo5pO4+
 OHNjr8ZlwoTyQQwy4gpSh8H//0eVJvc/PFE5S1drPpT+XF27oV4TjNjtsEGPrOBymjFo
 nA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yPOdog2d2dwbfs28fCvHLLSNJsF30PqsU53nWUWzmY4=;
 b=aOUQz+rkxDEIYpIbRDN0BAKvML+MpCy3ZxceeBG2vZxJnjCkv+ZG2qOkuFxDU5dyMY
 tW3UQ+qFlvsviGf4ecRTML9mmebDWW1jHVR+AxkadAHoeYoFjd/8YRdxePi41PBQz8N+
 O0mySA8z7ioTVLSAdW030HI3tyrwgABBcgWUSoloyAHGRPkHkB/OQTy0MMiQ8aYDawlj
 iYeSSjXX5puAh5HfWXX22d03PuDVpPnE5Bm5AxEzVUILJ2CzJd3fSB02xMo+G7KVuBkn
 6UqvePAu5omHA4y4A7/Wrg810bhP9sdJwq7n70W6z8/k2JSkIN+dVVVcMEMxelm3SZOx
 HXtg==
X-Gm-Message-State: AGi0PuZygatJcoH5hptgZoo635HUS8F+UqTl8pvphWhurN9Ann6HrQI4
 RIyTiWvXe/01xqX14p9KshEbh14HazCSxg==
X-Google-Smtp-Source: APiQypI5TN3IvpHQ4SR6elcs3R5s2Wv1DQvIaD3bGlKhmZAA4YNwVrLG63JgjmG68xsJJ+IEG3ZyBQ==
X-Received: by 2002:adf:ee87:: with SMTP id b7mr26448992wro.104.1589301555588; 
 Tue, 12 May 2020 09:39:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/17] target/arm: Convert Neon VRHADD,
 VHSUB 3-reg-same insns to decodetree
Date: Tue, 12 May 2020 17:38:53 +0100
Message-Id: <20200512163904.10918-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VRHADD and VHSUB 3-reg-same insns to decodetree.
(These are all the other insns in 3-reg-same which were using
GEN_NEON_INTEGER_OP() and which are not pairwise or
reversed-operands.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 6 ++++++
 target/arm/translate-neon.inc.c | 4 ++++
 target/arm/translate.c          | 8 ++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 25c08a4170d..353cb1f4992 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -47,6 +47,9 @@ VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
 VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
 VQADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 1 .... @3same
 
+VRHADD_S_3s      1111 001 0 0 . .. .... .... 0001 . . . 0 .... @3same
+VRHADD_U_3s      1111 001 1 0 . .. .... .... 0001 . . . 0 .... @3same
+
 @3same_logic     .... ... . . . .. .... .... .... . q:1 .. .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0
 
@@ -59,6 +62,9 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VHSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 0 .... @3same
+VHSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 0 .... @3same
+
 VQSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 1 .... @3same
 VQSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 1 .... @3same
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 20f0f2c8d83..e9da47171c6 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -877,3 +877,7 @@ DO_3SAME_64_ENV(VQRSHL_U64, gen_helper_neon_qrshl_u64)
 
 DO_3SAME_32(VHADD_S, hadd_s)
 DO_3SAME_32(VHADD_U, hadd_u)
+DO_3SAME_32(VHSUB_S, hsub_s)
+DO_3SAME_32(VHSUB_U, hsub_u)
+DO_3SAME_32(VRHADD_S, rhadd_s)
+DO_3SAME_32(VRHADD_U, rhadd_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2c842df4451..ebb899d846e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5435,6 +5435,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VSHL:
         case NEON_3R_SHA:
         case NEON_3R_VHADD:
+        case NEON_3R_VRHADD:
+        case NEON_3R_VHSUB:
         case NEON_3R_VABD:
         case NEON_3R_VABA:
             /* Already handled by decodetree */
@@ -5517,12 +5519,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VRHADD:
-            GEN_NEON_INTEGER_OP(rhadd);
-            break;
-        case NEON_3R_VHSUB:
-            GEN_NEON_INTEGER_OP(hsub);
-            break;
         case NEON_3R_VQSHL:
             GEN_NEON_INTEGER_OP_ENV(qshl);
             break;
-- 
2.20.1


