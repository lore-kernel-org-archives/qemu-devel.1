Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B1ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AF02084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paaJgLVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AF02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaXI-0002Hv-Aw
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGX-00027i-PN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGV-00045T-Pc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGV-000450-Iw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:47 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r1so15633327wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h7SouDH/ir50kc8xWfv14MzPQ3OZz+xXVPPsfFcQ7S4=;
 b=paaJgLVfvSEMw8qV7MNTyvwsw5tcPZT2rrQZMNNdlMGZIgM8BK9wY49NtBOjoFV4Er
 MnoNe1wxNKE9HovK/28rOPFe2C4gmBKcEZ/D5WVPPBvGbEJm4uJ5gTHpZngA1Y/KQi3h
 E49mt+jr9fk4U0HXh01aB18EQ4Zq59djWwgshP20ILirHPJ35Hvxu4UhFjV/eZO6G6N7
 94OwW3qJ8ZrqyQUJ8tJEbumFA+NGlUKNZsX/DcXHEE8Vi1XQRqymtaa0kn3KpjkwX/9M
 gwdatxliXKAYnTHJQkCAgIN7lDrG59R7SlNkJTJ7u/JWeguyb47USBlmgtLhsRFw5Cz0
 navw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h7SouDH/ir50kc8xWfv14MzPQ3OZz+xXVPPsfFcQ7S4=;
 b=DS3gGWTArZI2OO4x1u8HRbuwnPPNJEX3TW/Hf1MfNDQUIoIs/WtwZVGpNonzTFlKvW
 NHdTHL0bnWsA1/ncIzM+Xvo9yc75VQ39hu0rbJwWf/jqrPjFwLh6Z2RPTOB8Hu0lnBix
 /IIkYwbCUy2pABhySChXjfSi8eF6kU+BLy9m0hzX5VjheZzLBfi2j8d2poqcnkFVun52
 eX/nFLviGSOmVjqHvXXQPGqLpVJr4GrDlSZcuBP0/SD7lLr7L5sSrgKhVZGOjzyf0y/0
 PmmWL+emWiPJZs+VVfegFGW0Gi274eL5Doj7UZCq/gpO3Y40YRgLfRBjWXd1FMvdnTL8
 twUw==
X-Gm-Message-State: APjAAAU2l/6u8WJN35d2HGKsXwAAiBIz1zAtmGWmv2HXkeV8IOmR49j8
 uOe9Cw+fg6M1BxwXPCETalTFKQ==
X-Google-Smtp-Source: APXvYqw6T7rSJShtp4qS7Vvm8YI5KDB8Sm/yy+y/Z7+ZBAd90+mZc11Ac8iByuBFlcB3pbNMbWvPxg==
X-Received: by 2002:a05:6000:1621:: with SMTP id
 v1mr3316868wrb.62.1571912566508; 
 Thu, 24 Oct 2019 03:22:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s12sm24444274wra.82.2019.10.24.03.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C11591FF92;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 05/17] travis.yml: Fix the ccache lines
Date: Thu, 24 Oct 2019 11:22:28 +0100
Message-Id: <20191024102240.2778-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191009170701.14756-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


