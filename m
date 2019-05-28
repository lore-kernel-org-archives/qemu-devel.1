Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B7C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A587420883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdE7kc1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A587420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVZ54-00072k-Sp
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:11:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVZ3I-0005lq-Rr
	for qemu-devel@nongnu.org; Tue, 28 May 2019 06:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVZ3G-0006oe-L4
	for qemu-devel@nongnu.org; Tue, 28 May 2019 06:09:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVZ3G-0006ne-Es
	for qemu-devel@nongnu.org; Tue, 28 May 2019 06:09:50 -0400
Received: by mail-wm1-x335.google.com with SMTP id d17so2216481wmb.3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=uUUpFitvie/E2cI8g/Leng5/oivvqAC4XiTmCl3vOvg=;
	b=QdE7kc1vAQqmE15LgfYCzWMGFdwJoGX2rnwHHF1A9ykGvDjhaNRa4GmEfWfnV/qflV
	YGrm1P9j3eCoRfDp7DcCt8c/Jm5RqE8eiuCX682sYYC2KHug2aKYr+rYvcYxfV+JQY7O
	LzCGlgFdtUMPEchksKWk2aFWgSfTAg4MhKQ771FIi9LEOF10qN+wK+yZ0pDyMVYzJt7Q
	9s4RA8UlCggIJHbD1T9pe+Gtv2Kk74CU4w1il6G34YikleyNox+zLBLaZHt3/hDtPL0J
	HbL5lbjUXU05N2Zc852fxEguXzECQ1AcpynkwVWqrXvJU5JnGuPvVxP+UQCzUU2Nm6xY
	Q8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uUUpFitvie/E2cI8g/Leng5/oivvqAC4XiTmCl3vOvg=;
	b=lcNALn8HWGufbb8yrJwPN1KYSIIGK86h0zx5M8QVr0VlgBTLZTqp0GBlhYc5SZaftp
	jWZkVkq1gcB3k3G96A3woydwomKutWEibBEd/P8Mu+9QkHwiJ2JjSr0tTkNCIALHZDrN
	DisAcu9MY8s8JBiQ0LaMbqe24VLUQdXg0SxxmxaXC/hC1PVMhgZZPIShmMaFVtNuWBTP
	YSGzPenKznWW/A9SgNkt8ShTZ4kWAtraXL8HGTYf+NTGbKbAR4Ink5BDc61JwQmfmES4
	Koq9hEfCBzkLZEtC2otndc4i6ldRf5vtCRJjZPcc5lGF0vn7/wQPxOdJwT9aU7M9OxOO
	vZKg==
X-Gm-Message-State: APjAAAVvCs17Wonru/+V8EvOnx6jMgHxJiH1BVlvJek2wZy1UAmr05dU
	P343noLcbD5jTPhIGCtR1ePc5qloMXc=
X-Google-Smtp-Source: APXvYqw3U27gx4IAAvU25qGYCG0GKjFSNvV1gWgBViOObm3aQF2VbSd35sQu6ARwmml0/xf2qxne1w==
X-Received: by 2002:a1c:104:: with SMTP id 4mr2478468wmb.97.1559038188480;
	Tue, 28 May 2019 03:09:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	x12sm7512812wrm.92.2019.05.28.03.09.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 03:09:47 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 215F21FFA5;
	Tue, 28 May 2019 10:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:44 +0100
Message-Id: <20190528094953.14898-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 19/28] tests/tcg/minilib: support %c format char
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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


