Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC733C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B7D20797
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYnhSvU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B7D20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx7a-000630-Ct
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM4-00051A-SZ; Thu, 03 Sep 2020 17:01:13 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29]:34350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM3-0007sf-5s; Thu, 03 Sep 2020 17:01:12 -0400
Received: by mail-oo1-xc29.google.com with SMTP id k63so1135286oob.1;
 Thu, 03 Sep 2020 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ooJ5JWX44T4rpsVTQbxVK9w+LAQEjZ1790XiAupTrvE=;
 b=cYnhSvU/5APT+omor5i3Awsj9iTcCzyuAF5bA/l9EI4PrN7otvAu3MEhZKF78vkYZ8
 AX2CJ1sAfKGs0/t7UntU0PdCZQaBFTck38wW0a9jNGjSgCxFI8LUkvBRuUv2vkbC+Q1d
 hSD20VxrSIXstJblKSwUpCkNIFqO8HcVnTMrLdlzcflWAVHfeXXV8T/P1OaA6IeUP05P
 HZ2EM15h6jXlEOckjfthQLDIkc9inMcduKqeLcSl3c5uscEutv3Vqxb82Mi0mgh5Yi7v
 Fwgkooh4eZqroxeWnm4rrfVtgAs2Ekn5A28Uonadg8cNJ/Y4oi8GpjbZ0CkQni0xs0FZ
 2RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ooJ5JWX44T4rpsVTQbxVK9w+LAQEjZ1790XiAupTrvE=;
 b=kO2fiqurucrOSPUA7mZ+HDorOkEveEAaPf54vpqWSAPlP4cugLFb/OLYbAr5RgaLfv
 knGsiesypq+8HYwEYUfx/Zo/NFYF5Stjl8IYzYPEoTRglcVY6VnPlSv+5VkXTAQNA3Pp
 brWyRICw75QjGwKhAjGBy+eyqm7DULr1vjI4gpX6zrJ3ZFmtu9pdzr75UflB7FRIDB53
 VQYPfvy5mXC+Xq0diV7wbAYNfdDBtLf6v1+dpTithaWoSsu+5vXtEVHudnLSNrAheBxI
 QiumHnUHHTT1EHbZbr3JAoAi/Z5E/OfJrNgGPnhLH+fIkCug4FY1fUJv4izGqf9luy8b
 F4uA==
X-Gm-Message-State: AOAM531eaYupr9jrV5/44HgXhW7VUdO0sy5arXzQ2w6GmESP+vwn0wed
 AvJZxCW0KAbT0TW5F2eh/JiTa1k/s0jE8g==
X-Google-Smtp-Source: ABdhPJyrt/U04xIvJZzUVYMcbP/+B4V5yliYVgNS1ZJeIkJYJvEMJ/WKD6rDWMmPYyXbbkRSqGNAPA==
X-Received: by 2002:a4a:d549:: with SMTP id q9mr3347752oos.74.1599166869225;
 Thu, 03 Sep 2020 14:01:09 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id e9sm814941oog.10.2020.09.03.14.01.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:08 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 65/77] virtio: list legacy-capable devices
Date: Thu,  3 Sep 2020 15:59:23 -0500
Message-Id: <20200903205935.27832-66-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc29.google.com
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

Several types of virtio devices had already been around before the
virtio standard was specified. These devices support virtio in legacy
(and transitional) mode.

Devices that have been added in the virtio standard are considered
non-transitional (i.e. with no support for legacy virtio).

Provide a helper function so virtio transports can figure that out
easily.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200707105446.677966-2-cohuck@redhat.com>
Cc: qemu-stable@nongnu.org
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 7c78bdd7a3d0086179331f10d1f6f8cdac34731a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c         | 25 +++++++++++++++++++++++++
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b6c8ef5bc0..398fd4a305 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
+#include "standard-headers/linux/virtio_ids.h"
 
 /*
  * The alignment to use between consumer and producer parts of vring.
@@ -3278,6 +3279,30 @@ void virtio_init(VirtIODevice *vdev, const char *name,
     vdev->use_guest_notifier_mask = true;
 }
 
+/*
+ * Only devices that have already been around prior to defining the virtio
+ * standard support legacy mode; this includes devices not specified in the
+ * standard. All newer devices conform to the virtio standard only.
+ */
+bool virtio_legacy_allowed(VirtIODevice *vdev)
+{
+    switch (vdev->device_id) {
+    case VIRTIO_ID_NET:
+    case VIRTIO_ID_BLOCK:
+    case VIRTIO_ID_CONSOLE:
+    case VIRTIO_ID_RNG:
+    case VIRTIO_ID_BALLOON:
+    case VIRTIO_ID_RPMSG:
+    case VIRTIO_ID_SCSI:
+    case VIRTIO_ID_9P:
+    case VIRTIO_ID_RPROC_SERIAL:
+    case VIRTIO_ID_CAIF:
+        return true;
+    default:
+        return false;
+    }
+}
+
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
 {
     return vdev->vq[n].vring.desc;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b69d517496..198ffc7626 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -396,4 +396,6 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
     return unlikely(vdev->disabled || vdev->broken);
 }
 
+bool virtio_legacy_allowed(VirtIODevice *vdev);
+
 #endif
-- 
2.17.1


