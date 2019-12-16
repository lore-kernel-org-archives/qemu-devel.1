Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5771C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6D7206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lh1e8t1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6D7206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoTS-0000AB-Bv
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFe-0007dl-EA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFd-0007nT-AG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:22 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFd-0007lW-45
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:21 -0500
Received: by mail-wm1-x344.google.com with SMTP id b19so6249831wmj.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=INEC+O3trc34/sQ9VXKjuFm8nPKS5N+4sZ+l5CuQdRo=;
 b=Lh1e8t1VanEgXHprir+MfcM8kydEMOOKZ6lsmPA657uh3UJa8N3oRjM1Hr1nwhnfAO
 ucl7yInlLKGjv1R4vAC0Lc8tF7pfI2+dNPcyrPgr9LaebJSugLG22mJ3Fh/kHcg2pTNx
 P1JbPUu/fCwf73qXMPbev+W8oygWkw+oAyANN+lxSgWy+PgQcOhai7snbZBnKXFemYWz
 TiZyXkka3+zJH7aEU0STz1TqNIBxUA5Y/yqgiOFfYZVIMbtQSLViocuko0DPAi/7YwN+
 9tnz4YZuHiw+sLwSv81hrG3Gwiq/70Sz+fKS+NdpJvrtMcvG2QV3Lwj44o+LozRkdUE2
 lbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=INEC+O3trc34/sQ9VXKjuFm8nPKS5N+4sZ+l5CuQdRo=;
 b=jz3nDKNA0eDt3TkyfnaW9p6YhFBzfxN6fclLMfoOiZvKZ+vI6emVj1QPSi8RdMEsz4
 kpwYsrqGX6He2ZIbC2O0IALJrbXyhlxqB1bAvLgAJyAom64ZkBltnK/8tuqeSkUUdEwF
 b3d7NFIZGW5LW098ywwjltKCHae35FXb4wzqPF3u71ueu0XgQk8sNuUKqmMQeHhDAY4D
 pC5uJvSc3X1Vd84fuR5/GLaXure3gcxL4r5jOIdsNpWAEETIsqojs8WLzY9slDgbePrK
 qk2s5XznuPKrhLard/TF5yGqR6ttY8GxSjC58JXMIVrBfge7FSFPN+3o/KgDF+tTe7S5
 Pz2A==
X-Gm-Message-State: APjAAAWHcqJuTetftu21+N23DP4Ji+UnB6/RemjdlKkz6/CC8k0/9N5Z
 fOpDHweRPI6j7ulxgwt2ORK7fuwDciHQ+g==
X-Google-Smtp-Source: APXvYqxe0fs2kpjA98H9FvOAaaBPn7OD2T3pPKvXDYEFa8pd0X/jNyhibSJ5NYszTHIwPdflYsbXFg==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr13969037wmb.123.1576494558774; 
 Mon, 16 Dec 2019 03:09:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/34] watchdog/aspeed: Improve watchdog timeout message
Date: Mon, 16 Dec 2019 11:08:40 +0000
Message-Id: <20191216110904.30815-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

Users benefit from knowing which watchdog timer has expired. The address
of the watchdog's registers unambiguously indicates which has expired,
so log that.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-9-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/wdt_aspeed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 145be6f99ce..d283d07d654 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -219,7 +219,8 @@ static void aspeed_wdt_timer_expired(void *dev)
         return;
     }
 
-    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
+    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer %" HWADDR_PRIx " expired.\n",
+                  s->iomem.addr);
     watchdog_perform_action();
     timer_del(s->timer);
 }
-- 
2.20.1


