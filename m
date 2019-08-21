Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50BAC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B843A22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B843A22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0P7L-0004A4-Lm
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pagupta@redhat.com>) id 1i0P5G-0002Bf-Gp
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1i0P59-0004jM-R6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1i0P57-0004fc-Sw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7EE7308FC4D;
 Wed, 21 Aug 2019 11:47:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF08B2E07C;
 Wed, 21 Aug 2019 11:47:10 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9E5791803B58;
 Wed, 21 Aug 2019 11:47:10 +0000 (UTC)
Date: Wed, 21 Aug 2019 07:47:10 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <1761975250.9673246.1566388030011.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190821132440.066dfbba.cohuck@redhat.com>
References: <20190821073630.2561-1-pagupta@redhat.com>
 <20190821132440.066dfbba.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.177, 10.4.195.26]
Thread-Topic: virtio pmem: user document
Thread-Index: ++MfrA1XY/bimkRUBv5J22FkR4vFWQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 21 Aug 2019 11:47:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtio pmem: user document
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
Cc: mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 lcapitulino@redhat.com, stefanha@redhat.com, riel@surriel.com,
 nilal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Cornelia,

> > This patch documents the steps to use virtio pmem.
> > It also documents other useful information about
> > virtio pmem e.g use-case, comparison with Qemu NVDIMM
> > backend and current limitations.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> > v1->v2
> >  - Fixes on text format and 'Guest Data persistence'
> >    section - Cornelia
> > 
> >  docs/virtio-pmem.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 docs/virtio-pmem.rst
> > 
> > diff --git a/docs/virtio-pmem.rst b/docs/virtio-pmem.rst
> > new file mode 100644
> > index 0000000000..0346e61674
> > --- /dev/null
> > +++ b/docs/virtio-pmem.rst
> > @@ -0,0 +1,75 @@
> > +
> > +========================
> > +QEMU virtio pmem
> > +========================
> > +
> > + This document explains the setup and usage of virtio pmem device
> 
> s/virtio pmem device/the virtio pmem device/

done

> 
> > + which is available since QEMU v4.1.0.
> > +
> > + The virtio pmem is a paravirtualized persistent memory device on
> 
> s/The virtio pmem/The virtio pmem device/

o.k

> 
> > + regular(i.e non-NVDIMM) storage.
> 
> missing blank before '('

sure
> 
> > +
> > +Usecase
> > +--------
> > +
> > +  Allows to bypass the guest page cache and directly use host page cache.
> 
> "Virtio pmem allows to..." ?

done.

> 
> > +  This reduces guest memory footprint as the host can make efficient
> > +  memory reclaim decisions under memory pressure.
> > +
> > +o How does virtio-pmem compare to the nvdimm emulation supported by QEMU?
> > +
> > +  NVDIMM emulation on regular(i.e. non-NVDIMM) host storage does not
> 
> missing blank before '('

done.
> 
> > +  persist the guest writes as there are no defined semantics in the device
> > +  specification. The virtio pmem device provides guest write persistence
> > +  on non-NVDIMM host storage.
> > +
> > +virtio pmem usage
> > +-----------------
> > +
> > +  A virtio pmem device backed by a memory-backend-file can be created on
> > +  the QEMU command line as in the following example:
> > +
> > +  -object
> > memory-backend-file,id=mem1,share,mem-path=./virtio_pmem.img,size=4G
> > +  -device virtio-pmem-pci,memdev=mem1,id=nv1
> > +
> > +   where:
> > +   - "object memory-backend-file,id=mem1,share,mem-path=<image>,
> > size=<image size>"
> > +     creates a backend file of size on a mem-path.
> 
> "a backend file with the specified size" ?

done.

> 
> > +
> > +   - "device virtio-pmem-pci,id=nvdimm1,memdev=mem1" creates a virtio pmem
> > +     pci device whose storage is provided by above memory backend device.
> > +
> > +  Multiple virtio pmem devices can be created if multiple pairs of
> > "-object"
> > +  and "-device" are provided.
> > +
> > +Hotplug
> > +-------
> > +
> > +"Virtio pmem devices can be hotplugged via the QEMU monitor. First, the
> > +memory backing has to be added via 'object_add'; afterwards, the virtio
> > +pmem device can be added via 'device_add'."
> 
> Please lose the '"' (copy/paste leftover, I presume? :)

Done :)

> 
> > +
> > +For example, the following commands add another 4GB virtio pmem device to
> > +the guest:
> > +
> > + (qemu) object_add
> > memory-backend-file,id=mem2,share=on,mem-path=virtio_pmem2.img,size=4G
> > + (qemu) device_add virtio-pmem-pci,id=virtio_pmem2,memdev=mem2
> > +
> > +Guest Data Persistence
> > +----------------------
> > +
> > + Guest data persistence on non-NVDIMM requires guest userspace application
> > to
> 
> s/application/applications/ ?

done.

> 
> > + perform fsync/msync. This is different from a real nvdimm backend where
> > no
> > + additional fsync/msync is required. This is to persist guest writes in
> > host
> > + backing file which otherwise remains in host page cache and there is risk
> > of
> > + losing the data in case of power failure.
> > +
> > + With virtio pmem device, MAP_SYNC mmap flag is not supported. This
> > provides
> > + a hint to application to perform fsync for write persistence.
> > +
> > +Limitations
> > +------------
> > +- Real nvdimm device backend is not supported.
> > +- virtio pmem hotunplug is not supported.
> > +- ACPI NVDIMM features like regions/namespaces are not supported.
> > +- ndctl command is not supported.
> 
> Only some nits from my side, otherwise looks good to me.

Thank you for the review. Will post a v3 with the changes.

Best regards,
Pankaj

> 

