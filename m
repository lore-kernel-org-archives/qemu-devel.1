Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5D9C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE46A207FD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDjq19py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE46A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5jK-00045L-FX
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5VY-0003V1-KM
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5VX-0005Ao-GC
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5VX-0005AH-DI
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10wNZRiSDwsgBzUvgX+qZm4UOG4d0UwTiZy8rXJV4jo=;
 b=YDjq19pyxb3ybffHqs3+MxNRgnqNU09FHrhfOM2G8S9S2CtJqDI9KPSgrNvIQSsGOx+FKv
 NYW9QItIMa9X8pqAfsuobwWv1xmtObqFkjlgfL7vkMfGUV2CD8rXG6QGb05ErwlVzm6we0
 lfvPNGDfKPZQ3DMKE72C+L7aLn8OI7E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-MnzbPnS9MoWseXuWKW-kGA-1; Sun, 05 Jan 2020 07:59:49 -0500
Received: by mail-qt1-f199.google.com with SMTP id e8so8949920qtg.9
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tfGwPPQntx/q9Ytbl/8/C6b7fB9jJ0SAUnXApOete/4=;
 b=PcNs4JhKexwrXgb7CG3jpqw3x6xSDXfCg7qNg2Gq7VyZ8hHxumir3DchfVioOyi+ux
 aOC9sQIrETegtCSxcV0i5hR3KMsZQe0raBPFWiUhlFfVE/zlhA9ejLv2l8YNFsrg8MJf
 Zv6X/t2BVBhCd6UP6JjoFWI9hrD6O09ezjVki0yfUjkDdkP2ROHJJBwdo+DS3yU7KUVl
 MAkMm6m3W1/YNNZptBHrcSbDF82qt/KS9yI+NelW7xIcrqegvcYeuixKbo3SdLHDDps1
 m8bSb9k8B4rRIKfwJ2dRfCRk1C3Om7FmLmX3ogNJ2mi2oz7TIeerJ/tMQjazagx/ALdg
 atDg==
X-Gm-Message-State: APjAAAXHvrHYY8g3XIrfJny2iJNT2YhwxqOjCiC4iNVieg9aHPEYhWkF
 0ItexzHZIMO/0iewdQADTXaXKkn7K4Fd+q2hjL4JTy2oYvtMvr/6E64nBitxy6QP6HTEnKKf//y
 X/GIlCR8cL5DH/7w=
X-Received: by 2002:a05:620a:228:: with SMTP id
 u8mr78749096qkm.88.1578229188590; 
 Sun, 05 Jan 2020 04:59:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOE4cIY1bNLTLu0Bu78IPE9J/LJAq1L5FwOKszwHvLSvf0wCD2P/qs4S0HjmVaD/b7kzC+5g==
X-Received: by 2002:a05:620a:228:: with SMTP id
 u8mr78749091qkm.88.1578229188391; 
 Sun, 05 Jan 2020 04:59:48 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id t198sm19356680qke.6.2020.01.05.04.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:59:47 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 28/32] virtio-mmio: update queue size on guest write
Message-ID: <20200105125622.27231-29-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: MnzbPnS9MoWseXuWKW-kGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

Some guests read back queue size after writing it.
Always update the on size write otherwise they might be confused.

Cc: qemu-stable@nongnu.org
Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20191224081446.17003-1-dplotnikov@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index ef40b7a9b2..872f2cd237 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -308,8 +308,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offs=
et, uint64_t value,
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
         trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
+        virtio_queue_set_num(vdev, vdev->queue_sel, value);
+
         if (proxy->legacy) {
-            virtio_queue_set_num(vdev, vdev->queue_sel, value);
             virtio_queue_update_rings(vdev, vdev->queue_sel);
         } else {
             proxy->vqs[vdev->queue_sel].num =3D value;
--=20
MST


