Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994CAC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CE62072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJxD3szZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CE62072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoOa-0001N5-Rx
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoEB-0005S3-LJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoEA-0003pV-J9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:51 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoEA-0003nf-DI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:50 -0500
Received: by mail-wr1-x444.google.com with SMTP id b6so6749960wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ja100L2N0JSJy62pEiA/ccOKIDxWtzpPJ0XV3cScyTs=;
 b=rJxD3szZPuc62GPbpsqwnGszF5iNLhVyTJ6GevJ0Q52NCwg0B5Z/xBP/e96eY0EDD7
 zIXXSjkLzT/LP9ID72bEfjOd7mn6XJ5me8V2y0MWmSzTnKR/oy0wIgTzPOlEuSXPGaET
 8fQhM5D5hnXvwD2BqU6mwx8blYz9GpdkRtIQlU49l9V3+3o02Cp+FOqpVaKmO9Cj7Ch8
 nkBoGqj48rLqvN6X7pP8HSLAdtT9T9l9/+dfYOpmIhYRBTr9A4bVMerp+eZMpkDwlqru
 deI+AudNFiLJMc94UFURAjokcwklVXOuzdC6UvvXf0fxtdA6vpWHXgezb8pf0QokgTKD
 P06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ja100L2N0JSJy62pEiA/ccOKIDxWtzpPJ0XV3cScyTs=;
 b=EXdkoSApqNNYIZWHQZckcO3fXY+vuP1KgPIa7RP49bzCctA/IaZNBW+XtvVg+yOo/I
 AQblPAysR0PgdeamGhVPkEDJxY69onz8R84PcReCqAqtNwXxXqBtLRuyixqkMoi+bNPV
 j8zyz7Am4wiOr1QWUz5CugohhRSa81JTQNzHZBE1KXpmdjYgbY+OAoIS+FIPx6OLwkDh
 RsgQlYqOhzXQlxAB5fmRC9AsWz/7dyXhN3qBdmlH/iLv/cFAo8M+mFBVuaHyKf00rjd3
 XVGhmNphETdbRme2hNodEt7bECtNxt7pilBG1hxyVxybnmJBveJ4ZpNX2k/dUJnqYbwB
 f7yQ==
X-Gm-Message-State: APjAAAVW795VesrWiz7NblGZ/QX5g0ZwBHpwG7JnB+MdzQkRCIGC/pyO
 sXV1+fZG0prQfUfzRZhYdPRsoQ==
X-Google-Smtp-Source: APXvYqxdqBeVh8nArEaVKnsgnBJ74f4lNhtkgpVhTH1Y0z62hvc5rEyjmhCE7cW2Gu84zwgi9XkzOw==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr27825975wrw.370.1576494469396; 
 Mon, 16 Dec 2019 03:07:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g199sm2097052wmg.12.2019.12.16.03.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:43 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2A7FE1FF9B;
 Mon, 16 Dec 2019 11:07:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/16] Fix double free issue in qemu_set_log_filename().
Date: Mon, 16 Dec 2019 11:07:27 +0000
Message-Id: <20191216110732.24027-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

After freeing the logfilename, we set logfilename to NULL, in case of an
error which returns without setting logfilename.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191118211528.3221-2-robert.foley@linaro.org>
---
 util/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/log.c b/util/log.c
index 1ca13059eef..4316fe74eee 100644
--- a/util/log.c
+++ b/util/log.c
@@ -113,6 +113,7 @@ void qemu_set_log_filename(const char *filename, Error **errp)
 {
     char *pidstr;
     g_free(logfilename);
+    logfilename = NULL;
 
     pidstr = strstr(filename, "%");
     if (pidstr) {
-- 
2.20.1


