Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9220FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E32A20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzbmAveP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E32A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5jN-0005aZ-77
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5df-0007zL-1P
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dd-0005Mv-Qc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dd-0005J0-KX
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so2287223wrm.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TcDnMTCbqc+SMPI8ZRIhg2t2SAwRlKS9dBsRR316T8M=;
 b=YzbmAveP3kH7nfi1Fd1MCw5P8sEtLkh9oaa0FdIsIlgTJpxxai+H+uusU5scFJbqVJ
 IuO2sBK3Q3/T1zq+kSSJ+nnxHcQvZHv7GSO1dNcv3MLIDqFe9zbIWTzAMT+FQIBn4WCR
 mu7CgkOxp8KQmK/pBhq3rirs1AEtQ87YUFhWg+cQM4LdCkAUrpsS7qe1AxkKHWQnr46s
 YHBSP4r0jlmDndyRHHjvu+Co7eFTuStk79rHh7wwdbYB80c/zDTsVN0URPuszI7exnWy
 B+MQU9Tdv3AGcfn8m9t165hNc3G7UYdFvWg5vRh/GYoDdT4UlInoJD3TBbWEVvxtYgA0
 wuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TcDnMTCbqc+SMPI8ZRIhg2t2SAwRlKS9dBsRR316T8M=;
 b=WvyPJh/LCi7wBjZl8zoE6Ye7aSZjwSy5TdmWX0sf67bZisUlT7E0+7SdTZv3r99SnC
 aVUY/skNtqMF5KXnOcOxekBV+x+vR9SFL3ioERnVI3DaaOT8/QdkQQ6DbluBG0ZFv9AV
 +95JiV6qv8LlHroAOisb8zWd0CHIHB/fTJn9D2tMY3UeqVc71kzT6y83yTaFumLBsaNl
 Cgo35fBiOb8UtVOhIK/8eCDNJRWw7P8vHRzNx8HhRQZGynhptQcGBJwW1Onw6cqiVKEK
 LtURgUHKSLTI6Z7pz+1iU9jZ0CQEdxyJRANDQRFd2QUqhFSMXtTf0RaZ48tctFR1KEIZ
 5Nzw==
X-Gm-Message-State: APjAAAWK0pzFn8qrca7Q/sFGwdXINnrIQXUqXf0eY2532kEve88sJU6J
 38jZBcZW4JrK9bJzsJSjiy8w2Q==
X-Google-Smtp-Source: APXvYqzvScam17OEllCAM0H3PFsvZMFcjf5pnkMDAKp97HCLjvz0oDvgbC/67fpQFdDWEQsyjKnMVw==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr2905615wrn.250.1571318179027; 
 Thu, 17 Oct 2019 06:16:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r65sm2215123wmr.9.2019.10.17.06.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F0BA1FF91;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/54] translate-all: use cpu_in_exclusive_work_context()
 in tb_flush
Date: Thu, 17 Oct 2019 14:15:25 +0100
Message-Id: <20191017131615.19660-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 66d4bc4341..0a08fcda3e 100644
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


