Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0852CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85843206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85843206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iORwI-0003TE-HK
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORuM-0000cW-7f
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORuL-00009z-5h
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORuK-00009j-T1
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:29 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05F314E832
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:28 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id k9so1171846qtg.2
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IdlizDIEBScJbIDv8LEKDA03XXP0B1/qZLoPYcS0j8Y=;
 b=jJOTP4Pz2evy4Fg4ECviWyDN9+ZT0ZbCS6NRGwS2VNxWwuOmhAfN4kbAzpZNr38GtG
 dMfohDjAOuyVxQ6trf6INM2Bf/YuVztX8yXMGyQd4lkLAYCs0XI3Oo3tuFpcb/PvATjF
 u4qLOzUz3x6841T0u1iMX+zYRLgiyo6KiQhuGVh+WJnMvFFcw8iuqAhXCwRBsF6J0f5D
 +pKNlGzdotoptHHXxJGD3VuBKSxtK5+9JJjO52Ayr+sQ7Wh6KvubuI1Mc+hGV0zLBdUC
 QKcAsre1c7lioMVtCEDLfKcU99uIJhXSucKbxL4jqfGE/oghZAo6bVguB89Mnx42D7NB
 aAPA==
X-Gm-Message-State: APjAAAV7amHL9J0binG6abHMgQaUutH6PVwxLLIp1sVA/sPA1uxv/84H
 meu/Brr+IEVds71a6ABwuwlS2oPJMtntEoLmNxOtNmDrFp/nLFxSLO9AaqHUjQ/sO6h4VUOJqdP
 sot+PTdGasfNqU/4=
X-Received: by 2002:a37:4a91:: with SMTP id x139mr9203337qka.103.1572118766662; 
 Sat, 26 Oct 2019 12:39:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw26a24A7ZfaRbgokatmmFGCer+OYlyMuTYcpfOmlNp0sKlpHIsOblY3zw+kNyeQmo0S5NHVA==
X-Received: by 2002:a37:4a91:: with SMTP id x139mr9203314qka.103.1572118766416; 
 Sat, 26 Oct 2019 12:39:26 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 r29sm3483747qtb.63.2019.10.26.12.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:25 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/25] virtio: Free blk virqueues at unrealize()
Message-ID: <20191026193824.11926-4-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eugenio P=C3=A9rez <eperezma@redhat.com>

The function virtio_del_queue was not called at unrealize() callback.

This was detected due to add an allocated element on the vq introduce
in future commits (used_elems) and running address sanitizer memory
leak detector.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Message-Id: <20191025083527.30803-4-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/virtio-blk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ed2ddebd2b..ba846fe9dc 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1206,9 +1206,14 @@ static void virtio_blk_device_unrealize(DeviceStat=
e *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOBlock *s =3D VIRTIO_BLK(dev);
+    VirtIOBlkConf *conf =3D &s->conf;
+    unsigned i;
=20
     virtio_blk_data_plane_destroy(s->dataplane);
     s->dataplane =3D NULL;
+    for (i =3D 0; i < conf->num_queues; i++) {
+        virtio_del_queue(vdev, i);
+    }
     qemu_del_vm_change_state_handler(s->change);
     blockdev_mark_auto_del(s->blk);
     virtio_cleanup(vdev);
--=20
MST


