Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C7C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2272073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2272073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMWf-0000lR-Tc
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1isMUG-0005Nl-P2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1isMUF-0006Yw-C6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2739 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1isMUF-0006WQ-0i
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:56:11 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 834D2A7E2A704F125BDD;
 Fri, 17 Jan 2020 15:56:06 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 Jan 2020 15:55:55 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>, <pbonzini@redhat.com>, <fam@euphon.net>
Subject: [PATCH 2/2] virtio-scsi: convert to new virtio_delete_queue
Date: Fri, 17 Jan 2020 15:55:47 +0800
Message-ID: <20200117075547.60864-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200117075547.60864-1-pannengyuan@huawei.com>
References: <20200117075547.60864-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Use virtio_delete_queue to make it more clear.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/scsi/virtio-scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 858b3aaccb..d3af42ef92 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -945,10 +945,10 @@ void virtio_scsi_common_unrealize(DeviceState *dev)
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
     int i;
=20
-    virtio_del_queue(vdev, 0);
-    virtio_del_queue(vdev, 1);
+    virtio_delete_queue(vs->ctrl_vq);
+    virtio_delete_queue(vs->event_vq);
     for (i =3D 0; i < vs->conf.num_queues; i++) {
-        virtio_del_queue(vdev, i + 2);
+        virtio_delete_queue(vs->cmd_vqs[i]);
     }
     g_free(vs->cmd_vqs);
     virtio_cleanup(vdev);
--=20
2.21.0.windows.1



