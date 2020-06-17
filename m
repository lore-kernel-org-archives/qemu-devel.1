Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53519C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8AB2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQoCPWgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8AB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfIN-0002n9-6i
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDd-0002lU-Ot
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:37 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:39813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDX-0008RF-Q4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:37 -0400
Received: by mail-qv1-xf41.google.com with SMTP id r16so1760442qvm.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wrWqzZuurKLoDMN6QCL6bZgCudK/zrEU5r5KFbp+gtw=;
 b=hQoCPWglOq4TovAqV8Vh7jPChis7GkW1FdcQ/q/4+2mPBL552PrmZoA95o2z/wtxwl
 307nBu0ery1QUYdSLMNvgWKVvHh667gKWdReAhHnG3msMMfPO14KgDFAoSJxi0zD+Y4O
 N7RAT4TEmn178wK9mszQO6HeCV47LXV6ZRsh7cETFIg1BYWdb+39qQBxHW1ruNxIO9oL
 blKSVaCcT9Hn8rMBSCBQzPQYJq2PcJylOAKUPVTlFtsLx4nB5XoVNlypuRIuHrz4Gkr2
 7E5+zdO3NOSaz+P4V+L1IWgkv4pei+jzLw6TozajGuGpe0DlkvAmjBnE5Xbv2QdKO6m6
 quhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wrWqzZuurKLoDMN6QCL6bZgCudK/zrEU5r5KFbp+gtw=;
 b=eOHqJkqIf1fsxZ4p5M+ma6OxWp5HSjDl/p2V1kga2TUB6LDb/hlKA4MdY646SV6UqI
 SmOnVTeU4BL79QsJTsr19cWXFKLc5oK7/nqsVeI0cK74dwCkKvPJswLGbV4QS4d2LBH8
 JB1GdGTbrj2KUAh1BK1sS0lAseExqjpMmbjLB/AQ91zyBNP9NvZuGcsb4xZX2gxVoeGj
 FswcS9BB8GbGTNlkeePBO1vWgE+NG5V37xB4s1ByDH2Hw+Rhtlyw+68Jla11Z3RfiO+G
 4DoNvefelbN8dtysYILEVChxZ/T1f8cXsuyAs1EtaEoZn2qkQRXf6rautE7HtY8X69+N
 L+5g==
X-Gm-Message-State: AOAM532enHAS678a/hiKFvW5cUlVmn71xAo9H38TS5I/pt8Q2acA/4aH
 8wJ6ow9+Vk3kVVOhwv2NnvGdD/Gbe/xdgA==
X-Google-Smtp-Source: ABdhPJwuO3Dv8hCbqTJxJ+vAtG77B3ov/8/C9+sgyue0s0+Db7c20QuTw3Ev7xPICGX3GBCYs5DgVA==
X-Received: by 2002:a0c:806e:: with SMTP id 101mr520295qva.173.1592427810525; 
 Wed, 17 Jun 2020 14:03:30 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:29 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 10/73] hppa: convert to helper_cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:28 -0400
Message-Id: <20200617210231.4393-11-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf41.google.com
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
 robert.foley@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 52d7bea1ea..9c4d5b28b0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2725,8 +2725,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
             tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
-                                         offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             gen_excp_1(EXCP_HALTED);
             ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.17.1


