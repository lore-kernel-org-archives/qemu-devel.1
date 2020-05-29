Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB3920C09
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgjpq77t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB3920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef34-0002Hs-EY
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeez8-0004HM-8L
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeez7-0003Z8-Fp
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:41 -0400
Received: by mail-pl1-x644.google.com with SMTP id i17so1146785pli.13
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wgvUXG0Vlnhy8HNXWH/V4PveTdhkLExBdueTuZ9bPNI=;
 b=pgjpq77tuioHkGAn2W5W6tXnUhQdUcRYYceF/Doy3VPpMBY4vDnZO+aNpPkW8iaPgl
 DSIbGA9X84HQyIqnKowd6UShgAcCkHkZLVO1BEoC+489tP8lTCr9tX3kMQlNvaVIlql0
 NDpC7kfUey8E3JhG2fQ6sUhVhp8gjCyKZ3hzV4N3XNw6lDdd6cddGKW1Fkp9Bu2Eh7/I
 WeSfHliOUQo1wGlMOlCm8JtoV0yF1D71K5P2Mr+KDPv06QzjPH2EUPEBpPy9+Es7jxtB
 YecaNz04uHvYJqqEDqo7tFopD4KWpSxjkGHfYkpBo0VgvLbS3ZlU6/8u6TrsVWkuiGGt
 MVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wgvUXG0Vlnhy8HNXWH/V4PveTdhkLExBdueTuZ9bPNI=;
 b=M4wtjsO8tPMHoUKlQf/z7O36CzW5OFPIh2aP+c/9lMTlxC7vidycZPkwXh1cNBQDC2
 yyEsBQsuudUOMFteWpPIQZjiwmfGSi9eIMnLWPPjWgY5pgYM55pBxaggbse8jgaHShph
 MqGynzQKoaaEIw45DsEQnBynh+60FR4a5JilzZfSLsfWFqVBUlGTznOQVACodx0+xU1J
 LzOdp+XzfiHv/HjnnOPewQJY7jZHyoJxdG628p/J5LwySSceKsYPn3OQW8yWY3SLfHBS
 nBmK7M7z+8jhps6e0Dwtn/PJxw9TavESGPH2r9cK2AosP5Hmevc4BHsF0IAHH10MASe1
 ryxA==
X-Gm-Message-State: AOAM530lmwYOSSCjGpT4z6krTgJYLpCMOo+cbVsK2I6fuYDlSi8+pbEc
 S2QA6nmdKL4IDx8IfBXrooB1EaIG7h+00g==
X-Google-Smtp-Source: ABdhPJwtM2Z0wJ7Nip6sWVTLJvDCmNvz2dIQoMYVxj0ZSNEHJGCGH2/hgFrL1OKUBSXqXQFPEU6tWg==
X-Received: by 2002:a17:90a:297:: with SMTP id
 w23mr9833565pja.140.1590758619893; 
 Fri, 29 May 2020 06:23:39 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 03/12] thread: add qemu_spin_destroy
Date: Fri, 29 May 2020 09:23:33 -0400
Message-Id: <20200529132341.755-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

It will be used for TSAN annotations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/qemu/thread.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index d22848138e..e50a073889 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -215,6 +215,9 @@ static inline void qemu_spin_init(QemuSpin *spin)
     __sync_lock_release(&spin->value);
 }
 
+static inline void qemu_spin_destroy(QemuSpin *spin)
+{ }
+
 static inline void qemu_spin_lock(QemuSpin *spin)
 {
     while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
-- 
2.17.1


