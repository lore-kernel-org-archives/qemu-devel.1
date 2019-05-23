Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26537C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C5720851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a30k3ixb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C5720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33249 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl7N-0007uz-4i
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:38:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvO-0005zz-Jw
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvM-0001Wm-Hy
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkvM-0000zw-93
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so5641125wrb.9
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=mI6pN9UnLPqpwK2uAx0syvUxElq3Ud6lBiwzd8Of+TY=;
	b=a30k3ixbS4lqsT0IEw3rOb/FUhkSaA32MzBVHIV0lRLFCXMAiDkw3kDhgYkfJVwZ0c
	LF1ixYC8bXhEpfPAhX3BZ6hK6kRATnLWtcjcelnXSU+ZCZ8iJcYJ9KHDJk6ZOLBdJh9o
	OL+/e3uL5Yq6fEo1u02n7EhlFSh4L34kclhm5HP8SrpXjiLEElnStGpJQp47P2Oc1S3I
	lohMeQa91dgb+eUz1YBGRtR3cVryTaDaov7ErUiMX3QOpo3I7J1sOxhTu0R5escYXcdj
	y2f2lZxZ9vxCsUBJ8rEwzZ77bNLL21RWLKoeFNjV0fWhgQprPLMWzeW0yXoRnZqioevU
	wy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=mI6pN9UnLPqpwK2uAx0syvUxElq3Ud6lBiwzd8Of+TY=;
	b=hQXWX0hW/K1Yp1gmhQfqn5GPp3scXlHySOlmhhnlAtgKcgJ7MKWfAgGYto6CpNqI0k
	Ox2aIut5h1Ll6CjmTDoB/01fNHeHw5gnF90ksAObAiF0+rI2874qEx7Ge2D3kAdmcpKq
	sBiScZ3O8ozAW+dspbujAkDOdNB/u7gJzXH/+AeUhlgv3162IWmdjHwdN+heGJbibsxV
	tyCQp+yff7bTqy7UwmK/h4MiaZeBIzSW1ukSvaL6khqbrYqY4RNMjRHRCQ3e6t3CwlqD
	ZvHSTcT8xowwbtDPhTyuwjqluxfbRBzytXINU2uFegdFFowp9+qEsd9R2VuoV32Cvebb
	TQnQ==
X-Gm-Message-State: APjAAAWK6s5QTNS+q+j7zaYt432CuToMhtkHOfUZSrbVhsCnWlrjIgxJ
	dfQwwjZZyXorIsqOWRpqLxbRbA==
X-Google-Smtp-Source: APXvYqw52ADrBUBKtUmkq7k1y5/IgOAwpdFqXlycpN5KDFlh8Q7jhzBVlC5D8ogVYStWY/ryoFBtcw==
X-Received: by 2002:a5d:5743:: with SMTP id q3mr18253898wrw.92.1558607143785; 
	Thu, 23 May 2019 03:25:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	g6sm36900389wro.29.2019.05.23.03.25.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:40 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D53841FF8C;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:20 +0100
Message-Id: <20190523102532.10486-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 16/28] editorconfig: add settings for .s/.S
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are starting to add assembler foe tests/tcg so lets make sure we
get the mode right.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


