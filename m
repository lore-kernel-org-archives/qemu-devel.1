Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF53C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DC520575
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g69A2tRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DC520575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzuN-0004BK-QE
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq7-0006T4-PQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq4-0007Dz-LZ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id l15so14002227wmh.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+ZwHV1TY0j+MTqvjQNw1IJRg8wBizhyo8ltO1jMhlE8=;
 b=g69A2tRdba4f0A0mocmGIFdBA2FhKTst5Hfi38fpzLPTYMcOWIJ2xb3L/R6gyPxbyU
 vFhpNFQK0daY/N7M12Sezu+aUv6wzLnyIWSDk5mTrCaTThXvSg8+lHNae3UCa9xYO909
 6oXPexeakZR8Hc5HdYfYsG/fCoruErjK+iTWI517dMwUu8M+8xdHoUd7m7Yu5Z5OGZ/n
 bcY+685c39s9kort8LIBatCnsC8r7DEkJgjBKD4J/8MwxCVQxt8bVtRTEV4/2Z9QD2MU
 vuaRPNIxh+zkZg7Eofkw2P7b3b03oqN5pk/7dUYgubdVkuvEUKS3OW9BaWHx6uR+Nfjt
 /UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+ZwHV1TY0j+MTqvjQNw1IJRg8wBizhyo8ltO1jMhlE8=;
 b=lDcvgXhBIatcmRWk0I4oiy0PPok15pDOijaHjSy+3nGhb83hB/nrnBXRFzwvF3BY1o
 35D6CCKOhYNhomlT2bAarvM4AHmbyFcf1WhRjX2NHnq2IiW0v3Lr00UP4chPx9BRuQUF
 7Z5d+5qMRjDHENVyKzRRPastvpvKrb0MeArULjMpefW4ibEX0R2qvvI1Q7wkEHyfPFeL
 PdaGDR8ADUGL67mmihp5yMCcvVBOwf9+vF1vpZ4SIhdASoCrY1ptieRhgA3mBwqN77Mw
 aGECTSkzHG9HHktnQrajbXM3xfjUOvXtAqFQQsws7u70G0HAqkJEdvkUhSH4faYsrkIm
 6SHw==
X-Gm-Message-State: AOAM533Kt4sasaqGLjKJjEGIwsHt+t3iWuZIy3LhTAx9Oe318lwr9tjE
 2tE+Sffv/eukAWPx0pHjw3pxDg==
X-Google-Smtp-Source: ABdhPJwNINJP25/mPno0ACKvKjaA5qdsaGjdmvC5wgYZVm4vKB+j557A+omJvzgyeeiqqqJLo/Be0g==
X-Received: by 2002:a1c:e045:: with SMTP id x66mr11411611wmg.104.1602516855317; 
 Mon, 12 Oct 2020 08:34:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] Makefile: Remove config-devices.mak on "make clean"
Date: Mon, 12 Oct 2020 16:33:27 +0100
Message-Id: <20201012153408.9747-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The config-devices.mak files are generated by "make", and so they
should be deleted by "make clean".

(This is different from config-host.mak and config-all-disas.mak,
which are created by "configure" and so only deleted by
"make distclen".)

If we don't delete these files on "make clean", then the build
tree is left in a state where it has the config-devices.mak
file but not the config-devices.mak.d file, and make will not
realize that it needs to rebuild config-devices.mak if, for
instance, hw/sd/Kconfig changes.

NB: config-all-devices.mak is also generated by "make", but we
already remove it on "make clean".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I didn't remove the existing 'rm -f $(SUBDIR_DEVICES_MAK)'
from the 'distclean' rules on the basis that config-all-devices.mak
is explicitly removed in both 'distclean' and 'clean', despite
'distclean' depending on 'clean'...
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 32345c610ee..c2120d8d48d 100644
--- a/Makefile
+++ b/Makefile
@@ -775,6 +775,7 @@ clean: recurse-clean
 	rm -f storage-daemon/qapi/qapi-gen-timestamp
 	rm -rf qga/qapi-generated
 	rm -f config-all-devices.mak
+	rm -f $(SUBDIR_DEVICES_MAK)
 
 VERSION ?= $(shell cat VERSION)
 
-- 
2.20.1


