Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32070C2D0CF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013F620709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSYDfcnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013F620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijQw9-0007XS-IM
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 11:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQlz-0003ag-BA
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQly-0005Q7-Cf
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQly-0005Pz-8w
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zj2wVrIh8KQNhFA65bESMfJP7roYgy+mFo3n5QglPhQ=;
 b=HSYDfcnQC1rZrfLybnIh+F7sEZoO5BTJ6cWKZFsEifZ/16PqQOB4MYbFbscw8uH4Lyr8ae
 nV6nmbTTXjWVO3+weUvzd3tya4KlFaP2xuhY2MSY5kZytijDgdFTGD430h0uCXyc4BKlqS
 VuBf3A79ZKN+VVwd4jkVbJtuS5Lb3FU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-WVBpQVurOlOncalRRBQsvg-1; Mon, 23 Dec 2019 11:41:32 -0500
Received: by mail-qv1-f71.google.com with SMTP id g15so11629472qvq.20
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sanExUpcAf7TPhNumiJmyXjhA8u9u6QpSUASPDnjn/0=;
 b=LC9+SpZn83E2noEEmikWriGeh4s3W3k3WBfdfsxUGNg/CPvt9YTVnanRt81M/ozsQN
 xW1q18QGDGYr1XLlWt8j+4xU5lTa6s4Vruyt1LUxrO57RP8RxR473nz+mtPgTxEIrrIy
 HDJAmWvNskYYnK33jWvXRcpWXcPnCKfyfg+cvEt+fy2PoI3eCUdsBEbvn/vxBgLQB89M
 2vU2xPTKbYqtltXLctnuPp/YGn0OVrdajyiDt2rQ5m4gg1yF8oBBdW3jC9Cwb8p/VRXZ
 bddtfP8m/4y610+OEM8s36ZUPNlJbC81gEejt3pXKEHDdP8CQtPeB9cieuz50q0aRhUX
 nEhw==
X-Gm-Message-State: APjAAAU5Zve9Gv0eb3SWKzhKwXL1Brz3+iu7Jsy5L7o/ZEFMHQESLG8z
 wlTRZrLSgShJwZGZYQ4NIr7nf/nCgvwVLi3w9WE1Z4qfxFyXCWL/6Xz94lO1cpkDNc5XgkEa8EP
 irPQvO4YRT0vlAI4=
X-Received: by 2002:ae9:f502:: with SMTP id o2mr25648392qkg.89.1577119291960; 
 Mon, 23 Dec 2019 08:41:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzAdDHozY1iPuJQG8QAYeBkagUKF7GQsAXj6//X2u+8eoZT7FHgzzX4GBZWz6jyImaIZhGZjw==
X-Received: by 2002:ae9:f502:: with SMTP id o2mr25648381qkg.89.1577119291761; 
 Mon, 23 Dec 2019 08:41:31 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 m10sm5848176qki.74.2019.12.23.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:41:31 -0800 (PST)
Date: Mon, 23 Dec 2019 11:41:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/27] virtio: update queue size on guest write
Message-ID: <20191223141536.72682-8-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: WVBpQVurOlOncalRRBQsvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some guests read back queue size after writing it.
Update the size immediatly upon write otherwise
they get confused.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..e5c759e19e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1256,6 +1256,8 @@ static void virtio_pci_common_write(void *opaque, hwa=
ddr addr,
         break;
     case VIRTIO_PCI_COMMON_Q_SIZE:
         proxy->vqs[vdev->queue_sel].num =3D val;
+        virtio_queue_set_num(vdev, vdev->queue_sel,
+                             proxy->vqs[vdev->queue_sel].num);
         break;
     case VIRTIO_PCI_COMMON_Q_MSIX:
         msix_vector_unuse(&proxy->pci_dev,
--=20
MST


