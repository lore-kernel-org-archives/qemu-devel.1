Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898ABC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5C32076D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL0L5eQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5C32076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS7QN-0004Z7-6y
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OM-0002yH-Ji; Mon, 12 Oct 2020 19:38:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OK-00073I-M6; Mon, 12 Oct 2020 19:38:10 -0400
Received: by mail-pf1-x442.google.com with SMTP id n14so15239376pff.6;
 Mon, 12 Oct 2020 16:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RCiwtCbp232Z/M6MRS2ljqmJJBXyJVJiELXNvh6qszk=;
 b=OL0L5eQGJ6rvuey/xogh3eQQNsHyY3lLk+4/KvAcAz4SfDTiYsJqB2vczyftIEp5l5
 lpkGlLq4XBbv1JIzSM9fil6bVCOTPNnOWmkyVNjQUZOheiSZHnuUMN6XqWXp8Ul8gQdJ
 e70ddGTRB9mkpYXdXaQ/IisMOF7lrG8Eng/8UzkLua6m6aN6IQje6cOlhhayAYEfj6Xd
 o2hUmOJlAr6H1sPQnH0gt0fDmRFItEc1tFR9lE0XH4ADI7tpbd4cZi8jbOFyHyZNHYjo
 Idoj+yXlbVt9Vvt74ROYsUcLjPpc9HDmoLDiCYiT/0KnPb2/j7CEnCEaT5sGVFQTySGi
 oAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RCiwtCbp232Z/M6MRS2ljqmJJBXyJVJiELXNvh6qszk=;
 b=lAi9s27T0Yw5x0iJMVeMnrvok0ucgDJH7dPE/uvPLzp/BeKFOh0s/PGeC2VK8p8HUP
 ANOdj++gza7n5iRvJrZar2BkrEjcF7e7qtFF7dsrdeQPqYYXs6tJ7qyQ7YBTjF8r4Mlf
 x/wPkBZlPDFxDIgTQ9xO02+Jfdv0x93YL9Grod5C6tW+dv9JqydshVTm6fg2dUM/KQvH
 nz95wT716N8FXohUaYyXRpmG4o7COCq7L4qvLcL+Y+ymxZhBpVuI1IvA10OLbt/sAgJt
 LbAHPWQVqGwuEItq7xzMxDHDQOqsqg+tfNIJGyJSSKY8mPiY/HKhrzsUV3068lZFqcFf
 Ni8w==
X-Gm-Message-State: AOAM532iCQkVSSSyNmGcvj3/89wC5MRrlShRL3wQ68tsFv7sI4ifauiZ
 jibfv+XjIejrdhgfVZq6fiyQHza4oS1LuA==
X-Google-Smtp-Source: ABdhPJxJVu0P6bXjsMjNtBNsoLyTrGKWC9QAp8bvNI8d7odPoKdWTRjsRoUrPcLj+9FOvS3+57kOfw==
X-Received: by 2002:aa7:955b:0:b029:152:883a:9a93 with SMTP id
 w27-20020aa7955b0000b0290152883a9a93mr25157722pfq.25.1602545886598; 
 Mon, 12 Oct 2020 16:38:06 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 x12sm21975783pfr.156.2020.10.12.16.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 16:38:05 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 2/4] gitignore: ignore a bit more
Date: Tue, 13 Oct 2020 07:37:38 +0800
Message-Id: <20201012233740.190-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201012233740.190-1-luoyonggang@gmail.com>
References: <20201012233740.190-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable the creating multiple build directory at the source root.
Ignore /meson/ and /roms/ for better search experience.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .gitignore | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index b32bca1315..f78ee9f297 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,5 @@
 /GNUmakefile
-/build/
+/build*/
 *.pyc
 .sdk
 .stgit-*
@@ -10,3 +10,5 @@ TAGS
 *~
 *.ast_raw
 *.depend_raw
+/meson/
+/roms/**/*
-- 
2.28.0.windows.1


