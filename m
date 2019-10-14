Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E8AC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B4A20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VnTpB8sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B4A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxxb-0000ii-0N
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvF-0007JD-Ud
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvE-0005vX-VA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvE-0005uk-P9
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id j11so19161269wrp.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TcDnMTCbqc+SMPI8ZRIhg2t2SAwRlKS9dBsRR316T8M=;
 b=VnTpB8sqXBvIvtF5yjTZvEcpflNYrKJhxc8WiUTIuCs8QgtlYbp8+ETdtBf/aZlmxg
 KPsKx7HgK4Z43ZdttNWYoSw1VYD3zXAmBNEiW/ujR+v4yrAikRnN46I7de3L4nIgF5Dd
 jMi2VmkthDwbumSM99z+14a7D8QKrnqlyC6HC+piA2a99bdaIgb7LgchgrjoTAnMqgm1
 EROzAamFa1HdKpc03SdazTJrKbxbZiw2cf0N0woa4MX7vADSAwF8FwWHohyNhphSLUgH
 sowYJ5ugpwDqv/NRVufeiL0EklUJfbbsdVTDW9VKZfrSjRpfxFKucsUQyV3v16zUa+lj
 HS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TcDnMTCbqc+SMPI8ZRIhg2t2SAwRlKS9dBsRR316T8M=;
 b=brQ5rztqUgVA2CmiZ4lhPW41ipVLBKD+jpTIUc3mDFMVX7iACChvzDFYzyLk5sAh23
 fPh9oP5R5uUMjD1Q5csCYBAwi9CuQhSPQ6yBPGCFlHkuv8D4GRj/K0vELAj/Q0ChYy3U
 SIFSUdXpsCvmXGd6Cg1UxGtafKAZIY5Domzy57zat6e3zmXDune4zwxmT7EJPdXn0gWY
 3gPr2YCivTWM3WKf7/g5vAsvrBhIUg3MW1chM7d2kpvnOLLnPG5IjNpw7wIQW5TKGB45
 ZSghCnYU9Ln4wmUYa8wWgrwFApfCgwEnEdVDaECuV8d4Crmt+gAoxIOYRhdCjMMoWRSm
 KrVg==
X-Gm-Message-State: APjAAAVLFPo7d+hGrzPSbJwM5Y7au2bMktmxBP5O+7G/AMuTvHXSF80K
 i6nBeOJNf1FT2hUEU7GO6SJ+pw==
X-Google-Smtp-Source: APXvYqzk9SbKRTqNJl3Ito9j5uHQWz6UCu87Fw3DgAsg0U2C3sLl4OZQjTvbRktOGaNsRji3Q5fCuA==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr24823864wro.285.1571050191698; 
 Mon, 14 Oct 2019 03:49:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t203sm21013915wmf.42.2019.10.14.03.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5EDD1FF91;
 Mon, 14 Oct 2019 11:49:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/55] translate-all: use cpu_in_exclusive_work_context()
 in tb_flush
Date: Mon, 14 Oct 2019 11:48:57 +0100
Message-Id: <20191014104948.4291-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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


