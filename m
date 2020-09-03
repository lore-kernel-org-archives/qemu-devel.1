Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA53C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B83C206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDCvC9jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B83C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwo1-0002Y4-Ap
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL9-0003nF-RX; Thu, 03 Sep 2020 17:00:15 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:34286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL7-0007RQ-9M; Thu, 03 Sep 2020 17:00:15 -0400
Received: by mail-oo1-xc43.google.com with SMTP id k63so1134591oob.1;
 Thu, 03 Sep 2020 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G4FtznJiI3bIZt9XXorrUG/m7EUVyV0wnG1XwMDDxC8=;
 b=tDCvC9jpTzxhbzzF3UA4RaxA2NnpMC9rhgAdfeUV9aIeNNUWhhXBm8DiMY+OGsZwQl
 KQHfh+IwV+5DJ7o92Al0B5n5x8z5I4uFqlu+6AbmthVS486gV1jBcv6PtXsCKS/Qr6rp
 U1olNh6pBi5xH/6zfT8MpI2Sb/yv11NkAwrzCASrzE00oKplfFDe0zvC0hwwKCIepmc6
 SmjdbbhMl2YEEG1CDrrOOewKR652KoF2d8n4t7ije+Hg++X9AR3eij+7lGpR4jWeupeV
 bSj+C9Vq6JYREN8eBTaXTYjP7/udt/XX7DS59eKPNqqsHSpYl8md7t3077+gQNYlFCxw
 EL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=G4FtznJiI3bIZt9XXorrUG/m7EUVyV0wnG1XwMDDxC8=;
 b=ZczYajC1InT7At7m3Xw6r28fyVYSQ3T5YFSzyvS5MWas0TruwdHIEYnC+7NhXJPAza
 y0oKaodOUknQj3Plbd2G858modWmMkD/DTE2vEt2i8q6TTXFIAd6CQl4ehQnFQ9XYDbO
 Ggu0C85IcR8+yxMTwwln6C+WSLzDwZbURP59/dUQgk2yIFyCMC3nltpCzbabPaqLkANg
 qxY1PwNYVdKFsvs5z5D8ePAN519d13P2HOHtsvt0RRU9oxxJQN5M51dP0S+/rdtP7IVB
 kNdJFTeHhNyTIMSunzdcKeu6iQrD6KFNba8apBLxNJ87w9MlsJDre5xS0SOD9SyflGJ0
 kirA==
X-Gm-Message-State: AOAM530GMHPYIUu1GHAfJQuHyOWR6XPidx7mIs77i3RYt/HUNXbwRbwG
 Nf+eK9cwKYk0UsiSdatziHCaMuj8kio=
X-Google-Smtp-Source: ABdhPJz3XtAG4yS2UyPAD2NPlOM3Exkq9aY9AfN0Rsrnfwa3uFU3uEicz0IPBkPaaPHqvxqqprHEZQ==
X-Received: by 2002:a4a:bb05:: with SMTP id f5mr3354000oop.5.1599166811194;
 Thu, 03 Sep 2020 14:00:11 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id k18sm766595otj.55.2020.09.03.14.00.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:10 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/77] aio-posix: don't duplicate fd handler deletion in
 fdmon_io_uring_destroy()
Date: Thu,  3 Sep 2020 15:58:42 -0500
Message-Id: <20200903205935.27832-25-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The io_uring file descriptor monitoring implementation has an internal
list of fd handlers that are pending submission to io_uring.
fdmon_io_uring_destroy() deletes all fd handlers on the list.

Don't delete fd handlers directly in fdmon_io_uring_destroy() for two
reasons:
1. This duplicates the aio-posix.c AioHandler deletion code and could
   become outdated if the struct changes.
2. Only handlers with the FDMON_IO_URING_REMOVE flag set are safe to
   remove. If the flag is not set then something still has a pointer to
   the fd handler. Let aio-posix.c and its user worry about that. In
   practice this isn't an issue because fdmon_io_uring_destroy() is only
   called when shutting down so all users have removed their fd
   handlers, but the next patch will need this!

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>
Message-id: 20200511183630.279750-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit de137e44f75d9868f5b548638081850f6ac771f2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 util/aio-posix.c      |  1 +
 util/fdmon-io_uring.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index c3613d299e..8af334ab19 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -679,6 +679,7 @@ void aio_context_destroy(AioContext *ctx)
 {
     fdmon_io_uring_destroy(ctx);
     fdmon_epoll_disable(ctx);
+    aio_free_deleted_handlers(ctx);
 }
 
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index d5a80ed6fb..1d14177df0 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -342,11 +342,18 @@ void fdmon_io_uring_destroy(AioContext *ctx)
 
         io_uring_queue_exit(&ctx->fdmon_io_uring);
 
-        /* No need to submit these anymore, just free them. */
+        /* Move handlers due to be removed onto the deleted list */
         while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
+            unsigned flags = atomic_fetch_and(&node->flags,
+                    ~(FDMON_IO_URING_PENDING |
+                      FDMON_IO_URING_ADD |
+                      FDMON_IO_URING_REMOVE));
+
+            if (flags & FDMON_IO_URING_REMOVE) {
+                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
+            }
+
             QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
-            QLIST_REMOVE(node, node);
-            g_free(node);
         }
 
         ctx->fdmon_ops = &fdmon_poll_ops;
-- 
2.17.1


