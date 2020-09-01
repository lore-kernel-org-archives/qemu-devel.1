Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04DDC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C37207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkBUo/9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C37207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Av-0005tQ-Kd
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83o-0008Up-TR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83n-0006FL-1x
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id t10so1142687wrv.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wf7EKEC+mbE1bc7HSiXCoMXwlLDAHzyz88luKZOItlg=;
 b=kkBUo/9wWWrRk4upZIKP4rc8Y9wHY5vok7CAkG0mXN++8F8BIp56Pk/TxBPLtgCTHm
 KK+imTH9mPhfPsgoOFilcd8DnzBLKvoUzCGMSsP4rBJBg7MAV/sUf8vcM3OTDzMYtMzZ
 PWEeWoKs9Vs3NO9lpVzhBVi6gmOAJN/12+l5MUlVWnjgAwkWLwzscyQImPYWa7uYupqx
 BnBjLrKNuOc8dcsvXH039q9zolNOvKOw36ZCiI6D6ic4BFJOrw9xsz+McCs9e3u964IB
 ocge+7APLcATckfvMx3l5VecQtqj36+wHe0LYsrfmwoxv2dK7SLIvJqdgaImw5RX+hlr
 +Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wf7EKEC+mbE1bc7HSiXCoMXwlLDAHzyz88luKZOItlg=;
 b=ca8uamgQwX6vhIAP0c+Cl53rRjhP7fWoI+c67nkyiW4Ts9QyVUx78pyF/D59mDHq14
 sgQoMKJDur9o1nueTbSJrdUHJdhjgvJD+LMlmYVDBLDyR/RtZQlZjhM3xsUavQaHjkMS
 b7gS09UsrdRDjLD6XF75xJuKIlNXka9GzckM5acD6yoasiWRgLUZSPdHOhBDJyyjTdND
 ZewONgQggfOmjJzsxdxK0jXvE21TSEZ6ljRGIUD/9HijYBGZ8yBlFLcBO9Z6XJU+h/Lk
 /ip6YPRYMRjG7dBfBX12+SuVHLAUwAoBHyo6vp0gVefvbahhXrQvXkmAscNbmZwXv7rw
 jDlw==
X-Gm-Message-State: AOAM531IcEaanxOuItPp2YWCNOEzNHUFyTqFuICPOxcDZoPqHctZD8at
 zEIuTUZsynk1q/POqa7+nqatoVFS+cFZy4Tl
X-Google-Smtp-Source: ABdhPJybPOpgo0fzWphQ5ozj8Ec/+8zPw/D+3fWbIpIQrTUCyKUcPtM4HJEIpC0K1gbeLZBsh/LhiA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr2462963wrs.19.1598973537302;
 Tue, 01 Sep 2020 08:18:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/47] target/arm: Implement fp16 for Neon VABS, VNEG of floats
Date: Tue,  1 Sep 2020 16:18:00 +0100
Message-Id: <20200901151823.29785-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rewrite Neon VABS/VNEG of floats to use gvec logical AND and XOR, so
that we can implement the fp16 version of the insns.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-26-peter.maydell@linaro.org
---
 target/arm/translate-neon.c.inc | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 0a96245e962..45cea6ca766 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3741,22 +3741,44 @@ static bool trans_VCNT(DisasContext *s, arg_2misc *a)
     return do_2misc(s, a, gen_helper_neon_cnt_u8);
 }
 
+static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                       uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_andi(vece, rd_ofs, rm_ofs,
+                      vece == MO_16 ? 0x7fff : 0x7fffffff,
+                      oprsz, maxsz);
+}
+
 static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
 {
-    if (a->size != 2) {
+    if (a->size == MO_16) {
+        if (!dc_isar_feature(aa32_fp16_arith, s)) {
+            return false;
+        }
+    } else if (a->size != MO_32) {
         return false;
     }
-    /* TODO: FP16 : size == 1 */
-    return do_2misc(s, a, gen_helper_vfp_abss);
+    return do_2misc_vec(s, a, gen_VABS_F);
+}
+
+static void gen_VNEG_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                       uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_xori(vece, rd_ofs, rm_ofs,
+                      vece == MO_16 ? 0x8000 : 0x80000000,
+                      oprsz, maxsz);
 }
 
 static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
 {
-    if (a->size != 2) {
+    if (a->size == MO_16) {
+        if (!dc_isar_feature(aa32_fp16_arith, s)) {
+            return false;
+        }
+    } else if (a->size != MO_32) {
         return false;
     }
-    /* TODO: FP16 : size == 1 */
-    return do_2misc(s, a, gen_helper_vfp_negs);
+    return do_2misc_vec(s, a, gen_VNEG_F);
 }
 
 static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
-- 
2.20.1


