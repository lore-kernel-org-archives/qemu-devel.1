Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BD8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DAD20702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcjQf1DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DAD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdWy-0001zq-UK
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKw-0004zv-Cg
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKu-0006qO-Lf
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:42 -0400
Received: by mail-wr1-x42e.google.com with SMTP id q5so23978914wru.6
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z8+7R3MmmcndzfMXwtKjgL5/CCMc+Xc8nupS/X00rus=;
 b=qcjQf1DSHf79VcNlRR59uY0ST5iwrQh3WQ6BFifR02+48pLWqNbg8erPyCVsT/LXlT
 k37ZGL40+YiMavb3iCMaMvSdZSbRaM1Pfd9hpnbTj5hHvyUZxaiA7cRG/A3Y3AEXR71e
 e2akNGhBuooZCCe87GhxAleMaa0GBhMb6ITMIdo+Z9zXcLboVWti66+mT4l1K7G+Jsh+
 N0ky+g9AlWneZeHzxPs5l09jgG2WEN5ds4LdE4KIJDALsvpePamBPSJA4ppAjD29ZATN
 FfHyeV42A3JIvPaCnJohPy5aw7U0tBcyLy2oq1yD7dXTiSg+GMUWrTxPu4qTdGMMX/Rt
 bQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z8+7R3MmmcndzfMXwtKjgL5/CCMc+Xc8nupS/X00rus=;
 b=PNzbw7nU3J/a/pdhPlE4jvLji/SRhy43OvFDHgVZnpwQeRMcp/wcYnL8GWWZDVHPzU
 IK09FLlnlVKnjYy0gP9L64XYIhILOvG0FSBk7hxwQKVz0y/r+9Xfgyf2cGbnpFJqy9cm
 /27yuatkidVbGvMRnQygqd3ZgPnoCXMSNwrTPDRcocNtKQz3/pxJqCPltl/8Iw1FASBr
 4jR44sLEJxkNAckB0jPmCzIS8FZFXOf5ztzgh7SNng1yixpY6Ae3vsEe41v9UepIM5Ki
 dyo3/0S8+P9JX0H/zHC4/EYS6JC7U2qKQ2dApJASy8dpCgy8m2Cpc0tsf1aS+SUgY12h
 hfcQ==
X-Gm-Message-State: AOAM530UAioYOA3g/5cvi974ReS7twWHglwNzWVe0G2C834Tib/1TlRC
 a6ClvZwXpxwQFetapZ+HOjV9YXyJFME=
X-Google-Smtp-Source: ABdhPJxBBDzsOwevk0Blb7sUS5zkujXCGF6JFkm7rEZZZXY75a2rZwDz/Jg5vIJosSNhAzjEsvGbIw==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr27639775wrt.5.1593612219261; 
 Wed, 01 Jul 2020 07:03:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p14sm8261263wrj.14.2020.07.01.07.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DBCE31FFC1;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 40/40] shippable: pull images from registry instead of
 building
Date: Wed,  1 Jul 2020 14:56:52 +0100
Message-Id: <20200701135652.1366-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have a source for registry images pull from there rather than
re-building every time on shippable.

[AJB: change to upstream when we merge PR]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index 81905727d14..eb8b68610a2 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -26,12 +26,10 @@ env:
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
-  pre_ci:
-    - make docker-image-${IMAGE} V=1
   pre_ci_boot:
-    image_name: qemu/${IMAGE}
+    image_name: registry.gitlab.com/stsquad/qemu/qemu/${IMAGE}
     image_tag: latest
-    pull: false
+    pull: true
     options: "-e HOME=/root"
   ci:
     - unset CC
-- 
2.20.1


