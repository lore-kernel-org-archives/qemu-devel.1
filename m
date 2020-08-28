Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A72BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188B520737
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m09jRW4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188B520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjLy-0000QG-8Y
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCl-0002cy-Iz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCf-0005zf-9N
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so80045wrw.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/Ki0FEJAVncOeHF2Ucul7Zf8qvOQrPlrcF6S9f2G/rs=;
 b=m09jRW4Tv6kgufoV4Nw2hxTquxtjIxwXe66OwEXY91E7HxUjADOf4iFtSOr29YtTpO
 KqUUxRb4x7XYqo33sYJKqbIS2FrPm0FOJ8oLFn8FaijLZq7ObRt1/bxk6iHrCULTeBHz
 O7+U2nku5qHPZIr4X3eWmIVN6Pxtg4b1pnuOXjyL5kTUJaOVCb3rzSENjJQbmIb3i4G+
 urV/rp+HozCv4ZMCMgXj0cGvTB17Kox7Nu5F8inu+FKBraUSX+vtyV8s46z1xYvGCgOf
 sxvZOaYt+zehdwpu46yH5rVtn7IpG5HhkVyWZa/84i3xQ1XD8fHnDy4e38Zh2FzDF5+8
 PRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Ki0FEJAVncOeHF2Ucul7Zf8qvOQrPlrcF6S9f2G/rs=;
 b=q+AscMW96QBu5lDRHrhHaUMf+XtQB+1saigjgVcsSHv0YyFBhSul29HAPzSKf79Q29
 vw83xipKAcdALF+q1L6w4JL2nLK0rotwYboAZl5C4Gaz/yiqe8dw3F18ZfoE9rjAtJcd
 Zb2Bfy9VG3kOlGdXH4uc/pWeC/raqeQ+wiAS4aHWTl3BOde6aZMyD0vp0unMn0NQkcg0
 7zWSXVOOE7iw/QQdbJLlwywqLie7r9MeEqZc5PCpwieLlw0GrwSU/kAUYBkVN1S9f7Jo
 JmiZ3SvsO6gAirMG6gkQqyYE2tZVggroqRerHquBtx63eBZW475oy08ZnSbGkx+hJ67b
 p2PA==
X-Gm-Message-State: AOAM531aXw+AVh6eRaZmJIlGPUe4l1fbYY2dFdJJe2MHrxSVo3f2ue3X
 ONdKADLZiyFmLzlrLjFLK3donYxJ0Qhdsu6R
X-Google-Smtp-Source: ABdhPJzliAeAsLXh940Hqg5V4R4Iq/8F9tP8lPLQWFedqgKmw0g45C+LRv4IoqkAoyVs2NfL/XDcTA==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr257757wrw.378.1598639659872; 
 Fri, 28 Aug 2020 11:34:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 19/45] target/arm: Implement new VFP fp16 insn VINS
Date: Fri, 28 Aug 2020 19:33:28 +0100
Message-Id: <20200828183354.27913-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

The fp16 extension includes a new instruction VINS, which copies the
lower 16 bits of a 32-bit source VFP register into the upper 16 bits
of the destination.  Implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp-uncond.decode   |  3 +++
 target/arm/translate-vfp.c.inc | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 9615544623a..39dc8f6373a 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -74,3 +74,6 @@ VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
             vm=%vm_sp vd=%vd_sp sz=2
 VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
             vm=%vm_dp vd=%vd_sp sz=3
+
+VINS        1111 1110 1.11 0000 .... 1010 11 . 0 .... \
+            vd=%vd_sp vm=%vm_sp
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 7ce044fa896..bda3dd25136 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3454,3 +3454,31 @@ static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
 
     return false;
 }
+
+static bool trans_VINS(DisasContext *s, arg_VINS *a)
+{
+    TCGv_i32 rd, rm;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (s->vec_len != 0 || s->vec_stride != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* Insert low half of Vm into high half of Vd */
+    rm = tcg_temp_new_i32();
+    rd = tcg_temp_new_i32();
+    neon_load_reg32(rm, a->vm);
+    neon_load_reg32(rd, a->vd);
+    tcg_gen_deposit_i32(rd, rd, rm, 16, 16);
+    neon_store_reg32(rd, a->vd);
+    tcg_temp_free_i32(rm);
+    tcg_temp_free_i32(rd);
+    return true;
+}
-- 
2.20.1


