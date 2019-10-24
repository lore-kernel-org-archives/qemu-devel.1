Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF90CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491602084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHAPepzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491602084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaUe-0006da-79
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGT-0001wU-Pq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGS-000428-KT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGR-000410-V3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id q13so2181431wmj.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kRoSu+GZV2ZcoSH/WS9NLUu4AUZmaf8NZ0qnOrd8lIU=;
 b=EHAPepzBZAlYyy07RghiDCHQBQjM0v6YYz3zLvk5DeujWCLZBovvWcLE+77P2f4ZMc
 k9JkCVcXVT6WuLVZQ44ErGvJ9CB+g4twhyAmq+Xe9ExLxkawvnO9h5+C1Fru3kxGydUC
 p7iRX2HXa17PYKF6in54mwn7Icm/gO7TKX5yMZJUF6AH4W1m9WqAoAEyV0EHD2uIWGs3
 oJk3/qwU9jMvG/PhsY7ut5ceRzeRQCqnNsvTilgbx5S0lgALaYeKjeQoaz6EUncci9iB
 GpPluhcQsr5d8pcD4gyiVL6HYBl1hco2I2Gk9q8ufe6WPJJgSslruReAgavBciRQ6edM
 Rxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kRoSu+GZV2ZcoSH/WS9NLUu4AUZmaf8NZ0qnOrd8lIU=;
 b=FJoF4by4wlNCS25EyAVHBfRZbAfdBgziQVJKotI5r6gDNHCdfdKMl7JVkp6CHWfpyF
 NuCToq7A9cwIekWd4/sAFznMKShOtOtHNeSG71tyHIJI0xWazRm7A2nAncCH2dDos6Bi
 C28tZsSNe5kc8mrFfCeBcpii7MYAO/WHiVHxFNJl3JqqitWf2ad+JmB83xCchj197EHc
 ukHG0huFwvs3TZFSMEhRZ1JO4qOopZEQMzVOSXCfXTGmTmK02A/gC0PeXpfqUL7RqASO
 R53pjO6Xx4hMD9VYNkBz08zBUp1Jxy7685CwjMuo4/vlOxG/as9qGDa+XGYzZ+biI1E5
 UnNg==
X-Gm-Message-State: APjAAAX4MBg1YjI+sFIaA1rFczk0YydV0mhTRNxvJrJXqYgs1PEBWScW
 Z9KDoV4/wmj2E1az/nvxXEjsrA==
X-Google-Smtp-Source: APXvYqzCLrCHLl3VevjjLuZbKF685b8ZeRdl1s9lDRkLrBhFodr26EE3CDk2NrQBwxNKrp/SVqgtlg==
X-Received: by 2002:a05:600c:2948:: with SMTP id
 n8mr4052307wmd.128.1571912562472; 
 Thu, 24 Oct 2019 03:22:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a4sm1869605wmm.10.2019.10.24.03.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94C5E1FF90;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/17] travis.yml: Use libsdl2 instead of libsdl1.2,
 and install libsdl2-image
Date: Thu, 24 Oct 2019 11:22:26 +0100
Message-Id: <20191024102240.2778-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

We've removed support for SDL 1.2 quite a while ago already, so let's
use SDL 2 now in Travis to get test coverage for SDL again.
And while we're at it, also add libsdl2-image-dev which can be used
by QEMU nowadays, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 7be2a9949f5..b446e04e8ae 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,7 +39,8 @@ addons:
       - libpixman-1-dev
       - libpng12-dev
       - librados-dev
-      - libsdl1.2-dev
+      - libsdl2-dev
+      - libsdl2-image-dev
       - libseccomp-dev
       - libspice-protocol-dev
       - libspice-server-dev
@@ -309,7 +310,8 @@ matrix:
             - libpixman-1-dev
             - libpng12-dev
             - librados-dev
-            - libsdl1.2-dev
+            - libsdl2-dev
+            - libsdl2-image-dev
             - libseccomp-dev
             - libspice-protocol-dev
             - libspice-server-dev
-- 
2.20.1


