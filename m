Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00423C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A9A206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtQISJIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A9A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlTy-0001AP-0V
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl6C-0006hu-DP
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:56:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl6A-0002LA-PQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Md6vo2LrasxyjY0uRkbE4pzqGEK/9UBJvsNzXykdtFE=;
 b=gtQISJIX+3lzCx26qokseUq0rbXohoUPy2A7ygR8zol7eFAZCmdOX2zY6wSljK7Myb9X05
 62izJR4uDcDczh90/mrbD0vmLmXnHtpJ+qPTJ+0t8/aWQi5RiweEVTgn+FI+JNiTsLUPif
 v0aUNEki5C/Xtmn7rH7cwVGkElWM0VE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-uch6L2XQPhi-fGOtkIgs0g-1; Fri, 12 Jun 2020 10:53:12 -0400
X-MC-Unique: uch6L2XQPhi-fGOtkIgs0g-1
Received: by mail-wm1-f70.google.com with SMTP id u15so2036260wmm.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Md6vo2LrasxyjY0uRkbE4pzqGEK/9UBJvsNzXykdtFE=;
 b=etyRBP0BapybySLTIDI3OcxLSBOoDjnjf9WmHDt/dkVKrPpOns6rSVUxYlZmGPJkxi
 TvPn4RRFvXeVWijr40rVAlggJygZTv0IPB3THreMw313oXB0CFrCWtg0TYWPVJS1WGBI
 iwPSBpio+ZD+VV/HHUI2DHqTWsciowht3gMI81dXktiQyHU2MZoPtAeME/Ne9rYgKPvM
 XsqGHrCdnMxaH0UMpiszX0FgRUMAXDfrlhm4L1f0KbD2RJD2PU88cBdkiMv/W0dpBwc2
 ZHePOBwOCxIPgf1epj9dVdyELWn2+HucdmP2hmicG4Mu1nI1b0BiGq4y2PKKqA6Red86
 41ag==
X-Gm-Message-State: AOAM532LhA7mnEGhyARWcOqNkAUtmXe5ZhI2/gzAUunl0rx6blz8CMhu
 +PQXSHQlKh/pUiMFk90cso/AZj8nYfpuyDXZdNzVGz9tqFyCekhgHDUaZd3aY5qb8vuaqIhS6YE
 Bo3StWfLxMSN/yJ0=
X-Received: by 2002:adf:f446:: with SMTP id f6mr15327333wrp.59.1591973591416; 
 Fri, 12 Jun 2020 07:53:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs2YowVJuuMs2q+eclSLwCdMPq59T7t941tTR+bwRmytba306Tyz9E/yYc/f+V6GG3C5oX7g==
X-Received: by 2002:adf:f446:: with SMTP id f6mr15327314wrp.59.1591973591228; 
 Fri, 12 Jun 2020 07:53:11 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id 23sm9695058wmo.18.2020.06.12.07.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:53:10 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:53:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 58/58] virtio-pci: fix queue_enable write
Message-ID: <20200612141917.9446-59-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

Spec said: The driver uses this to selectively prevent the device from
executing requests from this virtqueue. 1 - enabled; 0 - disabled.

Though write 0 to queue_enable is forbidden by the spec, we should not
assume that the value is 1.

Fix this by ignore the write value other than 1.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20200610054351.15811-1-jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d028c17c24..7bc8c1c056 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1273,16 +1273,20 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         virtio_queue_set_vector(vdev, vdev->queue_sel, val);
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
-        virtio_queue_set_num(vdev, vdev->queue_sel,
-                             proxy->vqs[vdev->queue_sel].num);
-        virtio_queue_set_rings(vdev, vdev->queue_sel,
+        if (val == 1) {
+            virtio_queue_set_num(vdev, vdev->queue_sel,
+                                 proxy->vqs[vdev->queue_sel].num);
+            virtio_queue_set_rings(vdev, vdev->queue_sel,
                        ((uint64_t)proxy->vqs[vdev->queue_sel].desc[1]) << 32 |
                        proxy->vqs[vdev->queue_sel].desc[0],
                        ((uint64_t)proxy->vqs[vdev->queue_sel].avail[1]) << 32 |
                        proxy->vqs[vdev->queue_sel].avail[0],
                        ((uint64_t)proxy->vqs[vdev->queue_sel].used[1]) << 32 |
                        proxy->vqs[vdev->queue_sel].used[0]);
-        proxy->vqs[vdev->queue_sel].enabled = 1;
+            proxy->vqs[vdev->queue_sel].enabled = 1;
+        } else {
+            virtio_error(vdev, "wrong value for queue_enable %"PRIx64, val);
+        }
         break;
     case VIRTIO_PCI_COMMON_Q_DESCLO:
         proxy->vqs[vdev->queue_sel].desc[0] = val;
-- 
MST


