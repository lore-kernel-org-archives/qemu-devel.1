Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FDC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00B62070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJTUv7Ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00B62070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXWc-0006Dv-MR
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX57-0003hV-9J
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX56-0005C0-76
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:25 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX56-0005Br-3j; Mon, 06 Jan 2020 13:26:24 -0500
Received: by mail-qk1-x744.google.com with SMTP id k6so40299199qki.5;
 Mon, 06 Jan 2020 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4+oVQB+J193/KmZY8maPFyIkwwRtaLrd/XP0/x5tOE=;
 b=lJTUv7EyIfaLsTN5YiW7f9v/wG/JJh69AI5ZjAmTOHkILFITpsXHBbgiT6QV46Th2R
 CvpoZUSu2wMpM0qQvkd4HpVbVgaBD7gnQu6L4lGy3FvsuBuxS03z+zt3iWWGw0YwpQea
 ofQlFWcgiIP2CaP7eZ5S5gb0PgL+qP9J0emZT8ks8PSRifrR9q7w0JOLxBbKGTR1xiDG
 J7S2DZu1SWbqI++IWL+ponIlciRb2mlzuGm7o7lvNghx9SA8y5gTlzzuzccnNqArW89I
 jCKZdvbDGn19pfOEXxsnNGV3Bumx/5ZOGFgdtECvO/ob+xlyTuO+S3eImsdU/8+7Q4W/
 w2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4+oVQB+J193/KmZY8maPFyIkwwRtaLrd/XP0/x5tOE=;
 b=q8IHPmM/U6+D7JCSvWzbQwOHG0HCPM5EW6d4cQ++JmWBckbvbticyLsQDFWy6UK8BY
 MzfpkqsIw2Nsx4+3xWFWfQL7EH2UqNuKtrwWsKpaIYVpbrEKLa/rffH7BxLCJJ6HmSH9
 +RI/udpWYef/btz1crgE9/IRlD+/YUY/DyhXN54rCuAYtmFJROhFpFD2r+SFtINzzPa1
 rruK2VS3q+0BDXyr8VsxkTKcFlw5SFzgW7zZK3Z62PXO+1vDE9vGwv6hbI36CmwvOp/F
 S9X7Y+/XnsSlN49XDUiPCZ7/ywQxt0blIwP1k3PRyLWYep3pIYOw4pue9IDH0K6ZpRJM
 CBjg==
X-Gm-Message-State: APjAAAXgEIAfonpRO1En/tuVT7r5gnTKMbQFWVKEqgjTye7dOHNnSvrT
 hYy65iqW/u/+wYmysQWeUF6vdoNI
X-Google-Smtp-Source: APXvYqzec/GMmFqXRPQVV5bOLUXpecEJ5+Z8cAxYziv1UxICY9ICN8PR8HGeALoUM8DDd22rXBKH8Q==
X-Received: by 2002:a37:8e03:: with SMTP id q3mr82847731qkd.395.1578335183533; 
 Mon, 06 Jan 2020 10:26:23 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:23 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 51/59] virtio/vhost.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:17 -0300
Message-Id: <20200106182425.20312-52-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The label 'err_features' in vhost_dev_set_log(), 'out' in
vhost_device_iotlb_miss() and 'fail' in vhost_dev_enable_notifiers()
can be replaced by 'return' with the appropriate value.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/virtio/vhost.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4da0d5a6c5..7b36839221 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -774,7 +774,7 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
     int r, i, idx;
     r = vhost_dev_set_features(dev, enable_log);
     if (r < 0) {
-        goto err_features;
+        return r;
     }
     for (i = 0; i < dev->nvqs; ++i) {
         idx = dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + i);
@@ -792,7 +792,6 @@ err_vq:
                                  dev->log_enabled);
     }
     vhost_dev_set_features(dev, dev->log_enabled);
-err_features:
     return r;
 }
 
@@ -938,7 +937,7 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
             trace_vhost_iotlb_miss(dev, 3);
             error_report("Fail to lookup the translated address "
                          "%"PRIx64, iotlb.translated_addr);
-            goto out;
+            return ret;
         }
 
         len = MIN(iotlb.addr_mask + 1, len);
@@ -949,13 +948,12 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         if (ret) {
             trace_vhost_iotlb_miss(dev, 4);
             error_report("Fail to update device iotlb");
-            goto out;
+            return ret;
         }
     }
 
     trace_vhost_iotlb_miss(dev, 2);
 
-out:
     return ret;
 }
 
@@ -1356,7 +1354,7 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
     r = virtio_device_grab_ioeventfd(vdev);
     if (r < 0) {
         error_report("binding does not support host notifiers");
-        goto fail;
+        return r;
     }
 
     for (i = 0; i < hdev->nvqs; ++i) {
@@ -1380,7 +1378,6 @@ fail_vq:
         virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
     }
     virtio_device_release_ioeventfd(vdev);
-fail:
     return r;
 }
 
-- 
2.24.1


