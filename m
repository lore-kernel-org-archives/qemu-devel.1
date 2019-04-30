Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C4C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6AE20644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+TEAR2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6AE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWHs-0000aF-VT
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2G-00048d-QF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzl-0000iF-3X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzk-0000hm-UK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id 26so4621120wmj.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6vVqCrsSMAq2VmXMxaXptAXGJhe00/TSZtSzKlH1E7Y=;
	b=N+TEAR2qz8+bQY349k4oW1ogx+snm0wjMuv28HrsNRc1GZsynNz/ZluipAN5c4TFOC
	AJyhX/Iwq3mVCHYW/kARm+2MPPyWbnYZuNRf71HY+cFE2qFilpSl7KI35mS6MKVcSwYB
	zKT43HVfwP4dKjS4rU90tBGO66HZZo3o9zQtTDBo1bFly2gcrUeV+TIc/3gkrC+hJ65G
	2kpLPg3R4E3ATrvA0AfR3OMtZCjBVR3IyV8WWABjeMsopxtEAPc/fMyui9teHT8qWLlY
	9IDoR8kX49yKsDl5RjkfF3wq+bn/xUVDTdZiFUogGvFrWjjMvbSMrLLA0IwYyCeW3ypG
	KeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6vVqCrsSMAq2VmXMxaXptAXGJhe00/TSZtSzKlH1E7Y=;
	b=Vupy9t5705t+4KxefXVR5ubTSXhvlnOw/NIAeA7AhTtm/PwC8DgUQbxpn/r4n69jOk
	LI3CSImSEueYyAqRe8XMoQlDlMrPb4mEHnl8/VKPOy/Z8bw86PwKWF7ytQLVHHFAxwoe
	JEOqfyK8iUaXqOztslwsJFMd6adhRXL4bQbg+5R5GGPZ5C/9dXOgP+scWLgE210/SWQ7
	ApiGO+kmNLbS5JJZTBsvmNsgJn5Ma1WyGFUQfSNCB3nrdD4eeQYS33G7E0mVIPa43u2J
	H7NdEqY3RV16ytm3IGDQjUH22oVUtgGXRBlUTlmEKytcJpZ+p0RmFemDo60p1DVTCpU9
	dyZw==
X-Gm-Message-State: APjAAAW3XrDsU//xEpYYdJmrPOKU7aaViRtvjUaeDo66UWjiYscOcI2o
	+qSJezO9E9TLtW73pP4xuSlnqA==
X-Google-Smtp-Source: APXvYqzOyenQPLY6nVy1/nfj/90b4hxKJ+mLRiL0QYjZIcCnZJwnQ6z15H3ONmynoSvoH/evuL4QTQ==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr3995782wmk.9.1556643159959;
	Tue, 30 Apr 2019 09:52:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 11sm1941265wmk.17.2019.04.30.09.52.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id BCC911FF92;
	Tue, 30 Apr 2019 17:52:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:24 +0100
Message-Id: <20190430165234.32272-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v5 05/15] tests/tcg/minilib: support %c format
 char
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165224.fhEmt4xAtjzG6xULTmBna1-VDV3b6z_5xA7JF71C3Po@z>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/minilib/printf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/minilib/printf.c b/tests/tcg/minilib/printf.c
index 121620cb16..d530b32be5 100644
--- a/tests/tcg/minilib/printf.c
+++ b/tests/tcg/minilib/printf.c
@@ -47,7 +47,7 @@ static void print_num(unsigned long long value, int base)
 void ml_printf(const char *fmt, ...)
 {
     va_list ap;
-    char *str;
+    char *str, c;
     int base;
     int has_long;
     int alt_form;
@@ -119,6 +119,10 @@ void ml_printf(const char *fmt, ...)
             str = va_arg(ap, char*);
             print_str(str);
             break;
+        case 'c':
+            c = (char) va_arg(ap, int);
+            __sys_outc(c);
+            break;
         case '%':
             __sys_outc(*fmt);
             break;
-- 
2.20.1


