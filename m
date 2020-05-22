Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFA8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CF52070A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4htgXC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CF52070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcARW-0008OW-MF
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKd-0003Q8-KO
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:35 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKb-0006Hv-9G
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:35 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a5so5132886pjh.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=diIOPIiuRLIcEaQmwzzlKokyZy0yKGmGdNzT1yctxLA=;
 b=y4htgXC0XqAXfehtDZQyLI9kx5BTzgc4CTGWxcPXdh5B0UA+GPS1ORWRLQyFPk/lO+
 TnKu76KLNbHbLTK0McGA3WrmyD/dilSsefEJjCSzk4SJUxPf5803dOQx1bIbgn8TS1PI
 MRz5pZv8tZev+gcRlNm3vX7/zntQmNBvTFhr6RsDswnQ/JW/AWORUhVEYFT3O6Lz3uwQ
 JA/WM+99857+4onUrQD16AxqoEClH/W8l/KpZf34uoLXKhe8x5yCaCKhBxAhjzovsL9f
 djQJSYRJKmikgS6u765pkXlJusu1Q3sA3gB2KM5iPrQvy41MMtkb3OAGm3W9q9FaZfoz
 s0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=diIOPIiuRLIcEaQmwzzlKokyZy0yKGmGdNzT1yctxLA=;
 b=rsUr/23n8bmhOb3ESYKV0FJ1php01nrIF+30PdbxXNqVD7HTev5pZZordgkg4FUFEH
 JKc5dMdFX8fXNoZstW0SCy4EAzQQMTu2AN6Adg7FiCepIPw5WAZmfZ+X1N62VbD04Ngn
 raZRVKB4QmguR08Ivy4vvid8F465uldVJ0uPNIfvkK87bGwjqpTJj8afcGfVOGBmg69L
 p0kL0ZpcFtzR9nBcoxQmvUFFQqVnH9wW+W+iqikgMOsDMGygfDRCcVqME0i2qLTs77gi
 CgyebGvhBwuk5EEvRyUjEZBVue7q3YBjpVh1v9z+esSRxs0n2c7yV133x6Dmd29QVJfB
 ip6g==
X-Gm-Message-State: AOAM5300UhWdhz9gmXklsz1NilzG2y6QjP3dPfB4RVU4obXDHLtY/K6F
 rqKlmETUSh2I4YqwdVDlXhGN8rbgrxZB1Q==
X-Google-Smtp-Source: ABdhPJzJNjSu3apx5VFMvsRSRbtiGOv0+yhJ38PtdCJlBmLFO9eYQhVMNPtyCBnn8NIKHqg6ZPYwFg==
X-Received: by 2002:a17:90b:1082:: with SMTP id
 gj2mr5610647pjb.225.1590164131706; 
 Fri, 22 May 2020 09:15:31 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:31 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/19] util: fixed tsan warnings in thread_pool.c
Date: Fri, 22 May 2020 12:07:52 -0400
Message-Id: <20200522160755.886-17-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For example:
WARNING: ThreadSanitizer: data race (pid=14665)
  Write of size 4 at 0x7b1c00007890 by thread T99:
    #0 worker_thread util/thread-pool.c:112:20 (qemu-system-aarch64+0xd52108)
    #1 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xd5be30)

  Previous read of size 4 at 0x7b1c00007890 by main thread (mutexes: write M875, write M897):
    #0 thread_pool_completion_bh util/thread-pool.c:177:19 (qemu-system-aarch64+0xd51a73)
    #1 aio_bh_call util/async.c:136:5 (qemu-system-aarch64+0xd4f98e)
    #2 aio_bh_poll util/async.c:164:13 (qemu-system-aarch64+0xd4f98e)

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/thread-pool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index d763cea505..2403669827 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
+#include "qemu/tsan.h"
 
 static void do_spawn_thread(ThreadPool *pool);
 
@@ -97,7 +98,9 @@ static void *worker_thread(void *opaque)
         }
 
         req = QTAILQ_FIRST(&pool->request_list);
+        TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
         QTAILQ_REMOVE(&pool->request_list, req, reqs);
+
         req->state = THREAD_ACTIVE;
         qemu_mutex_unlock(&pool->lock);
 
@@ -107,7 +110,7 @@ static void *worker_thread(void *opaque)
         /* Write ret before state.  */
         smp_wmb();
         req->state = THREAD_DONE;
-
+        TSAN_ANNOTATE_IGNORE_WRITES_END();
         qemu_mutex_lock(&pool->lock);
 
         qemu_bh_schedule(pool->completion_bh);
-- 
2.17.1


