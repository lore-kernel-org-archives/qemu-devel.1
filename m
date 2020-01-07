Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5663CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209BF2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hopuq36k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209BF2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iormB-0000AY-CB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iork1-0006f6-CU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iork0-0004hP-1l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorjz-0004gc-Mr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9epneyHKkAEq5gGDVE/gbeFue8BzwP7OkBM6QzY9Yk=;
 b=Hopuq36kIYXfxrhB5y2zH6PKJzOIe4MxDSqytjAwwDyjMmizHs3G87k/pqEhvNGSMXmlwo
 gpoSXGktrF8e1vIqTaBhWhouqvkl4nfG6M7iuCdg2q9e6jwRat4alJtGdmDJKVIymzT5gO
 6iBo+9Tk4aUpfSU8mMdMcp+RYuTD3vI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-kTdlcqhcOpq2PbMxC8IyZQ-1; Tue, 07 Jan 2020 11:29:57 -0500
Received: by mail-qk1-f198.google.com with SMTP id m13so140796qka.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iiaP0RxMw50Y4u2HruPOoUKc+xP0ZRMmYrMUAAr8Wgg=;
 b=Xlw4ICsSQ8nlets+uF0/oO7RjkbR8QkR8uDd0nKpDY96sv/smhIunL7cvsEtkeMRI0
 7f+EYClmlQiA2dfoGIxxFwknW4TWu8QceJCtkO2eTxFpg7QEmCaCdpEg7L1AFKfPLT3W
 its84S1Li+hJIbVkl/vxn8ZanrmBAoltFA8YDcQOaVmk4aMTnLpP0UdvjnVtyO6u41b/
 xRZugquyQZXiPL6j3FBTGAr9y0d+naffkE2IWcdGQl3AQKEYd4Vm66hwpPI+bXQ/OgbP
 8elkgeIsF6mtQjgwJMEdLFUjMUx/FCU3knmom7Ca/pf+zvbwR2n/aGMufJ4wmaK7tvWz
 i5Tg==
X-Gm-Message-State: APjAAAV7uvMNemMlq9iSnkgMMWwmykw4Wb1eXIo5PF50I782ml5aQt76
 EK9aB5X3trznS9b4wKkdf8JKuAb2J1lf+bPbddXpIIft16RKna6v9OKTQ7bdjvwLzW7AUK8ePtO
 yI7pQlTuI89aO/gE=
X-Received: by 2002:ae9:e714:: with SMTP id m20mr82668qka.403.1578414597070;
 Tue, 07 Jan 2020 08:29:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDWDMiFTydcHlMfSpLOjjQ6uZn4k7sj1O9kBGGqK54fuatvIVtNP/tWSsrtOZBqxgRbfscoA==
X-Received: by 2002:ae9:e714:: with SMTP id m20mr82656qka.403.1578414596867;
 Tue, 07 Jan 2020 08:29:56 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id h1sm108315qte.42.2020.01.07.08.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:29:56 -0800 (PST)
Date: Tue, 7 Jan 2020 11:29:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/32] virtio-input: convert to new virtio_delete_queue
Message-ID: <20200107162850.411448-6-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: kTdlcqhcOpq2PbMxC8IyZQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems cleaner than using VQ index values.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/input/virtio-input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index ec54e46ad6..9c013afddb 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -280,6 +280,7 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
 {
     VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
     Error *local_err =3D NULL;
=20
     if (vic->unrealize) {
@@ -289,8 +290,8 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
             return;
         }
     }
-    virtio_del_queue(vdev, 0);
-    virtio_del_queue(vdev, 1);
+    virtio_delete_queue(vinput->evt);
+    virtio_delete_queue(vinput->sts);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


