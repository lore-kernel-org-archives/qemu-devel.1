Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1ADCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1100F2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eU33qTDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1100F2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzkx-0001rD-VS
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzeh-0002Rm-Gz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzee-0005L5-81
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:18 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzee-0005F8-0B
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id p4so19334487wrm.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vvU9WS5QfaOqxMDyhhQhtaEUX4XoV/gPkr7meS65DwI=;
 b=eU33qTDyWdDXR4rB/zkWNWIvYySHL+wtrLwLJOdtiZbqfabi2w16K72m5U5VuwQNHI
 0fzTAjN4bHXkEv5/kn0T2P77lj6pL/y2tzALidWg+KcGwNVQ6/TO/tsEwkV5ZuP33VjB
 KDUvKhX3iX0hqRg9Q+07kc++OeXjtInX/0ddBx5wQNYOW4UtMORlHC+MxwXwR1Gvw+VY
 D4EdsOjQ9drV7btBDmcAEeET7p3bd0tCbgrsKVeVXbaoAO7WFmdcYkJjY6dZPMAhkBc1
 o+x6bJBl9r3DQ0e//MsorrHmv54KtPd1ORI0rspyDjp7yHFEs3Z86/Y5pDmGu8YKeTeo
 VH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vvU9WS5QfaOqxMDyhhQhtaEUX4XoV/gPkr7meS65DwI=;
 b=WzDxSNyzTWgTxfklE0XvCOIhZqEBxQkLZeYy7Z0Cm9ItYG8MfNrVL/vWXin0KF891F
 +lF+gqGsF+/Psuo32cfCbzqyhvTyq+nNsiwum4e4+R8JMrhbrDasnLkAN3tRom9oO7Wg
 bxENqoTkVIqUff9EFxcaCkquJvL2DE/oygGMYCOAd7kYRMCQICA6Xirn2Zt3ndBpDDVA
 6/BgqD+SjL5gZJtoTKRBFl3OQoTiNAHL8WNoN8KUgIphrMeOtvTAnFGph5Wop1SJJPIi
 XWWzJB/Grv8/28AeDtULpiXcCACUmA6J2/s3JS6w5FYqCKZpX+RAFGSCoZtYSOBxdqbT
 tOww==
X-Gm-Message-State: APjAAAUqaFoCJkYtgcmAXxq26vBNSpgLGOcRz7AZzeYS1Z9ACsEyzk3p
 YVn4MCe43j97501a6SfQ9dqXBw==
X-Google-Smtp-Source: APXvYqxqlMbBD7Ti5jJXE80tdXUa90e0e9ozMVxCtDGfl9D7U9IXlkuSkw2FmXGglcjF68X8AFGemA==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr4646065wrj.283.1571771830073; 
 Tue, 22 Oct 2019 12:17:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n17sm7601668wrt.25.2019.10.22.12.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A5F441FF92;
 Tue, 22 Oct 2019 20:17:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/19] travis.yml: Fix the ccache lines
Date: Tue, 22 Oct 2019 20:16:50 +0100
Message-Id: <20191022191704.6134-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The "command -v ccache && ccache ..." likely were supposed to test
the availability of ccache before running the program. But this
shell construct causes Travis to abort if ccache is not available.
Use an if-statement instead to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-5-thuth@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index e65e53f3d7e..7e0d4ad2b31 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -91,13 +91,13 @@ git:
 
 before_script:
   - if [ "$TRAVIS_OS_NAME" == "osx" ] ; then export PATH="/usr/local/opt/ccache/libexec:$PATH" ; fi
-  - command -v ccache && ccache --zero-stats
+  - if command -v ccache ; then ccache --zero-stats ; fi
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make -j3 && travis_retry ${TEST_CMD}
 after_script:
-  - command -v ccache && ccache --show-stats
+  - if command -v ccache ; then ccache --show-stats ; fi
 
 
 matrix:
-- 
2.20.1


