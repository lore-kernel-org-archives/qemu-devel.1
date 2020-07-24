Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C6BC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27382070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2JgEyYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27382070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrTu-0005ji-5c
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSG-00040J-8T
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSD-0000Ev-SB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id r2so2164902wrs.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Id1YCSiSU2q2j/dgGEuAaj7qLUPGFg0y3qBG4FUdnyM=;
 b=b2JgEyYSIlJbet+lauKxt9i4DpZfuivx/B/gJVRvAmfuvzEd/PlqFX40VhuGJ5RCow
 XDki+qoxHFrLXxcU8oUGczNPKnPNUi4WQg6x1jTLVCRKXmiSUdSiMENCWtCN2fskiGCk
 Q+Dhx6AXY4MMRucaP4JOzFUkoNbVM9oJPYO3/uetqY0xkYtnDOM+gKbIDCFVI/70olH4
 12fKpdOf18iZt5RS+hdCdl+HXdq0CVCb0ytNzV9L4NW3p1HC9UWuul6OGw6ot87J8PG/
 GgcaxaiW4IrmtExlPr5W/Tpbtft+tyfqkaHDVqblDz56o0bOwD3MZWM4S6n4B/kY+7Co
 BfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Id1YCSiSU2q2j/dgGEuAaj7qLUPGFg0y3qBG4FUdnyM=;
 b=p6NpejePtmP1JoULJ8vCfM7Y7HBL0UWno6ntb4ZftPlAjmDUpdDEIu5J0CNeGlKr5P
 MTbz7D1OVPkaGgFFP6ltzZD0uol7IMioQNs/inLJ0EoSoNK56vqsplIJs5ALWZfkaRUA
 H0HpkOyPlgbVGx5lxaAoOOdsLRtiDtGWXVqx7MsmWWIUG61qJPLTaH0OikubmQNzJP1F
 LF35oB0Af3Fcv5IMcj2Om3MinDId9dDPuIOUydSGoTr7Ecyphm1pewcPSTXIcjcqqBSK
 giSnU6WyHS3bzT/r1klc8xtSP7v8m+9K+nx6DRLfNxKGf1nhrZvVOkS4JdI9+pKz5Bnv
 jBHQ==
X-Gm-Message-State: AOAM533WI1xQrTpMXMmDgjUSi/paqPiQCiWo34FqcF5s/IugaUYfOkVI
 xCygjAMIyEzmHsMowVBSwkbHNA==
X-Google-Smtp-Source: ABdhPJwuDqDVfQsO7zmNQ8l1DMTZQBIfn8rK4/lJrudVVdVKJcT0ntSeTmU4F3OwwAQXvBzkQnHiEA==
X-Received: by 2002:adf:df85:: with SMTP id z5mr6965254wrl.267.1595573112265; 
 Thu, 23 Jul 2020 23:45:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 130sm285785wme.26.2020.07.23.23.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B39A1FF87;
 Fri, 24 Jul 2020 07:45:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 01/16] shippable: add one more qemu to registry url
Date: Fri, 24 Jul 2020 07:44:54 +0100
Message-Id: <20200724064509.331-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The registry url is <project>/<repo>/qemu/<image>

Perhaps we should rationalise that some day but for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200717105139.25293-2-alex.bennee@linaro.org>
Message-Id: <20200722062902.24509-2-alex.bennee@linaro.org>
---
 .shippable.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index f6b742432e5..89d8be4291b 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -27,7 +27,7 @@ env:
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci_boot:
-    image_name: registry.gitlab.com/qemu-project/qemu/${IMAGE}
+    image_name: registry.gitlab.com/qemu-project/qemu/qemu/${IMAGE}
     image_tag: latest
     pull: true
     options: "-e HOME=/root"
-- 
2.20.1


