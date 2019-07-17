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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A71C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329342182B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVd5azNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329342182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnY5a-0001fS-2W
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 20:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hnY5Q-0001HI-06
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hnY5P-0001l7-4P
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:46:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hnY5N-0001jm-94
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:46:23 -0400
Received: by mail-pf1-x443.google.com with SMTP id 19so9930176pfa.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 17:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=bKSblPx9MgZD4RtFAKIXTYOFpN5+W8v5wIvWZqdsNl8=;
 b=lVd5azNWDFud+sgga6wbB2HPlW5D7t2POQQDx3gsiR4nbrqwKhqUBeu5sjT/uahoj2
 Wkx4zaCmXGX8hv0gDBxNlEOKSdCMRLbNcP9jmTTwCDjKxG2nEKRGzVfGY5bjDgzraq+I
 O9xQqyldTe2I8XNgUvAFz78BJGlrFy7cblq8p2QYzYmYYq63lcqLVswdXipdFpA9bwF9
 PtQ41+CTW3qx6BaHvSYWYLZ63T6aZV/QfupWGIv+csvNODyFYUUFY4EIU4r1GZa+43K/
 OwyVdTQw5KZfNDlybSt4if+alMdG+bA5uo1k7SiyqJwk68tcBtpJ7KNXGfrb7i6JXUVK
 cSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bKSblPx9MgZD4RtFAKIXTYOFpN5+W8v5wIvWZqdsNl8=;
 b=Ek6+h4EfWT752++SMa7SwxonTD7WhL5+LiVCflrHCSD2AbQNx8+TWjD6MOvBIuYo+Y
 lWoboQfOnhT8ey+Q9lRdQ/xrsHlkoCoZFjXsP9KGkjHm9RS7rVq71eDF8Q6U5Q2dEJlY
 kGXOHqJAptWMPgtw+7QdFqqS6I9Ewbs6pPzDj/s2ljKKI5QmfJ8Ev/B3KxncLlGLqLgB
 o6bTdkrT1nrVSMP+UE7ta3P/rLjrLw6DncwSQdefNA/6TLd/3x+F1Rc3zXyE7DUHC024
 xsHjNfpYNJ82LJTRTZSLVby05mcQy3B35CNh+NXWnQDUV60qZGXfAuhxoUKSkLqY0NtI
 HcIg==
X-Gm-Message-State: APjAAAUD30ESSACSIEtfyeSTgLFmoRdUUymAkP9a7iauD+qvJXoayAVK
 hKsO2vgMdsih46qshzec2Jw=
X-Google-Smtp-Source: APXvYqwVWwee6HKE6fK1pHQoBZBQjr2gs53SHMjhh5MxLmrXeuhKS3pWoRnpcu9h490RK9iPNvGbBg==
X-Received: by 2002:a63:bd0a:: with SMTP id a10mr36894992pgf.55.1563324379595; 
 Tue, 16 Jul 2019 17:46:19 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id g62sm22132880pje.11.2019.07.16.17.46.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jul 2019 17:46:19 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com, stefanha@gmail.com, pbonzini@redhat.com, fam@euphon.net
Date: Wed, 17 Jul 2019 08:46:05 +0800
Message-Id: <20190717004606.12444-1-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 1/2] vhost-scsi: Call
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
 hw/scsi/vhost-scsi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 4090f99ee4..c0dd9bdf89 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -210,7 +210,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         if (err) {
             error_propagate(errp, err);
             error_free(vsc->migration_blocker);
-            goto close_fd;
+            goto free_virtio;
         }
     }
 
@@ -240,6 +240,10 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         migrate_del_blocker(vsc->migration_blocker);
     }
     g_free(vsc->dev.vqs);
+ free_virtio:
+    err = NULL;
+    virtio_scsi_common_unrealize(dev, &err);
+    error_propagate(errp, err);
  close_fd:
     close(vhostfd);
     return;
-- 
2.17.1


