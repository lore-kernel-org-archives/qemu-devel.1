Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED4C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61A02064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+6TqLbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61A02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aS1-00041C-V2
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcW-0005W5-6b
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcU-0007GO-62
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:27 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcT-0007G1-Nz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id w12so14596019wrt.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4qoFVLEk4TMnSbFDHJO1R3wqor2c3af6vJj8knvgvVs=;
 b=M+6TqLbvamS6vUkSEZ6TheYfPLwCCDeqbP11gqV4EkTF95L0by3caNbDGfqOtSAPK5
 DajEiATREsKszZulmCytYHusguMng0SA47sBlZJSVnfOoMSc7c+d/uEg0w9gT9l3ApB0
 +FN8tAu0oMyqC1mJEc76aE2rfWVMjyz7IhIcSJ8TrqPOC5UNXRUhkiCSfTw/y6MFoM3H
 aUV3M5j2GEIw3i0ND0s95ZSukyfDiJiriKQHHskMx/PGIUyoA9S1mMAUUr9ytNoi5WUq
 jPLheobdrL0xU7sn0x6PSYxwIcoP8No5EyAJuJ/xzLX0VdRPNVYd36gcoyx4sYFfChtx
 M14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4qoFVLEk4TMnSbFDHJO1R3wqor2c3af6vJj8knvgvVs=;
 b=fjPYnYYn31QQsXYXR/LZFtNlBAbdqUf/Wk2zN/Nk47tmEM3hiS0f+Uc15Vtz0DPIpR
 qGT3Lq+nDT/+TeO9i9Mn4iA+yqi9b625bdAGErPiayZUy0EcVzQTYWl1GUPpu/Dbz+8R
 We8tArN0NjxpzGIlVlVTA+7je+S2YGy+X3dwrPlYlxPTj5TzdXot6Z/oiY0KWvn9DD7R
 BSlrBvhfbeKEt7Eug4fWwiAKHpSpP3mJLKTYzCCqE1DtS7RNN+RPQwCoaLXqiAr95fnD
 8kzOQIPrf69e3m0wddRUVn7iSaYYJVyj63R+ivMbWcSZeHiiX6wvE72KxnFtSvI7TKGk
 9udQ==
X-Gm-Message-State: APjAAAXtnViJAv0btMp9QCx4cxKKQSvQxd9/G/wd6+68IOUW+N7q7fN3
 jfAr8jKfCEqfYfAeAd5gqZCWYg==
X-Google-Smtp-Source: APXvYqyNMVE5fA/+qmBHrCcdDTiSEecKUireicvIQL4mRsrhQ1Xx8KTxN+2a7kDHkM0eZ+oMvqo5vw==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr76302155wrq.178.1582634844749; 
 Tue, 25 Feb 2020 04:47:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w1sm24513316wro.72.2020.02.25.04.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:20 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 174CF1FF99;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 09/19] tracing: only allow -trace to override -D if set
Date: Tue, 25 Feb 2020 12:47:00 +0000
Message-Id: <20200225124710.14152-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 Laurent Vivier <laurent@vivier.eu>, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise any -D settings the user may have made get ignored.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
---
 trace/control.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/trace/control.c b/trace/control.c
index 6c775e68eba..2ffe0008184 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -226,10 +226,15 @@ void trace_init_file(const char *file)
 #ifdef CONFIG_TRACE_SIMPLE
     st_set_trace_file(file);
 #elif defined CONFIG_TRACE_LOG
-    /* If both the simple and the log backends are enabled, "--trace file"
-     * only applies to the simple backend; use "-D" for the log backend.
+    /*
+     * If both the simple and the log backends are enabled, "--trace file"
+     * only applies to the simple backend; use "-D" for the log
+     * backend. However we should only override -D if we actually have
+     * something to override it with.
      */
-    qemu_set_log_filename(file, &error_fatal);
+    if (file) {
+        qemu_set_log_filename(file, &error_fatal);
+    }
 #else
     if (file) {
         fprintf(stderr, "error: --trace file=...: "
-- 
2.20.1


