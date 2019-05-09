Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB53C04AB2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BC8216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgMcDmdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BC8216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmQ9-0008Sz-GK
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:01:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO7-0006y7-Me
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO6-0004sT-Ey
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO6-0004rS-9E
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id o189so4179600wmb.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=aFzzG2auF78ywEWte0MlDNULKwD0Ag6042JYL1TfabE=;
	b=LgMcDmdS5px4u8Edm/5nbq69gWtrPO9scm/6E7lFOTW7TNceii628hCGTr8PPPgpk1
	/82Mk43KXWx1erYG5ZEv7SrqoZF7HiVCf75Qm83HaWsK5go9FNZhe5OBDZBS1DwaEYrW
	jjLTBkKIfFQedR784PloXjJiXsonsLp4vRlTaAmUPiN9RojiVAZK+I4160SpM1cdqyUC
	owwGT5y6NpFuhKtradGHbxS+s1FzrfeTT0V5atBaQ99PrwmDtUbxwzenlp9kbUFo8S7N
	kCq5tNS05aC+QpFl5TlnFqplZpNqkkSn6yBMwflb5xuiHmv8wj7K/RAtiIrvqn8jbmhj
	liUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aFzzG2auF78ywEWte0MlDNULKwD0Ag6042JYL1TfabE=;
	b=VWUaHCwC7Q/rWR7wjo2TELzDCCDIztpEy7FgaEmjGXmvv1dodlugcCxfVZ2qNzshhy
	ZYzZkwOODUB2Cuw9owDo5S7cpT1IKy5NDx2PlIAiHadMVDNlDOkUdbyV9vlOGlnVpe2k
	35ajLFYba2cFrKL0a3EWfYZx08DMBgknJwh0I09aWfM5tcvwUNXff6KVVwnJwC5Lbicd
	Lv9Mk2+yctQ5ggmgPs5JMBopKxtlNsEwj2XKW99kYh3EtxZ3gtQU74ubCXZX8hqks/n7
	nocQsSAR34Dor8pAqOeclw8kPe5tdBzaWabJI/OjusKhD+1mYDxguW+tO7Lh7KIWPzRU
	Ud9Q==
X-Gm-Message-State: APjAAAWTFQZMyKdUgcrtMvYWxLL6LjfJDFf+gV7V0zBPvv2PkWYwujjg
	8YUFvaaUbhkiR5nVuoT2CK++0A==
X-Google-Smtp-Source: APXvYqxLO367Kns7j++E9zHR0HMteKwnePALlx4zLJlw4Yl+a2X7YDVfC8Zp/DlnGfOiGgVfUlPTaQ==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr3870168wmc.36.1557421157208;
	Thu, 09 May 2019 09:59:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h81sm8627276wmf.33.2019.05.09.09.59.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 87DF21FF93;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:54 +0100
Message-Id: <20190509165912.10512-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 06/23] editorconfig: add settings for .s/.S
 files
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are starting to add assembler foe tests/tcg so lets make sure we
get the mode right.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .editorconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.editorconfig b/.editorconfig
index 15828833938..df6db65531d 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -26,6 +26,11 @@ file_type_emacs = makefile
 indent_style = space
 indent_size = 4
 
+[*.{s,S}]
+indent_style = tab
+indent_size = 8
+file_type_emacs = asm
+
 [*.{vert,frag}]
 file_type_emacs = glsl
 
-- 
2.20.1


