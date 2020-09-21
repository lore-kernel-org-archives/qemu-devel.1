Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EBC4361C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA13A22262
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awAmJULs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA13A22262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPrC-0001UY-S5
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPon-00087R-Px
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:37 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:34104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPoe-0000H9-Lf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:37 -0400
Received: by mail-pj1-x1034.google.com with SMTP id s14so240081pju.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a3xDNZ7X5vKgkbce6iNasAuvv5vN3OhZYwiJJsW3uGU=;
 b=awAmJULsrklwurhqPSgooahcyyO8jhAtSszZlCnIWwHNzyw6XkHtgKt6GASQAP4GIW
 ST3/TMT/fYB03UUhXAZWlctkkP33nLHq3sMyrjjOzoR/Ly48qtRy0QHI1NHFbmDyXDXK
 4JJAaoVWBmbPkIEpp40I6KCmUp2XJU21offAHLx5z01d8efx1Lvtbge/hvAvMaiYwFn1
 UkPL6VjXFjxaNN7VIcFUtOkCuyjGVaFVkG2HMSMnKnh4hwFQ8c9FzZBb3ELq7nOGYhgC
 vHgVn+sBEaIQ5ffFyrymNKjTJcfEWMW15XT4RISHWf1o0i8Ske5KB3naDohiStDwsQo8
 PiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a3xDNZ7X5vKgkbce6iNasAuvv5vN3OhZYwiJJsW3uGU=;
 b=fkEKEdyO6yi1vZ2HROmRFQAaCmabaFr7ouGdbcNdFHb+VINeSvm6LrDbaaJ6nB47af
 dcglNnzFoQNJvyhRs5OgvxeoGu6l2G7g7rOYSbzeRX0hkmCSPD9OwiKo0CBMo5MAAKTS
 PS+ytvU/tJAe2SChQq0EuZvgTwXZhuiW3J/4Lj4YmPx/npuAy57K0odh1cbqV8HISd+/
 /5r4dIU610y0C33bgTaG7wshkdXo3jCXpTIGa0nlNKkOlQujSqC9P0SsdsjYT6Qo2S5g
 RG2mzP1UvlSwCla2VT+eJQNHdHqKnJNcJrX6P4Hvyf1oO1CXNqwAKvfgqtp3VlT0XJda
 Il+A==
X-Gm-Message-State: AOAM530AIVDeQwVONXINAeMspTMXWk721pbk9cUc3FeEWJuBXX5W6wMc
 QMLN0oLy1Z8jjBxk8a7chwG9uDn17bNgAw==
X-Google-Smtp-Source: ABdhPJz6WfiAQwmlqC3V2y5W+SuTJ74316H8Kh/+ChUO4g1NpnX2N7hmWyISqwoagIev/8k8/OZB8Q==
X-Received: by 2002:a17:90a:cb93:: with SMTP id
 a19mr383566pju.207.1600710085421; 
 Mon, 21 Sep 2020 10:41:25 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm12585379pfm.86.2020.09.21.10.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 10:41:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/11] capstone: Require version 4.0 from a system library
Date: Mon, 21 Sep 2020 10:41:10 -0700
Message-Id: <20200921174118.39352-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921174118.39352-1-richard.henderson@linaro.org>
References: <20200921174118.39352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're about to use a portion of the 4.0 API.
Reject a system library version prior to that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4c92b43fe5..114b136129 100644
--- a/meson.build
+++ b/meson.build
@@ -613,7 +613,7 @@ if capstone_opt == 'no'
   capstone_opt = false
 elif capstone_opt in ['yes', 'auto', 'system']
   have_internal = fs.exists('capstone/Makefile')
-  capstone = dependency('capstone', static: enable_static,
+  capstone = dependency('capstone', version: '>=4.0', static: enable_static,
                         required: capstone_opt == 'system' or
                                   capstone_opt == 'yes' and not have_internal)
   if capstone.found()
-- 
2.25.1


