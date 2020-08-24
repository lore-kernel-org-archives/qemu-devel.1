Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6B520706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 22:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbS+GoCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6B520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAKaS-0002ZE-PZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 18:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAKWQ-0007Ca-Ge
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:00:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAKWO-00006L-MD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598306455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x35caCXuOckWr0t/0QSl7Z1oGqEi1qLutXHP06QSpTE=;
 b=WbS+GoCdplRMSWuIjHM6H1VMYdbSu4e1ixUweyoHhOuKZFwUgjvyxTd1kjgR8kVkrwGe6k
 yXRV+/6YLWdSQNuqwtMZre7oEAQpvWDzTmOPzjj5/HWkGNFEWQipSlUvbqxwqPFCri9Wi5
 jSaziu4KAVKmJytX36zpCf41avTfOBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-RqXHqp1-PZu48tR_cdJ9Ww-1; Mon, 24 Aug 2020 18:00:53 -0400
X-MC-Unique: RqXHqp1-PZu48tR_cdJ9Ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 754EF81F018;
 Mon, 24 Aug 2020 22:00:52 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85CD562A13;
 Mon, 24 Aug 2020 22:00:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] virtio-vga: Use typedef name for instance_size
Date: Mon, 24 Aug 2020 17:59:36 -0400
Message-Id: <20200824215936.2961951-7-ehabkost@redhat.com>
In-Reply-To: <20200824215936.2961951-1-ehabkost@redhat.com>
References: <20200824215936.2961951-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 17:57:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes the code consistent with the rest of QOM code in QEMU,
and will make automated conversion to type declaration macros
simpler.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/display/virtio-vga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index f533d7d1b4..7c995ddc81 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -194,8 +194,8 @@ static void virtio_vga_base_class_init(ObjectClass *klass, void *data)
 static TypeInfo virtio_vga_base_info = {
     .name          = TYPE_VIRTIO_VGA_BASE,
     .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(struct VirtIOVGABase),
-    .class_size    = sizeof(struct VirtIOVGABaseClass),
+    .instance_size = sizeof(VirtIOVGABase),
+    .class_size    = sizeof(VirtIOVGABaseClass),
     .class_init    = virtio_vga_base_class_init,
     .abstract      = true,
 };
@@ -224,7 +224,7 @@ static void virtio_vga_inst_initfn(Object *obj)
 static VirtioPCIDeviceTypeInfo virtio_vga_info = {
     .generic_name  = TYPE_VIRTIO_VGA,
     .parent        = TYPE_VIRTIO_VGA_BASE,
-    .instance_size = sizeof(struct VirtIOVGA),
+    .instance_size = sizeof(VirtIOVGA),
     .instance_init = virtio_vga_inst_initfn,
 };
 
-- 
2.26.2


