Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9122C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7046C2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GakJUK72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7046C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfKq-0007Cx-LG
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDe-0002mJ-7x
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:38 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:40741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDX-0008R7-BJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:37 -0400
Received: by mail-qv1-xf43.google.com with SMTP id e2so1755979qvw.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I06C2sE0s7zrdX3gLkjEgs8DOpvCtPpl7x1fQYW5h5A=;
 b=GakJUK72IOEF2gr6ZnvdYEt0Ixa+LSj089KcAo663SMsOh9Uak7fxg/4RTtL+mO/MT
 PTE7gH/2bwCTbggFfOsuC5l+tVIk4K0elPXfLB5UO5tkeVl06+gcSDDgSoFO+Zh3UBgS
 c/O5TfHPAOpU4BP+sTgs6tI+NOptFFEdJIOFYhcaRHEJ+NLN9ftoqUHNPrOE+I5dgfnW
 5ZNP2awYQ7jhNJtlDzXDP+oVQbSZTm9hZ/JVOcVgqVqvgRBLrlftglE26Q70h7udHtCq
 NzSiiXRuNlFJRRT+5crJkVvLm77Nc87XH5veZyvfRFP3rRbjeizlhaBs6MijS0LTCG5w
 iaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I06C2sE0s7zrdX3gLkjEgs8DOpvCtPpl7x1fQYW5h5A=;
 b=f3iACXxGqMRJELipjCGYzGRc9K7XJa2FbmZua1av2LYTblWtygHVpW9ssPyngGmGtS
 rpQv2i23R+DhdvFxoiyR4OwtLuukVasZaC0/X4IRnNKnpSOSde+3zKk1wEw7tY+AxJaA
 meG+g3PV61LoD8CGsn0RtGLkvpIaL6OufM+stlR3MB3fneJza1zNIpofU3xt18CQqdT8
 ZwASnKv1yGw72/oA/6qIkZLOmcWRsVgWjtjrWP6EUqzaNqdyKRO9WWUPIodJSyEraTNe
 a9P3AAn5CIkyfjohQGbm8vBI4Wcn2VmMZe/Lo1a8bJ30rDMD4TsAbYZlVi6bUrbQezqC
 KlLg==
X-Gm-Message-State: AOAM533ujACWKtlq5q3mqcz1ZGJAYh8MW8z4n1cduE8uywbTYknJSRNA
 k9O3LGwkAHie8uGm6maaB2FBDmXCJXYd0w==
X-Google-Smtp-Source: ABdhPJy9Y3jCD5Svbcn8gi54vhh6rh2X1StsZj2/rLhK+sA/K+Go/prVJsjFv0AqRiEzC3ttlgUmBw==
X-Received: by 2002:a05:6214:848:: with SMTP id
 dg8mr552195qvb.152.1592427809217; 
 Wed, 17 Jun 2020 14:03:29 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:28 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 09/73] cris: convert to helper_cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:27 -0400
Message-Id: <20200617210231.4393-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf43.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

And fix the temp leak along the way.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/cris/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index aaa46b5bca..6c4f091b7a 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2823,8 +2823,9 @@ static int dec_rfe_etc(CPUCRISState *env, DisasContext *dc)
     cris_cc_mask(dc, 0);
 
     if (dc->op2 == 15) {
-        tcg_gen_st_i32(tcg_const_i32(1), cpu_env,
-                       -offsetof(CRISCPU, env) + offsetof(CPUState, halted));
+        TCGv_i32 tmp = tcg_const_i32(1);
+        gen_helper_cpu_halted_set(cpu_env, tmp);
+        tcg_temp_free_i32(tmp);
         tcg_gen_movi_tl(env_pc, dc->pc + 2);
         t_gen_raise_exception(EXCP_HLT);
         return 2;
-- 
2.17.1


