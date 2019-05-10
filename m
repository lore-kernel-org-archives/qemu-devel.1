Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B7EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB25217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtT/LEiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB25217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9UM-000699-Nn
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:39:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MJ-0007Ka-Mh
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MI-000612-Tf
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:59 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MI-00060c-O2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:30:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id 13so3575779pfw.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=LtT/LEiz8o8zZQG66+lyn31ggveLygkwoxdavL7ktPh1tyYPRmK1hIc4aZIyCEW9C+
	OBowa7uPF2HK1lhsIX8q2WSzDubSznb+XQtAcgQbTVpYBLTrNBnwHYxbHuAMfLmYJ8+r
	86vbw8svJwSbsugVfl2GoZm394SUdefVT084ocDxYGGdObxsAZPoTo6A7YDNf86UahwT
	JhHRb2jPTClkKuNQ7Ea+lM3+0L3NhEhNtdD0c5OR9GLx7yUXTQ3yXAkjaCbA7XY3sihS
	VQMlGvcDkev8Q+r7qPu8RgoHkAXVwhIEEWtvkbFNlMwJK5e9lYakLkJIBhHk08bVt0NX
	UYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=NuZXZEzxPw/ZIlK3i+COtUyd9lLOHnHsAZcvNCWHUaLzcyHaYqUY6WXqSBG5Xrg9Ja
	w9yWNySyjVpLU/cqbSWuNvDoGEAAlPUNlc1idLQuIgL4yNl2zIzKSwUB/UB4IyW/dpi4
	ebZJ2QbCTkkwlrcQa91U9BeNJj6dJTDNYK5vWJSuXst8gz/EFNU0hDqDO1otYH5Mnbhz
	6wUyKdGzOqfLO4t3t40IeZ4U4d+8JS2wXTC1BEZuGkNlptTzhYPTZ103JrpZtIQBSl8n
	pf1V7L42lILEM8KHPW+wyorrrjFyVFHfIQoZfNJC0pYjC+6M1tRozOx1M9t56nDQAbnc
	KScA==
X-Gm-Message-State: APjAAAWfCjXrBxHfR/Tk/jTiD+w6gsBEHzoE67JWMuz1KpoA4DCaE83g
	4JAL8i75t6W9PD5KzrBTvEyPFjs85LE=
X-Google-Smtp-Source: APXvYqyuYjh0sgsMhSPVEpdqp80pFPFflmTFDb17rN3jZDZb6zillSn8GF9Dk97zgjsJWWvS9W03qw==
X-Received: by 2002:aa7:8212:: with SMTP id k18mr15939374pfi.50.1557509457381; 
	Fri, 10 May 2019 10:30:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.30.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:30:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:29 -0700
Message-Id: <20190510173049.28171-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v6 05/25] crypto: Use O_CLOEXEC in
 qcrypto_random_init
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoids leaking the /dev/urandom fd into any child processes.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/random-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 260b64564d..6df40744c7 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -42,9 +42,9 @@ int qcrypto_random_init(Error **errp)
 #else
     /* TBD perhaps also add support for BSD getentropy / Linux
      * getrandom syscalls directly */
-    fd = open("/dev/urandom", O_RDONLY);
+    fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
     if (fd == -1 && errno == ENOENT) {
-        fd = open("/dev/random", O_RDONLY);
+        fd = open("/dev/random", O_RDONLY | O_CLOEXEC);
     }
 
     if (fd < 0) {
-- 
2.17.1


