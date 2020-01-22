Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D33FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD00B2467C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/vNa1VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD00B2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDAw-0007Dw-On
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuD9Z-0005vp-LY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuD9Y-00085w-Lg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:29 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuD9Y-00085A-GC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:28 -0500
Received: by mail-wm1-x341.google.com with SMTP id b19so6203600wmj.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2aMYsER9zNwJfrjG23Mx7vaXxE5F7HH8AoPTJnB/ClM=;
 b=m/vNa1VZj0E+3i2n6lj4816uWOX8JRchTe+zuQPvU7gY5rAkvF2NcTTVugwopQHGJf
 C5XBLwcC/OdzNUpeHDvrCz8c3HjCKKzHp7w+KkY2zwbDsrHikGKERdot/el1V+Ovv2SO
 U4HUMo3awzF8Ng5hm1vMrXMvoeFkZn1lnUtNXifaFg2/tyyG90wzuglAdyIkB9pJzDDa
 ZOICCEEOYLmwvzxkK1LOHCoJjGDbfvGaDeYl/jOZvTxWL0KX3KjHQUrOZNQHarmaV9Ls
 HqNVUYCw+SrPGtwiwdqCf6sIfCCPfPUjOlXDNjohymxtl5zzvBa1ob2m9J4gcnWYz9Cs
 bh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2aMYsER9zNwJfrjG23Mx7vaXxE5F7HH8AoPTJnB/ClM=;
 b=qM/w3FB2dontUCqvoZZCjOQaRh9kLlIbrs2aYWuL8LWU3HNmsZYXLZwDGUz0jISClv
 R1xBkAxHkgPXQtByG2ymWXP2yh78BOMN7Ixs9SMDsL7PG/NLSN2saObUMJ4Xut8PkxIP
 6bleK9z264zx6VxJgvjYjeNS3u1KtOFXXPh6OHOPeSzZjOOeEqA+iXxswGFa3M4E+Gxq
 Zm7GC1U9UivUoQsMR+BolpA0nt5jJ50GxQixWlaC+wxCZX5GNHZ6igFhNASzpfcRcIYn
 6i6Tz6Dt9ku4Kjsr7sfuVrhjzYrV8XEZTm8u4Fefg6+RR2A8xq1p3nvCu1qpYDymwfuV
 bOrQ==
X-Gm-Message-State: APjAAAX2ymUddJE8P912HUIKN7hnaG+37tJCElZtIrq+mqN1w7sNRAU+
 dx/H1tcoGVLy5t1IMOTgAcnI9A==
X-Google-Smtp-Source: APXvYqzSB3IPI0wn9oHVWMWdQRUcS0kJhrqKifFb/3dTJuzl0E6rndAMHPUWbmeuaWfbWm4DhFbx9Q==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr2290250wmc.78.1579688547434; 
 Wed, 22 Jan 2020 02:22:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm3368334wmj.14.2020.01.22.02.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 02:22:24 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE9171FF8F;
 Wed, 22 Jan 2020 10:22:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/3] tests/docker: better handle symlinked libs
Date: Wed, 22 Jan 2020 10:22:22 +0000
Message-Id: <20200122102223.20036-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122102223.20036-1-alex.bennee@linaro.org>
References: <20200122102223.20036-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we are copying we want to ensure we grab the first
resolution (the found in path section). However even that binary might
be a symlink so lets make sure we chase the symlinks to copy the right
binary to where it can be found.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 31d8adf836..96d4326d53 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -109,7 +109,7 @@ def _get_so_libs(executable):
     ensure theright data is copied."""
 
     libs = []
-    ldd_re = re.compile(r"(/.*/)(\S*)")
+    ldd_re = re.compile(r"=> ?(/.*/)(\S*)")
     try:
         ldd_output = subprocess.check_output(["ldd", executable]).decode('utf-8')
         for line in ldd_output.split("\n"):
@@ -145,6 +145,7 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
     if libs:
         for l in libs:
             so_path = os.path.dirname(l)
+            real_l = os.path.realpath(l)
             _copy_with_mkdir(l, dest_dir, so_path)
 
 
-- 
2.20.1


