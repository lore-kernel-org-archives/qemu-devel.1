Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395EEC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1197021479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1197021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHKn-00015O-Bk
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hiHFq-00067y-NB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hiHFm-0001A2-Oc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hiHFi-000123-Ty
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82F6D307D96F;
 Tue,  2 Jul 2019 11:47:11 +0000 (UTC)
Received: from gondolin (dhcp-192-192.str.redhat.com [10.33.192.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 067355D9C3;
 Tue,  2 Jul 2019 11:46:55 +0000 (UTC)
Date: Tue, 2 Jul 2019 13:46:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190702134653.1a529826.cohuck@redhat.com>
In-Reply-To: <20190619094907.10131-2-pagupta@redhat.com>
References: <20190619094907.10131-1-pagupta@redhat.com>
 <20190619094907.10131-2-pagupta@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 02 Jul 2019 11:47:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/7] virtio-pmem: add virtio device
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
Cc: kwolf@redhat.com, aarcange@redhat.com, xiaoguangrong.eric@gmail.com,
 mst@redhat.com, armbru@redhat.com, riel@surriel.com, david@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com, lcapitulino@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 dan.j.williams@intel.com, nilal@redhat.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Jun 2019 15:19:01 +0530
Pankaj Gupta <pagupta@redhat.com> wrote:

> This is the implementation of virtio-pmem device. Support will require
> machine changes for the architectures that will support it, so it will
> not yet be compiled. It can be unlocked with VIRTIO_PMEM_SUPPORTED per
> machine and disabled globally via VIRTIO_PMEM.
> 
> We cannot use the "addr" property as that is already used e.g. for
> virtio-pci/pci devices. And we will have e.g. virtio-pmem-pci as a proxy.
> So we have to choose a different one (unfortunately). "memaddr" it is.
> That name should ideally be used by all other virtio-* based memory
> devices in the future.
>     -device virtio-pmem-pci,id=p0,bus=bux0,addr=0x01,memaddr=0x1000000...
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> [ QAPI bits ]
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
>   split up patches, unplug handler ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/Kconfig               |  10 +++
>  hw/virtio/Makefile.objs         |   1 +
>  hw/virtio/virtio-pmem.c         | 189 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-pmem.h |  49 +++++++++++
>  qapi/misc.json                  |  28 +++++-
>  5 files changed, 276 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/virtio-pmem.c
>  create mode 100644 include/hw/virtio/virtio-pmem.h
> 

> diff --git a/qapi/misc.json b/qapi/misc.json
> index dc4cf9da20..6f1bff10e4 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2738,16 +2738,42 @@
>            }
>  }
>  
> +##
> +# @VirtioPMEMDeviceInfo:
> +#
> +# VirtioPMEM state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 4.1

Not sure if this can still make it...

> +##
> +{ 'struct': 'VirtioPMEMDeviceInfo',
> +  'data': { '*id': 'str',
> +            'memaddr': 'size',
> +            'size': 'size',
> +            'memdev': 'str'
> +          }
> +}
> +
>  ##
>  # @MemoryDeviceInfo:
>  #
>  # Union containing information about a memory device
>  #
> +# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
> +#
>  # Since: 2.1
>  ##
>  { 'union': 'MemoryDeviceInfo',
>    'data': { 'dimm': 'PCDIMMDeviceInfo',
> -            'nvdimm': 'PCDIMMDeviceInfo'
> +            'nvdimm': 'PCDIMMDeviceInfo',
> +            'virtio-pmem': 'VirtioPMEMDeviceInfo'
>            }
>  }
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

