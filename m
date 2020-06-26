Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D80C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C093F20C09
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HI4KS185"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C093F20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot0w-00059x-T8
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot05-0003Qn-Pp
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:22:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot04-00050b-8q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:22:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so8754094wmf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UsvCJ1FtgsYHjIIgU0bFzUSnvljWkIkb9Subsb2kO6E=;
 b=HI4KS185qC+55mTwfaURF8bnOdQJtP0e40UJLtp/NS5TxHakZPKe4QVpWt2FLMtXaF
 1BleFv29NtccJLYy+P2fZQWekYU1s2xA55Sfuv/fWCAp7T84wfPqlekf1qivS5KUDPNB
 0LNzFggT2mNNHF0TVBcHQ1RVBFZUTCB0NFJAS3OSQ9ubhCWCZ47c6qVLqli5QXY6Dfcp
 gO1ffGgtApgAPWnewRxAlMziWW0nqkbU1MBr8kCTn78NrhYBmPSsRPsjc0KQj7Ys4DaS
 v6csIBOzlm889rNFt91GS5kROqzMIRjRRcBhEwE7BrQytU8Kf2NiYdpXd3VTud7zpVJU
 eJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UsvCJ1FtgsYHjIIgU0bFzUSnvljWkIkb9Subsb2kO6E=;
 b=Dza/YWxzICyfLlhGVfLm3JHj556OUOZIwwdKIpGtuTF8E8SRI9jufZ6cmI3VptYIoN
 YkMTTM4er/3t6KqnZt25IanZE5NA7L1ZigyQzbBGTmiDtci+GJfCcdG525cwwHsuetiF
 r+Gt8ZxEtErzk79FVoN+rrX4dokUSOxYnCC1Aslgur4aqg+r1pEBaIOqKwDFUs5pxzB3
 9ToXv7i5ByVJVnHR5+7dmfdpJo5oq1lXfdCVut1sWOC1tmtOQvT+giMfy1TFgeBNpSZE
 o72tzFjNnSxnIGKg8X3RImWhq5F5TaLSSXet4cZ+/blULe5Lloz0vdhXFqk26IqCbTMT
 u5AA==
X-Gm-Message-State: AOAM53079WlgSdMQqJAFf/UAEPH9MTA+jCg3+fjDPCFH1HYApggTVaIv
 9Nq1wci20SCzUo7sD56YG1qDpQ==
X-Google-Smtp-Source: ABdhPJyUu9mCVjoMCns72qXRVAts0xau7VyfRALREgyAj5LtSJJPoLESwXoK4ugeFTH0rUZ4F2uocA==
X-Received: by 2002:a1c:2e47:: with SMTP id u68mr4929167wmu.45.1593195774898; 
 Fri, 26 Jun 2020 11:22:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r12sm37304294wrc.22.2020.06.26.11.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FCFD1FF9C;
 Fri, 26 Jun 2020 19:14:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/30] tests/docker: check for an parameters not empty
 string
Date: Fri, 26 Jun 2020 19:13:41 +0100
Message-Id: <20200626181357.26211-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/docker/common.rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 02cd67a8c5e..b27ce17e333 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -47,7 +47,7 @@ build_qemu()
 check_qemu()
 {
     # default to make check unless the caller specifies
-    if test -z "$@"; then
+    if [ $# == 0 ]; then
         INVOCATION="check"
     else
         INVOCATION="$@"
-- 
2.20.1


