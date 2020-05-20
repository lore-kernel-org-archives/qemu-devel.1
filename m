Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AFAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481A3207D4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMZSqeIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481A3207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPPc-000660-EY
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM4-00007M-2O
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:56 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:34584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM3-0001yf-5r
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:55 -0400
Received: by mail-ed1-x529.google.com with SMTP id i16so3198885edv.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dnU7gW5Cd1Qobc/cZXPkaWez6sVKYdN9N3HtZBS9Vzk=;
 b=lMZSqeIQ/8aqCxdKE0tDiEXCjyjlt2AmIIYUTS+gS/OaBpPKPQBrofZFjAg1YpOI0H
 94t2R8Ic2009Vq72J6LoGtbAK3EmqQCyyOOpfEunhO9g2NyYNcJB7sJdTHVM2hdTPA4p
 7zhVT64UV30AhYpDedx0klZY7S+HCyH7seH4NhaHIQVM3H31fynRNLUD7IQjIxijDhRZ
 uMNBzb6Xbjmp1g2msluyul46+/htzzoV8CrPMiHEwjFsxGliGW/btq/QflCaeD1rwE8v
 kEKmsiru8ALFcOG4Jqp8NuZfCi2en3e5vINzKwnXFkzVM665Dbf4CTuWexVSYCQf0Z/I
 WTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dnU7gW5Cd1Qobc/cZXPkaWez6sVKYdN9N3HtZBS9Vzk=;
 b=RpE+EggQnQ4KmPmZPatWUdVwv2LCYm1zBgtf6mtPuNiB/QT/BLRcOoMewdTSmTmMc3
 6MkNIednE9g6VVJTYH5OhA8j1UjqryLp05vQqx5VYNJzLI43qthmJlNWNTDABvo14NTa
 LXJYD9F5e7eLPEUYiDeTDL+cAQ8eNCKF3HhaGP3sStF4cnAQkgPZHWZzqg7SDGSWcou7
 vcHv1UlghjnxlJ+3tW7DItE723sHYhqgmp1B5NYQNO627fm01PwR51eSexAGlITjlThZ
 N4/9LJ0C3Fvs1qnJd22zk/Xsv65GkFL3SVw5H+DvAsmXkFhgWqcWX9cei7ofFmuBV3K+
 skuw==
X-Gm-Message-State: AOAM533+7DWnsfwhGmk2lcxTJE/BzK5ebE71eILZlrJO+vybAdBnupjW
 fyAyJYWX+Kl6yaG/j8z5CfCnsQ==
X-Google-Smtp-Source: ABdhPJy4R0eEg+FO1yCyKoQ5NnitpJiP7mdg5Y9cXDQ9L2bMHaNXzCe9baY6SJ8A0lW4Tr6oyZVlsA==
X-Received: by 2002:aa7:c6c6:: with SMTP id b6mr3481695eds.53.1589983553667;
 Wed, 20 May 2020 07:05:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h18sm2054301eji.86.2020.05.20.07.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DEF971FF96;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 08/15] tests/docker: bump fedora to 32
Date: Wed, 20 May 2020 15:05:34 +0100
Message-Id: <20200520140541.30256-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should be keeping this up to date as Fedora goes out of support
quite quickly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 179575ecaaa..92204dc79eb 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:30
+FROM fedora:32
 
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
-- 
2.20.1


