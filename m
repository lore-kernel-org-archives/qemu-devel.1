Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF14C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9617C20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZyRQE6MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9617C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NOM-00036C-Nw
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKN-0004py-KX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKL-0003qx-Kp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:23 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKL-0003oz-Dr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:21 -0500
Received: by mail-wm1-x341.google.com with SMTP id g1so8045555wmh.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VpwFpiMNotiifqERZwrlUS7tMztF4zpdV9YKBtMwAzQ=;
 b=ZyRQE6MFUXogmCv7BXm5vq3qJTVllCYg50LkwvGBzIL427iRM2MbIUwYgS+XzgBr7x
 NiIwBvZzVJUPhjoRLRNvSAxwq+nwcPlFBmPnq360D+uIb4JKqzrHs9b77bLmsJAFE+Df
 APVrOzZ22gYxZ8FlPBZvRzwPk3VHq3277gWI3YfeQ21IclmDVqTFiV1+kqZu3O8EYDVT
 Vb6Qa32c5MXCC78OgkopuPKcU+IdBRwBufQQ9fQ2m5qoxIwABHmEOztBovYZkb/liGxh
 eiS20XzeiII1Tv0PmwelA2lXYiCVgtAh9vt1XxatN5XUe/iEvpXBa0coWoLY5Y/ghmxi
 NCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VpwFpiMNotiifqERZwrlUS7tMztF4zpdV9YKBtMwAzQ=;
 b=owNnm0pP0LZJ25FcSB7aGbgdUXjL7yTTOneP+j6Hl0CR62Uq2PINEBLFAdW+SZo3+i
 YjS8L/EjhWxSaViDnDhbLxDATIkJ9NuSQPCcLcF3iOtEM9FrbxcLvkafbN6hFVce/sO6
 exbo8Yowb6U89Z+dNdLyE8NUNHZw+B0FPfqE1gKZjwMaccpILlZrYRyOV1OONogUwIaY
 g6jzaILbCyo1MCqIjGOJ6PcN8DUW0/TBJN+RpiDw/CjLyxhID0eTmcpgm5XB2BZPF+Su
 QXhwSfXmk08eNQ5i9fHnAvNZNKdkDHbLTMVA7tl4jaGcSch33EGc5nNGaXSeim6wI32J
 ONwQ==
X-Gm-Message-State: APjAAAUiRfY1FU2aQr4P2OcSndwZcF4ddyD+NBTjBjANMeHZphcSlkP6
 BuORjooHPwno33VPQmeDPKijbQ==
X-Google-Smtp-Source: APXvYqxAs6IXhXlxAR2sJ+fJIOZW2l6tuGG+RCLLhhZK2Rugs51Gxz9cUIJDX/q/4wqWphshnSYaRw==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr325935wml.88.1581634280400;
 Thu, 13 Feb 2020 14:51:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm4608557wrs.8.2020.02.13.14.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E8D11FF96;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 07/19] travis.yml: single-thread build-tcg stages
Date: Thu, 13 Feb 2020 22:50:57 +0000
Message-Id: <20200213225109.13120-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This still seems to be a problem for Travis.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0612998958b..f4020dcc6c8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -400,7 +400,7 @@ jobs:
     - name: "GCC check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
@@ -409,7 +409,7 @@ jobs:
     - name: "GCC plugins check-tcg (some-softmmu)"
       env:
         - CONFIG="--enable-plugins --enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
-- 
2.20.1


