Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C184AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C5B2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GE0AA6F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C5B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlflN-00012h-Ow
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfES-00041j-B1
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:28 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:33709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEQ-0000LR-Hu
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:27 -0400
Received: by mail-qv1-xf42.google.com with SMTP id d12so1775865qvn.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oS4OFCHOXLNPVShms1TjWbnrC15wr+ouKwB5TcDXaeE=;
 b=GE0AA6F0qghZkTHfPxeGxcc04dzhmoqfZtJMXikX8yoIn+CxuNQ9j94pEpjoZ8fMBx
 IBSDa8D0i9ekrXE+rJP+qNDmVFN/MLpPNG4EETYPdc6TJpbyqEQg8tXRV3qQeTc+QhtD
 WAIyLdjtp0HZ+czVWcizdGrk5825Y1Ze/MIeWuSZuHLqYH2A7G0RIW+9Pu+g1svJNNxm
 y4r3wdr+f/WLp7gqW2z2+xeKXC19oLV3tJTr6/6/V4IukBqzPJ9f/md5wgb1xq1OJoKT
 kNxX7iwjE8PwLyFYSD2Hh6AqqXTwZnefhQTmg4ymy5RcFhQ3R+UpFnNY1UTKKPCRYbMI
 7CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oS4OFCHOXLNPVShms1TjWbnrC15wr+ouKwB5TcDXaeE=;
 b=ZSmm7x55lxeLlRJixHDcMK8E4sRvPrjxl1KWCUZpCs0rIDAoU/2zK8WueQzo7348IU
 jHAC4xl4Bfg6TEtSQ8NcGQKx//cnyFIUbCskLhC0X9Oqgb3+x1Ju7Axa3IcG6NHtlR6j
 6JbdGVxT2tICLCJNX+eVPw+efrLQF63C32nZeYgkGxwcCoU5Ec0F24ffxb6ii7OffQbV
 dW6XTL0I+U3CDwWpllJIcDIdUef4EspmH3c247x5SLHSNlo6kP6Kz30IvMabs3ammkzr
 mWHlRCk3DMv2dwIpxZXg2U/f1Kqtx2BpCyfBPQ4ss0wbjFceGnL+3apDlYzJr72AtqRF
 gYsA==
X-Gm-Message-State: AOAM531jNa/tqcGbpqUs7CzMxWhozpEuE8rWKjvC/Ed1E0yXDw3MUydC
 T5Gb2iucIQ1jwfo9d51xp5F/dB5MkfQjLQ==
X-Google-Smtp-Source: ABdhPJx1hN6zWpynxS0xeB7YUJdmDiLn5MvRJZQa4q3/0rSqcrGAqD8GNRMWxANy1OOfhVa5sWQW7w==
X-Received: by 2002:ad4:4851:: with SMTP id t17mr599131qvy.160.1592427864494; 
 Wed, 17 Jun 2020 14:04:24 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:23 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 47/73] hppa: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:05 -0400
Message-Id: <20200617210231.4393-48-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf42.google.com
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
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 71b6aca45d..287055f96e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -61,7 +61,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 
 static bool hppa_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
-- 
2.17.1


