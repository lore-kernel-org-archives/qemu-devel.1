Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7358C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E43A2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E43A2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49455 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3UQ-0005fM-AK
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:15:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hU3Ta-0004o8-FM
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hU3Gk-0005cn-Qw
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hU3Gj-0005YH-1v
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59C76302451A;
	Fri, 24 May 2019 06:01:18 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30B5A6198B;
	Fri, 24 May 2019 06:01:16 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id A48975B423;
	Fri, 24 May 2019 06:01:12 +0000 (UTC)
Date: Fri, 24 May 2019 02:01:12 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <1169789759.30828172.1558677672163.JavaMail.zimbra@redhat.com>
In-Reply-To: <cf892fc7-37f8-5819-eba7-dd007ed4f2c5@redhat.com>
References: <20190523102449.2642-1-pagupta@redhat.com>
	<20190523102449.2642-2-pagupta@redhat.com>
	<cf892fc7-37f8-5819-eba7-dd007ed4f2c5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.169, 10.4.195.20]
Thread-Topic: virtio-pmem: add virtio device
Thread-Index: OrIYvle9T020FYjOkOaPVYhsa9vULg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 24 May 2019 06:01:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/7] virtio-pmem: add virtio device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
	xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	mst@redhat.com, armbru@redhat.com, riel@surriel.com,
	david@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
	lcapitulino@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
	imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>,
	nilal@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
> On 5/23/19 5:24 AM, Pankaj Gupta wrote:
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
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
> >   split up patches, unplug handler ]
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> 
> > +++ b/qapi/misc.json
> > @@ -2742,16 +2742,42 @@
> >            }
> >  }
> >  
> > +##
> > +# @VirtioPMEMDeviceInfo:
> > +#
> > +# VirtioPMEM state information
> > +#
> > +# @id: device's ID
> > +#
> > +# @memaddr: physical address in memory, where device is mapped
> > +#
> > +# @size: size of memory that the device provides
> > +#
> > +# @memdev: memory backend linked with device
> > +#
> > +# Since: 4.0
> 
> You've missed 4.0; this should be 4.1.

Yes. Will update.

> 
> > +##
> > +{ 'struct': 'VirtioPMEMDeviceInfo',
> > +  'data': { '*id': 'str',
> 
> Why is id optional? Does it make sense to have a device without an id?

I think that's how it has been for both NVDIMM and DIMM. And it works
fine with optional 'id', but requires unique 'id' for underlying memory device. 
That means its okay to keep 'id' optional for root dimm/nvdimm/virtio-pmem 
devices. 

Thanks,
Pankaj

> 
> > +            'memaddr': 'size',
> > +            'size': 'size',
> > +            'memdev': 'str'
> > +          }
> > +}
> > +
> >  ##
> >  # @MemoryDeviceInfo:
> >  #
> >  # Union containing information about a memory device
> >  #
> > +# nvdimm is included since 2.12. virtio-pmem is included since 4.0.
> 
> 4.1

o.k

> 
> > +#
> >  # Since: 2.1
> >  ##
> >  { 'union': 'MemoryDeviceInfo',
> >    'data': { 'dimm': 'PCDIMMDeviceInfo',
> > -            'nvdimm': 'PCDIMMDeviceInfo'
> > +            'nvdimm': 'PCDIMMDeviceInfo',
> > +            'virtio-pmem': 'VirtioPMEMDeviceInfo'
> >            }
> >  }
> >  
> > 
> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 
> 

