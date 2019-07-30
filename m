Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1FC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D1820651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOiJ-0007d6-JZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hsOhs-0007Dp-IB
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hsOhr-0001Ul-Cy
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:46:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hsOhr-0001UU-3R
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0244D796E4;
 Tue, 30 Jul 2019 09:46:06 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA0535D9C5;
 Tue, 30 Jul 2019 09:45:50 +0000 (UTC)
Date: Tue, 30 Jul 2019 11:45:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190730114548.4ff4188b.cohuck@redhat.com>
In-Reply-To: <20190730064658.27369-1-pagupta@redhat.com>
References: <20190730064658.27369-1-pagupta@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 30 Jul 2019 09:46:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio pmem: user document
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
Cc: aarcange@redhat.com, david@redhat.com, riel@surriel.com,
 qemu-devel@nongnu.org, lcapitulino@redhat.com, mst@redhat.com,
 stefanha@redhat.com, nilal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 12:16:57 +0530
Pankaj Gupta <pagupta@redhat.com> wrote:

> This patch documents the steps to use virtio pmem.
> It also documents other useful information about
> virtio pmem e.g use-case, comparison with Qemu NVDIMM
> backend and current limitations.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  docs/virtio-pmem.txt | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 docs/virtio-pmem.txt
> 
> diff --git a/docs/virtio-pmem.txt b/docs/virtio-pmem.txt

Maybe make this ReST from the start? Should be trivial enough.

> new file mode 100644
> index 0000000000..fc61eebb20
> --- /dev/null
> +++ b/docs/virtio-pmem.txt
> @@ -0,0 +1,65 @@
> +
> +QEMU virtio pmem
> +===================
> +
> + This document explains the usage of virtio pmem device 

"setup and usage" ?

> + which is available since QEMU v4.1.0.
> +
> + The virtio pmem is paravirtualized persistent memory device

"The virtio pmem device is a paravirtualized..."

> + on regular(non-NVDIMM) storage. 
> +
> +Usecase
> +--------
> +  Allows to bypass the guest page cache and directly use host page cache.
> +  This reduces guest memory footprint as host can make efficient memory

s/as host/,as the host/

> +  reclaim decisions under memory pressure.
> +
> +o How does virtio-pmem compare to the nvdimm emulation supported by QEMU?
> +
> +  NVDIMM emulation on regular(non-NVDIMM) host storage does not persists

s/regular(non-NVDIMM)/regular (i.e. non-NVDIMM)/ ?
s/persists/persist/

> +  the guest writes as there are no defined semantecs in the device specification.

s/semantecs/semantics/

> +  With virtio pmem device, guest write persistence on non-NVDIMM storage is
> +  supported.

"The virtio pmem device provides a way to support guest write
persistence on non-NVDIMM storage." ?

> +
> +virtio pmem usage
> +-----------------
> +  virtio pmem device is created with a memory-backend-file with the below
> +  options:

"A virtio pmem device backed by a memory-backend-file can be created on
the QEMU command line as in the following example:" ?

> +
> +  -machine pc -m 8G,slots=$N,maxmem=$MAX_SIZE

I'm not sure you should explicitly specify the machine type in this
example. I think it is fine to say that something is only supported on
a subset of machine types, but it should not make its way into an
example on how to configure a device and its backing.

Also, maybe fill in more concrete values here? Or split it into a part
specifying the syntax (where I'd use <max_size> instead of $MAX_SIZE
etc.), and a more concrete example?

> +  -object memory-backend-file,id=mem1,share,mem-path=$PATH,size=$SIZE
> +  -device virtio-pmem-pci,memdev=mem1,id=nv1
> +
> +   where:
> +   - "object memory-backend-file,id=mem1,share,mem-path=$PATH,size=$VIRTIO_PMEM_SIZE"
> +     creates a backend storage of size $SIZE on a file $PATH. All
> +     accesses to the virtio pmem device go to the file $PATH.
> +
> +   - "device virtio-pmem-pci,id=nvdimm1,memdev=mem1" creates a virtio pmem
> +     device whose storage is provided by above memory backend device.

"a virtio pmem PCI device" ?

> +
> +  Multiple virtio pmem devices can be created if multiple pairs of "-object"
> +  and "-device" are provided.
> +
> +Hotplug
> +-------
> +Accomplished by two monitor commands "object_add" and "device_add".

Hm... what about the following instead:

"Virtio pmem devices can be hotplugged via the QEMU monitor. First, the
memory backing has to be added via 'object_add'; afterwards, the virtio
pmem device can be added via 'device_add'."

> +
> +For example, the following commands add another 4GB virtio pmem device to
> +the guest:
> +
> + (qemu) object_add memory-backend-file,id=mem2,share=on,mem-path=virtio_pmem2.img,size=4G
> + (qemu) device_add virtio-pmem-pci,id=virtio_pmem2,memdev=mem2
> +
> +Guest Data Persistence
> +----------------------
> +Guest data persistence on non-NVDIMM requires guest userspace application to 

s/application/applications/ ?

> +perform fsync/msync. This is different than real nvdimm backend where no additional

s/than/from a/ ?

> +fsync/msync is required for data persistence.

Should we be a bit more verbose on what which guest applications are
supposed to do? I.e., how do they know they need to do fsync/msync,
when should they do it, and what are the consequences if they don't?

> +
> +Limitations
> +------------
> +- Real nvdimm device backend is not supported.
> +- virtio pmem hotunplug is not supported.
> +- ACPI NVDIMM features like regions/namespaces are not supported.
> +- ndctl command is not supported.


