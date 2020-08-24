Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65558C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C29320738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+N/8Knb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C29320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADek-00039k-GN
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTp-0008KZ-No
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTn-0002hQ-Oo
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15so2165484wrt.12
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IWRcaA8/wlrHD8pgz5xTOhWNZhjrxV7FX8GxKOdWsX0=;
 b=t+N/8KnbXTmBR1M4tC2ZyENx8oIQX1H86/vJJoyahGzv3EYtqA0OHijlJKtTyrYGa0
 Eewq199eJOLxpgE5DXk5mvWjo4llJy7sZg48w2ePM0dNw5hrsXEnw4rd7dYP2goyRSQj
 xBucSXTWTQg6Aubx5fF8i7SbcTWNcjQO2GsK6DdGR8RI6tJ9rxYcY92dH4bWZ2/9HfD1
 xbYEji2YufzdQ9bPOU4SKASvsomJ2rHwa4E23H7wh0PL5A3yFPG9Q3VGvW+4nXel0Z8g
 7we2+6X9tt8rFNN73B/NWgl7qciGcyFSg4nkOLPW/zBWdWKxTiuPE2weZ+YV3SgBxr9v
 YR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IWRcaA8/wlrHD8pgz5xTOhWNZhjrxV7FX8GxKOdWsX0=;
 b=qA7KvYNlV54K58iB3HluDG+zt9u5EPZU88x6+9oyVHBJ9hq+H5spKaH5V+F7kJHDb1
 y1iOkoV5T0dbFE73Fd8I1EGj9GO6MmSU2Ig9AUCjn2Sy+Jp5fU1Jfu4iygauBGhinQPo
 k+gFevkzmbngBedd55qpiNmY3NBDHYbW4zXYTw21K04kW6ZQKH9+7/+NoLHIriTjzIr3
 RrX0vZc1ETrcg2QoLC8WVJZu0qfEnwY332fnBVD5WAhGUfVntzIb1sFLfk7nQ4f+PVDC
 Q2SvB/OGRNXD1ieoNjeDHHk8gmEkkrsIV9JxMuXajMeCR29gzkdAdf6Ur+39xN1o7kCW
 /iBA==
X-Gm-Message-State: AOAM533Hm5Ri1E30pTZpmPSC5mE7sJ1sZ2Rf3gY/56834hKXSZfuW9Ef
 k1BchmmTD3dEk21tzLCsYJ5vCg==
X-Google-Smtp-Source: ABdhPJy1vns/1i1UTwJKvvMWi89EWQPFc2biXa78iFcSa7DdVSV0bfAdTvkDm7h9bjIrOKGDZgv0rQ==
X-Received: by 2002:a5d:5086:: with SMTP id a6mr6123315wrt.304.1598279386408; 
 Mon, 24 Aug 2020 07:29:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/22] target/arm: Implement VFP fp16 for VMOV immediate
Date: Mon, 24 Aug 2020 15:29:21 +0100
Message-Id: <20200824142934.20850-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824142934.20850-1-peter.maydell@linaro.org>
References: <20200824142934.20850-1-peter.maydell@linaro.org>
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

Implement VFP fp16 support for the VMOV immediate insn.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp.decode          |  2 ++
 target/arm/translate-vfp.c.inc | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 5c64701dde0..c898183771b 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -154,6 +154,8 @@ VFMS_dp      ---- 1110 1.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
 VFNMA_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
 VFNMS_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
+VMOV_imm_hp  ---- 1110 1.11 .... .... 1001 0000 .... \
+             vd=%vd_sp imm=%vmov_imm
 VMOV_imm_sp  ---- 1110 1.11 .... .... 1010 0000 .... \
              vd=%vd_sp imm=%vmov_imm
 VMOV_imm_dp  ---- 1110 1.11 .... .... 1011 0000 .... \
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 99b722b75bd..c864178ad4e 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -2161,6 +2161,28 @@ MAKE_VFM_TRANS_FNS(hp)
 MAKE_VFM_TRANS_FNS(sp)
 MAKE_VFM_TRANS_FNS(dp)
 
+static bool trans_VMOV_imm_hp(DisasContext *s, arg_VMOV_imm_sp *a)
+{
+    TCGv_i32 fd;
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
+    fd = tcg_const_i32(vfp_expand_imm(MO_16, a->imm));
+    neon_store_reg32(fd, a->vd);
+    tcg_temp_free_i32(fd);
+    return true;
+}
+
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
     uint32_t delta_d = 0;
-- 
2.20.1


