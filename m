Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C525AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9971C20786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="digWy/xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9971C20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCZy-00037h-R7
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPR-0001hN-1E; Tue, 16 Jun 2020 10:17:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPP-0006aE-GZ; Tue, 16 Jun 2020 10:17:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id u23so16054958otq.10;
 Tue, 16 Jun 2020 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EO7pUhlzm0oZLNOP4SxgQUagDG4s3W5EaxNKZcENM6A=;
 b=digWy/xaSI0RgYIlNNAZE0ngwT+2nfXgaL3nZ7q4aeVdjht7KXJvDw3SNYK/ZzF2y4
 ScbQ73N0AT4P5es9J/D7Kk6qZtZ5VObzlHuh54mXMvqKqcEZMTGlXmcxWKw40ct4K6M7
 emmGFQyR02a4D+RQvYm2ikEutwtu40f8HlLwSgDHJk90EFLPwvSqSUhUsSzuUg2iDE5/
 C+ueAnd0BuMn+uI0FkXlFW8m5KemFIgxumB0Avw309hLGRJXggJVtryxt25yHt+8+AeL
 s5OnQ6lqinEhFS+VE35CxB+aUbAdPZU9d3fiykeHpIQSmMlCqCmVrGNPhaLb16VLjaxf
 0jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=EO7pUhlzm0oZLNOP4SxgQUagDG4s3W5EaxNKZcENM6A=;
 b=udHXXNLdxrY5FG869nOBHtXGxUGtCBcdqwXx9An3KdLle51gtOHmNu2PN+m0n0znG1
 /ntZ09EtHzLgsQh4JdxDt7Q6O8svC9EQNDo52kF5HqSwaIOvg0OtsobyfSRJ9s52ks43
 COPZ4AyMLdwLk30cech/ZKVvdJ+uPATs9B54hq82+5Nxp/QS6lQTUV/FXUfqW8ELLrCb
 rjHiwai4nf4Htxp/3EYAm+5pb8M6nOiFqwOuMQXg1SWgSRrhd4HXxHZbLau+wOaTq+6X
 Hn92TNv1HXXcktowRC4ARDb2/itMyQRSJYzeefOg/K5VDZG43tmvl0vEg9YeUjTW4oZm
 0tOA==
X-Gm-Message-State: AOAM531jVeVLbfwuMWJY85cacN6h1sfC3JtrX3aBQ2s6a6+AMIu45eWr
 6WZ40LBdRTPMi2iGbIia8uZ+fKRR
X-Google-Smtp-Source: ABdhPJzoo/1kBILNkuoqEbECjuO83AGa8gq6fOuZLgHBNAXMBpVNtYaBAiPtRI7qkYad6/VTwAeLtw==
X-Received: by 2002:a9d:730c:: with SMTP id e12mr2599634otk.8.1592317069709;
 Tue, 16 Jun 2020 07:17:49 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x1sm1535173oop.44.2020.06.16.07.17.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:48 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/78] virtio: add ability to delete vq through a pointer
Date: Tue, 16 Jun 2020 09:14:48 -0500
Message-Id: <20200616141547.24664-20-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

Devices tend to maintain vq pointers, allow deleting them trough a vq pointer.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
(cherry picked from commit 722f8c51d8af223751dfb1d02de40043e8ba067e)
*prereq for 421afd2fe8
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c         | 15 ++++++++++-----
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..31dd140990 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2330,17 +2330,22 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     return &vdev->vq[i];
 }
 
+void virtio_delete_queue(VirtQueue *vq)
+{
+    vq->vring.num = 0;
+    vq->vring.num_default = 0;
+    vq->handle_output = NULL;
+    vq->handle_aio_output = NULL;
+    g_free(vq->used_elems);
+}
+
 void virtio_del_queue(VirtIODevice *vdev, int n)
 {
     if (n < 0 || n >= VIRTIO_QUEUE_MAX) {
         abort();
     }
 
-    vdev->vq[n].vring.num = 0;
-    vdev->vq[n].vring.num_default = 0;
-    vdev->vq[n].handle_output = NULL;
-    vdev->vq[n].handle_aio_output = NULL;
-    g_free(vdev->vq[n].used_elems);
+    virtio_delete_queue(&vdev->vq[n]);
 }
 
 static void virtio_set_isr(VirtIODevice *vdev, int value)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c32a815303..e18756d50d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
 
 void virtio_del_queue(VirtIODevice *vdev, int n);
 
+void virtio_delete_queue(VirtQueue *vq);
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len);
 void virtqueue_flush(VirtQueue *vq, unsigned int count);
-- 
2.17.1


