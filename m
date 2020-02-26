Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4FDC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C5B21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmWy0kaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C5B21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rPp-0005IU-Uh
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO6-0003YZ-UQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO6-0005hy-0v
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rO5-0005ez-8g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id p18so1660321wre.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TTSs93+2HBYN8glyvvdvMmnuBxLRlsClqFUymVWehjM=;
 b=HmWy0kaID/7mKwVWTFJFsVI/FHPAR198Nd1qUUCEurHwSwxr6xfF5hcyGVhzXV0y6d
 NNVrmZmfYk5ueew2wtt/JCEcd9LKgmo/io+dMPVU5ZMZm+UMD7kf7TTc86EGsCNh4W2d
 KLlraXOlepF1bY8Qn0JBa+d1KL/1KphkAhffGHCrVY/LlEhTrnQcFSgIJOH8TsmNg/v9
 UQLaTPrNexjGVlOwXcVoMv3XSVaoM6G6fYmcnT+H+H9UdgqvXH7eyXoW3vdD8UM2G8Ha
 Mcp5cYEIe/eitKUGxOhAQKyO4dZklMThryp0z3jwkQvDqyTG0sSo6WJHDFgxL5qp9Kdz
 F0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TTSs93+2HBYN8glyvvdvMmnuBxLRlsClqFUymVWehjM=;
 b=FRd8aytKsauom6ZoAJxweHWcA4oBrPaKIoE4P32NVUUsFbvnw24sHTMgREz0KV7mr/
 ddRfulpJX3QJVWQXQ7eW9WqSMbf5hc7W88FMD1xoXWMioIAzG+SH864PCuPs0GMiU0mC
 lhdC/59G2QPY9qzhPmAzXhjPiGSMjJtEAvxmuH8Kzc6tQ3jNIIQ6bZ/jSYy3bUmLfhOK
 SpzQ3k/PuWrIVTePisXRLWRQROKl8/5Cp15t8GO2MHHOw6NhYHPiUklJ0+UEGJNA2Hon
 kFDIz99QdTNXikcGaDUkFPzfshMQUgV/qyHVbbQBkyD6cvE18YGaCkjJPomjE0RTSKz2
 4rQA==
X-Gm-Message-State: APjAAAUbhMBX5m4wudRhByXWhzD/kADAf96I2ONAlI1XwYIQAZXSgri3
 SyAXSN5DB1Th8WIsoUMdmo/xBg==
X-Google-Smtp-Source: APXvYqy9PraXvr5vHTGjNN9X71onpmpa8wiTKx26oSh32gqcG4fM8NM+DBlGzkFhtlMi8YSgs6kzKg==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr3730179wrv.259.1582703144062; 
 Tue, 25 Feb 2020 23:45:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z4sm2058140wrt.47.2020.02.25.23.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:45:40 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CFEA91FFA9;
 Wed, 26 Feb 2020 07:39:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 18/19] tests/tcg: fix typo in configure.sh test for v8.3
Date: Wed, 26 Feb 2020 07:39:28 +0000
Message-Id: <20200226073929.28237-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although most people use the docker images this can trip up on
developer systems with actual valid cross-compilers!

Fixes: bb516dfc5b3
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200225124710.14152-19-alex.bennee@linaro.org>

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 9eb6ba3b7ea..eaaaff6233a 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -228,7 +228,7 @@ for target in $target_list; do
                 echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
             fi
             if do_compiler "$target_compiler" $target_compiler_cflags \
-               -march=-march=armv8.3-a -o $TMPE $TMPC; then
+               -march=armv8.3-a -o $TMPE $TMPC; then
                 echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
             fi
         ;;
-- 
2.20.1


