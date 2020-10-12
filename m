Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948EC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BE12074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exgSCy6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE12074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Gl-0000qI-P6
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztf-0003ab-LD
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:37:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztY-0007lS-4n
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:37:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id d81so17522725wmc.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=73sxXQONcqBgzHuOsaIz5hu+3BY6+pw52N6WyKkQfZo=;
 b=exgSCy6TBYKs+2u6PmauhdJ/pAV+QrSf2WLOJjFOA913gOLmL4t0hjV+pGDqFu59Kd
 shf6GEjbd5Xl9baMOMbtewoojWiuyQ1lZCErfoS3kXKtI3bWXD0olSbRYV1TsabJX/7q
 /JuIkVjG6Wj0oH+m7Hk+KEq52DO13lKiXQ3MhV9kMny4wRJLcVNJKKEYWo7aMIIHMgKm
 segKFQ8AK/ZTWrMvOWZZ5NaPOdnIwXzrtWxUQK93fM2sNdnX5MQk2hpbZi2DEOOt3eTq
 hyuH9Qv3WwK2VwWEQ+vSoTrHi/uqU8HHczSgqEPivdBX+3weH2MjPpKUR4hMhd334SB3
 9R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=73sxXQONcqBgzHuOsaIz5hu+3BY6+pw52N6WyKkQfZo=;
 b=iBnKR604NRohEYj6AkWjhObOmjd68x5p1w1bFNsZb78CfjJ9EYqwJr5mVHejiiKeC/
 CCfi8gCIh/kohLIpji4MLt23jH+IZyHya2Mh3gm+yS548hr79cM7KOFniNZ6jiY1EZVh
 BpxBIP5pgJUDuTLpuyzg6lmnT/ctMfO599pm0xeFK7u/GX/q5fRR+l9iQ/RlNApSvYUl
 tqxcv9YhX+gDA9XrCWBkDw0Yl3pkNn5ZSrmzYIaUpeojpLGR15Y4GCeCzzcj2ySXcaUE
 Xzo5MuhZZzNqHHbCNWYGINlB5SPDEF56cQ+d1nBNFLFfMoWAu79Hxj1Ah5+saAEtLDTz
 jXpw==
X-Gm-Message-State: AOAM5336GovaUJOtiCA705XHhhdmk5Sl7rxf/87NsFX9OTuOBVh81B4z
 jhChRXurwVfbEx81kHQiqmgySw==
X-Google-Smtp-Source: ABdhPJy4LPQpvrsnt5RCAZ9vHcRDudF9jd0mi6uJSyVW1oujaQiAGY70CcWC3vHFoJMgAPKgVLa9yQ==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr11867963wmf.10.1602517070880; 
 Mon, 12 Oct 2020 08:37:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/10] target/arm: Implement v8.1M NOCP handling
Date: Mon, 12 Oct 2020 16:37:38 +0100
Message-Id: <20201012153746.9996-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From v8.1M, disabled-coprocessor handling changes slightly:
 * coprocessors 8, 9, 14 and 15 are also governed by the
   cp10 enable bit, like cp11
 * an extra range of instruction patterns is considered
   to be inside the coprocessor space

We previously marked these up with TODO comments; implement the
correct behaviour.

Unfortunately there is no ID register field which indicates this
behaviour.  We could in theory test an unrelated ID register which
indicates guaranteed-to-be-in-v8.1M behaviour like ID_ISAR0.CmpBranch
>= 3 (low-overhead-loops), but it seems better to simply define a new
ARM_FEATURE_V8_1M feature flag and use it for this and other
new-in-v8.1M behaviour that isn't identifiable from the ID registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  1 +
 target/arm/m-nocp.decode       | 10 ++++++----
 target/arm/translate-vfp.c.inc | 17 +++++++++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cfff1b5c8fe..74392fa0295 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1985,6 +1985,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
+    ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/m-nocp.decode b/target/arm/m-nocp.decode
index 7182d7d1217..28c8ac6b94c 100644
--- a/target/arm/m-nocp.decode
+++ b/target/arm/m-nocp.decode
@@ -29,14 +29,16 @@
 # If the coprocessor is not present or disabled then we will generate
 # the NOCP exception; otherwise we let the insn through to the main decode.
 
+&nocp cp
+
 {
   # Special cases which do not take an early NOCP: VLLDM and VLSTM
   VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
   # TODO: VSCCLRM (new in v8.1M) is similar:
   #VSCCLRM      1110 1100 1-01 1111 ---- 1011 ---- ---0
 
-  NOCP         111- 1110 ---- ---- ---- cp:4 ---- ----
-  NOCP         111- 110- ---- ---- ---- cp:4 ---- ----
-  # TODO: From v8.1M onwards we will also want this range to NOCP
-  #NOCP_8_1     111- 1111 ---- ---- ---- ---- ---- ---- cp=10
+  NOCP         111- 1110 ---- ---- ---- cp:4 ---- ---- &nocp
+  NOCP         111- 110- ---- ---- ---- cp:4 ---- ---- &nocp
+  # From v8.1M onwards this range will also NOCP:
+  NOCP_8_1     111- 1111 ---- ---- ---- ---- ---- ---- &nocp cp=10
 }
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 28e0dba5f14..cc9ffb95887 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3459,7 +3459,7 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
     return true;
 }
 
-static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
+static bool trans_NOCP(DisasContext *s, arg_nocp *a)
 {
     /*
      * Handle M-profile early check for disabled coprocessor:
@@ -3472,7 +3472,11 @@ static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
     if (a->cp == 11) {
         a->cp = 10;
     }
-    /* TODO: in v8.1M cp 8, 9, 14, 15 also are governed by the cp10 enable */
+    if (arm_dc_feature(s, ARM_FEATURE_V8_1M) &&
+        (a->cp == 8 || a->cp == 9 || a->cp == 14 || a->cp == 15)) {
+        /* in v8.1M cp 8, 9, 14, 15 also are governed by the cp10 enable */
+        a->cp = 10;
+    }
 
     if (a->cp != 10) {
         gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
@@ -3489,6 +3493,15 @@ static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
     return false;
 }
 
+static bool trans_NOCP_8_1(DisasContext *s, arg_nocp *a)
+{
+    /* This range needs a coprocessor check for v8.1M and later only */
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+    return trans_NOCP(s, a);
+}
+
 static bool trans_VINS(DisasContext *s, arg_VINS *a)
 {
     TCGv_i32 rd, rm;
-- 
2.20.1


