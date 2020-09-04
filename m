Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC7CC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6BC207EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrGAhPln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6BC207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEwy-0007St-18
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEEwP-0006xK-PW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:51:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEEwN-0001Od-NL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:51:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so7414368wrm.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4duUGoQXDKkk+15r/4jG9Yu6iIkSZXmDV4hH5PvDtEs=;
 b=HrGAhPlnd+GnJNGVH24tf+F5+4TDmJP2B0QKL/VtXo0/kMBHv3CyXIPXc9Zj2C9VBB
 POnyYZHP2+KfufFNS4rYHDMeDM7631Nb8P6XqxriWHN3aPRv3Mj1MVazmyfuhsQAgMAY
 sHnEus9VB8x3moEY6eRHii3kM4cTisVOyASmmljEGoRBklVB9KdD4KXkdgUvw9pYeboY
 vqrcMfrgKM+eI+Pi6TFW/wa1l2xYDYUKn3IbLhWL2IOKUGu5Q1UxuxYUVtSpu17fIzxv
 QPwBV5D8uNIqazVqHwuxbxTc9YBwC8zLGKgZ1YTxtcwxl9Edz8i6xdcYLipGItEQjRY1
 DkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4duUGoQXDKkk+15r/4jG9Yu6iIkSZXmDV4hH5PvDtEs=;
 b=HD6HFvAuIjX3gJDIiNjDBPhgobQzbsMuftLEcYj9U+Vc/dUlpiyQK3RYnBknyPKb/8
 l/5H/3G33QUtJQEsMDAjcgrSRMYQC0wNXVo+hg5zdCQnFeba6V+LOHfAD0vMMtGF264h
 8ogE4+bdfcykGp9BLzM2IZlnX2U4Ynl5iNjKFyNa+jPhomC05BLRru1nBW5WJaRXrcPI
 2IruygQ5X5razVyaaLopsIWPxNCdaRXAIZTDbEFCWRXLbUZ5RJ0koqeso/pazKzUUSnU
 OuBCcHY8Rh34qiApqg6caVfR+r73dKGF1XAn5cCDJ8bx8R/zQRXgzE8CfmpG8vuQt66o
 3CFA==
X-Gm-Message-State: AOAM531Q0FdjXo313CH4b5PuMNxp2ghvtBWpSjCO7/8+g9dIRyomgwO5
 LMf1cdx39WVX7ZgAU60E9AEFQQ==
X-Google-Smtp-Source: ABdhPJw5YI7d9zcjRZMbILfy13U1idmGoJPQVzEuyC1veU3z7KfdIXe7VIUYqAmgEqykk0KYGf1YHg==
X-Received: by 2002:a05:6000:83:: with SMTP id
 m3mr8396292wrx.165.1599238313154; 
 Fri, 04 Sep 2020 09:51:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm12900162wrr.8.2020.09.04.09.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:51:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66D381FF7E;
 Fri,  4 Sep 2020 17:51:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] docs/system/deprecated: mark ppc64abi32-linux-user for
 deprecation
Date: Fri,  4 Sep 2020 17:51:40 +0100
Message-Id: <20200904165140.10962-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's buggy and we are not sure anyone uses it.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 851dbdeb8ab..11c763383d9 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -424,6 +424,15 @@ linux-user mode) is deprecated and will be removed in a future version
 of QEMU. Support for this CPU was removed from the upstream Linux
 kernel in 2018, and has also been dropped from glibc.
 
+``ppc64abi32`` CPUs (since 5.2.0)
+'''''''''''''''''''''''''''''''''
+
+The ``ppc64abi32`` architecture has a number of issues which regularly
+trip up our CI testing and is suspected to be quite broken.
+Furthermore the maintainers are unsure what the correct behaviour
+should be and strongly suspect no one actually uses it.
+
+
 Related binaries
 ----------------
 
-- 
2.20.1


