Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323CFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8EC2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6QKODt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8EC2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Bo-0008U4-5x
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Am-0006qK-Hu
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Aj-0006Pc-DE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:04 -0400
Received: by mail-wr1-x431.google.com with SMTP id b6so14672675wrs.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MaB6EkUcV7cS8jhBR3D/MkieWNjgmYqTc6CjEYzz2lI=;
 b=n6QKODt+W0JzwxucAFN4utcBzGXEUJGsYUW2i2SMAGguOEqYkMvwngszmX1J9rtLwt
 V9nIuJlRfUPS0TVD4jp1roqNk21u4z2UX03yHAIbAxaabQy1IsFH6usCK07dhHfUk4gG
 B22ZpHlSLVrqx0vpE/m1iI6dh9ohC+tX+qQSJqCoAV2twQOUNlr6o12d9KA0RnEVwyro
 Z4ZuaOeXxh6/6qAl/z3uPVcPJplgGT/MiH81HROHSisnzzVB82T5btbswKOlp0Mdq7Z9
 x6fqwB4Z0/RKeuRSJWmCpRLx4TXUN3JfzNejIANRvjBCgvC5ldXRJYwyZ82PoL4XTqDU
 pCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MaB6EkUcV7cS8jhBR3D/MkieWNjgmYqTc6CjEYzz2lI=;
 b=LZB+MlHTXBjx05Ekv4flZkLBFTnoq4tYgEu+KiNHNEz+92TAwkmYeGxVyST54hyZ4D
 9Q/ABGljjvx4m6nicqclfcm61cGVpqvFKKnjgS0KGwbANp7dHtQzIpZnk/Yeb/6FkGoB
 YgrDRfyq4q/vvp+5QSRFjP2c4jgqbc21w7/Il8988bzB96+pBnDmZIJxL2T2S4t9Serg
 QmMJbPnK45XLBxNXakcgNlXGs+Ujq5Ogjeo5F6P7f8C1Ax05XRblyf/yDkwtRsNp0CKE
 7M/KluCR6SsugVGYrxHoFwXEbFqEUAWYcooM4XoqPsg1uo55ymrhqpoc8pKUsE7VICSk
 M/cw==
X-Gm-Message-State: AOAM530IoJse8xsqq6kLhHQcUOvgy9pL//ihN6IvlsfhABqpjsH08VgT
 BaVEieGC2Ix3G1kwqxDSMd44MIq4jiw=
X-Google-Smtp-Source: ABdhPJxIs1HOaDtOPikSF4Eg+N8kRtuGyovAAfCrdpp++Nw6smyzpDEXHG4IJTPSWUC7y+RbS9m1wQ==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr19578441wrw.242.1595852640076; 
 Mon, 27 Jul 2020 05:24:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o2sm3934205wmh.5.2020.07.27.05.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:23:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 793AE1FF87;
 Mon, 27 Jul 2020 13:23:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/16] shippable: add one more qemu to registry url
Date: Mon, 27 Jul 2020 13:23:42 +0100
Message-Id: <20200727122357.31263-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The registry url is <project>/<repo>/qemu/<image>

Perhaps we should rationalise that some day but for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200724064509.331-2-alex.bennee@linaro.org>

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


