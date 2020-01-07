Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EDAC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D9A208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9ZUESkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D9A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqGk-0001yW-B3
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIP-0000PJ-FG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIO-0002JS-BN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:21 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iopIO-0002Ij-5r
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:20 -0500
Received: by mail-wm1-x342.google.com with SMTP id d73so19037079wmd.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5+y6glt1oNxJugm2Ypcxd+Fn7DJ6oHVA90lV4Ls02gw=;
 b=T9ZUESkhNQBjOjLvg4vdncq9LWXZJGl1bSvfT8JJ3ZKgvYl1GymEsqIkGLEdoO3zbH
 s+e7E6WyfXxrKxRLmCwEXyFFC0EHc4dRbIZlh69GBoN/VzT8kNI4TUAGffxEDAa4Cwwx
 kjad6eWPXGlkteN3/sRrnA3PkCV16ETX3K4i6AuK8aozdsGBiwqGxxqKogRJrpkYjZRY
 PKkRktvkLFZlRkNrkhPaLWBfUC1eHFA0SHRQX730mFX73Im2XVOMA7Q4PtrjSTRHgdb9
 Z1EU6Iktk+BoA5IxY9hq3XAq8sOfamgKZ+mq3qSKLS7XjIfMQxDGmpKcuoE75veBtWzA
 twmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5+y6glt1oNxJugm2Ypcxd+Fn7DJ6oHVA90lV4Ls02gw=;
 b=fea6kkhuZX22GzUDQVmqVT5sLuxtdyxJdJhCD/zxnKhEMaqTBOjA68zNM/Cf8WVAbS
 OrQ5ymicTbq2l2Lfp1zOQVoaQcehz6E6BSrIuOhfAlXa1ZsleR0URxDRKuDtg7QpIG+l
 k4p9bVWkk9gs4cpp6TcT+XoAc+aKC9Y87DVUt0YBALHtwnvU/UtADfL3L/4C6GVGf27B
 +P82vq5lMxIHKxVQHoKRVDoFR4W6NiVl6VLE3HHRBN0i+iL5FX1N3bFEIQYfURE7Lx2O
 Q1kEsdwGBz6NarMH4odZV+cekM1luZUFLH67fkoTMjhoXWxvK5thSBojuZ0ZgBzc36Hs
 lFaA==
X-Gm-Message-State: APjAAAWozwf+zOBb9zxbKuE0YjHEmMS/iolma408Pe3ioh/STR0ylkGq
 soBw78SBmPfzTn45fipELpw45w==
X-Google-Smtp-Source: APXvYqzInmGcd4F/ishrr0pzTmT9jpjhidj2veNpWAjnha9274YpQAbHxgV/P6C6WnHsjQouaychrw==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr40737020wml.49.1578405199240; 
 Tue, 07 Jan 2020 05:53:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm26279525wmj.38.2020.01.07.05.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:53:16 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 977CE1FF93;
 Tue,  7 Jan 2020 13:53:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 6/6] travis: install homebrew python for OS X
Date: Tue,  7 Jan 2020 13:53:11 +0000
Message-Id: <20200107135311.5215-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107135311.5215-1-alex.bennee@linaro.org>
References: <20200107135311.5215-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Our python3 requirements now outstrip those of the build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 848a2714efe..a86ca34f79d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -57,6 +57,7 @@ addons:
       - glib
       - pixman
       - gnu-sed
+      - python
     update: true
 
 
-- 
2.20.1


