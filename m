Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E1DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90042084A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yjT0simJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90042084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwDh-000476-4N
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:29:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBr-0002wt-7D
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBq-0001QX-EP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:19 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBq-0001PJ-9B
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:18 -0400
Received: by mail-pl1-x644.google.com with SMTP id g5so2133892plt.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ynany7TpuwIOWZBHNBqsv0L1yKHGvVYa7cOFengyx/8=;
	b=yjT0simJO9u2OuwMQdQp6mWSIr/NSNxCUkdo/UGM6kQ7Lqqyfy1RVOjW9p0fcorW+o
	WgkEmCt874s6HU4n+oXj9Ub3A1J1ArN4erWkQAX8VuuNdf2+ZIV5prdaZei0I/O1Q9Xd
	adPuiLjPINlXBfZfqeNIRurnRQMBexi7csVqe8q8f4/TuZ4ILuqEyjB8Y8bssTIfnVol
	LJP1nVtK08TmONJQgF8Keon25pFt+iV+pScAKPrGJhYypyk4YSWkJyAgh9/Zd8q/u9dI
	L2S4Jxh6UWs7qSdrc+2eSl6MR1Zrpm+FJjVehn+WPfayu5rJryxAWQNkiK2dqNVuq1H/
	frSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ynany7TpuwIOWZBHNBqsv0L1yKHGvVYa7cOFengyx/8=;
	b=h0EdQw9MUaMYUCX0KJQ5kiWralzkRtSxMBsI4X2aLdw2iEQWE5JK1jYkL/fFs83A8N
	PppyBecbinLG8exrqhYDfdtE+Pj/mFypPfSGILqtXc/gWRsr8TXMXRhKnN0bvTM0sF8z
	zd3/oirPmxpQ2KLRNRX0kwVxnbyHYd8ihp7cSFVH9j5ysK3L3514vxM3VLuH/EnoW5Pm
	ePxL4kXndzlQG7jzDushB/okjM9ElUlLl6M+00W3xtFvxnAmVqKX+07NDw7gjKtYSReZ
	gSgcf+dXrn16HntbAhWxtZ9OSNiaaq+bvMDEIDvWe1Dx5ZbJ6h0RIFbRQM9jzgJS+qzF
	b+XQ==
X-Gm-Message-State: APjAAAUcguASXjzvcC+K/zvVf12K2uuHb9EwsoGz1w5qOAWF1xujkbJa
	FJQW8/vPvmN/3xnZ18AbfJCmqFTo00c=
X-Google-Smtp-Source: APXvYqwMcKgpSE2r788iiQxW5LBAz7RRtw2q3ryosUWSzsWQSXeNhAYt9UCC0bgtg4hRItIe1ibQBA==
X-Received: by 2002:a17:902:b412:: with SMTP id
	x18mr10205522plr.304.1557458836901; 
	Thu, 09 May 2019 20:27:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:05 -0700
Message-Id: <20190510032710.23910-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 3/8] target/sparc: Define an enumeration for
 accessing env->regwptr
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 85b9665ccc..08f7d1a3c6 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -31,6 +31,39 @@
 
 /*#define EXCP_INTERRUPT 0x100*/
 
+/* Windowed register indexes.  */
+enum {
+    WREG_O0,
+    WREG_O1,
+    WREG_O2,
+    WREG_O3,
+    WREG_O4,
+    WREG_O5,
+    WREG_O6,
+    WREG_O7,
+
+    WREG_L0,
+    WREG_L1,
+    WREG_L2,
+    WREG_L3,
+    WREG_L4,
+    WREG_L5,
+    WREG_L6,
+    WREG_L7,
+
+    WREG_I0,
+    WREG_I1,
+    WREG_I2,
+    WREG_I3,
+    WREG_I4,
+    WREG_I5,
+    WREG_I6,
+    WREG_I7,
+
+    WREG_SP = WREG_O6,
+    WREG_FP = WREG_I6,
+};
+
 /* trap definitions */
 #ifndef TARGET_SPARC64
 #define TT_TFAULT   0x01
-- 
2.17.1


