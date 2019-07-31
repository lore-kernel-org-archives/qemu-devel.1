Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C9EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326D9206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZ3qN8oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326D9206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrEe-0003D9-FR
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8h-00027q-G8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8e-0000kw-Rw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8e-0000ed-CP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id s15so38988665wmj.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x7RGFDz62fM8+46VM8mYT+u7ako6VpEUPrNMjeMtALg=;
 b=rZ3qN8oqK9kJSDDW+QP2nyYQA6VsxAb55XFQtHdMPASlLfsdHxWIySIwZBiwYf5svf
 r7CugMnDuw1kLmx7QxXbiyHvQJBNb9Wg1BCYV8FrF2JGSZDtqKD9nvQG/Uq419ps4M8f
 hT/z3eVaBF3Kst6oBnZZYv6m0EK0DNBaDtOGvB8TzAbHh476EDHlwNRW/jpo1sTPIsTm
 agyxPPA+RQsHQSCFGQ1tzR6A2LYlIeRjoPnE5zbEx8T23S/nOHI0JUrFEJNr8U2wZDw8
 x5Z1NBeX6N5j075VIrQwopKDbiGg0gg2T4z8XvqHK0M9sXBZ8MlsJnWEUie13qTFWGZf
 yTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x7RGFDz62fM8+46VM8mYT+u7ako6VpEUPrNMjeMtALg=;
 b=IftYZD444X+3kafTxLcnfNRUsb/6lWxlWz6nZWblULDCrzJXlXtfR/qwqaLp+th7rU
 PCanA5qHAQY0TezNzcBOctGQeCXilOv5p9e7La9wyr1fdsKvz64VWONctUc5+Oo2X6hH
 Jl5aVou0ZE8094oDy3nJaJn6iStej/7tRUXrR0oo6C+DmZUIP1rK37W4ccojz4RnHbvt
 jSk2O0drZARb+mC335iLBhmcgoz15FOS0QxGWWmG4eFlXYYn7w1CFZJL8m2ZuCiIeHmC
 /83uekqKRdhWz53WUnZjDwpLMjLmYGqYbA9nxOVD8koQAmHXsNLnVN+Prd2l6IvoLjbb
 BIuw==
X-Gm-Message-State: APjAAAXO2EsqMaQjHLzP9GPTmuWS96YGVesIRVHoerxEaKWNp9jwVMdZ
 J7VCycgrRq2mKdkjiQRi0DkIRw==
X-Google-Smtp-Source: APXvYqwjUsp1IVBy6xrCqi1tVXrWJVCUtSduOhHwQ7RF1c+nNgCjnBVPanLhuaU8ryQy+a5kRuIkhw==
X-Received: by 2002:a05:600c:20c3:: with SMTP id
 y3mr114925235wmm.3.1564589246646; 
 Wed, 31 Jul 2019 09:07:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g8sm68930589wmf.17.2019.07.31.09.07.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5D11B1FF9A;
 Wed, 31 Jul 2019 17:07:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:35 +0100
Message-Id: <20190731160719.11396-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 10/54] translate-all: use
 cpu_in_exclusive_work_context() in tb_flush
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

tb_flush will be called by the plugin module from a safe
work environment. Prepare for that.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b1699..9c5c60ed964 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1268,8 +1268,13 @@ void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
         unsigned tb_flush_count = atomic_mb_read(&tb_ctx.tb_flush_count);
-        async_safe_run_on_cpu(cpu, do_tb_flush,
-                              RUN_ON_CPU_HOST_INT(tb_flush_count));
+
+        if (cpu_in_exclusive_context(cpu)) {
+            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
+        } else {
+            async_safe_run_on_cpu(cpu, do_tb_flush,
+                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
+        }
     }
 }
 
-- 
2.20.1


