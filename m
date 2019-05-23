Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3BDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4432020868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBCx6fa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4432020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlOB-00064A-KE
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:55:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2q-0004TK-OV
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2p-0006gk-RX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTl2o-0006cu-Ds
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id f8so5699705wrt.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Tdq1lhooOg5isCiP/Tk4l5zr7fBDvEhDVLC+/j+f1ds=;
	b=bBCx6fa1QtLXyXvYOhyVry/s/1iNd1OKFirniS+oQ+EuMi0qUP/1ztmvOQiQV2Xsdk
	b3ek7jZE80QXAXYlZf+ZA7ZSapeUV/v65Twmv+F6bFVUm+JXocdph178JqahqcXy0Sgb
	QTsgppuonSs0kF9H3lTnbcGizSQnnopv/6D4jQ8mJjr0FbdPuJVDfBHch6p8SOwBkHKb
	B4vu6ncjiR09vPaGIkzZsKBMOmiQqENNdXul5KxbCJh+zPYvZxILmYYCLT18DiL3TeR2
	hUwyMv5jubrrU0seU81YITeFHZnEesI0aVLWW+MCxJm9lAtTT8HbnaX20b8+uYSHB4Q7
	/qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Tdq1lhooOg5isCiP/Tk4l5zr7fBDvEhDVLC+/j+f1ds=;
	b=CxtKvQMjQsEwyDHZBd+Y06U/rSgcZKywgjpsQDMNBz7Ems4bGBQTuiP2BRrvGY6GcM
	0pIKXPmp5PDm72Dm5aDiux4js4m4zC7LUL8y9xRM9wnvb0w+/edSC8di2psv8oXi7+pZ
	VUklvBoz+e1m+JoeMSN63IQm6Z4sA7d8I0ISTYlKr5GXWfAmWfe3hRi8alSfKv0xwGM4
	5wJZwsdF/DbxHfTQwqv0UVP6dkjcGc/4cnz6n3j7FuVFBYnDNmkJ8bLDPpBrx1LCpAcl
	IXOQRhX/ED9LCCDOBl1czYggi+eb9NSWzMRZUYSmGRAbD2jGcTx9MZmMxrwnisVRnGLe
	UlUQ==
X-Gm-Message-State: APjAAAW8TJufMQP/jIHlIbSfSZe4qLQxWoFbQgllxQ3XT4R0w0CbtFoy
	yDtfzRQWZINrbUwkKOvULQbiwg==
X-Google-Smtp-Source: APXvYqwOoY7nM/oyyiu1+JeGeKIORpp0neSVntzPM1GQ+Cl0OpmfvCk2ebvdkWaps0LlK8csbgUHzw==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr5500140wrp.281.1558607629430; 
	Thu, 23 May 2019 03:33:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id o8sm49092082wra.4.2019.05.23.03.33.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:33:45 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 201BB1FFA5;
	Thu, 23 May 2019 11:25:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:23 +0100
Message-Id: <20190523102532.10486-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 19/28] tests/tcg/minilib: support %c format
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/minilib/printf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/minilib/printf.c b/tests/tcg/minilib/printf.c
index 121620cb162..10472b4f585 100644
--- a/tests/tcg/minilib/printf.c
+++ b/tests/tcg/minilib/printf.c
@@ -119,6 +119,9 @@ void ml_printf(const char *fmt, ...)
             str = va_arg(ap, char*);
             print_str(str);
             break;
+        case 'c':
+            __sys_outc(va_arg(ap, int));
+            break;
         case '%':
             __sys_outc(*fmt);
             break;
-- 
2.20.1


