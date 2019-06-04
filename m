Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBD6C28CC6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C8420B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C8420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY9KE-0001Gu-JK
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 09:18:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hY9Io-0000Rk-Ep
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hY9In-0003TC-IP
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:16:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hY9In-0002zr-Cm
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:16:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E68C3001809;
	Tue,  4 Jun 2019 13:15:56 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C33319C69;
	Tue,  4 Jun 2019 13:15:43 +0000 (UTC)
Date: Tue, 4 Jun 2019 15:15:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190604151540.1076d3d8.cohuck@redhat.com>
In-Reply-To: <20190523102449.2642-2-pagupta@redhat.com>
References: <20190523102449.2642-1-pagupta@redhat.com>
	<20190523102449.2642-2-pagupta@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 04 Jun 2019 13:15:56 +0000 (UTC)
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
Cc: kwolf@redhat.com, aarcange@redhat.com, xiaoguangrong.eric@gmail.com,
	mst@redhat.com, armbru@redhat.com, riel@surriel.com,
	david@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
	lcapitulino@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
	imammedo@redhat.com, dan.j.williams@intel.com, nilal@redhat.com,
	dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 15:54:43 +0530
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
>  hw/virtio/virtio-pmem.c         | 190 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-pmem.h |  49 +++++++++++
>  qapi/misc.json                  |  28 +++++-
>  5 files changed, 277 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/virtio-pmem.c
>  create mode 100644 include/hw/virtio/virtio-pmem.h

> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> new file mode 100644
> index 0000000000..c462d2c942
> --- /dev/null
> +++ b/hw/virtio/virtio-pmem.c
> @@ -0,0 +1,190 @@

> +static void virtio_pmem_unrealize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
> +
> +    host_memory_backend_set_mapped(pmem->memdev, false);
> +    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);

Adding a queue during unrealize looks weird... copy/paste error?

> +    virtio_cleanup(vdev);
> +}

