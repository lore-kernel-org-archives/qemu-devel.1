Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E62BC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DEA20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFh/nUt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DEA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmy9R-0001Fq-V2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35041)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hmy9B-0000L1-Av
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hmy9A-00083K-DU
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:23:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hmy9A-00082v-6t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:23:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id g2so7223267pfq.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+wNQNJSarln9knX28psYjT7Bngaa0MsW1kki3C9Cweo=;
 b=mFh/nUt7Psi6dchjwmmOgok29HlE6P8wr3dSkqncGkt94Bi9uzld4bmq7GbMi7/MX7
 enRPn0E4exeXo+lq1lHl9RZmCQpmqVg+XJ9Ixtq3KgGKTpsP04DG2EYqDprpIA6stav2
 WjCbetCHPTqzrVS40dWdGGZluo9i0qgQJS2zPVt9gT+qKS92nZGf6GfzQbu/YzqaWXS8
 pwCUpPUUBH93r4lV9bLEuGCU0AfSdKBF/ZdyQb1kKelhSQU7vC7x1LXa0hcTRo2dMQaM
 dh07Tz13b5+KEvQV++OykLup4kNu3b6FJ34YdPmwC+bUF8A842mvNfbrnaBlBj0Uveai
 TmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+wNQNJSarln9knX28psYjT7Bngaa0MsW1kki3C9Cweo=;
 b=WQuL0BIi2vJXwHm/Q3wHUK9TWFF4cSai392J61K1ALWB/YFpxEhHa66dBkXZVLh7hf
 hne4azx6aGubEQmfvPFjhtMj5zi8hOBkXnu9/DCxeMITLtcXIMvp7q8AlameeYHJlKfS
 zcsff+7XjpH3h5mupjrYL2Px6YZIDreOM7uqLwsHWcSeCKJ57xN5ns/to7+px0UShvEP
 r/K9Z5asgRZxLiM4s3/ULUfRQ7sDblWYp75sBvbq6+FJ5jhpy1MlRgCdCZfUn0W4BvLW
 oMRqhmD/cau+dS++gVM+VSsqiYTXF6iSX2VUFA8Gn1ExynLIRfwlFRf8buBAc87oJDK6
 Gi1A==
X-Gm-Message-State: APjAAAX9F3a8W2b5dSowsK04cUdgnhUBS76BAgxLRN9zkl03L+w9DQVy
 1Lr17wapx3wlbW9l8i6+uI4=
X-Google-Smtp-Source: APXvYqzIAbzwl/j1Mx0/dYjtav5gczxnzO0t7AhaQySuTXNG9s+Aa7aMzxF1iEbtGEw19iTTZinaMw==
X-Received: by 2002:a17:90b:d8f:: with SMTP id
 bg15mr28342218pjb.65.1563186231274; 
 Mon, 15 Jul 2019 03:23:51 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id 131sm21636967pfx.57.2019.07.15.03.23.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Jul 2019 03:23:50 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com, stefanha@gmail.com, pbonzini@redhat.com, fam@euphon.net
Date: Mon, 15 Jul 2019 18:23:26 +0800
Message-Id: <20190715102326.2805-2-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715102326.2805-1-xieyongji@baidu.com>
References: <20190715102326.2805-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 2/2] vhost-user-scsi: Call
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
 hw/scsi/vhost-user-scsi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a9fd8ea305..a79653df46 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -87,7 +87,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
-        return;
+        goto free_virtio;
     }
 
     vsc->dev.nvqs = 2 + vs->conf.num_queues;
@@ -101,15 +101,21 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
+    virtio_scsi_common_unrealize(dev, errp);
 }
 
 static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
-- 
2.17.1


