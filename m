Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C4DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21401207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Brs+LV5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21401207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIC4-0007jK-BU
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI97-0001nr-G2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI94-0006NA-Pw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a94UYI+65+IE3CC0VO+z1PvpA042gsvmsxJdoYuVA5g=;
 b=Brs+LV5vnxxFai2pNGGPHOoqQyx8e3g4xqE+FVrsr4lijsIfRPDZsId6qEItgjBgxDVC14
 Ao+MPfLZ00Q3HPu+bbnWW0CvCan73O9sk7I/QJATZSYoS9HXkeEU1etyvnSMOmE3O3sQ1E
 MluahhBbEeLyDEWozyCv2YetTVWm31o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-aurM-0PPN7y5HZhNEHAasQ-1; Thu, 27 Aug 2020 09:40:47 -0400
X-MC-Unique: aurM-0PPN7y5HZhNEHAasQ-1
Received: by mail-wr1-f70.google.com with SMTP id l14so1558662wrp.9
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=a94UYI+65+IE3CC0VO+z1PvpA042gsvmsxJdoYuVA5g=;
 b=UbzCu+pnyWkUI414l4OnE3ewBqAdWn3UQ0kmqciXVBeRFN8PLISshVLsvSO8YZiotz
 9f/RQVPRXJDP3gCtu+jjFf0U7akl4ucNG6gljo1KG6aLgoZiq/rfLe90lH9iMXJOXRJ8
 oxcUVbxGvHZy8suched8mxC/Ih4sDSvUnSr3mD//vMwLllu1Vsk2BGtR+xUxaBq5asak
 CRzgqYHjfKhAhhFecWvcK+TAW4KTUSOHMJw8rgRYucolDVUelTZAUX1j1g++E9VSsem9
 hZbA+nAeOH11aWha914R7ACkpQnIAYNlT7wSen2vdFCR9ycCf8MvqERJRJ+rgkDBdjNa
 X8rw==
X-Gm-Message-State: AOAM532zH8XnfFOnhtYPi4hUT/jQuV0SLCUOFEwTIlI+pKjueT2Y9fHs
 svZtVeqE+PR1WmKQQujpTXDfJD0/Fi8FIhchBUew3HdzaflU5pZsU875Fl+/zaqZAHOzifEsfQ2
 hvR3UPiLojC1fHAA=
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr12713277wmj.66.1598535646050; 
 Thu, 27 Aug 2020 06:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxifhvwmceur6ViUsX3vyIfXaCbybcm/YZ97Ro3rDwOyxZ7LJjQFFxNrmVZG5gigX6Td+QFnw==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr12713263wmj.66.1598535645841; 
 Thu, 27 Aug 2020 06:40:45 -0700 (PDT)
Received: from redhat.com (bzq-79-180-15-82.red.bezeqint.net. [79.180.15.82])
 by smtp.gmail.com with ESMTPSA id
 n8sm6278855wra.32.2020.08.27.06.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:45 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/13] virtio-scsi: introduce a constant for fixed virtqueues
Message-ID: <20200827133954.2118749-9-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The event and control virtqueues are always present, regardless of the
multi-queue configuration.  Define a constant so that virtqueue number
calculations are easier to read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <20200818143348.310613-5-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-scsi.h | 3 +++
 hw/scsi/vhost-user-scsi.c       | 2 +-
 hw/scsi/virtio-scsi.c           | 7 ++++---
 hw/virtio/vhost-scsi-pci.c      | 3 ++-
 hw/virtio/vhost-user-scsi-pci.c | 3 ++-
 hw/virtio/virtio-scsi-pci.c     | 3 ++-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 24e768909d..9f293bcb80 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -36,6 +36,9 @@
 #define VIRTIO_SCSI_MAX_TARGET  255
 #define VIRTIO_SCSI_MAX_LUN     16383
 
+/* Number of virtqueues that are always present */
+#define VIRTIO_SCSI_VQ_NUM_FIXED    2
+
 typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
 typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
 typedef struct virtio_scsi_ctrl_tmf_req VirtIOSCSICtrlTMFReq;
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index f2e524438a..a8b821466f 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -114,7 +114,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
         goto free_virtio;
     }
 
-    vsc->dev.nvqs = 2 + vs->conf.num_queues;
+    vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
     vsc->dev.vqs = g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index = 0;
     vsc->dev.backend_features = 0;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index b49775269e..eecdd05af5 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -191,7 +191,7 @@ static void virtio_scsi_save_request(QEMUFile *f, SCSIRequest *sreq)
     VirtIOSCSIReq *req = sreq->hba_private;
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(req->dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(req->dev);
-    uint32_t n = virtio_get_queue_index(req->vq) - 2;
+    uint32_t n = virtio_get_queue_index(req->vq) - VIRTIO_SCSI_VQ_NUM_FIXED;
 
     assert(n < vs->conf.num_queues);
     qemu_put_be32s(f, &n);
@@ -892,10 +892,11 @@ void virtio_scsi_common_realize(DeviceState *dev,
                 sizeof(VirtIOSCSIConfig));
 
     if (s->conf.num_queues == 0 ||
-            s->conf.num_queues > VIRTIO_QUEUE_MAX - 2) {
+            s->conf.num_queues > VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIXED) {
         error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
                          "must be a positive integer less than %d.",
-                   s->conf.num_queues, VIRTIO_QUEUE_MAX - 2);
+                   s->conf.num_queues,
+                   VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIXED);
         virtio_cleanup(vdev);
         return;
     }
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 095af23f3f..06e814d30e 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -50,7 +50,8 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues + 3;
+        vpci_dev->nvectors = vs->conf.num_queues +
+                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
     }
 
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index 4705cd54e8..ab6dfb71a9 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -56,7 +56,8 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues + 3;
+        vpci_dev->nvectors = vs->conf.num_queues +
+                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
     }
 
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index c23a134202..3ff9eb7ef6 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -51,7 +51,8 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     char *bus_name;
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors = vs->conf.num_queues + 3;
+        vpci_dev->nvectors = vs->conf.num_queues +
+                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
     }
 
     /*
-- 
MST


