Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE0C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089F121537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089F121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZG4-0004G9-9g
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hlZES-0002Cm-M4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hlZER-00013w-KQ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hlZER-00012T-D3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:35:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E0DD30842AC;
 Thu, 11 Jul 2019 13:27:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D1D560BFB;
 Thu, 11 Jul 2019 13:27:57 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 296F7206D1;
 Thu, 11 Jul 2019 13:27:57 +0000 (UTC)
Date: Thu, 11 Jul 2019 09:27:56 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1989916325.40961265.1562851676762.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA_fHQKz3Kw1sumQHRLvq+LQ1nLo3V3v_dXE7PRT8xou9w@mail.gmail.com>
References: <20190702150606.24851-1-mst@redhat.com>
 <20190619094907.10131-5-pagupta@redhat.com>
 <CAFEAcA_fHQKz3Kw1sumQHRLvq+LQ1nLo3V3v_dXE7PRT8xou9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.25, 10.4.195.1]
Thread-Topic: virtio-pci: Proxy for virtio-pmem
Thread-Index: w6lLIHCpQ1uGtQb9RExyg1k+2Qp1JQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 11 Jul 2019 13:27:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 08/22] virtio-pci: Proxy for virtio-pmem
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
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Peter,

> > From: Pankaj Gupta <pagupta@redhat.com>
> >
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
> > Message-Id: <20190619094907.10131-5-pagupta@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Hi; Coverity spotted a bug here (CID 1403010):
> 
> > +static uint64_t virtio_pmem_pci_get_plugged_size(const MemoryDeviceState
> > *md,
> > +                                                 Error **errp)
> > +{
> > +    VirtIOPMEMPCI *pci_pmem = VIRTIO_PMEM_PCI(md);
> > +    VirtIOPMEM *pmem = VIRTIO_PMEM(&pci_pmem->vdev);
> > +    VirtIOPMEMClass *vpc = VIRTIO_PMEM_GET_CLASS(pmem);
> > +    MemoryRegion *mr = vpc->get_memory_region(pmem, errp);
> > +
> > +    /* the plugged size corresponds to the region size */
> > +    return mr ? 0 : memory_region_size(mr);
> 
> This looks like maybe the arguments to ?: have been put
> the wrong way round? If mr is non-NULL we'll return 0
> and if it is NULL then we'll crash because memory_region_size()
> dereferences mr...

Yes. I will send a patch to fix this.

Thanks,
Pankaj

> 
> > +}
> 
> thanks
> -- PMM
> 
> 

