Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426AACA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1781421655
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1781421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOS4X-0002hG-51
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORuu-0001Rq-Sd
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORut-0000WM-Bs
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORut-0000VZ-3u
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:03 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D3E485360
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:40:02 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id l32so3849739qtk.9
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VSAgiCx/ZDiMkWQzhksyT4dczHf36GYChIvUpTB4N5c=;
 b=BKp4ZEGqqQumafQoe4nTWttafdG1gaVGCtSr3fMFNQcfs/lZSvMgDNXMsJIxheVRys
 OsejJ847N1+nBsG12yQevLMIdjraSA0qs66ZvAaaC/iHzRj/aOJ3tBcs99LhGnnbU18E
 6g3Y6SO6mDpZVyDJ6Olcvpun4jWTav5YCEGY1B3EedJTGwo7C4710rTmj+XS7crub1bQ
 REbBinPmz4AknepLQH/PqcM1E1U5ktKzozhZIiX6vMgmHdXZyKG+tSDZNv7x3ks5fWM1
 ciRHtz5jmk3JefsleaYuaq2aBYQ/fro/beRJtcQsZDSlhDcRlNXGHvGQU1tlS954Y1s6
 OpKw==
X-Gm-Message-State: APjAAAVg+B2yQi5OyzKtgJXm5TKbBlwSyX+ok3B939ogNW0aCgHeqYSf
 JYz1bk3nRSu8uepbHPz9AcLQiQ6ao+Hfw5OwJpnO/GdIO5hUMKFaDqyeKShY3FsmtVlyA1uRhr8
 /l6UwjWIH2LJM5KQ=
X-Received: by 2002:aed:24e4:: with SMTP id u33mr9838779qtc.259.1572118801052; 
 Sat, 26 Oct 2019 12:40:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxm+TQ1CPDxypbcoseGqhWzkC2a4BRJxvDs4OECAbHbFoZRvxeR1t8DhUq1fwTOP1/2wH+zVw==
X-Received: by 2002:aed:24e4:: with SMTP id u33mr9838762qtc.259.1572118800807; 
 Sat, 26 Oct 2019 12:40:00 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 11sm1665748qtx.45.2019.10.26.12.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:40:00 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/25] tests/virtio-blk-test: read config space after feature
 negotiation
Message-ID: <20191026193824.11926-10-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The VIRTIO Configuration Space cannot be accessed before device feature
bits have been read because a driver doesn't know the endianness until
it has checked VIRTIO_F_VERSION_1.

Fix this problem in preparation for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191023100425.12168-2-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/virtio-blk-test.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index ed13167392..f6674fb233 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -125,10 +125,6 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
     char *data;
     QTestState *qts = global_qtest;
 
-    capacity = qvirtio_config_readq(dev, 0);
-
-    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
-
     features = qvirtio_get_features(dev);
     features = features & ~(QVIRTIO_F_BAD_FEATURE |
                     (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -136,6 +132,9 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
                     (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
 
+    capacity = qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
+
     qvirtio_set_driver_ok(dev);
 
     /* Write and read with 3 descriptor layout */
@@ -359,9 +358,6 @@ static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
     char *data;
     QTestState *qts = global_qtest;
 
-    capacity = qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
-
     features = qvirtio_get_features(dev);
     g_assert_cmphex(features & (1u << VIRTIO_RING_F_INDIRECT_DESC), !=, 0);
     features = features & ~(QVIRTIO_F_BAD_FEATURE |
@@ -369,6 +365,9 @@ static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
 
+    capacity = qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
+
     vq = qvirtqueue_setup(dev, t_alloc, 0);
     qvirtio_set_driver_ok(dev);
 
@@ -434,8 +433,16 @@ static void config(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtioBlk *blk_if = obj;
     QVirtioDevice *dev = blk_if->vdev;
     int n_size = TEST_IMAGE_SIZE / 2;
+    uint64_t features;
     uint64_t capacity;
 
+    features = qvirtio_get_features(dev);
+    features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_RING_F_EVENT_IDX) |
+                            (1u << VIRTIO_BLK_F_SCSI));
+    qvirtio_set_features(dev, features);
+
     capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
 
@@ -475,9 +482,6 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
-    capacity = qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
-
     features = qvirtio_get_features(dev);
     features = features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -485,6 +489,9 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
 
+    capacity = qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
+
     vq = qvirtqueue_setup(dev, t_alloc, 0);
     qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
 
@@ -584,9 +591,6 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
-    capacity = qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
-
     features = qvirtio_get_features(dev);
     features = features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -594,6 +598,9 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
 
+    capacity = qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
+
     vq = qvirtqueue_setup(dev, t_alloc, 0);
     qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
 
-- 
MST


