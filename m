Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06442C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F0D20665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePb5m9dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F0D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwu4-0005B4-RL
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMI-0005Iv-MA; Thu, 03 Sep 2020 17:01:26 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:37276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMG-0007vO-LQ; Thu, 03 Sep 2020 17:01:26 -0400
Received: by mail-ot1-x333.google.com with SMTP id 37so4025703oto.4;
 Thu, 03 Sep 2020 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JAH928Qnnsu2tDkDklCgu+9iEjldTCiX63xa+JPkWRQ=;
 b=ePb5m9dlRBPpA2JY/NHJt/ygzSjENB1Tptyn6Y1auHksrimzBwICqB57RaMQm8E9Bq
 qalsYwEHSvlESi4ZIAbgeG2m5OzB+JY3e625b7KZvLgrXY2A6/QoTbYSKG6h0uHzHcXR
 8vDkBBOCtS0kNoDCDkcGMXRssdnvqsMONzrnSSRONFO/e1tVYOaS+z/60SIMKIgTyB2v
 /UG+YOmwUNl/DfhbTfNwORHKM/g0Xb9a7Swd3Y/c2DtIRcKVsSAwIQDztgsJNRPmtWOu
 E9VOcZa6W4jL+kINcrhbyLUh3iQVNSc1I4oAF5FPJsFhNLuGMyNASxjKb8MjFC2a8Xss
 6dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=JAH928Qnnsu2tDkDklCgu+9iEjldTCiX63xa+JPkWRQ=;
 b=GlXLr2ijMauHpzw4/zSqYS1IUvQYF2/nywmurrGoopTTVWa3prPjxGUzw/iaqkFnTa
 NSSImx9Qd0q3CwEY6a+HdW1vkupS+KPR6KbHyaIKVCtJlmPsClGeQkVrYlmzCppSYR0U
 972Hw3YLXzImCZ1L5ntboV0uhtXncutwROLc1Q2Umk4tCoY7S7aChK6hIFlXZFS6rFnf
 XaXsht92c2koXPRGdVQhRXSW11W/5JXfOzjGeZR+InYJnstMm5X9e3cTmmcwNAAl0ww2
 racIxoYeZHWuLfuJ/oQ03vFgb6UrifDQDIkChm38zWMkZy6NlulCkIQMx1ucd5GclRj7
 A8OA==
X-Gm-Message-State: AOAM5313+ixlZseq6LzarKI0i3Jq3JXztkY8EXfdZP2J/RVIRsCgan8T
 5EG76I9w+wqaHsMmPCmyDX4Eu3ihUIaPGg==
X-Google-Smtp-Source: ABdhPJzHOzj28XTF1ohpba1t7iotP8fR1XnvsjUuRryK87lOOZHSE28M9mgP3tgxTy1pBTGCW7X2uQ==
X-Received: by 2002:a9d:6f05:: with SMTP id n5mr3219530otq.346.1599166882786; 
 Thu, 03 Sep 2020 14:01:22 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id q15sm830950ooh.44.2020.09.03.14.01.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:22 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 74/77] nbd: Fix large trim/zero requests
Date: Thu,  3 Sep 2020 15:59:32 -0500
Message-Id: <20200903205935.27832-75-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x333.google.com
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

Although qemu as NBD client limits requests to <2G, the NBD protocol
allows clients to send requests almost all the way up to 4G.  But
because our block layer is not yet 64-bit clean, we accidentally wrap
such requests into a negative size, and fail with EIO instead of
performing the intended operation.

The bug is visible in modern systems with something as simple as:

$ qemu-img create -f qcow2 /tmp/image.img 5G
$ sudo qemu-nbd --connect=/dev/nbd0 /tmp/image.img
$ sudo blkdiscard /dev/nbd0

or with user-space only:

$ truncate --size=3G file
$ qemu-nbd -f raw file
$ nbdsh -u nbd://localhost:10809 -c 'h.trim(3*1024*1024*1024,0)'

Although both blk_co_pdiscard and blk_pwrite_zeroes currently return 0
on success, this is also a good time to fix our code to a more robust
paradigm that treats all non-negative values as success.

Alas, our iotests do not currently make it easy to add external
dependencies on blkdiscard or nbdsh, so we have to rely on manual
testing for now.

This patch can be reverted when we later improve the overall block
layer to be 64-bit clean, but for now, a minimal fix was deemed less
risky prior to release.

CC: qemu-stable@nongnu.org
Fixes: 1f4d6d18ed
Fixes: 1c6c4bb7f0
Fixes: https://github.com/systemd/systemd/issues/16242
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200722212231.535072-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: rework success tests to use >=0]
(cherry picked from commit 890cbccb089db9e646cc1baea3be9dc060e3917b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 20754e9ebc..0918173c1b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2365,8 +2365,17 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
             flags |= BDRV_REQ_NO_FALLBACK;
         }
-        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
-                                request->len, flags);
+        ret = 0;
+        /* FIXME simplify this when blk_pwrite_zeroes switches to 64-bit */
+        while (ret >= 0 && request->len) {
+            int align = client->check_align ?: 1;
+            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                                        align));
+            ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
+                                    len, flags);
+            request->len -= len;
+            request->from += len;
+        }
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "writing to file failed", errp);
 
@@ -2380,9 +2389,18 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "flush failed", errp);
 
     case NBD_CMD_TRIM:
-        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
-                              request->len);
-        if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {
+        ret = 0;
+        /* FIXME simplify this when blk_co_pdiscard switches to 64-bit */
+        while (ret >= 0 && request->len) {
+            int align = client->check_align ?: 1;
+            int len = MIN(request->len, QEMU_ALIGN_DOWN(BDRV_REQUEST_MAX_BYTES,
+                                                        align));
+            ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
+                                  len);
+            request->len -= len;
+            request->from += len;
+        }
+        if (ret >= 0 && request->flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->blk);
         }
         return nbd_send_generic_reply(client, request->handle, ret,
-- 
2.17.1


