Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687BFC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BE3269F3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfW7LebA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BE3269F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi5O-0004CY-Ez
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:00:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhor-0007WS-S2
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhoq-0000S4-Rk
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:41 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhoq-0000RX-MI
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id r10so9217195otd.4
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ItJ/j1rsNlTOBkZ0FnAZ1n8hrTC6onkMWRtzxbxhbeI=;
	b=wfW7LebAy3VrqSB0gMnU+a52AZG7CJy/g0gXAzaRMAU+Z5mrSBRfU7SLZjLLWMDaIn
	Aaxz62jRl/RmWTsLf0/EMA4wuGa0eWOkivmFOc79CzBA5fBFYeEZn5xcfuKGRFxRUUUl
	J0banYvtSGgoxJS9b/WpbaifwTazoyRZa1d6EzJW2AaIIY0vHA1Os8Z10rtuHsBibRWj
	m2ugHkvsWEfPZ4qSOEJ/xRVxfSH5fmzM+Wxh/T5tyVTYf1G9N1ka57/bJ5i0KU6PDKrD
	1Dmj8s/k5D9MFEYJdmqcvWNfuo0FBKlKaI8eEPQHfFpsJA5hrLgHy5d3nEzyuLADs8tk
	V4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ItJ/j1rsNlTOBkZ0FnAZ1n8hrTC6onkMWRtzxbxhbeI=;
	b=plAe7ey/4RKdhXQD4D9tdl+CWkEFo6Q2/Y7uSxI46r9ggn2/qBjtYK/Vh2O6JzmgQj
	eD37m7fSLwj4o6583LmNu2dnHTfcfOVn/a5gbpA+mt2CpeFUUvG7FpNVX5L6+WXz0FW5
	3vpbmcS17yMUtKhnsBeHv6pn3GE/fpadlIbDat8vIJ4KHl9kMqFc77LCeXLPQzX1GBb9
	7fP30tShV6TEhoNShKEGQ2Jq4tijQSd8/3w4uC/t71y9uXMX5vcIfKJJEmUnOsLHkxFS
	s1fGKfRNukcwn98CImagDs2GcE8kzpt3kcfHkCcw0a1w1ZLOolw0ucEkp62i72Vdx8BI
	6XxA==
X-Gm-Message-State: APjAAAUEbfQ4VQFlacDOyu3nqU3m5Gg3VRS+T6E1W648AqK8bTu0QOxV
	KXlgD8j98YH9rP7ukkOUelXNTYSyyuvxrw==
X-Google-Smtp-Source: APXvYqx8HGgWs9/dfN2pPyGJHxXkwrtGXD9aWTduSreJSgqsmPKyZ9ZlaKL0GToQodywECL96yqS0g==
X-Received: by 2002:a9d:7312:: with SMTP id e18mr1884692otk.148.1559310219719; 
	Fri, 31 May 2019 06:43:39 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:06 -0500
Message-Id: <20190531134315.4109-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH v16 14/23] tests: Add rx to machine-none-test.c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, philmd@redhat.com,
	ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes check-qtest-rx: tests/machine-none-test.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 4c6d470798..80df277357 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -56,6 +56,7 @@ static struct arch2cpu cpus_map[] = {
     { "hppa", "hppa" },
     { "riscv64", "rv64gcsu-v1.10.0" },
     { "riscv32", "rv32gcsu-v1.9.1" },
+    { "rx", "rx62n" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.17.1


