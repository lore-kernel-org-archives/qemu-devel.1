Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3D6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0387C2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ko47ccey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0387C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfWO-00025d-7O
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDi-0002vJ-DE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:42 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDe-0008S8-GE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:42 -0400
Received: by mail-qk1-x743.google.com with SMTP id l17so3471079qki.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5p5QVMZ54qL4PKza/xfxsC7DswUaUr8tRQACxDFIq5U=;
 b=Ko47cceyF6xkP1sqhiKJJfvtLpsMqHO2ctU5ho3y93gZ72PKeO8FjMj7g0orB+jRnQ
 mRt9t7raBAkBcU4xXIAx8Qp+w01TR0dZMjWke81TLI5UXMCvShzZODMEpdO52ewAD1CQ
 B1+J8Rczl9oeQzX5hceglsk9VeoFHpf+bbb4UTY8iIQP0Z32hz0LhRKE9mkjUw/uRGCS
 nsPkzTW70M9JMDGga7cnYULifBvGzZfCK1660ye9wa9FC3kSAo0ljkJVFPZMC/yL+RAX
 JSiXRhmE5dDRDHt70/M6V/vmTQbLHAF6IVn99uiQ0EYxC+W5GudRX5B6qEdMSwUk/mW9
 ffKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5p5QVMZ54qL4PKza/xfxsC7DswUaUr8tRQACxDFIq5U=;
 b=bBJY0xZdN21P6mTif+DLy4Uz/sJeqBD/984R6dVz5fj8yZSiVyeH08pTPyjT5A+d1S
 xv2kK61TEHEQxd835pkeIG79REQiflsWpcl23c3RKxNBWauf90ZN6FQIWVhFa1OQhcQ5
 pdgj9O9WTpFPKuo64xZJZpGmPG8/Q2gLHa6zF/1nib0iJA4FBaqw4/WWT1jmftuPPJqB
 pypi2aXS0JUkskgV9hKLhk63+niiKxIIbRxQu+AhkUptde/hEgz/jchcdXEun18QRSsv
 XWyZ0EWEISmhb7HXMuNluLBTMKzoNWDjkIM4KLgzuxU4LNkor15/Wped3rXaFD6hY80R
 F3YA==
X-Gm-Message-State: AOAM533wpHmAMs6GRK+FL/Z7O27fjvNXec6j+RqsomusmaLeoMfRCp8N
 IeS5UCOUi3olvqimnjzCHcwqp+DFOrsv4g==
X-Google-Smtp-Source: ABdhPJxQOEfP7M+e1MUpRSZ6W3L7GPhxnjeAQEQT1tGJ629bE91LFvkT/MCL7BGrzzDkO9WG8+q4Lw==
X-Received: by 2002:a37:5e07:: with SMTP id s7mr622767qkb.20.1592427817350;
 Wed, 17 Jun 2020 14:03:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:36 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 15/73] tcg-runtime: convert to cpu_halted_set
Date: Wed, 17 Jun 2020 17:01:33 -0400
Message-Id: <20200617210231.4393-16-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/tcg-runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 32ec18fe40..ca0774d3bf 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -173,5 +173,5 @@ void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
 {
     CPUState *cpu = env_cpu(env);
 
-    cpu->halted = val;
+    cpu_halted_set(cpu, val);
 }
-- 
2.17.1


