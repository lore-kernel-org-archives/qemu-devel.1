Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA5CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934C92082C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFEWVP/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934C92082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqmg-0006q0-9C
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqke-00055l-DA
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkd-0002qe-Gj
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkd-0002pw-BR
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id p7so8995157wmp.4
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZIx2URSbhQtQxwSH9NicQbjsqcplkfjt7F3Xbrr+u4U=;
 b=XFEWVP/aGFnw1NRLaBU5ieydfRPYUDIBZnQCoZK/eHOgndNaAgrrWSGtYh8iiDMMXd
 KD9sKkj4vcURgi+xhF8hOUbIN5YwnPenvspkS00tiglxScflGpi9rwtdHMqnyj0KieSq
 P5IVRE0AURS8eKXk2ORcAqmgat7xxwzoO8bEktQZNa5BzHuLqdLRgOaDFlA3QX1Q1BCb
 Oec/z49Vo2IXxwQSmBeZRKZGtY/4mOgDIvQekY/kBjA9sUmLDySUx0rfbcKjvU4APgx2
 sBt53Ij/tqpUx6BQirdcIrNmaSeFgPlDBPHw9YT/40KDy9X5e9fKskg4HgIx1aK0+4Os
 YtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZIx2URSbhQtQxwSH9NicQbjsqcplkfjt7F3Xbrr+u4U=;
 b=Bb1gHgxgTD9bcUtr3bKtK8aBlTyqFkp3CGV5GXWFY55N1ibS5TQtRnuyz2ITRpdGDh
 gOQn3R/hLXzd8zyMrUdJui0v9ST9wUeKKUYP+tUjU9ArJ+YIweO4Y1zrZNkYg59aaU0j
 FELKOO3cMB5YCxbbp0Hc517AxkOrFmSZn3bW8bHO23BCZmoqFUagTjjrGEApF1Ywcdvs
 JSTvFpqp6yLIKq69VUl52velE8DZgiOkggpf55DThzqko1KAdv629bOHTNclyohUzsGB
 sclkmkQ5/UcH+VbWukytbFickF6oauBVYwv/W26q9IuAfRE+vdTN3UHvQXHD2DkQ3vP9
 93TA==
X-Gm-Message-State: APjAAAWcAR5xzhgjCm5KDoBhOb3Ux9arZFnC3fRLvJz7qDfRn4a16gFo
 DeGfKj/le/KMRil3pP7FcrVWU/DX
X-Google-Smtp-Source: APXvYqx0mDth76RRWkA7GiYHDReRfYQ2zS2m3hxNJCtJiIDRdd5IVEKWy9RwxV3B8xuGNYnpSzh48w==
X-Received: by 2002:a05:600c:2212:: with SMTP id
 z18mr12985024wml.154.1571499282193; 
 Sat, 19 Oct 2019 08:34:42 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/11] tests/acceptance: Fixe wait_for_console_pattern()
 hangs
Date: Sat, 19 Oct 2019 17:34:28 +0200
Message-Id: <20191019153437.9820-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Because of a possible deadlock (QEMU waiting for the socket to
become writable) let's close the console socket as soon as we
stop to use it.

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index e3101cba30..a0450e5263 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -74,6 +74,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None):
         if success_message in msg:
             break
         if failure_message and failure_message in msg:
+            console.close()
             fail = 'Failure message found in console: %s' % failure_message
             test.fail(fail)
 
-- 
2.21.0


