Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF3C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6090022225
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuvY3Lgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6090022225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWgQ-0007Fe-DG
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWg-0002Yf-1s
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWa-00059r-Qc
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:27:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id a17so6713808wrn.6
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tlWKWmJvleFe6NmAUM6zvE4yQ74zUWxKvHgBoaE7gkg=;
 b=UuvY3LgzA4JkbAlpECtwA1VNgNyY1hVmaX4FiaM+z8O54MISa+mFZHdEzm9CC8vFT9
 Ooi73pU3FTfb8Uf7+QAqkcA9wy6UVvFb6zIqSFTJEEOTI3rEPMHyAO4lpxZNYqp97CxQ
 JI5tnq8P21fliGpl9hUOWSyeMziHfPGciQH0WIkVskHeRk4CoFet4HV3nWq+ZHXAdcu1
 W6VKYT6WFfmUMfUvLk/I15JEOPWHO3emNsVcLWwVh9B3CZMJmyJSUncJcFbck96810zO
 5WZ7Naaj5Va6KkTCgURwrCd+kpSUSgT9u6YTe5cHr7qK+DKjLmOyuo0m0zwPRIY/dFEG
 ry4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tlWKWmJvleFe6NmAUM6zvE4yQ74zUWxKvHgBoaE7gkg=;
 b=Bwe6G1/MGH+KJlN+NvqdU9Ehgmdg7NSeVi9V5StlJDhCrBnMzU15JtYgdupCp2Qo6e
 YxVISotPyuWMQutUR8JWLCcf1XXL1XZbrq5d6tqab8ie/TDduuJeQEUCY2VLrowlrKu/
 942fAlTaMR3dBnaNGDioQ1+3Rc8jHPG56pXrHgu4DddkjdeWGqmkus77V30FHNPaC8KB
 Fd3nLEzQX5e0DGX0UjbvhHriVI0WiwHde5W3TEdnxfaXqtVwuox9vlAw/aY1d6BvewW6
 PcpRXIMcCSaZx9aubHZ8jWE0lU7OJ0gCm98CVyKWJ8aj4yG0J0JdeHGc6qNQW1hUzp/0
 kOyA==
X-Gm-Message-State: AOAM5325aPQ84UNBPQYFdn+qtzmxp16DiQsVtUDXiyjbYJzayUl8p1aI
 nw0VROnrqb8NSy2Ttx4ZMF16KQ==
X-Google-Smtp-Source: ABdhPJxKhLIPGj3RKOhfLD7HAlO47tHDN4D861Wbbk2zuxWl8tyUFkQD7xkVFqjAoSAam2qfpb7rGQ==
X-Received: by 2002:a5d:574a:: with SMTP id q10mr4227164wrw.127.1600259219490; 
 Wed, 16 Sep 2020 05:26:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v2sm32290614wrm.16.2020.09.16.05.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 04C1D1FF92;
 Wed, 16 Sep 2020 13:26:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 6/8] configure: include tilegx-linux-user in the deprecation
 logic
Date: Wed, 16 Sep 2020 13:26:46 +0100
Message-Id: <20200916122648.17468-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The target is already marked as deprecated in the documentation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200915134317.11110-7-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 58be974065c8..dfd7f18dcb24 100755
--- a/configure
+++ b/configure
@@ -280,7 +280,7 @@ supported_whpx_target() {
     return 1
 }
 
-deprecated_targets_list=ppc64abi32-linux-user
+deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user
 deprecated_features=""
 
 supported_target() {
-- 
2.20.1


