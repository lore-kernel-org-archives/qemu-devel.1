Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42768C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 15:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FC020897
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 15:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6izdwyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FC020897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK19Z-0001zN-IC
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 11:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kK18r-0001ZJ-I8
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 11:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kK18n-0008Ll-1p
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 11:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600615232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fPXueWttktEUjcOPlrIesR5oL3s/6sAM6uv0WPBOABU=;
 b=S6izdwyp3VM/Qu1wP4+W30PcfkABpChV0x8nQz4OLsSVUds+sVhuDhIhL7h2sQ9QxNz4Xd
 aqKhq2J6Em9g0Aj8SQSS8zHxIeu/BLRKFrUU8e9EKvgbS2EO1vP5kqyFG4MJ2YnI/eL9mv
 eDjRAkjAPbAsz1q+TxWh0TObAIqWG8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-J_9zU-ooOSa1QuDFThU_XA-1; Sun, 20 Sep 2020 11:20:30 -0400
X-MC-Unique: J_9zU-ooOSa1QuDFThU_XA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B2110BBEC0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 15:20:30 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-15.ams2.redhat.com [10.36.113.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 711325576A;
 Sun, 20 Sep 2020 15:20:25 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost-vdpa: remove useless variable
Date: Sun, 20 Sep 2020 17:20:24 +0200
Message-Id: <20200920152024.860172-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 11:14:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

in vhost_vdpa_listener_region_del(), try_unmap is always true and so,
vhost_vdpa_dma_unmap() is always called. We can remove the variable

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4580f3efd8a2..c6cae6a6cabf 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -153,7 +153,6 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     hwaddr iova;
     Int128 llend, llsize;
     int ret;
-    bool try_unmap = true;
 
     if (vhost_vdpa_listener_skipped_section(section)) {
         return;
@@ -176,11 +175,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     llsize = int128_sub(llend, int128_make64(iova));
 
-    if (try_unmap) {
-        ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
-        if (ret) {
-            error_report("vhost_vdpa dma unmap error!");
-        }
+    ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
+    if (ret) {
+        error_report("vhost_vdpa dma unmap error!");
     }
 
     memory_region_unref(section->mr);
-- 
2.26.2


