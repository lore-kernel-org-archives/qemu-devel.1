Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F074FC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DF1207FD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RciQZePO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DF1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5mT-0007kV-AS
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5Vj-0003jy-2O
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 08:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5Vh-0005HE-Nb
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 08:00:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5Vh-0005GZ-Gl
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 08:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgmNsnDUrIKv5qIqtQ+hIbBMXsq7KvX1kSU3ybRDZeQ=;
 b=RciQZePOm70DAm57Ot+NWxHWOMKeZjivap2a9gw2AWerHZzMRAbSoxpLMgIPkx0ugLiR12
 vPOhgBpnrLotab4Rok1aM8j464BWgmN1C7QgqmtIPC4lRrTSXYDkBFGolB51ByzRWshKIS
 81PZWIPaceCpUNjTPFFvh+/8eygw0s0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-jw3MDuN8OFuZnxySen45cw-1; Sun, 05 Jan 2020 07:59:59 -0500
Received: by mail-qv1-f69.google.com with SMTP id j10so2759180qvi.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tdoWlLoYwJDJiT74CT7GYIP+izHUlkgXXi1RbTtf6v8=;
 b=CoHqpNhrCqzo8ugyK0eCbPAQZP6MM+53yJwHM8RB1TiEeqhwLrMeHUYtgGiz4Pp0xN
 KI2o/D0DCEZ+5AkE5qfruhm1ExHA9rlM8i9x0HSC0+K8LNNyuNF5f3+rgp4H/CaJurv1
 NKyydIYOMlJJO9chWSDbzQWeSa91D8VLcKRNl5Zev7nSrKapToFNfaVLPHbXwQI4nD5h
 +EBs/epW2+rhYq8bsk9pIkAaFbYOM3SlcmqA6K7hNS8on3pqlSd/3Qf90ISrrjDvApY2
 Xs9EfPupGTHdC6JstbVKW8+dBJ7HeRJcMxBDlb3DFWgcBLr7kbHGH0MaTyASTKQ489Q7
 xckg==
X-Gm-Message-State: APjAAAXdQWTizB0fyqo+7Iv6n81c12L0w+4erTsuu9c0HqsYhS7yov4M
 hPRA48mpIUdORW8jVESeJD4H1ckUsioAJb7UpQRjkaz7XLvHnnzdrNSKOKITXLsW3xa6yQr5L2m
 3F2HjSpcorhdM2U0=
X-Received: by 2002:a37:6cc1:: with SMTP id h184mr77141179qkc.96.1578229198623; 
 Sun, 05 Jan 2020 04:59:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpj+KnaJfccbiF/CfsiYRydssjgq27XCEF2rQy1KfGYj6TbF1wmVWRF/GMaFw3zhUFUfoF+Q==
X-Received: by 2002:a37:6cc1:: with SMTP id h184mr77141168qkc.96.1578229198396; 
 Sun, 05 Jan 2020 04:59:58 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id t29sm18626355qkm.27.2020.01.05.04.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:59:57 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 30/32] virtio-net: delete also control queue when TX/RX
 deleted
Message-ID: <20200105125622.27231-31-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: jw3MDuN8OFuZnxySen45cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 qemu-stable@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
If the control queue is not deleted together with TX/RX, it
later will be ignored in freeing cache resources and hot
unplug will not be completed.

Cc: qemu-stable@nongnu.org
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20191226043649.14481-3-yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index db3d7c38e6..f325440d01 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3101,7 +3101,8 @@ static void virtio_net_device_unrealize(DeviceState *=
dev, Error **errp)
     for (i =3D 0; i < max_queues; i++) {
         virtio_net_del_queue(n, i);
     }
-
+    /* delete also control vq */
+    virtio_del_queue(vdev, max_queues * 2);
     qemu_announce_timer_del(&n->announce_timer, false);
     g_free(n->vqs);
     qemu_del_nic(n->nic);
--=20
MST


