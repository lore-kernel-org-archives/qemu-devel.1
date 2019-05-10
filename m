Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C88C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149802182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9FC5WjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149802182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuMM-00022V-6y
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:30:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHk-0006Iv-Ig
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-00014R-AK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHj-0000vt-3Q
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pl1-x641.google.com with SMTP id bi2so1971614plb.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=q9FC5WjX7Sjp9A4E/k9cgfEf7yTbFV4yLRQJSZnkUh2FFec8t/Uz+/GgB650uA+f3T
	4aU9dWy+5aQR/SyeX59WPaPYYNzcMbWumNI3YgklONkhrwwyTZmifKDWZoK0hPT4jofh
	Ft8MN8WWsuOiozsvu1Ueugk8/sainc6H6uQVjYlLiZ1RaLJrqqZ67AZ7idWXiZrj/6WT
	hdSGeOZOHojHZR7HV42rejEG0kZzc2nL3Ns1yyhSg6OQ7dC+Z9g8aDJBTpzrFNBYAQAV
	EB+4+YrgLhz+wxCYxoJ0wR6IP7vwqtcC53jBxnlfks0WS03jZGUlrADPgzQlPdcuqQNs
	HpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=obp1S+l9cKA/u1QRzzZWW5BzD8MbU2EbgpAmpIc5SSvV3uq6QcaQln/+ePaapeeNkN
	BuTu3Zby9RFmvul3NRX8FkWdBejxL0IBltut3ROIX0MlrdQEYXEBBUQ1ENBg2TT/QjfB
	lGo3cs3iWLYnm1i54SrWcQ9GJjmvaWIR68F8yCzVGgU0A6bjZyNwcKCykuekd6MsPgEU
	cVhuV99VEvJRuf0PgQE5eWJLyxdrANhWDIZi9EUyv6LbEcifo6w54BJzft1RVb77Puza
	E2iaSDTlG3mMPNIX+oCUxntz2c+WK0SB3RN2ZWG3ySJsSNRoRdievOS1ke3N5GXJkUK3
	gbxQ==
X-Gm-Message-State: APjAAAWXFHByz/XLiTjuNk3bAS3cQekNx+GhBlju648lFn+e3DXHszYW
	GNMKOgUAm4C8Z0G+SvC3663uW6v5u8A=
X-Google-Smtp-Source: APXvYqyizxe64sBZDW8Yg5hCADX18y+iFoh2Fu90ZRf8QP939M/KXqY030cD0l4qeK8K7/eEYR6OUw==
X-Received: by 2002:a17:902:7c8f:: with SMTP id
	y15mr9415198pll.339.1557451506794; 
	Thu, 09 May 2019 18:25:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:39 -0700
Message-Id: <20190510012458.22706-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v5 05/24] crypto: Use O_CLOEXEC in
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


