Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F46CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DCE20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWk/UoIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DCE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaRB-0002B3-7p
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGe-0002RS-Nh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGd-00049p-Ph
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGd-00049D-Jf
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id q70so2189220wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w1qnPs43iqMvKjSf/fjqkSNGtgVoCE4DlIB5unqr3MA=;
 b=YWk/UoIAjeIgfyfNw8okgzxZ5rm3i73IYgDUvt9I+oFySOkcAIG3p4vkek65glJ6Dw
 MR/q3QjIpIOP8ZlZF9YzBeKpPbEEWFqLHKCe66fba8elxZzE6MAK2mW85gpVnDJ2Tp+W
 6md6E9cWHUeTbDMpYq6JtknEB6YazhdNfgdEvF0FnjQVU7L25WoPughr0KvPSLnJGmKU
 F/Hg0+mIGUscLy36URDWrLvuGMWISg1RH9j0UXAslpISmlzdGy5JO0LhSNC/eyBwgUvO
 azF7E8lfecgQM0p0y+5Rcsf84Uz4mEvxqrM9TPd72ITqfvtmVRRADOkNDRwIxYF4R0xb
 muEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w1qnPs43iqMvKjSf/fjqkSNGtgVoCE4DlIB5unqr3MA=;
 b=a4VuS6gVc031iOEAkNLusFkpyw1F46n+sM0zDou7VgE2cD/duM2N/RbMedkuJ11YkJ
 cfIaoOLHFQm0lQA07ZYMzcD+11RT7j4VI+rT1WI4rxbzFbRrcVKEf8cQbSdbozVZAwKZ
 nIXBSwnuCjAiI39DW+NYx/5snE2Zviveh0TJigqLDfoIEVa7kpvlGS4YIGrFYDSV/s0D
 /JdhJ2HSTTSbY+6eLaFqZqHdC9SoQQmEoHTr0gkQ5z1CF432t2qMUkUz/8sQHqnhEbEU
 e+CdyoDnRhIQ9yqbTryoY4Xu/Oy9GVX53rfbsgi9oTp3EvD5RZLUwqcp+IQ/uBYIPZsx
 rv/g==
X-Gm-Message-State: APjAAAVpfxqVpLKRnuWknft1UScmYsFy+OBtD0W9UgzQuKRBrzM4wPy2
 HXtcYDSzClcfiwljvbT8zNuDPA==
X-Google-Smtp-Source: APXvYqywtHU2f6OTshDUJkmOQKdPCzZQTCJmQ1rBEDPjxvAVaIVed7vkTsWgdAzqPiA1FEdphVp/sQ==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr4455710wmj.90.1571912574568;
 Thu, 24 Oct 2019 03:22:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c144sm2483904wmd.1.2019.10.24.03.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 81C921FF9D;
 Thu, 24 Oct 2019 11:22:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 13/17] travis.yml: cache the clang sanitizer build
Date: Thu, 24 Oct 2019 11:22:36 +0100
Message-Id: <20191024102240.2778-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hopefully we'll see the same benefits as the other builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index da6a2063fca..c43597f1331 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -189,6 +189,7 @@ matrix:
 
     - env:
         - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
-- 
2.20.1


