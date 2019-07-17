Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB90C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDDE2182B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBFmTC7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDDE2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnY60-0002YO-Vv
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 20:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hnY5Y-0001g5-16
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hnY5W-0001pj-Sw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:46:31 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hnY5W-0001pW-Mk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:46:30 -0400
Received: by mail-pl1-x641.google.com with SMTP id t14so10968910plr.11
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 17:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=y7FSocOkMHVg4UK5VR546jFApa/3IjN0xth3/ynVktM=;
 b=jBFmTC7P9uml8WriUrIub0rQoyzoinEaCYneySCOTh5GI+AklZf58PZeo4A3lqTGZp
 pPr7KJDKUj8+rJbmxnH55/Bi6CwT8rX0yZZDmbBdQKEO+3jTJW0SDtvmGauM2Cd+Ql62
 I8Fy/gMjz0YlHZKtoOEvWME4g6TDiZ7CoA8r9w63O/tLcJiWbZAD3k6XahiVgc1OENic
 qB1oZiRnrifJYdLAsNqzZPsifUqepwdzZheowIGX2NM+fzkJ4/tfRz5g5xk0SHlZuARm
 ZpmEM3OzhQou731mHvtRn1h8cNd6gd6JCXI1S+DBy1aFXuDVGXuVofon3ByYw1vN3Bk6
 4VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=y7FSocOkMHVg4UK5VR546jFApa/3IjN0xth3/ynVktM=;
 b=jGMxNDALjWPUa8wtlq7MuArQ5cKaOmpkyG5hBH2CmUod0VwbEPqrggP9E68apx2I2h
 rz7p1T1pAfcXCrRGCz23NBUOesTNRWUyoiMOx/xopp8NAAvs4FwEdP+BH1SSLqv1ke+A
 XOZR2PwUZf0yGYffbQRD2N6HBQgUI/6GSly6WenMVqRS7Zk8/lhpMp3mh/S0/xBbupUK
 o7qXah2qijeV0kEs07JRDKrGuHlSFg70QcckCsIDlOz+JTDXiu+udAMU0V9RTVrVUu8N
 /ParORkxAZidlMSzoooIsv2N/ABoG1FtHljI+6wK52VjvChokRXLK5StjneMzeckyZLi
 i4Pw==
X-Gm-Message-State: APjAAAU5xC1yJzVzf7Kj0ICtpbHNp7NCCoxB6GTDJ7LLQpBGBxdmM8U1
 KbRz4+KeRh0nbnKwA+MFrbU=
X-Google-Smtp-Source: APXvYqwoP6+7MVErkrozIlhhfQI80VYrXQFzbRs5mXb36qIYCgdvoKdO5FGFpnuKl9jU4BUpgV44yw==
X-Received: by 2002:a17:902:1003:: with SMTP id
 b3mr39875866pla.172.1563324389858; 
 Tue, 16 Jul 2019 17:46:29 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id e5sm26290303pfd.56.2019.07.16.17.46.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jul 2019 17:46:29 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com, stefanha@gmail.com, pbonzini@redhat.com, fam@euphon.net
Date: Wed, 17 Jul 2019 08:46:06 +0800
Message-Id: <20190717004606.12444-2-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717004606.12444-1-xieyongji@baidu.com>
References: <20190717004606.12444-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 2/2] vhost-user-scsi: Call
 virtio_scsi_common_unrealize() when device realize failed
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

This avoids memory leak when device hotplug is failed.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/scsi/vhost-user-scsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a9fd8ea305..17826ef8e2 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -87,7 +87,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
-        return;
+        goto free_virtio;
     }
 
     vsc->dev.nvqs = 2 + vs->conf.num_queues;
@@ -101,15 +101,23 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     if (ret < 0) {
         error_setg(errp, "vhost-user-scsi: vhost initialization failed: %s",
                    strerror(-ret));
-        vhost_user_cleanup(&s->vhost_user);
-        g_free(vqs);
-        return;
+        goto free_vhost;
     }
 
     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
     vsc->target = vs->conf.boot_tpgt;
+
+    return;
+
+free_vhost:
+    vhost_user_cleanup(&s->vhost_user);
+    g_free(vqs);
+free_virtio:
+    err = NULL;
+    virtio_scsi_common_unrealize(dev, &err);
+    error_propagate(errp, err);
 }
 
 static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
-- 
2.17.1


