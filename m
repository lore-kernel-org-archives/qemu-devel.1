Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1995EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96FA2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="US0dj16d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96FA2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzDe-0001jM-06
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAt-00057b-2L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAr-0006cz-EY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id o8so13447686wmh.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sfF8uQlqTNWoN2CdQI+dtwBm9efGllQvPXBr2wV3kLI=;
 b=US0dj16dEkO0ktvMnbDhVuqDO02RSgEe/Ta3ul4SP1KC5WwifjnEPHaFuE32KG4oZ5
 uaqCNi86EZXW+5gG9zp1XsHVe9NVlbIk1MxjPcGKHMoTNtNIxBz93ARAjMYrgGKYEDXy
 2Qsn4gOOhjNMBV3JabWNY0ACj6qsisDRJ2uoBf8VtvotuPCmeHtNiULI5JVpR4jnp54T
 BC9bMTiMOquxI8o72yQRP69zDuz5zrQtOMkt44aPQPsr8gGBGUbEzXCY8RWTi53moXMj
 0iUPcd/2ZtzNAfYG7ghFDs+b4TKj4ebS1EgrgFLxDDf8kEtjuTPtQ7QApCOo79kAlzsG
 c4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sfF8uQlqTNWoN2CdQI+dtwBm9efGllQvPXBr2wV3kLI=;
 b=OfRxx4PpRvHCLxxIY9dX6O/K9VvHtvJMsLQoT5k0B0snh/lPDPPOc8HosDUJ8+PNcf
 p7MXGM3nLmFMFnuxwtMEJSAe9EGQn6jXjtZ8EfOG3vXGQGYsw5UDJkGpvBQ7IpId3Yhq
 QSy24mEmSoYgzEgnis4HBd8ZhXPtusaPOiOKFaFva6+Q9dPWcZz5RMEyNlD0wPQxDFHv
 yBWFiBJ6lX0EXg7yR8iREYxlqiibjiksCeJ1dcTdlo7xBYIQmpGzM9CHH71f214nIVuc
 y3nCE3AF0nOWvj98CMXWgbSEihM9v4IYqiJifCyq4O/A4qZyD4y7ViH+UnRtcQC7ylbx
 +FLw==
X-Gm-Message-State: AOAM5301zdCMqmZnU1JMS92DaIA34S9y97yaKsj0KFK09Bf9/wSbes6Z
 cDbJy2EirCxsMOOm9cBtN58q78GyP7uf8g==
X-Google-Smtp-Source: ABdhPJwFsqbxFSYynaCP8JTXsVave4PZgk2aLEyHocgUg4KsebCG3mh/7fJ5C4I4qe2GA8L0pJzAXg==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr137616wmi.41.1594649475872;
 Mon, 13 Jul 2020 07:11:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/25] build: Enable BSD symbols for Haiku
Date: Mon, 13 Jul 2020 15:10:47 +0100
Message-Id: <20200713141104.5139-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Tell Haiku to provide various BSD functions by setting BSD_SOURCE
and linking libbsd.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-2-peter.maydell@linaro.org
[PMM: expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 9b6ab9d3ca3..c70b43d1394 100755
--- a/configure
+++ b/configure
@@ -904,8 +904,8 @@ SunOS)
 ;;
 Haiku)
   haiku="yes"
-  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
-  LIBS="-lposix_error_mapper -lnetwork $LIBS"
+  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"
+  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
 ;;
 Linux)
   audio_drv_list="try-pa oss"
-- 
2.20.1


