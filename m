Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA98EC47257
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AFE20714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+AimE4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AFE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIpU-0000Ng-TT
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo0-00066m-0k
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWInx-0008Bm-EP
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id y3so1915290wrt.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d1f2aEdjsEFanYx6BNV67Yvn98soCaaI3O+YSwy/f9s=;
 b=p+AimE4aJ/Cg7++kZR1l90QvFobmfJUBthYDeijnCz5z3u0ahbytbgl3PQRFAfCn4K
 +ZYIIVMg03PqQ+1GwBd5sxM8okQk7USpTxOc6konF5rz7LcYCWwyXwOkHmCb4VSzu5ie
 JmctO2bWAdqyXtFALYRKicg7kcP3klW2GLDyAAlnpgb44fvvUglsGaLOGDjbXv+DSsqV
 dDq6aVj9biHd/yKNC+T9vImsanmQOPQ+3mKbVsicB9OktZpBnN3Hc4rfWAbOLrcYnXYH
 WufOdWpNgo/5afdjckaiUp7nJJBCRPQtpdDyAYKPNw07BLSDU+52mLMzY+nP2gkmskr1
 xFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d1f2aEdjsEFanYx6BNV67Yvn98soCaaI3O+YSwy/f9s=;
 b=dwRB5d3v1OuYcVItgiFYqT8EKn2cHBTj+AO+TSTE/fBy9/oMJZB/ZQvoTmktqAKdH1
 DEUskthbr5hSkHfiH+K7UW3adktw8X72THT/oYtNnKA2zqGlUO9ZHF8zcMaQRNr31mWf
 qSg2OLqz6YJYijPQF1bdYfyDL8u4arn3rH1/x3ejk+rWMe3GDJUe9sTcJxjTKrYyyjQY
 y/U+zG4xfninyWxHAlMM2Oc5WYFECorN6edVMi5ogakzPKJsbeBC86KH8kGkR101a9Xv
 hzWHkr/LCiwj8Vbayb7CI/fns6kvCLl2XJl56RsZwKsYM+4x8n3tN8xlYjT5/SyZTEmX
 U1cQ==
X-Gm-Message-State: AGi0PuY4oZXx3rvjIUBgVXRfvMkyWDCza3EoTeWExu+zc6SYvGXN8bRs
 WPp+m9re4rfWpC9q1efzKzc3Lg==
X-Google-Smtp-Source: APiQypLpiKxmTG7yG/IAkqbCGr6rn9WKEMKGU6fwjNoIzHr3aBX3owMf7JdZE5Yc4AWApNYXUwGDbA==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr10149959wru.153.1588766733628; 
 Wed, 06 May 2020 05:05:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i6sm2432884wrw.97.2020.05.06.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EBBEF1FF8F;
 Wed,  6 May 2020 13:05:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/14] .cirrus.yml: bump FreeBSD to the current stable release
Date: Wed,  6 May 2020 13:05:18 +0100
Message-Id: <20200506120529.18974-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hopefully this will un-stick the test which has been broken for a long
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
Tested-by: Li-Wen Hsu <lwhsu@freebsd.org>
Message-Id: <20200501111505.4225-4-alex.bennee@linaro.org>

diff --git a/.cirrus.yml b/.cirrus.yml
index 90645fede6b..f06f5af2b93 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -3,7 +3,7 @@ env:
 
 freebsd_12_task:
   freebsd_instance:
-    image: freebsd-12-0-release-amd64
+    image_family: freebsd-12-1
     cpu: 8
     memory: 8G
   install_script: pkg install -y
-- 
2.20.1


