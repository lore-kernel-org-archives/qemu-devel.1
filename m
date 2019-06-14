Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE10C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDF5217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ky7YLsxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDF5217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqFz-0001l5-03
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkF-0000T5-EM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkE-0002xY-6p
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkD-0002wC-TO
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so3033768wmj.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=08HscLjvD+PkgROa+8EpI2roPOdpCcPPJ5uFR5Az32c=;
 b=ky7YLsxAcIiyof1matNxkkgrxHSdO/GiNDxXq3/tXUK6IyZU0XmeR6eE3mig9pHNo7
 diWt4nPa2NBfaM1SJ2jWGulR1Z2nwHQPV0mS+BdsO6bsbj43J1eSe2xCLbcc47sH1kwD
 M5995shcL2u81R+8bJTOLTAKNBkvEwy8Z/5e1ygRx+oS+B9m1pIy5EvnWtuCXrhKimL5
 L4YWyJKjQccSccDp8JOrD5ziODbolvbP/YrTdEZzP7buw6yiUTu9XpAdyuU+FkIhs6Sf
 CWdOovEwRt+aPW//tsu3758borr74wZ+0jtNw5lDCNrpDgxrzqz4CVCgXmdkWHNqLBmt
 gmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=08HscLjvD+PkgROa+8EpI2roPOdpCcPPJ5uFR5Az32c=;
 b=ExJ2tuozlf0QED8fWnyXFVqW2YW1JqsUsS9nvslfGJHV9Ezuleq3UJZRlRCJ7EPgSY
 2R7BvTHVShQAna5bEM77ArvDGHU4wKPKs91XRwvwWlNdOfwRiW1qcLyLkg33FF4mIz40
 7rYzgSy1rAu3mEvMmRsMCxsqZJKs4dwfSDB/ehimYzCL1FbS1mXS1nwZ7T1st1d/IYQb
 T6LVkgpicWbfLp0I9O8NomZPR/zOM+YHiYJ5xVjcMiBEWmIQjwy3QH0uEKdGXByIclHC
 lv4i24eFOZoCY4EXdppsGvwDoWopzLhFlK7uR5dj/6ziyzvFHsb/OVNEpmc/05WLpEMC
 9aZQ==
X-Gm-Message-State: APjAAAV34E5jAulARggNoi/VXdIANGbRO76ar0XI2+XBj7haoI58tKaR
 F3xmrfeL6ZUosFPA8/34x76WW48s0uk=
X-Google-Smtp-Source: APXvYqzhA8snmlATmHfzsrQfvqPGr5v/fUWlMygQk+FX17hE35G1ilsEY/O5/ClyK2mBSOqf7a0hFQ==
X-Received: by 2002:a1c:305:: with SMTP id 5mr9092711wmd.101.1560532324399;
 Fri, 14 Jun 2019 10:12:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b14sm4225685wro.5.2019.06.14.10.12.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:02 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BFFB11FF91;
 Fri, 14 Jun 2019 18:12:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:14 +0100
Message-Id: <20190614171200.21078-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v3 04/50] translate-all: use
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
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
---
 accel/tcg/translate-all.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..54998e39c6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1268,8 +1268,13 @@ void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
         unsigned tb_flush_count = atomic_mb_read(&tb_ctx.tb_flush_count);
-        async_safe_run_on_cpu(cpu, do_tb_flush,
-                              RUN_ON_CPU_HOST_INT(tb_flush_count));
+
+        if (cpu_in_exclusive_work_context(cpu)) {
+            do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
+        } else {
+            async_safe_run_on_cpu(cpu, do_tb_flush,
+                                  RUN_ON_CPU_HOST_INT(tb_flush_count));
+        }
     }
 }
 
-- 
2.20.1


