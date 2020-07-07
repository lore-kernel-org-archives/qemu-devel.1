Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332B0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49132065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qsi2t6wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49132065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshzF-0003Ta-OC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoG-0006dm-Cy
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:36099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoE-0004r4-U3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id k6so44006459wrn.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7lFr9zkkCuEtI7DcfBdHOASgR49SrvXGNoFz77BDRTE=;
 b=Qsi2t6wcFmL8KwU9qnZG2amgnMNoeg1Fxx2ga+iobh91/t8lEntRT7/qun2RfJSE7H
 oVMHmipkoC3W+bAH3GTYNodG4aCnRhdd5xi7AHSFCeQwIQnGpgaKEX3uMdS7Dl2zOsb2
 YzczX044I5OD9xIHehsB1Sr8h1dAdLtvhgUy8oBYRF8Y/42nuB/pyG3oJjhS/Wsrx7wz
 9E9OrMnMWH0/DOg/Ei5P050t3+Gd8AB0iEsOpg4v34NkSfQTzereSWLRjBWrSl+UR9mE
 qhOp7PAI66KKKX3R4SoiIHiEU74bdPVuZ4EdFP1iyL7XpIKnn5RaEzpnxROGtw1xSZMk
 Yjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7lFr9zkkCuEtI7DcfBdHOASgR49SrvXGNoFz77BDRTE=;
 b=YC9A++GkT/alshB1Gv42Te1vIl3b8PxXZyCCjIlycTB+rHi8LvxbquCyaoeX/315Jn
 9o7AzVKlaUv9yyQc72IKERyzY+2MqgsSmdWBc782RQ/nytUYiQCwa9nQ/GkpS9vn5orx
 kjpXbtT39KCMRgfJDbAK1AUkT2tFy0u7d56DG3qrhGDGUJ0ND+2mylU0yUwrVAcwWDwW
 Y27P8OgDq8WaXnIh/6Wo+GCDzGLMnnN4I2iUSMGjX48VE2iqF2G5gsfH7mi5G8cdduuR
 aNKecPMNSk0lb2XwlqnGHlEsLNLIWAtAINLPr8wrqz5nhC+kR8Cu2djXRaiukz9X90wt
 k5lQ==
X-Gm-Message-State: AOAM533RCjGfMyImfyhKYrubtdwAfaDUXeGA4wF7KAbSeAlNnQv7+mtF
 5RI4WkTmLy5yYHhSLqdGGq050g==
X-Google-Smtp-Source: ABdhPJzzXPINUM2wYwZ+cz8AZ7kRvqH3yWeP6IBrdWRBsGVp3eOjT24kaQYI0j3vWFgRyxvOeU/z9Q==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr51208277wrw.123.1594106069537; 
 Tue, 07 Jul 2020 00:14:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r10sm26564128wrm.17.2020.07.07.00.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34E991FF9F;
 Tue,  7 Jul 2020 08:09:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 16/41] .gitignore: un-ignore .gitlab-ci.d
Date: Tue,  7 Jul 2020 08:08:33 +0100
Message-Id: <20200707070858.6622-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sooner we deprecate in-tree builds the sooner this mess of regexes
can be thrown away.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Message-Id: <20200701135652.1366-19-alex.bennee@linaro.org>

diff --git a/.gitignore b/.gitignore
index 90acb4347d46..2992d15931ac 100644
--- a/.gitignore
+++ b/.gitignore
@@ -93,6 +93,7 @@
 *.tp
 *.vr
 *.d
+!/.gitlab-ci.d
 !/scripts/qemu-guest-agent/fsfreeze-hook.d
 *.o
 .sdk
-- 
2.20.1


