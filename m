Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28715C7618E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 07:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D5120868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 07:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D5120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmvJo-0007jN-ON
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 03:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53299)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hmvJe-0007LO-Sj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 03:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hmvJd-0006fo-UC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 03:22:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hmvJd-0006fB-OE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 03:22:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2CD2D3688B;
 Mon, 15 Jul 2019 07:22:28 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CFA61001B32;
 Mon, 15 Jul 2019 07:22:28 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id D2D5441F40;
 Mon, 15 Jul 2019 07:22:27 +0000 (UTC)
Date: Mon, 15 Jul 2019 03:22:27 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <281594465.163254.1563175347444.JavaMail.zimbra@redhat.com>
In-Reply-To: <37ab5984-4989-8003-0624-c86f9ada5ee8@redhat.com>
References: <20190712073554.21918-1-pagupta@redhat.com>
 <20190712073554.21918-4-pagupta@redhat.com>
 <37ab5984-4989-8003-0624-c86f9ada5ee8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.211, 10.4.195.18]
Thread-Topic: virtio pmem: remove transational device info
Thread-Index: v6d7O1MsigxqhS8yLclikkgc8ILIfg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 15 Jul 2019 07:22:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio pmem: remove transational
 device info
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
Cc: peter maydell <peter.maydell@linaro.org>, cohuck@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
> On 12.07.19 09:35, Pankaj Gupta wrote:
> > Remove transactional & non transactional device info
> > for virtio pmem.
> 
> Can you explain and add *why* ?

As per upstream suggestion by Cornelia & MST, transactional devices are for
legacy purpose. So, does not make sense for virtio-pmem.

Thanks,
Pankaj 

> 
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  hw/virtio/virtio-pmem-pci.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
> > index 0da6627469..fe2af00fa1 100644
> > --- a/hw/virtio/virtio-pmem-pci.c
> > +++ b/hw/virtio/virtio-pmem-pci.c
> > @@ -113,8 +113,6 @@ static void virtio_pmem_pci_instance_init(Object *obj)
> >  static const VirtioPCIDeviceTypeInfo virtio_pmem_pci_info = {
> >      .base_name             = TYPE_VIRTIO_PMEM_PCI,
> >      .generic_name          = "virtio-pmem-pci",
> > -    .transitional_name     = "virtio-pmem-pci-transitional",
> > -    .non_transitional_name = "virtio-pmem-pci-non-transitional",
> >      .instance_size = sizeof(VirtIOPMEMPCI),
> >      .instance_init = virtio_pmem_pci_instance_init,
> >      .class_init    = virtio_pmem_pci_class_init,
> > 
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 

