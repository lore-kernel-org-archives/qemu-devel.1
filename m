Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B57DC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C8220883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPSlgcE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C8220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60227 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVZ3Z-0005h3-Fi
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:10:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYtf-0006LF-2m
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYtd-0005WD-RG
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYtd-0005TC-2t
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id w9so2133161wmi.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CMA0ydslPmEPlr23YQd+yhHgYe7W2HnkMpMaOZEuquk=;
	b=OPSlgcE7YkshYZTHRYGcP82H/qljTkKxyQpGXoFrSprAFyozjJ8YAh4LxMZNaIWFQl
	BFwkl2mSYX4bqGeHhTT3nndApM6F6v2n0cnApg4eN7oO5z8NU8EfxXRGeu3tph6j+CCu
	bPe/ZaaQgVba0w8lPpfQvgOLEvyPuCd9vBoFzzN529Rzl8lBETJEJK73zjJtnSw96OZq
	rgZfqYii4TQ56gTVZbrr6VP0u9kPBzkZEw3IEw0phcGAFBpLCEkrDZVUUjoRcYWveOkF
	7aLEZmngjono44O9zKQnkdaIMi5GN41ADJLDqReiyMXBKMz0Hvw/yio5do5vHJtvgMt6
	i0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CMA0ydslPmEPlr23YQd+yhHgYe7W2HnkMpMaOZEuquk=;
	b=AiD1Kw7cybgXgU61+gYhb9EEz0HsiaUwXO+qfpEgomRqsU6jHq4Q4gE7pSpL+s8HCw
	JHEDSkyUfeCl2XFoDpyty9ZjJMHIN/eJ46MdLeHW//yQIIZ5GJdgry73384TWfJYFeoa
	i5hWFSMiUyVAf/vAzaqNDa1WP/euG0HsI53gWL7S+8lDU6OCLQHYrSmpzacYiBCUH5TA
	2xDZc3FcvgskUGty4K3g0xa3urvq2ueYuieRVNM1KanPuFQ3/LE3BZFabCb2h1Ml/gMp
	EhQBRaop6VaG/tUTA+LhuxMgQBc+DeVB/q7lQ7hVKRl4ig4gatb390InJxUSE0SAswyI
	hMIA==
X-Gm-Message-State: APjAAAWmWCmiCrdpJyZNPHq3HzP8iNctQ+H0j8PTXIb/XmbX7zWn+KP4
	PgJ6WtSFpKGEeUQ5Tft5J4DumQ==
X-Google-Smtp-Source: APXvYqx+8GXgD6zUek104h5P69r2oV+8/cNH60VIQUb9qvo3MOQgMc5pwbv6rWrUXOEibCFO3Oj8mA==
X-Received: by 2002:a1c:9eca:: with SMTP id h193mr2456177wme.125.1559037591079;
	Tue, 28 May 2019 02:59:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c24sm1639625wmb.21.2019.05.28.02.59.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:59:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D56101FF9F;
	Tue, 28 May 2019 10:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:41 +0100
Message-Id: <20190528094953.14898-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 16/28] editorconfig: add settings for .s/.S files
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are starting to add assembler foe tests/tcg so lets make sure we
get the mode right.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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


