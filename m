Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32DDC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B41208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/ZxaLOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B41208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBadB-0005Sz-Rg
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacO-0003je-MF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:20 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacM-0004Ck-To
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:20 -0400
Received: by mail-wr1-x430.google.com with SMTP id a5so627382wrm.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=T1OFqc0n4tXLA0uJrhfV1aWiONH3/+FnVs/jfiL+i1Y=;
 b=i/ZxaLODK9+LxcfYU2mT6NT2R5I+kEANN2VMWvDl+XYb1+XTMdWT4ciR0nhaaR1gj9
 mTBM3aW9MHvPBm+T8+I/O4yL8Nqc9c9ZcpASxqexjlTQFLBOQIS4BaJ5FxCvv59VaEMI
 pYyT356zLIW+j0NG7gybg4bocbwDGClnUUYvAHoChYoD6ZZTWhyUUR/VGkS4PYmkLGkA
 shbFu0fLfcZQVksjHXcndgPqghOCjXCEHdWseOUjTZeBPHFeocqSljdGAeed7yAXqMwr
 hS6agfX4dFKzvi7AJK7G9Tc3oHXJpV5y88C9QR3WIkb7CZhnrFEcv25fqMvJ4BZybww2
 5u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T1OFqc0n4tXLA0uJrhfV1aWiONH3/+FnVs/jfiL+i1Y=;
 b=kzwQSWoqOsHcCFHzDC++phZYm1CQJvpnfa8dvYgMoJXpTzyH5ngnXKLGpODkn2xsF6
 n50IOnSZj4LiIHtGWgKkXPJ0zVRhzEtp7RtGAZm+v0bgNNPB/0rvngUaqfDAur9+2b0f
 lk6Dyq80FhyuX/boKHFe2Mg5+eaYMW/BA4suvm3trjucsypjxgLckiN1bCnQYuEEhMjx
 C1O0KOpDOCHBXoh/El3IDO+7yCtitCzEO1JK0KN+necOGB2twC9cPtXNqZEw22MUEanf
 v1rKknpBR3PWtaMDb5p2AVlVEhcgOD0U5ONPdWSCKt1NOkUQNsFzZ0CJqeH6ry5YhvgA
 m9yA==
X-Gm-Message-State: AOAM533zPgNR1M6Z8JMtWHxiIgVMXkvc5DurCbxrqeT5y0zxeEYnoPWI
 NRCuBh8n1RhXTs/6irTfbNsLbE9Tvazr8AUe
X-Google-Smtp-Source: ABdhPJyvte6beexMXB7qq7+G9E2We6pJnMOWgiJ15sfHAETQWcJ1jJcQ34j7YX1i/H5Up1+KLX7u5w==
X-Received: by 2002:adf:f511:: with SMTP id q17mr625595wro.414.1598606657084; 
 Fri, 28 Aug 2020 02:24:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/35] hw/clock: Remove unused clock_init*() functions
Date: Fri, 28 Aug 2020 10:23:40 +0100
Message-Id: <20200828092413.22206-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

clock_init*() inlined funtions are simple wrappers around
clock_set*() and are not used. Remove them in favor of clock_set*().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200806123858.30058-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/clock.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index f822a942209..468fed0996d 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -209,17 +209,4 @@ static inline bool clock_is_enabled(const Clock *clk)
     return clock_get(clk) != 0;
 }
 
-static inline void clock_init(Clock *clk, uint64_t value)
-{
-    clock_set(clk, value);
-}
-static inline void clock_init_hz(Clock *clk, uint64_t value)
-{
-    clock_set_hz(clk, value);
-}
-static inline void clock_init_ns(Clock *clk, uint64_t value)
-{
-    clock_set_ns(clk, value);
-}
-
 #endif /* QEMU_HW_CLOCK_H */
-- 
2.20.1


