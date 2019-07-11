Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FCC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1719F20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1719F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZiZ-00009B-E9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55123)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hlZhu-00088u-9l
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hlZhp-0008Q7-9Q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hlZhp-0008PA-2W
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57AC04E938;
 Thu, 11 Jul 2019 14:05:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BCB05D72E;
 Thu, 11 Jul 2019 14:05:52 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 40FDA1818485;
 Thu, 11 Jul 2019 14:05:52 +0000 (UTC)
Date: Thu, 11 Jul 2019 10:05:51 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <321746293.40974532.1562853951874.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA9=t7uK+=P3noWnP2Ga7=eKiPy9ZoDG9x=ty1P9UJgS3g@mail.gmail.com>
References: <20190702150606.24851-1-mst@redhat.com>
 <20190619094907.10131-2-pagupta@redhat.com>
 <CAFEAcA9=t7uK+=P3noWnP2Ga7=eKiPy9ZoDG9x=ty1P9UJgS3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.25, 10.4.195.24]
Thread-Topic: virtio-pmem: add virtio device
Thread-Index: Khf4yjVrVCqHefU2+Ipii6DLX2rOTw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 11 Jul 2019 14:05:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 05/22] virtio-pmem: add virtio device
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
Cc: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> >
> > From: Pankaj Gupta <pagupta@redhat.com>
> >
> > This is the implementation of virtio-pmem device. Support will require
> > machine changes for the architectures that will support it, so it will
> > not yet be compiled. It can be unlocked with VIRTIO_PMEM_SUPPORTED per
> > machine and disabled globally via VIRTIO_PMEM.
> >
> > We cannot use the "addr" property as that is already used e.g. for
> > virtio-pci/pci devices. And we will have e.g. virtio-pmem-pci as a proxy.
> > So we have to choose a different one (unfortunately). "memaddr" it is.
> > That name should ideally be used by all other virtio-* based memory
> > devices in the future.
> >     -device virtio-pmem-pci,id=p0,bus=bux0,addr=0x01,memaddr=0x1000000...
> >
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > [ QAPI bits ]
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>'-numa node,memdev
> > [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
> >   split up patches, unplug handler ]
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > Message-Id: <20190619094907.10131-2-pagupta@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > +static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
> > +                                         VirtioPMEMDeviceInfo *vi)
> > +{
> > +    vi->memaddr = pmem->start;
> > +    vi->size = pmem->memdev ? memory_region_size(&pmem->memdev->mr) : 0;
> > +    vi->memdev = object_get_canonical_path(OBJECT(pmem->memdev));
> 
> Hi; Coverity points out (CID 1403009) that when we're assigning
> vi->size we handle the "pmem->memdev is NULL" case; but we then
> pass it into object_get_canonical_path(), which unconditionally
> dereferences it and will crash if it is NULL. If this pointer
> can be NULL then we need to do something else here.

This will never be NULL. I will send below patch to pass coverity.

- vi->size = pmem->memdev ? memory_region_size(&pmem->memdev->mr) : 0;
+ vi->size = memory_region_size(&pmem->memdev->mr);

Thanks,
Pankaj

> 
> > +}
> 
> thanks
> -- PMM
> 
> 

