Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5244C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB502068F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwhU+lhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB502068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvx5-0001mE-4Z
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvq3-000185-Uy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvq2-0003f9-T7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvq2-0003cQ-Mn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zj2wVrIh8KQNhFA65bESMfJP7roYgy+mFo3n5QglPhQ=;
 b=HwhU+lhSzy2xJNfzn8StHrNOmV2fplVMQYJCl7Xi9Dt09g0/TVW1ofpoUIDfT3QMqjy0uT
 tFOOGWs7WJlgHQyNg9QL9o3H59yyPTwhmMYD21mcTF0ROAg4n4WzTHuqAFSt+qI6oOKjT9
 Rf8y3lk+USaAVmkUjVPVlw84wcINkjY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-4BquQgKdOXqGIWJJ4J27Fg-1; Thu, 19 Dec 2019 08:27:33 -0500
Received: by mail-qk1-f199.google.com with SMTP id 12so3575745qkf.20
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sanExUpcAf7TPhNumiJmyXjhA8u9u6QpSUASPDnjn/0=;
 b=jTCSfoNiPHPfVs68xEs9ttEAyVA9pM8uWmvIaPbL7YYT+FDiCd2EJHQUlkuEwvWLNM
 yUPFS7W2dX5XfN1a9eoHqTkxszEzp1Mct1AdB2mSxL4DhlsHNcsjt0YeU04VVOPpfcy6
 enq4hzqlSU4FJuMpCEzyrwxbVFOl/lYE0v9Gr3rMrlfGiVm9kP1PEURC0bRmLXnjVRAx
 r0RT8YoutQyF+fVX2HyQvvx0Fs9mZCZ/Z6s7WkagF/VNPDea2ejHquQyWMFKkjuZW8Qp
 KHlVSd0IjASY++ccfAiqQiWcbQxd+jTzH0qDFJHNTquPY3qE7in9G89oCI+Cqq9jnezW
 0KEQ==
X-Gm-Message-State: APjAAAUDSo5tXs9uQXaBPfrng+o8LAK/1sqQZ8TNyNHwB9X+UtU/zkRS
 g+NjjgnavbkV8yAyxml+jroXAcqvDgzJmPydViuatWaVq2SvGSB9XbrXGvxeQ3TImUdftmHTQxB
 wAioaDh1yg4nTDJY=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr7000067qto.304.1576762052420; 
 Thu, 19 Dec 2019 05:27:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkA5yqJEFgrmZxI0g2Lrazb3uSDg2jMPT3Sp/NwzeIe2D+Z8sQlqs1fSN/YO0FvJGnFVn9MQ==
X-Received: by 2002:ac8:709a:: with SMTP id y26mr7000056qto.304.1576762052277; 
 Thu, 19 Dec 2019 05:27:32 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id g53sm443675qtk.76.2019.12.19.05.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:27:31 -0800 (PST)
Date: Thu, 19 Dec 2019 08:27:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/24] virtio: update queue size on guest write
Message-ID: <20191219132621.16595-8-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 4BquQgKdOXqGIWJJ4J27Fg-1
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


