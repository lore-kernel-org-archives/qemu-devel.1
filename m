Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F8C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B386820862
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6N5mSF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B386820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSrH-0000yr-0e
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:44:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmV-0005Ot-IO
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmU-00021s-Lq
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmU-000210-GB
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id z26so2872281pfg.6
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=z6N5mSF+S/c66TXWfJZUlO0YBvfkWd8E8uyNzbDhFBxwmx1sse58qhUM3qDbffp9Lp
	oBUysDFc7IrgR1/vbIKHWozE1CTLaJTghD6fr+Hw13LxWVTPAcu4fIljfF3PcrrieeMo
	G8KNUQtQekXGvIYIJ0rqxXir4BKW4KUQsyj85B/qtGtXAZGegYBnsPqWYM1oFGS0iI+9
	uoiDwLjilM6IRf6Aa+49hFbsTkAckkJtV/O2s8ft6AAGL03JH5uCClI9rYhg4HNPy43j
	SMVwnxrtcG7PcWLxS6WW7RAgw/pgIkdMQZMTjsFRo9yIZ+zZZFq+6oGZ5z6f/qx78hEO
	ddMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=FMkvr75TVNkI/+LYUbl4NH1fRZy6ReAYB0Im+JPbicFv5jBChXKSmrinwdvZtbD1G8
	4q6es5F6VapCm7xiwicSifTNitUhDwx7p1YasRy7Sc8h44x+bsBB3AQWQHOleqLoX9Lr
	ugMb/7/O6BM1xmQKetSwI5kJOebSf9dX+x+KxIRy6cRFCwYZaLjKq7KY1yXFd5jTkicP
	6D8P6nOBPTD2zr70ZJSmi2T8wYHEGWm3iL6V7/p4mkkj40QO7jXMFSQwwX8sA+REPIdj
	O/kULI3XoUnw6RWO0y3dYdPlg6xhqPYKIHUaPoWY8YLa6BRu6zplqIgFj7LktNg+QO19
	mCMg==
X-Gm-Message-State: APjAAAUmrZFuqqv2VQ6B5tybG/AP51CzMLahuyIDazCZPly1HBVDAAxa
	3uO6l0JtETeWUwtF9Zgl2RiRIpScJUk=
X-Google-Smtp-Source: APXvYqzqPyqEdMp7MP1mYlbqOGODuNScMdY94YnL3dt5GNFWiOzmRKVSiyJ2Dfa4RdIVrsrAeZMO4A==
X-Received: by 2002:a63:fa4a:: with SMTP id g10mr54222747pgk.147.1558060773113;
	Thu, 16 May 2019 19:39:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:04 -0700
Message-Id: <20190517023924.1686-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v8 05/25] crypto: Use O_CLOEXEC in
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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


