Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CDBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BB82068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="bpkzki9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BB82068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklyI-0001dM-32
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jklwY-0008QP-UF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:02:18 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jklwX-0001KU-Ap
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:02:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so16465050wro.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wF+bGbEnfshWxsJ/yf4Ch6hkzE9gZQxmulbsomoxE0g=;
 b=bpkzki9hvT46KeGV5YtOIsmIqZrbO9YdiZFrl6U8ndVQtz2dLBeSq8KIMu99x1+7Nd
 Vd/Nm0pdvPmQHdVzdjzkPYNIIYvdw1uY2SRzxGCojRD8ksUum8bwM+edAi+MHSwiMYdw
 6ygjaQ9NGVKxncFZO0jizUO1ioIrkOuB5D+Iu1wRcXvRxca8XXKGVjshmb+InGBriSsR
 CZ2QNnYj0syl78LAbvn9CLp64aixJeHQFeISfra3IbH39MwvmBu22lL7BeCBoa1p/5L1
 Gz5zB/eC+wGg9wHGRsyG1+I1MlarXnLID19ipzj+v4oOGuJSDtrDnMNSxoZOBfys4/lV
 9nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wF+bGbEnfshWxsJ/yf4Ch6hkzE9gZQxmulbsomoxE0g=;
 b=Z53ACalC2bFFpEA35OKdsBH6SQBnomnj6c5nHJVUZwrAdph4Ill7ED4SehtTT0IeWf
 ajV0PTcMgpEUdgg4W0Lmiy91GhO1wWoaK/V+VXB2f6feFxAsEmn5BkbJ34rwtM+RBlPj
 ROY6LY5apuLdDNbAhUlcTLjuzFzAkfzPiMW55JF7qHSmliEmRdsta0LcNonhR7Aic+3B
 /1c9Pp7GYqskQy3YfmBGsrW+7VN1JbOzru62ykD7orMKgvWJH1A8xxVZpw9IpVDjGe0j
 bZvMe2ZR93rWBNsg/r8RQVwrWlM7R5XmhTEW8nglVuPMdqLx58qq4eb3KSvj+79ANdg0
 IomQ==
X-Gm-Message-State: AOAM533r48I52AOZGlUHBvSTntBoe/rR+cVNIrmeQQTXhisjBiO96yY5
 FRP0AFkdbcHiI8g5YkjA308qb9jocINmwQ==
X-Google-Smtp-Source: ABdhPJyFqkSmRND8gX+c3M1vSN6bf/Y2SHb1UO+BQGVgy24vrQRSaEfDckFSq7ciRZWWu2Y5vmORKw==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr27580766wrr.20.1592215335464; 
 Mon, 15 Jun 2020 03:02:15 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id g19sm21122757wmh.29.2020.06.15.03.02.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 03:02:14 -0700 (PDT)
From: konrad@adacore.com
X-Google-Original-From: frederic.konrad@adacore.com
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] semihosting: don't send the trailing '\0'
Date: Mon, 15 Jun 2020 12:00:52 +0200
Message-Id: <1592215252-26742-2-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
References: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=konrad@adacore.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: philmd@redhat.com, KONRAD Frederic <frederic.konrad@adacore.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Don't send the trailing 0 from the string.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/semihosting/console.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 22e7827..9b4fee9 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -52,7 +52,9 @@ static GString *copy_user_string(CPUArchState *env, target_ulong addr)
 
     do {
         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
-            s = g_string_append_c(s, c);
+            if (c) {
+                s = g_string_append_c(s, c);
+            }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: passed inaccessible address " TARGET_FMT_lx,
-- 
1.8.3.1


