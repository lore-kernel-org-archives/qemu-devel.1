Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F7BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE7D21872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUV0sfiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE7D21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZEd-0005UH-Ud
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZDt-0004dn-2k
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZDr-00006i-RN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUZDr-00005k-LR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id 8so3713910wmo.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mxOHNLiZiav5q06u4iP+1Y23i6AhW3YCUAOUVG6uEnY=;
 b=HUV0sfiHP4FCd9MBPOfk7ob8pDAkwa4XLMJWXvgfDx3mVfeMMfychtviJ1lDJeO1LA
 /ifa1TBv7diBbkY5Je5+9N4NzuO+w7tSlWij1KwCnTFaOnzgYF7s/ojsG+RsGyMYJuiG
 UZ9n0r1faB0W+jusiqudNpqAHmV/v2/2kLVkC8FaYihuRwrnl6egmqYo7PpUNpU4DvaR
 d4tZ1aUzNFrXzfX2Cr2J95xvSZ8RolmkR683o8/BZdf/njWUSTL2wJGdu5rcvBELBLq3
 YkNijRyZe9uhvL6pz13nWehyYo6u9a70P3ujs4YuLP7UrP7JxCWAHBr+iB2EV6h2BgNX
 Wkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mxOHNLiZiav5q06u4iP+1Y23i6AhW3YCUAOUVG6uEnY=;
 b=lzT8jDCpU+NpBEVbXo50x3dsdablv7dfdUf4m3Wnzw7Ju9QbzOz2/tvNxjTmvkccjP
 S/Q6deeNPEww3EByVn6vqNdeos4P4bc9PnsxeMZkbJTmclmkUrFXgn5DoC4irgq4WQ3q
 M8OyE0+3p+WjfEzaNSJSO52HtOFWyblaqhWlaqwK9jDECEO9AOn/vG6wc9iebT+Pe94A
 uBuvmgN8kQGcq3oQgoB23c3lXs796kGINx8U4M8wl5tPv+3XN1X8ei4Lijd7rf584oKW
 4Q2P6G6vSlHLFpFpddsF865rZNo1uX6Il4FSe+JMd/k6457KkKMo7PQRTKXMUeUKWFy4
 MwhA==
X-Gm-Message-State: APjAAAUZ2s1iSLhnYovBszT4wAUQP3A5Q7E1pPcePwV65mZXR3kcU7P0
 3OS6vyw/mevnjuf5GVXYr6deQg==
X-Google-Smtp-Source: APXvYqz1AnNoxxHyeaCpPeo9+tFbK3Ef++2pl5/3b0RuUzrfgVMMEB6638kh3YVFkP0X2YlLHYQSJw==
X-Received: by 2002:a1c:a4c5:: with SMTP id n188mr4799065wme.30.1573576854436; 
 Tue, 12 Nov 2019 08:40:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b186sm3588457wmb.21.2019.11.12.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:40:52 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B9DAC1FF8F;
 Tue, 12 Nov 2019 16:40:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] docs/devel: update tcg-plugins.rst with API versioning
 details
Date: Tue, 12 Nov 2019 16:40:51 +0000
Message-Id: <20191112164051.16404-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112164051.16404-1-alex.bennee@linaro.org>
References: <20191112164051.16404-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/tcg-plugins.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index b18fb6729e3..8d619fd44ef 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -25,6 +25,22 @@ process. However the project reserves the right to change or break the
 API should it need to do so. The best way to avoid this is to submit
 your plugin upstream so they can be updated if/when the API changes.
 
+API versioning
+--------------
+
+All plugins need to declare a symbol which exports the plugin API
+version they were built against. This is can be done simply by:
+
+::
+    QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+The core code will refuse to load a plugin that doesn't export a
+`qemu_plugin_version` symbol. Additionally the `qemu_info_t` structure
+which is passed to the `qemu_plugin_install` method of a plugin will
+detail the minimum and current API versions supported by QEMU. The API
+version will be incremented if new APIs are added. The minimum API
+version will be incremented if existing APIs are changed or removed.
+
 
 Exposure of QEMU internals
 --------------------------
-- 
2.20.1


