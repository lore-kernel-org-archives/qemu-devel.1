Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0CFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB5720663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHSPHQjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB5720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAOZ-00026e-Np
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKZ-0003GA-V0
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:32 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKY-0006GA-NT
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id t16so4573855plo.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hhjHkZsuPQqpn5j1/wPu9TPYOQurYS1uCjZTE9jPves=;
 b=WHSPHQjyqPfkzx7W+A894tHes/HkqL5TUFS5Hj6vTkvKkXpW9L4MW55REOjg5JhSWk
 SdOcmNelEvU5zmmI0Y1wmOsFg3HijE7su3DitGIbdPwBdfyfUWc1n4Qfkco4B9WOHOkM
 /oZjjHwdzYqWBU3+SRAGvK9cgZlRLQjBuvQfs0bbAPKeclO5CutnSS89wJcQy76miFxb
 mnvlzxOnJ8HZylKa9IKqRbMj4R53lVBWz/0aBENrJeGdfGSJeY2S8M4H0vl1NB+Z1v/j
 CvrUsoqfLMuutzahVqHsyjKggQnPqI84rX0FeMHeCbLWgRnqU4DT26BimQ18ol9qPAV1
 tM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hhjHkZsuPQqpn5j1/wPu9TPYOQurYS1uCjZTE9jPves=;
 b=hBxtymA0m1tZcVScZylq9HviVBjiGjRXPI6Vw3L98hcYJlJbVmJRhXfugf+ZnzxOzO
 hNOQTBjKNBUK6BXw8qLqCcJ7yZ4GXicBIPif6kqg71Vs0tCGct8FvN3QNF+CSE4slR1p
 wUqyy+VBONY7ugW2f2d08kUQN8fkA3xNWr8hhR2HE66P0U3IdZOSfz/Ezp3xvrLkQ75M
 x1g6tNZIdieyONuaS9R5GtezAfFrW7TQJAchYc2/k+7M7eQ/lkjB9QLnDCxWKsXWzrqi
 beoYSoN/5+2WNoTtKA301WtqLxiHarDPa96T+A+XjZtPXnkvPexoEl2KFPNvKqYDW8yG
 pUiw==
X-Gm-Message-State: AOAM532bcjs+5znm3j9GlfwDScKiSfdzV4HzfxcKqnNgBGYPyrfLgc8k
 0NpiE6W9qWCIlZ0tPyIu/6HbhdEO4bF75Q==
X-Google-Smtp-Source: ABdhPJxS6O5pF1E7y2oFN4vEouVrNICucVS+qcpof41rMFRCukUh1HQqPbDyCANC34mHd/M2XSUBlg==
X-Received: by 2002:a17:90a:1217:: with SMTP id
 f23mr5114019pja.150.1590164127476; 
 Fri, 22 May 2020 09:15:27 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:26 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/19] util/async: Fixed tsan warnings
Date: Fri, 22 May 2020 12:07:50 -0400
Message-Id: <20200522160755.886-15-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: Fam Zheng <fam@euphon.net>, robert.foley@linaro.org, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For example:
  Atomic write of size 8 at 0x7b4800113c28 by main thread (mutexes: write M30):
    #0 __tsan_atomic64_exchange <null> (qemu-system-aarch64+0x386f85)
    #1 aio_bh_poll util/async.c:146:5 (qemu-system-aarch64+0xcd1f61)
    #2 aio_dispatch util/aio-posix.c:380:5 (qemu-system-aarch64+0xcd8abb)
    #3 aio_ctx_dispatch util/async.c:298:5 (qemu-system-aarch64+0xcd31b0)
    #4 g_main_context_dispatch <null> (libglib-2.0.so.0+0x4c416)
    #5 qemu_main_loop softmmu/vl.c:1664:9 (qemu-system-aarch64+0x5cc6d6)
    #6 main softmmu/main.c:49:5 (qemu-system-aarch64+0xc62857)

  Previous read of size 8 at 0x7b4800113c28 by thread T3 (mutexes: write M81):
    #0 aio_bh_enqueue util/async.c:81:9 (qemu-system-aarch64+0xcd2267)
    #1 qemu_bh_schedule util/async.c:181:5 (qemu-system-aarch64+0xcd2267)
    #2 worker_thread util/thread-pool.c:113:9 (qemu-system-aarch64+0xcd473c)
    #3 qemu_thread_start util/qemu-thread-posix.c:519:9 (qemu-system-aarch64+0xcde280)

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/async.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/util/async.c b/util/async.c
index 1319eee3bc..51e306bf0c 100644
--- a/util/async.c
+++ b/util/async.c
@@ -33,6 +33,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine_int.h"
 #include "trace.h"
+#include "qemu/tsan.h"
 
 /***********************************************************/
 /* bottom halves (can be seen as timers which expire ASAP) */
@@ -76,10 +77,12 @@ static void aio_bh_enqueue(QEMUBH *bh, unsigned new_flags)
      * 2. ctx is loaded before the callback has a chance to execute and bh
      *    could be freed.
      */
+    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
     old_flags = atomic_fetch_or(&bh->flags, BH_PENDING | new_flags);
     if (!(old_flags & BH_PENDING)) {
         QSLIST_INSERT_HEAD_ATOMIC(&ctx->bh_list, bh, next);
     }
+    TSAN_ANNOTATE_IGNORE_WRITES_END();
 
     aio_notify(ctx);
 }
@@ -143,7 +146,9 @@ int aio_bh_poll(AioContext *ctx)
     BHListSlice *s;
     int ret = 0;
 
+    TSAN_ANNOTATE_IGNORE_WRITES_BEGIN();
     QSLIST_MOVE_ATOMIC(&slice.bh_list, &ctx->bh_list);
+    TSAN_ANNOTATE_IGNORE_WRITES_END();
     QSIMPLEQ_INSERT_TAIL(&ctx->bh_slice_list, &slice, next);
 
     while ((s = QSIMPLEQ_FIRST(&ctx->bh_slice_list))) {
@@ -280,14 +285,16 @@ aio_ctx_check(GSource *source)
     aio_notify_accept(ctx);
 
     QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
-        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+        if ((atomic_read(&bh->flags) & (BH_SCHEDULED | BH_DELETED))
+             == BH_SCHEDULED) {
             return true;
         }
     }
 
     QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
         QSLIST_FOREACH_RCU(bh, &s->bh_list, next) {
-            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+            if ((atomic_read(&bh->flags) & (BH_SCHEDULED | BH_DELETED))
+                 == BH_SCHEDULED) {
                 return true;
             }
         }
-- 
2.17.1


