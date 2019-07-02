Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE11C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C8421852
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C8421852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOdg-0005Mx-EW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiMHi-0003AT-9E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiMHg-0004T3-5w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:09:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiMHf-0004RG-WF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:09:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACCC4309174E;
 Tue,  2 Jul 2019 17:09:33 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 7CED21001B1B;
 Tue,  2 Jul 2019 17:09:23 +0000 (UTC)
Date: Tue, 2 Jul 2019 13:09:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190702130653-mutt-send-email-mst@kernel.org>
References: <20190619094907.10131-1-pagupta@redhat.com>
 <20190619094907.10131-5-pagupta@redhat.com>
 <20190702135519.46a9e3f2.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702135519.46a9e3f2.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 02 Jul 2019 17:09:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/7] virtio-pci: Proxy for virtio-pmem
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
Cc: kwolf@redhat.com, Pankaj Gupta <pagupta@redhat.com>,
 xiaoguangrong.eric@gmail.com, riel@surriel.com, armbru@redhat.com,
 david@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 lcapitulino@redhat.com, aarcange@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com,
 nilal@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 01:55:19PM +0200, Cornelia Huck wrote:
> On Wed, 19 Jun 2019 15:19:04 +0530
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > We need a proxy device for virtio-pmem, and this device has to be the
> > actual memory device so we can cleanly hotplug it.
> > 
> > Forward memory device class functions either to the actual device or use
> > properties of the virtio-pmem device to implement these in the proxy.
> > 
> > virtio-pmem will only be compiled for selected, supported architectures
> > (that can deal with virtio/pci devices being memory devices). An
> > architecture that is prepared for that can simply enable
> > CONFIG_VIRTIO_PMEM to make it work.
> > 
> > As not all architectures support memory devices (and CONFIG_VIRTIO_PMEM
> > will be enabled per supported architecture), we have to move the PCI proxy
> > to a separate file.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > [ split up patches, memory-device changes, move pci proxy]
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/virtio/Makefile.objs     |   1 +
> >  hw/virtio/virtio-pmem-pci.c | 131 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/virtio/virtio-pmem-pci.h |  34 ++++++++++++
> >  include/hw/pci/pci.h        |   1 +
> >  4 files changed, 167 insertions(+)
> >  create mode 100644 hw/virtio/virtio-pmem-pci.c
> >  create mode 100644 hw/virtio/virtio-pmem-pci.h
> 
> (...)
> 
> > +static const VirtioPCIDeviceTypeInfo virtio_pmem_pci_info = {
> > +    .base_name             = TYPE_VIRTIO_PMEM_PCI,
> > +    .generic_name          = "virtio-pmem-pci",
> > +    .transitional_name     = "virtio-pmem-pci-transitional",
> 
> Do we even have a transitional device for this? I.e., do we have a
> legacy version? I don't think that makes sense for new devices.


I agree - I applied so pls send a patch on top.
Or if you end up having to respin pls include this.

> > +    .non_transitional_name = "virtio-pmem-pci-non-transitional",

Neither do we need a non transitional name.

> > +    .instance_size = sizeof(VirtIOPMEMPCI),
> > +    .instance_init = virtio_pmem_pci_instance_init,
> > +    .class_init    = virtio_pmem_pci_class_init,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        { TYPE_MEMORY_DEVICE },
> > +        { }
> > +    },
> > +};
> 
> (...)

