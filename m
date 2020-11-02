Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0911FC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6300821D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE56dLe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6300821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZW5E-0001rf-8f
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZW43-0000zI-IQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZW41-0005xl-SR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604309025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oqaCBtiyHyraZrQbnp3YwL6DATj7zhKDy6uE+R2EKuw=;
 b=FE56dLe664FR5jlfxK+WwuKuuuACnECnw5YhW4v3zDEv8uLWXkiMp0yPFEJlFR72e1xh2v
 IKqRti0f4qNT6GQodiFYT7AkFan2aJXvwrC5dKbZvDySNZWD7ruxu8NX+98YFJOsc8pxWh
 19xIeN4UUtbPPmVe/A+kGN3BJvhv/9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-vO9xmQBBM16jbI8M3O9oUw-1; Mon, 02 Nov 2020 04:23:43 -0500
X-MC-Unique: vO9xmQBBM16jbI8M3O9oUw-1
Received: by mail-wr1-f72.google.com with SMTP id n14so6182143wrp.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 01:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqaCBtiyHyraZrQbnp3YwL6DATj7zhKDy6uE+R2EKuw=;
 b=Ufn9ebJNyqHifA5R2H5pzAb9bLvOoYUpRik5g6fs9OrEhI4NTdNMqY1zHC8IstVt9M
 EPQlKsIGXUSNpChGvZgrTbPsNlx0A9oYFShKwhNqRCFPkMMe4rx+rRMQcc0zM6H+7ykF
 1qY2Z+YBYRpGNI3qUoVjkV2n95D8qoLte03FDbDLSdSZl4PdEFvnTGPzclFZHbguO73y
 quQYymKJGVNRIwskLoopHKDLKpJaFeJVdTWfpx0OKH5/aT4sdj3ua0Bh7RU+QvwRE4XX
 eGMs/p6SkItoG5zk5y0PSq5GuJ16tgLUmPTH16psOelu6Q1npgGxMwSIVOs6rNYYLSJi
 arDQ==
X-Gm-Message-State: AOAM533Aqubl3YtaDNmOVbojSEpG2BfsnO3QNe/TJkCRWpVKUXVcb9ko
 N7cyZ8wZ2lOKHPyyTWrtqpeV0KnAztce0ImqB++6b348Jr6LKDyd58eCjJLIB4utB8y2LCISeRT
 zV8UKSV7XpUhfpfY=
X-Received: by 2002:a7b:c957:: with SMTP id i23mr17275131wml.155.1604309022055; 
 Mon, 02 Nov 2020 01:23:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyk+QDyNpG9dTaMZWy9y7bOQsX/Fs8KwApcQ2y4Nep/+DGI2aKxQqqzql7YYHH2+tbtT9EIQ==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr17275102wml.155.1604309021883; 
 Mon, 02 Nov 2020 01:23:41 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e25sm22320755wra.71.2020.11.02.01.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 01:23:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2] tools/virtiofsd: Check vu_init() return value (CID
 1435958)
Date: Mon,  2 Nov 2020 10:23:39 +0100
Message-Id: <20201102092339.2034297-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 6f5fd837889, vu_init() can fail if malloc() returns NULL.

This fixes the following Coverity warning:

  CID 1435958 (#1 of 1): Unchecked return value (CHECKED_RETURN)

Fixes: 6f5fd837889 ("libvhost-user: support many virtqueues")
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Add fuse_log()
---
 tools/virtiofsd/fuse_virtio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 324936948d3..83ba07c6cd8 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -1013,8 +1013,11 @@ int virtio_session_mount(struct fuse_session *se)
     se->vu_socketfd = data_sock;
     se->virtio_dev->se = se;
     pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
-    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
-            fv_set_watch, fv_remove_watch, &fv_iface);
+    if (!vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
+                 fv_set_watch, fv_remove_watch, &fv_iface)) {
+        fuse_log(FUSE_LOG_ERR, "%s: vu_init failed\n", __func__);
+        return -1;
+    }
 
     return 0;
 }
-- 
2.26.2


