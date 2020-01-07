Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABA7C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A7C214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijGlQUsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A7C214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53491 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosIY-00014Q-Vv
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorlh-00008a-Ge
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlg-0005n9-7B
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorlg-0005mx-3l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10wNZRiSDwsgBzUvgX+qZm4UOG4d0UwTiZy8rXJV4jo=;
 b=ijGlQUsKsYCuElg+pYZenDIyevqjG3Q57vonQgSpjvsceDO3G0IBOfayEo7prgaNQ+6llx
 lWBKAktHrBakG+x57BQKxoyeJhk6d+e3W4lGgSnaKtMNXMZgMFXOnWFTZKiziCkAT0gjmG
 EJYaCT8n78dK88Yql55LKBMdikevZog=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-1A66pp0oOm-Daz28AYJGoQ-1; Tue, 07 Jan 2020 11:31:42 -0500
Received: by mail-qt1-f199.google.com with SMTP id b7so105614qtg.23
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tfGwPPQntx/q9Ytbl/8/C6b7fB9jJ0SAUnXApOete/4=;
 b=lF2GannW6IkBgvFe5TcsEVamk0yGOyOAscozt3/c6w537h2sx3qAWfzitSiW5sGnuu
 eVSOfD62oLk17cBJnUvgWYVB3KCI1/aVnk8H/Hpu9hJi0cNl4tfrh9UwhpNGbwNy2NG/
 bJ1ECnGh23KPd+sWOjj6AloH7HF7lLBUgis8xKLoGZvlBO6tlnU+ymD2IoYjJO9QGnKI
 eb3Il1BHGSHxXdODann7/J1OnOLZQ/rGRo8TRSKrVs49xS/c9RGCswnhfYUa7fJJhkSV
 tOB1jme5S6eZcpb2nUu8EwNhV5EG5i95kXrN4qp5gV4ry+EBWcz62cAzZMdSSYYXeyhx
 xYqg==
X-Gm-Message-State: APjAAAUdyt9+P2r/nMqyoG3kwJmJejT2MC2Yng1w4yguJwn0si2LDyrG
 EHgoCG4C+WPLoUNxj6wXe1zgYw9vUBsB84+3CShYN3GH7JQumKY4ABu2qFQz2WT3tCE+dNrhI1m
 jLXmqdixoQd4o1B0=
X-Received: by 2002:a05:620a:166a:: with SMTP id
 d10mr128911qko.37.1578414701325; 
 Tue, 07 Jan 2020 08:31:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvb5KKZr2BkRauQ6Zeg0juDXNN9cPCctvqYKJEipgs2vuu5RW+bTvQGee9Z89TdvdUzBxlBA==
X-Received: by 2002:a05:620a:166a:: with SMTP id
 d10mr128884qko.37.1578414701090; 
 Tue, 07 Jan 2020 08:31:41 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id l184sm25959qkc.107.2020.01.07.08.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:31:40 -0800 (PST)
Date: Tue, 7 Jan 2020 11:31:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 28/32] virtio-mmio: update queue size on guest write
Message-ID: <20200107162850.411448-29-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 1A66pp0oOm-Daz28AYJGoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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


