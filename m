Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE21C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682752073F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqfQvRZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682752073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsDIK-0007mY-Me
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59617)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsDHe-0007Jf-Ko
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsDHd-0004qZ-Js
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:34:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hsDHd-0004oQ-CB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:34:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so63386422wre.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3I4jA2sDRFUkEhkPZXl6uyUAXLMqFsLByymO+/orOv4=;
 b=VqfQvRZWoa6T//DCafbEVb+ntQYy9VjUi1/v4EwT+85eO0UCB/iDZKDPxM78thFt6e
 EA9nUzM2HvWjMqvOG0EldajmBX4xRVVV89frn4lDCxD64LLgtK21ejnlsgc3CHDTRozX
 5DPqCwZFSerNNTZac2FnmeTqWWHJ4EU4OirW1JD66RI/Fm55v+cruqV28Jjcg/OjTtbv
 EP8efjWZnKWKHjK+7mBHmONfD3f34f+Ee2eR1dQG4xt7X4tYKF3gQBEfQXF62O3wfkWo
 1sTYPuOe+SW+1vRodJx/hinbhdKAHcuXGxyg+B2/O3BYOZrJnqg0zKXfuFC59JtuGHpR
 dRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=3I4jA2sDRFUkEhkPZXl6uyUAXLMqFsLByymO+/orOv4=;
 b=kBREPCbP+xGVhSvbopZbS9a7craq/KxRzi0iQ4aLM0THWEY9IRBnSPI26aWvJvTmA5
 0f/hclc3Bif5eb5+vMWso9PgTdh5xKuE5KMxe9GEfCII+dcMVNUgyflyGW7bRHlI6DGc
 d/YuodDS/00jQTN7rwZRSgVpgWoy2tT6j4MMIFPmWwb5Q0JlL0dx5Eg8FvJF3GN4wB8i
 B8mfvfiMLuG1tZX0AyNHiataKsWm7bk878KAajgy99ylDFY72f1JaiuFUJo63ZyjwZeL
 DEkMrthQFThSSjugdGdyNN5LyH8uXiIO84wLeDRwYCkPfLgyVmkg3lMBeqzvW/mK0MeK
 9G/Q==
X-Gm-Message-State: APjAAAURks389ky67t/ojqjpNs0cePD1ZirLHsFkJ5buDqs39I0DedEh
 DLJc2bX7S4JiTfmmrvpH1+aqWLuGLdQ=
X-Google-Smtp-Source: APXvYqwptaiXD44N+M68U4OYRANVxvHHChqnhjD1zY9Q/c2cIbIE6XQR0J8tUVLCLdhxvrhJcSzAUA==
X-Received: by 2002:a05:6000:1043:: with SMTP id
 c3mr68814531wrx.236.1564436055177; 
 Mon, 29 Jul 2019 14:34:15 -0700 (PDT)
Received: from donizetti.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o7sm51562163wmc.36.2019.07.29.14.34.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 14:34:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 23:34:16 +0200
Message-Id: <20190729213416.1972-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH] dma-helpers: ensure AIO callback is invoked
 after cancellation
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
Cc: John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dma_aio_cancel unschedules the BH if there is one, which corresponds
to the reschedule_dma case of dma_blk_cb.  This can stall the DMA
permanently, because dma_complete will never get invoked and therefore
nobody will ever invoke the original AIO callback in dbs->common.cb.

Fix this by invoking the callback (which is ensured to happen after
a bdrv_aio_cancel_async, or done manually in the dbs->bh case), and
add assertions to check that the DMA state machine is indeed waiting
for dma_complete or reschedule_dma, but never both.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 dma-helpers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d..d3871dc 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -90,6 +90,7 @@ static void reschedule_dma(void *opaque)
 {
     DMAAIOCB *dbs = (DMAAIOCB *)opaque;
 
+    assert(!dbs->acb && dbs->bh);
     qemu_bh_delete(dbs->bh);
     dbs->bh = NULL;
     dma_blk_cb(dbs, 0);
@@ -111,15 +112,12 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
 {
     trace_dma_complete(dbs, ret, dbs->common.cb);
 
+    assert(!dbs->acb && !dbs->bh);
     dma_blk_unmap(dbs);
     if (dbs->common.cb) {
         dbs->common.cb(dbs->common.opaque, ret);
     }
     qemu_iovec_destroy(&dbs->iov);
-    if (dbs->bh) {
-        qemu_bh_delete(dbs->bh);
-        dbs->bh = NULL;
-    }
     qemu_aio_unref(dbs);
 }
 
@@ -179,14 +177,21 @@ static void dma_aio_cancel(BlockAIOCB *acb)
 
     trace_dma_aio_cancel(dbs);
 
+    assert(!(dbs->acb && dbs->bh));
     if (dbs->acb) {
+        /* This will invoke dma_blk_cb.  */
         blk_aio_cancel_async(dbs->acb);
+        return;
     }
+
     if (dbs->bh) {
         cpu_unregister_map_client(dbs->bh);
         qemu_bh_delete(dbs->bh);
         dbs->bh = NULL;
     }
+    if (dbs->common.cb) {
+        dbs->common.cb(dbs->common.opaque, -ECANCELED);
+    }
 }
 
 static AioContext *dma_get_aio_context(BlockAIOCB *acb)
-- 
1.8.3.1


