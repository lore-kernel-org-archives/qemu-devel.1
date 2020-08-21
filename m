Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C69EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD03820724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFXNIgwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD03820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DBO-0006UR-VJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D85-00085j-94
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:55:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D82-0002nN-Qd
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QkeIEuTWWrDAk5fgLztw4p0UNTKf91orUMJW2LVbIY=;
 b=HFXNIgwNdhxxot8bqmav4vf0xzOJlkGpDrLbCN70GHEELVOU4suDOJQAcmnxIJ79l2NO0j
 i7inN8G4GdsHnhcofSWSm5qMubeBWXwLTKK/DdkCEH/BB2K8Fkde9tUtwohC3yMz/ctvFX
 0tGXwCW1PWXvglKQ2smYgMkkjuSekzU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-bXcHSh7tMnOjHvcpF9y6xg-1; Fri, 21 Aug 2020 15:55:06 -0400
X-MC-Unique: bXcHSh7tMnOjHvcpF9y6xg-1
Received: by mail-wm1-f71.google.com with SMTP id k204so1375559wmb.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4QkeIEuTWWrDAk5fgLztw4p0UNTKf91orUMJW2LVbIY=;
 b=DUSUO9hX2kIY7Vq3mgnIhk5EBKU5B08j72dlejLrTPEyDzfiNjYCXQjHgQkzYe9aby
 au0EhY2XUFEKSmLRFnuRpJkntrHMjTnqY3zmvamBJrIlpNuAiCI/AY7c0ue3w3DVFviz
 Ju6/RR5kjmvGUQNYhfbjz5jduAX7+IT1kXoUm5QMYPBfDsdxAQx44yeoP8KXXM1EUFAs
 hDogS+w5JvIT7mOQoMOr8wZQ0ienNDkoYlTCjR3aA+tLzUILnzpdcqVW1tgLCqw/u6PD
 C1QaARJcogffV0zldy49Xdx45miiU09yFLH+8wJ9uMXYo63uHoSjQ5OmDsp5Vov9MPiz
 qNbw==
X-Gm-Message-State: AOAM531+jvZm2xPyW1T3bNobJ9A0tq5h5JLCss4NoEUsHPjbIQcfbwNi
 tl2ydIfJ00QT11d/8UM5GvGE6gLzIOImzjxOpeplk0WgysthVWCsmRcQFuhQ+6pl60hY/CVSJRA
 d2X/zsOVHqSQ7xz4=
X-Received: by 2002:a5d:4241:: with SMTP id s1mr4065586wrr.411.1598039704635; 
 Fri, 21 Aug 2020 12:55:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMpajGP4WqfXOkZJv+j1i7lAsCAEl2/lVIVd6XTuoWAbxhQbxnoz07ynKNkJ1+tBrnBVAeeQ==
X-Received: by 2002:a5d:4241:: with SMTP id s1mr4065564wrr.411.1598039704477; 
 Fri, 21 Aug 2020 12:55:04 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z12sm6514659wrp.20.2020.08.21.12.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:55:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/15] block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
Date: Fri, 21 Aug 2020 21:53:56 +0200
Message-Id: <20200821195359.1285345-13-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BDRV_POLL_WHILE() is defined as:

  #define BDRV_POLL_WHILE(bs, cond) ({          \
      BlockDriverState *bs_ = (bs);             \
      AIO_WAIT_WHILE(bdrv_get_aio_context(bs_), \
                     cond); })

As we will remove the BlockDriverState use in the next commit,
start by using the exploded version of BDRV_POLL_WHILE().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index f98ca067144..3d49ff81fb7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -493,6 +493,7 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
 static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
                          NvmeCmd *cmd)
 {
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     NVMeRequest *req;
     int ret = -EINPROGRESS;
     req = nvme_get_free_req(q);
@@ -501,7 +502,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     }
     nvme_submit_command(q, req, cmd, nvme_cmd_sync_cb, &ret);
 
-    BDRV_POLL_WHILE(bs, ret == -EINPROGRESS);
+    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
     return ret;
 }
 
-- 
2.26.2


