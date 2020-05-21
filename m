Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E030C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C0F20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF8FyNqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C0F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbopm-0007b1-V2
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJA-0004Ns-EJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:37 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ8-0006iT-4R
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:36 -0400
Received: by mail-qk1-x743.google.com with SMTP id b6so7814837qkh.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NQ/BbjaNmbkm5KQOy7Vv4O17R/NYOg7qZF+hAsl6NgU=;
 b=MF8FyNqJb/RGFP/09QrjTIyVf34prruwqZ1AceBOSuOm48II948vnFxI3xzdmRnPzi
 DZ7vpfin3Nkm/cEGHA5V00jSHaM1SbzLyUgeh/y4kELaczI5vmcNnFTvDGPblHmyWgZM
 2XVUUDlCEmzs6o5EB91D8YsjrT5tR2ijt0fVlWrDKNdTGEQMYZnpIS4ENx3zW5wZ8oB4
 zyrLZQRiBpOpJgRxh7kXQUgR81wTWAKlVYsTyGIcKbMZOtnZOBQ40kNvemJZk+zNfrMU
 UMioW8CgE4Q0pNRWwSOd96K4NEybvbsefSuVVpS8TYGQpGtLYrtdMs9oizX/pYXMdHkv
 c0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NQ/BbjaNmbkm5KQOy7Vv4O17R/NYOg7qZF+hAsl6NgU=;
 b=amixXc/iZmNttRfyb+aLIBYCS6Bte22NvMY3vQr9+4uJWEnYTvG6+NdWROzvAeqW7V
 FXFX3q/up+jgE1eKNxDxjuDul5gCtz88f9HUaQM/fLZp3FFow1DQZoQ7jQa67djwHXip
 YUZOfidS/Ow+lhcM8JGWHI56K6f55z8Iw9mJpaE3wxbiRz4379KLCSzLI+TPzCfP4bCK
 rfQMWOi59ghwgI63BGDHN+yNsMaMk8jmhQSINK9UmeO0DXD0aOW/KZsSNbXf6osohWTC
 5JBZ0MYLd9n/DUbBQSooubr5PQpnGyQGIDfLjTuLcghDefV9UPAdoOgRMpspRBnGC8y0
 cU8A==
X-Gm-Message-State: AOAM531W9e6UIWOsMuSHpW+G/FkXrLDHfprZA40NW4IGK9LHUhFVM0iM
 2jgtdXBg6D+N9iARLHPgpHzS999eRaNBVA==
X-Google-Smtp-Source: ABdhPJzeBkaDp+FqKVcdVk/W/8+ZVXtC1PPJ04dX03wXjgBff+z9ucLK+bNXteXW28K7hFHCFRtVSw==
X-Received: by 2002:a05:620a:204e:: with SMTP id
 d14mr9451256qka.13.1590079472636; 
 Thu, 21 May 2020 09:44:32 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:32 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 58/74] unicore32: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:55 -0400
Message-Id: <20200521164011.638-59-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 peter.puhov@linaro.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/unicore32/cpu.c     | 2 +-
 target/unicore32/softmmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index b27fb9689f..06bf4b4b63 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -27,7 +27,7 @@ static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool uc32_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request &
+    return cpu_interrupt_request(cs) &
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_EXITTB);
 }
 
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index cbdaa500b7..9660bd2a27 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -117,7 +117,7 @@ void uc32_cpu_do_interrupt(CPUState *cs)
     /* The PC already points to the proper instruction.  */
     env->regs[30] = env->regs[31];
     env->regs[31] = addr;
-    cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
+    cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
 }
 
 static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
-- 
2.17.1


