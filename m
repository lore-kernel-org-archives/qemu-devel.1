Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5BDC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73D2208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDTxKr4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73D2208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkMG-00032g-Ax
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKl-0004pe-Cz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKi-00017I-Tv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKi-00016B-NI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id y4so24936979wrm.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BN4Hc+BdfKcsNsw/6ErEfw/2c/K9jmcSQTGwoFL/ES8=;
 b=oDTxKr4SsJ9/6hNlT8ERZ/E2JFsl7FVBA1crfvK8fkdYMFpjIJRRLJ8EUsh5Ul8+Yi
 8L+WB3/ISCZPoqR4I2eTY+QFNOWBN7oY+cCKKGmwhV+z7+sKlL1CLZA1lVqeF45muA+t
 2H2+Cxl7R8//L5znZYE850ixNJ8ACPJUoYls3RwN5++AXXZBIWZ424l0XQzoAVRfZi0R
 YyXQ2mR7hwtm9Gcz+J5F08/AJiXj5XhF1KY+3tIIIm6nynqdNQD4TqsjbOQJlUdPWEFR
 VBcwKuAC+CPIbXK64CqwWNO5wOPguHD9pv6zM5EmFlB8oGAKFDF4CwuO0vIM9rkfTsyM
 O0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BN4Hc+BdfKcsNsw/6ErEfw/2c/K9jmcSQTGwoFL/ES8=;
 b=OLFActUv73riDEPa5xx6mrBuNNwDZc/iAKZZdwkxE8TkW2rBRHjK2S0PvDppbEk1eF
 HBmwfR8aL9WuDIN+rpdVzSE38j4QbBSJkAjrvwpwzeYyTGzOzqZI7GMySbjMbsrIx+PY
 0kgwsKJU8gwsgjcjPGDUSqwcL+Pb5VVYDXsN1Zn+wWhC8CSm1tuOW9G87mI46cX/KxDp
 0J7DaONTeK+MlqdXrBcWa90BbwZ73RSyUeWLTqqMycluIVzBH6+0b1rAzuniHlYr6wLS
 E0usMv26N8tR7Psi91mgvGw7GrGkU0HrC3JAeJJgIuRRu6f+wZDIc50H2nbTneRyif7J
 ZBhg==
X-Gm-Message-State: APjAAAUvhJEvpiLU71u8bCnArqH95NuNEJKsAsyrrHkSg1iNoLw6CUC2
 4wTW/dS2mp8968XdUNsKdslte1YwR4A=
X-Google-Smtp-Source: APXvYqwpQFfmZUBqW1NgyKSA8khA6RaQPJfLQXjIv/E7ePWlQmB08k0LzUYzF7iyvIBNFIrNuXAdjw==
X-Received: by 2002:adf:cf0d:: with SMTP id o13mr30711900wrj.291.1563371459713; 
 Wed, 17 Jul 2019 06:50:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k17sm24887585wrq.83.2019.07.17.06.50.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:55 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4743F1FF9F;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:28 +0100
Message-Id: <20190717134335.15351-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PATCH  v2 16/23] NSIS: Add missing firmware blobs
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Various firmwares has been added in the pc-bios/ directory:

- CCW     (since commit 0c1fecdd523)
- Skiboot (since commit bcad45de6a0)
- EDK2    (since commit f7fa38b74c3)

Since we install qemu-system able to run the architectures
targetted by these firmware, include them in the NSIS exe.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-10-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qemu.nsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu.nsi b/qemu.nsi
index 75f1608b9e0..89c7c04f957 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -122,6 +122,9 @@ Section "${PRODUCT} (required)"
     File "${BINDIR}\*.bmp"
     File "${BINDIR}\*.bin"
     File "${BINDIR}\*.dtb"
+    File "${BINDIR}\*.fd"
+    File "${BINDIR}\*.img"
+    File "${BINDIR}\*.lid"
     File "${BINDIR}\*.rom"
     File "${BINDIR}\openbios-*"
 
-- 
2.20.1


