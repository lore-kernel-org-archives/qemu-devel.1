Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD46422D3E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K2L7eyXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD46422D3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dpq-0006IP-Qs
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSk-0003wL-B8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:30 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:47055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSg-00081J-OG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:30 -0400
Received: by mail-pg1-x52f.google.com with SMTP id p8so10385433pgn.13
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qC1PvBfdDas6WR1lzv+dfzk097rih2ij4A0RyNNv1uQ=;
 b=K2L7eyXd+YOojhCmzdjqnZ0E236d3XBwGrj7HP1u9v8pkHq1z0uY3ejPAQFATVTysP
 s2DCnaPI1Tzml/6usshGDHeEmBWhk4dB7NYE1lHiurjp9pFbCk21MIco0aQqwsRU9BSx
 EvQHgClEYqesCYy9AsZT0yDPOWjIusZoUDgBPCcY0MzeVaF0gfDGhTCtVrShlZl804R6
 fSfvJh19SfPWle8dQjh+ISBAzwOiZjjEBPOGHuz1TyQvr+/KQpeCdMmQ/Lhcx659C8n8
 Fuf/2RHne81C0PtH9QCltxo0euF3B8ndLnc7UiIGJVkX0Be3CuyCzPmuZaf/6KsM5j0U
 4Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qC1PvBfdDas6WR1lzv+dfzk097rih2ij4A0RyNNv1uQ=;
 b=kEaNMl+6NqYN5+KIKUGKo2C0mRifEYeinrCbZ0P8weDv7Tj/VaKp/XSkegjbRc2RS5
 ncQVbeRgjpmsNCWSKPPxZ1knPXS6pPfVXNOKp/9Ji6jHWo4H+5DFPiEUjrfQ7ZliRl0o
 1Q7ChDTMOGdmkom3WrE34NgXST7hGc+dxTsCjAF73ouEBPIVzrWLUMpytw8yjo4OMXsq
 xLcUJgQtoL96s9t5c/bDpGGwzVAhX+d0D9eQMs/4A1JKV8e7ZUhR1wm0AgjkwY3iHbh9
 MgreZNxdF7+gLFnc5VihnXeGD/2fcfIRZDcMyHP1bJdTS+Ho9HP3+FE0kwSTUqfjZH61
 nqTg==
X-Gm-Message-State: AOAM531HyGKR6KMSSzPPTroVsnmmzlYGpmKKxkADzY7reTWNP/df75sB
 QGCwgP01qknOIsTek9ZSZ6JuFLfzXuY=
X-Google-Smtp-Source: ABdhPJw1y53ETqdjHcJPqjUIfMUxbJAueRSei/1erKr7ZgaXgC2uK18IU3F1Uvsd6mlKG0pRtZaw4A==
X-Received: by 2002:a63:4c08:: with SMTP id z8mr6495948pga.201.1596710965257; 
 Thu, 06 Aug 2020 03:49:25 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:24 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 51/71] target/riscv: use softfloat lib float16 comparison
 functions
Date: Thu,  6 Aug 2020 18:46:48 +0800
Message-Id: <20200806104709.13235-52-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 32bcee0f380..ffcf8d2df99 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3998,12 +3998,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     }                                                         \
 }
 
-static bool float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare_quiet(a, b, s);
-    return compare == float_relation_equal;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
@@ -4059,12 +4053,6 @@ GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
 GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
 GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
 
-static bool float16_lt(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare(a, b, s);
-    return compare == float_relation_less;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
@@ -4072,13 +4060,6 @@ GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
 
-static bool float16_le(uint16_t a, uint16_t b, float_status *s)
-{
-    FloatRelation compare = float16_compare(a, b, s);
-    return compare == float_relation_less ||
-           compare == float_relation_equal;
-}
-
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
-- 
2.17.1


