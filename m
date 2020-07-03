Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1306EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D789520836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW8lgFww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D789520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHpL-0001zw-3Z
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHd1-0000wd-Cz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcz-0004Z4-Ep
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tXbtGjuArFU0L6axuc9oufytf20N/xVITacNIR/IrnQ=;
 b=XW8lgFwwz/p7nDFGwShyOS03a5VHhvFg5RkeZ4HE0onKwtzqb1gc/R2VVGwVoi8S+XYiVO
 rFBNv8Z2ottpyPY2j3Gop/keBbj28DrQm1Za0CWhUvCCQupgYGw5VBvd9lWXibTxn3vet0
 ZZ7tiNW6+JluVtJYAv6BMuhMx3XDSAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-jROEz1ldOU6kAwe7gPCFtg-1; Fri, 03 Jul 2020 05:04:59 -0400
X-MC-Unique: jROEz1ldOU6kAwe7gPCFtg-1
Received: by mail-wm1-f72.google.com with SMTP id g187so34475540wme.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tXbtGjuArFU0L6axuc9oufytf20N/xVITacNIR/IrnQ=;
 b=ofHP26QxPLe/W7Pi56mMEhg9xYi8gGD0KH9bC4MsE/xR4HIl38ZPzK7l5eZYJvHj9g
 fCNcnngPbtQ935fi7jDnI2i953JDxStiTPlD6mONSoDIIt3fPmWh990QIEUP5gDW4Qc3
 GnZLcnxsgix6vhQDt84BpKjGSyQDKvNxx3unywPvpedlGejRuBdqpe8OgcioWQbfCYjX
 K1UxbCoGFiaTPMBo2ztJw56rf5Y/TFRPvM+vPJgX6IpELhr0sfTq/OVMd43S6xn03tu3
 JIMjSSflh5ZQVDLkkmYGT2I/91QYxfZA3aC2HBT9SQQD/kqgr2GE1FFPdaxHEsiMmcsa
 h0dA==
X-Gm-Message-State: AOAM533Y6z88s2bx0znXHQPYWI+7autNd3i7lgMCEZr7zWEUw+uKR9MP
 khRBmRKy5dyNQJ41ipTrnZ7iMqxnSKkS7gsPKcm92Sp/r5NiIFI3jkgyWfqOlExuAqXf1Bq3yBT
 ZkevJq1h5j3iO/To=
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr33552587wrx.50.1593767097664; 
 Fri, 03 Jul 2020 02:04:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv9FCMfwSGdRhF0oXPmZmMf7It5RcWIjtd3s9RDzXtez9CWlg0rbOpmP1MSZtCHfYeKn70+g==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
 b4mr33552574wrx.50.1593767097509; 
 Fri, 03 Jul 2020 02:04:57 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 d13sm13143399wrn.61.2020.07.03.02.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:57 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/41] vhost: check the existence of vhost_set_iotlb_callback
Message-ID: <20200703090252.368694-33-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

Add the check of vhost_set_iotlb_callback
before calling

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-6-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5fd25fe520..10304b583e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1686,8 +1686,9 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         }
     }
 
-    if (vhost_dev_has_iommu(hdev)) {
-        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
+    if (vhost_dev_has_iommu(hdev) &&
+        hdev->vhost_ops->vhost_set_iotlb_callback) {
+            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
 
         /* Update used ring information for IOTLB to work correctly,
          * vhost-kernel code requires for this.*/
@@ -1730,7 +1731,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
     }
 
     if (vhost_dev_has_iommu(hdev)) {
-        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+        if (hdev->vhost_ops->vhost_set_iotlb_callback) {
+            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+        }
         memory_listener_unregister(&hdev->iommu_listener);
     }
     vhost_log_put(hdev, true);
-- 
MST


