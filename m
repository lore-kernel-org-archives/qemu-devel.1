Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6457C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F9420888
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQ8XhIEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F9420888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jylcu-00047z-0b
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 20:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZU-0000Jr-19
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZS-0008Fs-Bu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:19 -0400
Received: by mail-pf1-x441.google.com with SMTP id x72so4065146pfc.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=47EQx+PBbhx6NH5LPqB93rYv/z3gdVWS3BnfZRGSId8=;
 b=jQ8XhIEFA1hpQtBf3QL6Fj9jVCKQFtXKBtmd3yDdhdpo0eZdO3ehCjYQ5Y2N2ha16c
 mYgvhfjZXkl0j+9TglvnuRhTIbx+O44rTpE9p3GpgzD2VQ2gvrVjTlAxXt86SNZ2rZr2
 8YkQ3WwWOaXhXJp+geNvk53/tqTUpRdGYqRHfm41MdIw/dubiYsCILx2iOeWXzPGvo+A
 9PLm9uwdhZBdGrguFIWdSE2LhFlnvSOayuJDZujtQW6LQM9T6zMP24opIhseEjsnB9ef
 s4iI15eMiMZZtVqN3QDbPib/401Ac3HA2w/JeXSeYK2YT2NLIPXCnBEEIKY22I/9e6or
 IAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=47EQx+PBbhx6NH5LPqB93rYv/z3gdVWS3BnfZRGSId8=;
 b=sqQOFVZ44Ih1pq7QW4BaQaG+60mQdQ6CF+fSTnw1b8xSuPsh0+DLIwAVCZD+13sukg
 tk4Q4HrvYoqajJuMWysDnKNXaShN/o04MwNM68Cnpabn7dgT5m56NbGcURNVCLL8koXJ
 BHe5YmPlkq1oadefjDU323CG14W8hGoKWlXyS0OF01Ei9NUgywatNgezLo6hJk9t059p
 QLm+IDrfaTWXRBovqrnKujUCpXm2U3SNRy8ODThTuIXuf1d8Hmmmo2Npa/LByWtrXEOm
 N5ZapNswzJeRJ2qHKQ9tIKt5T0E95KQUV4BHV3p/2Tk36e2zcVKnHtc3jUoZhLtAkA1I
 szsQ==
X-Gm-Message-State: AOAM5316crFakZ2KLTqvgBHT6Ur/PJgWxD1SahLuQi3JxGlvRKZpgEwi
 OF6mgLNePB/D2+Y7aLBQe4DTIEGLRow=
X-Google-Smtp-Source: ABdhPJyiUJ1O5lAytZTGnfBF6Ez5cNLIA8nUT0xPa2ZJIRKqfWX4UU2AziPFBPkIilCMKGDCAhkmRg==
X-Received: by 2002:a62:2b96:: with SMTP id r144mr6447012pfr.272.1595550496829; 
 Thu, 23 Jul 2020 17:28:16 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id q20sm4224635pfn.111.2020.07.23.17.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 17:28:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] target/riscv: Clean up fmv.w.x
Date: Thu, 23 Jul 2020 17:28:06 -0700
Message-Id: <20200724002807.441147-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724002807.441147-1-richard.henderson@linaro.org>
References: <20200724002807.441147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Use tcg_gen_extu_tl_i64 to avoid the ifdef.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-Id: <20200626205917.4545-7-zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index f9a9e0643a..0d04677a02 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -406,11 +406,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
 
-#if defined(TARGET_RISCV64)
-    tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
-#else
-    tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
-#endif
+    tcg_gen_extu_tl_i64(cpu_fpr[a->rd], t0);
     gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
 
     mark_fs_dirty(ctx);
-- 
2.25.1


