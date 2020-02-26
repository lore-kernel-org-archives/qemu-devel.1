Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B34C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B9221556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjNhNOMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B9221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rUh-0003Oq-Mo
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO8-0003Yc-5F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO6-0005m0-UF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rO6-0005jI-NU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id f15so1020471wml.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=10nNF8qb+H2QvWDi632eKeeQj1H6sOcPu+kVZYTtYjU=;
 b=jjNhNOMJtieFgDDhbSUV1+MXTbOo9i4OU39xT60eMWqpPLrxnQW34N2gfBhjD1Q8wl
 qQBD33rPvugcmx8P5zUjZ9TdiqJ/HhHz72UNGOxjBcUDFWH0DwuEIa7PyrfkYw6xJ9Ln
 yIbunqIuzkeG+xySB7US0HPVphtgmCXQuyb8bUQcj4za3hphihb4EHEhv8F8nV7Dut2T
 P0TViTd8wkKdDMIveKsHfiTvdqjwQQjcrLMa58dxIDr45VPhVCrhnknhGIOcBU08bDj6
 wY7pKTSMD8D0ZtvD+yf7BbYe6Op/rnOs1eg0xvvrgJS2PJSg42VcBxGke6vubyDIHCEG
 VmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=10nNF8qb+H2QvWDi632eKeeQj1H6sOcPu+kVZYTtYjU=;
 b=pzXwpakj9a+6HryuAqY9G8u52YTuX2K2jLTDvJaW0q5brTnjD6Mk/VxuBUq3T4oAHk
 7uyTSl8C5J/JqLdeMazb/XE25NUSn0N8B7RIdFQXSuXsaQWT/Rw1zIqz1klRmeROEIbY
 l9ZtuyvTDThfwNfyH3aQ/A7Z8D1I0zrNbEQov4gJP7uRXRK/Ij69o6LdHu/UNa1UFwJH
 wTYdtE2cQCuGcXDlYjKgEKzZZL6NQ2XxusCZs/svtEnxHeRSEKz4YFh4rxNg88P8BH5Z
 0rM2Mc7VgmILRW2uShJMdGUpo4NvmMCp1PTQDN65cXI/qtjl7ZZMUx+UHlGUojATValJ
 588Q==
X-Gm-Message-State: APjAAAXuDBEPrnZSdnHhtISCpOR/f6DDeVYcNB+dCAAp38CX1VoeBX4J
 b5ZV/sFrwF2qWPTgAwj3aCmc8Q==
X-Google-Smtp-Source: APXvYqxU7oZggrm4W4JKnWdMCh7cGZiPYJjEQblR5eXZ3xuI5xUyJ/61lzOQJioQaEirQG5VBsNHsg==
X-Received: by 2002:a1c:df45:: with SMTP id w66mr3778110wmg.171.1582703145708; 
 Tue, 25 Feb 2020 23:45:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a135sm1696938wme.47.2020.02.25.23.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:45:44 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A65741FFA5;
 Wed, 26 Feb 2020 07:39:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 16/19] tests/tcg: give debug builds a little bit longer
Date: Wed, 26 Feb 2020 07:39:26 +0000
Message-Id: <20200226073929.28237-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When combined with heavy plugins we occasionally hit the timeouts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200225124710.14152-17-alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 3c7421a356e..b3cff3cad1a 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -79,7 +79,7 @@ QEMU_OPTS=
 
 # If TCG debugging is enabled things are a lot slower
 ifeq ($(CONFIG_DEBUG_TCG),y)
-TIMEOUT=45
+TIMEOUT=60
 else
 TIMEOUT=15
 endif
@@ -137,7 +137,7 @@ PLUGINS=$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
 $(foreach p,$(PLUGINS), \
 	$(foreach t,$(TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
-		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=30) \
+		$(eval run-plugin-$(t)-with-$(p): TIMEOUT=60) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif
 
-- 
2.20.1


