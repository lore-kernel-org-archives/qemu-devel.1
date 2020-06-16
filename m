Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3297C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AE520644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5YcdSOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AE520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD48-0004Zx-Oo
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQw-00045w-IQ; Tue, 16 Jun 2020 10:19:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQu-00071L-TC; Tue, 16 Jun 2020 10:19:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id d4so1648087otk.2;
 Tue, 16 Jun 2020 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0W0U9RIkePSj9Jq4sCO7/r+zLbHnoVoeB2KaUJc1NS0=;
 b=L5YcdSOGCBcxZXhl6BndtVQeFb0fyaoVcGj5oxw0hveK8Aq3qp2+yJyrU/QK99Zuvo
 3lT/4W245O8ySku38U5Lk9FILgJ1mPwADQzv0MimOqWDq/jlBV26nlJubKHmHa1hTKE4
 /xn7I+D1aKNKGvz/NoMRyoV1jzBLYwP/BTmX0QYl+oQUiobt22OSgzfVhjnjWWeNVG5+
 +oie0owTb7L4vbb7ETTLeR3cVryVfzVUTvk0TAIAh5+mbV+KRDoskUq0nqHgfE+tj3No
 9T7sF2zOQv44DsL3KXd7evUoVg2FSIY6B4NLJCqvRCg1ESkD7Mkepu0w/H188XMHVx9t
 iBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=0W0U9RIkePSj9Jq4sCO7/r+zLbHnoVoeB2KaUJc1NS0=;
 b=VZCDoaGjcWcTuIDlmD1Ni3gatDJ7plZgE6hSp6esO76HaI+465tyhNcZCfugjBMj74
 sl2KrIBJQ3QWG4oRxjC3U2CrGnhXFj+22z3C/dvZ3ClrVh8z7u8sS+NIdOEtwidz7OCj
 2tgDhWH/a16DEXQrpxF3p7uC0OtlydkbIyJr1vFDqSQL4lGtDpOMavx/6VANJwLp+8bE
 6VBAc6XU6ISpfZ+R21k/wn8Ny+9cIVp7/g67V3NRxt5t8eXTwtuwOmnK4ORx0q+RRlsc
 p/Yqbf3ENs4T6Vuwe1kGEGY301FYnGCU709Z+T4WQjR+6su8sH55bqBHXSFEuJd3uDlj
 UBJw==
X-Gm-Message-State: AOAM530DbJK0nqEMnX5PTKBN9iDC6wXRwxco6HP5yUb1t2FqvXUmK/vw
 /QjuBojqqwnw/yXVErjrU4GvtcJ1
X-Google-Smtp-Source: ABdhPJwmbdYCQwbFIvhqzNHp68Pnep1DyDRxvz2D1FGXG+yuP/VDLWv32JPhNerC9AudUR8XlXG3KA==
X-Received: by 2002:a9d:2d88:: with SMTP id g8mr2411808otb.149.1592317163011; 
 Tue, 16 Jun 2020 07:19:23 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f5sm4049121oou.47.2020.06.16.07.19.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:21 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/78] xen-block: Fix double qlist remove and request leak
Date: Tue, 16 Jun 2020 09:15:35 -0500
Message-Id: <20200616141547.24664-67-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anthony PERARD <anthony.perard@citrix.com>

Commit a31ca6801c02 ("qemu/queue.h: clear linked list pointers on
remove") revealed that a request was removed twice from a list, once
in xen_block_finish_request() and a second time in
xen_block_release_request() when both function are called from
xen_block_complete_aio(). But also, the `requests_inflight' counter is
decreased twice, and thus became negative.

This is a bug that was introduced in bfd0d6366043 ("xen-block: improve
response latency"), where a `finished' list was removed.

That commit also introduced a leak of request in xen_block_do_aio().
That function calls xen_block_finish_request() but the request is
never released after that.

To fix both issue, we do two changes:
- we squash finish_request() and release_request() together as we want
  to remove a request from 'inflight' list to add it to 'freelist'.
- before releasing a request, we need to let the other end know the
  result, thus we should call xen_block_send_response() before
  releasing a request.

The first change fixes the double QLIST_REMOVE() as we remove the extra
call. The second change makes the leak go away because if we want to
call finish_request(), we need to call a function that does all of
finish, send response, and release.

Fixes: bfd0d6366043 ("xen-block: improve response latency")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200406140217.1441858-1-anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul@xen.org>
[mreitz: Amended commit message as per Paul's suggestions]
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 36d883ba0de8a281072ded2b51e0a711fd002139)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/block/dataplane/xen-block.c | 48 ++++++++++++----------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 3b9caeb2fa..c4ed2870ec 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -64,6 +64,8 @@ struct XenBlockDataPlane {
     AioContext *ctx;
 };
 
+static int xen_block_send_response(XenBlockRequest *request);
+
 static void reset_request(XenBlockRequest *request)
 {
     memset(&request->req, 0, sizeof(request->req));
@@ -115,23 +117,26 @@ out:
     return request;
 }
 
-static void xen_block_finish_request(XenBlockRequest *request)
+static void xen_block_complete_request(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane = request->dataplane;
 
-    QLIST_REMOVE(request, list);
-    dataplane->requests_inflight--;
-}
+    if (xen_block_send_response(request)) {
+        Error *local_err = NULL;
 
-static void xen_block_release_request(XenBlockRequest *request)
-{
-    XenBlockDataPlane *dataplane = request->dataplane;
+        xen_device_notify_event_channel(dataplane->xendev,
+                                        dataplane->event_channel,
+                                        &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
 
     QLIST_REMOVE(request, list);
+    dataplane->requests_inflight--;
     reset_request(request);
     request->dataplane = dataplane;
     QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
-    dataplane->requests_inflight--;
 }
 
 /*
@@ -246,7 +251,6 @@ static int xen_block_copy_request(XenBlockRequest *request)
 }
 
 static int xen_block_do_aio(XenBlockRequest *request);
-static int xen_block_send_response(XenBlockRequest *request);
 
 static void xen_block_complete_aio(void *opaque, int ret)
 {
@@ -286,7 +290,6 @@ static void xen_block_complete_aio(void *opaque, int ret)
     }
 
     request->status = request->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_OKAY;
-    xen_block_finish_request(request);
 
     switch (request->req.operation) {
     case BLKIF_OP_WRITE:
@@ -306,17 +309,8 @@ static void xen_block_complete_aio(void *opaque, int ret)
     default:
         break;
     }
-    if (xen_block_send_response(request)) {
-        Error *local_err = NULL;
 
-        xen_device_notify_event_channel(dataplane->xendev,
-                                        dataplane->event_channel,
-                                        &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-    }
-    xen_block_release_request(request);
+    xen_block_complete_request(request);
 
     if (dataplane->more_work) {
         qemu_bh_schedule(dataplane->bh);
@@ -420,8 +414,8 @@ static int xen_block_do_aio(XenBlockRequest *request)
     return 0;
 
 err:
-    xen_block_finish_request(request);
     request->status = BLKIF_RSP_ERROR;
+    xen_block_complete_request(request);
     return -1;
 }
 
@@ -575,17 +569,7 @@ static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
                 break;
             };
 
-            if (xen_block_send_response(request)) {
-                Error *local_err = NULL;
-
-                xen_device_notify_event_channel(dataplane->xendev,
-                                                dataplane->event_channel,
-                                                &local_err);
-                if (local_err) {
-                    error_report_err(local_err);
-                }
-            }
-            xen_block_release_request(request);
+            xen_block_complete_request(request);
             continue;
         }
 
-- 
2.17.1


