Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB95C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABA820781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nW6IQeiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABA820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6AE-0005ul-AF
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68s-000459-Fl
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68q-0005ui-P9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id l17so2482674wmj.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OTrZxr+gr7TRXS20xbwh/wb3Pjs8p21fdYjxEPsPxt4=;
 b=nW6IQeizoebZzBBnUvlFkI1djmJVrNzyP9KYRi1BhllJgQsA31/tFl6+Qeq44yCpli
 RjUN7LkGuoYegmsqR3LyEJQlp/lRkyMqp6L44TpAdymaueX/+FTxPrGUPrbr7CMCLInR
 3IXGibs2Z6tOvvYRMzriOwI77c0kMHZPTqf0CSVoQDCun5PeBTq4k0L+Z6dGe9SGlffz
 x1yN5T+REERB1tQWSos3GrjsDBx0+JVfc6FY9gsIX1IgQcULu/YMNWyMJQBnLtCnm8uV
 OElPuWU7e8z/fcKxfbSVYHzm23Q7RAoj6H1ZTqYMU8TpTtOsFKXOgZus9af+Lob8yYm3
 pMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OTrZxr+gr7TRXS20xbwh/wb3Pjs8p21fdYjxEPsPxt4=;
 b=YOZlFoY050RetW0RCy3o8bdBuVoQ4KQoRPJwdk33cRf/do3Oo5nvD12WNiiKfnGrqU
 XsbWTdiEXJ6PB11YPP2CwKLEa/n5wimcNHfPHQmZvtdckO8nshCN8bnwZTq09EYpwX+K
 cqg/h3k1sGVUKEJD4n3lB8B7ZrLvnBSj7GpDrG2dA2ri7+HhTn+gQa8jnvKngse6uvnn
 rA1+Ek+eM1pbHHWQ4VlIAH7jdzrJJHDnEW5jGWn26ldFZmDM7z2qpq5RQPVld+ympfTx
 8tuaW8kwOZyvtnnOFWd5SpHVct9s3emfA27SIFEGK5Yp1oPbpgOG+wggAfgA2C3B+KCh
 Cqlg==
X-Gm-Message-State: AOAM530kbjG1BtK/oM9B8dlsXoRHGwOb/AUoh+TcBn7JMaK7+mTByBuD
 J/Wk/doWsQqBgkGYG3Q3/vq0kg==
X-Google-Smtp-Source: ABdhPJzM7WVDf5Bkf19BisW2Q4yQNCqdg/bDj6kZ9ilAHQW0fvNyyDGxF3K8PVB70bvAC/6x9Pqz4g==
X-Received: by 2002:a1c:c90a:: with SMTP id f10mr17217993wmb.121.1593007962417; 
 Wed, 24 Jun 2020 07:12:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s5sm8358484wmj.18.2020.06.24.07.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:12:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9EB621FFAC;
 Wed, 24 Jun 2020 15:04:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 23/25] gitlab: enable check-tcg for linux-user tests
Date: Wed, 24 Jun 2020 15:04:44 +0100
Message-Id: <20200624140446.15380-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should have the containers available now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7fcbdacd9e9..54da29dd384 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -142,7 +142,7 @@ build-user:
     IMAGE: ubuntu2004
     CONFIGURE_ARGS: --disable-system --disable-guest-agent
       --disable-capstone --disable-slirp --disable-fdt
-    MAKE_CHECK_ARGS:  run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
+    MAKE_CHECK_ARGS: check-tcg
 
 build-clang:
   <<: *native_build_job_definition
-- 
2.20.1


