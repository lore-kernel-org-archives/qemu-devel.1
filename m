Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB2C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E5A20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8/wb5mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E5A20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAzQ-0004Zl-JJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAoz-00047K-Qw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAox-0004Fy-7x
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAou-0003sj-0d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id t5so1133586wmh.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ngCYt07rD9S6NfmUGM8XQw4uLZvtIN9Vg7GKA5tvoZU=;
 b=Q8/wb5mWbbg9YxQUW1002d9yliCB1GtRry9dHyWhIdUjJJ7Vgk3twD3KFbhHlrIgth
 DOz5EGgaTDm6rxzc78rUL7zSI6mba/ocLSz/31tIm8oElVbcnQA/gt6WC5Slms1nWc5r
 bDK/cXa6DAfbgTDDOu0sF1tBski+OkF+gQcnhnl+T1/omCTzpREQjt8u0P3FLobZtSUb
 UgVPfbbRpDbvUfg2133r7rAkf3ne0VPPHaTjipPUhRSRjI23uB2SNci3k6RQtlmDHIjL
 bD8PolZRRycr57MzmIyC/J8RvLZwSeRa1dbR/0zjwPoo0c+qmvJKzd38C9ZYoWzTlBUo
 HXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ngCYt07rD9S6NfmUGM8XQw4uLZvtIN9Vg7GKA5tvoZU=;
 b=EHX8HxACOaCT8VGOZmQFqXIXbud+mi3Nl6oRCITKc+x46+D0hQoqhra5ssa+jZcdGj
 ibeatbytuICDEurD+SzOzubRqhirLKh+5XvXlil2Soa5CuNDOgRzqwGB1FjVTgDExkbS
 2kAkGBBwHcQguG6L8MNgH5ZeQ1bgiT+o97zYszBXU4qQsmbezPO5mGqLLUoTpgrObNRl
 rc10Wv3je0gBUb2phOX11nwdDvn5I/0IIjEiEqv37F1AZ1N8xq1lsUWg17drhSiutFno
 rZuN6pvW7Wdul+h4oX4cY4as6V9Mz3FOiVP0zhd1xVn8eqCQdfJ2Q8dAT5I1iUx8qToq
 mEag==
X-Gm-Message-State: APjAAAXT0ZK6Yed8/HB5YKGHX4KJRbCNakxWgiSSIQj9kNUBwN8IQfmo
 LpIgM+F0Wqmkf3So7ryRKFUe1w==
X-Google-Smtp-Source: APXvYqwH99jO3voaQpogWz065ubedl5AqOligoC9Zh+pxu6bLHQOpBKgk6PLM2imPxv1HySo1pvVlA==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr2869870wmu.137.1559898353495; 
 Fri, 07 Jun 2019 02:05:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k10sm1244766wmj.37.2019.06.07.02.05.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D9B71FF8C;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:00 +0100
Message-Id: <20190607090552.12434-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 01/52] editorconfig: add setting for shell
 scripts
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/.editorconfig b/.editorconfig
index df6db65531..a001f340bd 100644
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


