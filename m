Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D2C46460
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654C32168B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuKPLW1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654C32168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl5S-0006Lh-Ue
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:36:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvM-0005x3-9v
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvK-0001U4-9C
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkvK-0000vB-1l
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id j187so5195269wmj.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oyPkJQUuoY6kZyyqgBjqwhy0PzvVeS2HQFmL5+Adi4A=;
	b=nuKPLW1+Z37vDr7p+bdJhWm3p3mAdionkRiJNbA0/6Jv/44BIiRTMDJdObos7VqT+d
	x4DIe5tUSUWwGUZj8bLiQiX/XH5dNBKmSuO/ugUjSv1c/5ATrfsTMHUS/SoQs837fOei
	slgJHtrA/H51XCwznG3ZMO2Nd1M2xdHQufpwj+FwUaH754oM5zGhVR+QbIYANgKv7RwV
	mD5fYyaBaFjcGEFqkkSBfcWoLEY6Uw/DVy1yYEBP4pVmpqbmgCDUKHlirQlXQ0HSIrdx
	JvUvwxUD0lmsg3SWOsUbqbnTxI/kyUJDjLyU+IWAhp3LpeSdH4l4v9Psoy5CJPyhjxEX
	No3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oyPkJQUuoY6kZyyqgBjqwhy0PzvVeS2HQFmL5+Adi4A=;
	b=ExUf9Q472D0xawVF2WDOkmiWu7M7hipDw0CP9W5QuFk4lZIFgBQQS+xPIws5nZFTda
	wnXs6jsc8dSF/wzWSBek4aYZYscIqM0wkdLWxocyF11OVIa0nGBp3/zqapeQgzwrgx0R
	vtfsgakTemeJNi8Pgw4W9G9ophRXWWX60VMNLy9XP7X+XyZvYLVPQXxlV88LifPY8baa
	wgrF4OJpjseJxps11MvxB61GX/8K2FYKQ1t3hImWOWSZ6DZFha3vp5eogqEQCIvQJFep
	+Nm6t8l6pPyf7ewrvQ6yNGmXfrRiNnNL3DP/RDeMjAy6cCiDeBlr1tRa0aQJ6GuhU1oB
	7/Hg==
X-Gm-Message-State: APjAAAUFbXQ52ukncwW2eCXnSzcFQl0nO8vwMhbGhV0uHFjYWYjOLP8R
	9JcFpzvHabdV4Nu1EFVwrorNBw==
X-Google-Smtp-Source: APXvYqyT+yR32/9xDAVPsmQ4xUEo/rtWxzYzRMgWc5rZuJF4PVxEoO5niclZOw5lRSmuaVUTHExnEw==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr10801336wmh.138.1558607138116; 
	Thu, 23 May 2019 03:25:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 6sm35343311wrd.51.2019.05.23.03.25.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 205DC1FF96;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:11 +0100
Message-Id: <20190523102532.10486-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 07/28] target/arm: add LOG_UNIMP messages to
 arm-semi
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clean-up our unimplemented bits with a proper message.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/arm/arm-semi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 253c66b172a..a3bbef18ef7 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -28,6 +28,7 @@
 #include "cpu.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/semihosting/console.h"
+#include "qemu/log.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 
@@ -366,7 +367,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return len - ret;
         }
     case TARGET_SYS_READC:
-       /* XXX: Read from debug console. Not implemented.  */
+        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func__);
         return 0;
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
@@ -400,7 +401,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return buf.st_size;
         }
     case TARGET_SYS_TMPNAM:
-        /* XXX: Not implemented.  */
+        qemu_log_mask(LOG_UNIMP, "%s: SYS_TMPNAM not implemented", __func__);
         return -1;
     case TARGET_SYS_REMOVE:
         GET_ARG(0);
-- 
2.20.1


