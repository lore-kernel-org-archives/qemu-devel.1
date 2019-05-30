Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC7C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D949256ED
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoiCikYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D949256ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWI8m-0003r3-LX
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:18:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6S-0002W0-Jn
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6R-0006RC-SQ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6R-0006QH-M8
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:07 -0400
Received: by mail-wr1-x436.google.com with SMTP id b18so3779619wrq.12
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=jLczjKqy5I61WYJJtUxpOpS4jWdp7XC8w4aaEJBgg5s=;
	b=LoiCikYZy/xPUoBQXG0IZN1Ku+TWb6jvMovUQCSE8D3TqFc4PRUbExeruxaBRPyXbF
	OeHb5reDz8sqEDEe6dBzgDy6p/TG+2yi9JgXPM18khAwG4OY3VLHXSnlfwI8gT+QDK83
	lriewhXh9638Lqxz51P6r+XJH2KRDcLUzZ60XNLCUwlh+TER0j25IKp8tAq/174Rd4GC
	yi0dmq+HqoH7WrpH/ZIYDF5hhl1PlhxJn6Qb5+3I8M5Wm3GT15SpblgR9dGtBzn7wmHE
	vFJibnyH1G1l78ZprB7MqQyS4ZQ1/ljTsM1zxGlXZhoMqp0IPxFY0s5+AizWPLq8WakG
	CrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=jLczjKqy5I61WYJJtUxpOpS4jWdp7XC8w4aaEJBgg5s=;
	b=KJ9sY7hs04WbL39+3eVLV4HzXR4c8Ej2kOfNhj5BHtS2BVZr1f4RJaC+7vYRB3+xvQ
	aDGbPb+N9kb4Hdcvqq6RWC9VFnjglTzjO7BwdlbOMjFABBixKWhu+Ez31CfmZ/dSqNIs
	S8pEWnatYced2iAEX9jAIdual1jlBdexQ4SpznLmDSH+Zr+HpdiWQlxyCPAeNG+o+64R
	MJJeTKyDjmmwiiSXuwSK6KG4OjVrOpYdTcamt8Hf6tiUToXkBby1goy8dnZ3dFMRgHLk
	osduN8UChnlYkpMkZOOPlN8XXAouPqJIZBJkcIWVV83BlKWtStQQjYjx1AHS/RKttvBB
	YmPw==
X-Gm-Message-State: APjAAAXI9wVAG/ynF+dPWMyFUWnV1Rex570k8gC8X0wG2mc/RiAIxL38
	S2xe4KICie/mJqDulONROEOLgA==
X-Google-Smtp-Source: APXvYqzSvlnjOIuOy7/A6WaQaZJXpHHQ8jHZkGuH+CsOmlG2MWa2wq8SUdvpYnMq9HU53Xhbz6wWuQ==
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr2116981wrn.230.1559211366399; 
	Thu, 30 May 2019 03:16:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id o1sm74569wre.76.2019.05.30.03.16.04
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:04 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1CE381FF8C;
	Thu, 30 May 2019 11:16:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:38 +0100
Message-Id: <20190530101603.22254-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PATCH v1 01/26] editorconfig: add setting for shell
 scripts
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .editorconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.editorconfig b/.editorconfig
index df6db65531d..a001f340bd8 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -26,6 +26,10 @@ file_type_emacs = makefile
 indent_style = space
 indent_size = 4
 
+[*.sh]
+indent_style = space
+indent_size = 4
+
 [*.{s,S}]
 indent_style = tab
 indent_size = 8
-- 
2.20.1


