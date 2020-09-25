Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CADC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F84F21D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTcn7oVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F84F21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmwJ-0007ky-Az
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLmhl-0001NE-Vk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLmhj-0005dD-OK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:20:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601036399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1Ok+S4tCqvlGBK8mlM5wkU0Ocgo70X7Bu7JzOiKepQ=;
 b=hTcn7oVaehSRSW5b2SStQvkJHwpooj+Zrma5IvHALb4NM6GKu/zpmuzQtgooOcMepbAalR
 tQBRoIKMFU2J1pwcwiZ9pUTk+krFXXu19WnOfbaGVRg+4MAu1TQEWUYLyQykOYy/20V9qd
 wSmegCXpkpQp4ThGbKhK2ug3V6Z04KE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-4VN7quNmPySyZWlRVXo_vw-1; Fri, 25 Sep 2020 08:19:57 -0400
X-MC-Unique: 4VN7quNmPySyZWlRVXo_vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36B3F18B9F42;
 Fri, 25 Sep 2020 12:19:56 +0000 (UTC)
Received: from gondolin (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BEC95D9DC;
 Fri, 25 Sep 2020 12:19:49 +0000 (UTC)
Date: Fri, 25 Sep 2020 14:19:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH] virtio-pmem-pci: force virtio version 1
Message-ID: <20200925141947.4c30b2a8.cohuck@redhat.com>
In-Reply-To: <CAM9Jb+gmKmqVmb+BsNQ5R_rxiwEKBJKhEiO_=j_dYnoLkLC_cQ@mail.gmail.com>
References: <20200925102251.7216-1-pankaj.gupta.linux@gmail.com>
 <20200925123837.1733dcdc.cohuck@redhat.com>
 <CAM9Jb+gmKmqVmb+BsNQ5R_rxiwEKBJKhEiO_=j_dYnoLkLC_cQ@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: David Hildenbrand <david@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 13:49:05 +0200
Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

> >  
> > >  Qemu fails with below error when trying to run with virtio pmem:
> > >
> > >  (qemu) qemu-system-x86_64: -device virtio-pmem-pci,memdev=mem1,id=nv1:
> > >   device is modern-only, use disable-legacy=on  
> >
> > Oh, another one :(  
> :)
> >  
> > >
> > >  This patch fixes this by forcing virtio 1 with virtio-pmem.
> > >
> > > fixes: adf0748a49 ("virtio-pci: Proxy for virtio-pmem")
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > > ---
> > >  hw/virtio/virtio-pmem-pci.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
> > > index 21a457d151..2b2a0b1eae 100644
> > > --- a/hw/virtio/virtio-pmem-pci.c
> > > +++ b/hw/virtio/virtio-pmem-pci.c
> > > @@ -22,6 +22,7 @@ static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > >      VirtIOPMEMPCI *pmem_pci = VIRTIO_PMEM_PCI(vpci_dev);
> > >      DeviceState *vdev = DEVICE(&pmem_pci->vdev);
> > >
> > > +    virtio_pci_force_virtio_1(vpci_dev);
> > >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > >  }
> > >  
> >
> > The alternative would be to force virtio 1 only for 5.1 and later (see
> > https://lore.kernel.org/qemu-devel/20200921122506.82515-1-sgarzare@redhat.com/).  
> 
> Thanks for sharing this. It's still good to mark virtio pmem as a
> modern virtio device.

If you don't really need to care about compat handling, forcing virtio
1 is fine.

Acked-by: Cornelia Huck <cohuck@redhat.com>


