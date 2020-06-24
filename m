Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17939C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88BD20781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhtkAArB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88BD20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo65D-0005hn-3U
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61Y-0005Gw-G6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61W-0003Xa-K4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id 17so2665057wmo.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UsvCJ1FtgsYHjIIgU0bFzUSnvljWkIkb9Subsb2kO6E=;
 b=mhtkAArBeJ4g/pLN2chI6H/E73MmkTKkwmTatlo/mA/guux3+weGLovZ++icakMoyU
 j+2Khfas98ct2bAFbqzfLPTkGalXvcq9qPkbSiB/i9oeD9bH5IMUkYMQbnmt4IMYoGgF
 4vZ+NpQck/C54duEym+T2Xja+7gLN3Y8ReT7GJo0Ckuj3HxY4Z24B3mSVrY6cN0OEGSF
 aFAAG8UBU9NyshKmDHc3UZ6rE2KQzv1shF6Sxlfq5j06q+7GzM+WD/PMxftv3FFcr2NF
 LglPvuO4Vc9zd4ppau6bLo0IOvcT19oDv2xJmxWhalXyGxpgLs63uXUSiQGXLoHZpR26
 O6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UsvCJ1FtgsYHjIIgU0bFzUSnvljWkIkb9Subsb2kO6E=;
 b=OOd8Ec7NwXT+CSZO96YS9gVpHu3cwVfpBPfo+PNFujJGzeCh+FM5IAjS+USYj8R9HO
 6NAPJY3vBFvq3+/3Zz39VD4zNSIUA9ScQtGgMDJRELuM9fTAnXdtRkaIPxWZt6O/R/8t
 r7MEB+9rkPd+ZFpRoCm+sFXqeSTzt9QGuo1UX5VUDtsp0eLUxSKr0VuAnFx1Py8QAouP
 1hoJzlLQqr4HBPeSQm7WbDZBLtNgmuqt5FXF/DfYuwBJAESQ0GH5wyXGNDz6dfMZl6NW
 zfEkP5FDDfvQpFRkjynxRwpAcg6ZPxDcyQhDryyr9VaJDvmvqDiH5jq0zA09HY0ZORD4
 xPGQ==
X-Gm-Message-State: AOAM532L3SVSnOOQblvY6f/08JRJSSB2F9rVYpUpwvIuqwUHsbmnVATN
 RcbwPWxcHELgw+vjI5YOLoaM9g==
X-Google-Smtp-Source: ABdhPJzN4Km5lIe5ISVFN6u6iefkkTo7nmzWOEl8kbQWiqaLaTmO05JjXE1D2lPpIKs80x7jHDq/RQ==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr31731088wmz.59.1593007509054; 
 Wed, 24 Jun 2020 07:05:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm8465200wmh.14.2020.06.24.07.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:05:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 991891FF9D;
 Wed, 24 Jun 2020 15:04:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/25] tests/docker: check for an parameters not empty
 string
Date: Wed, 24 Jun 2020 15:04:35 +0100
Message-Id: <20200624140446.15380-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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


