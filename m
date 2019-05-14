Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACFC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2552F2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2552F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQSga-00048C-59
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 04:21:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hQSfZ-0003gL-AO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hQSfX-0007l0-Jo
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hQSfX-0007jk-BZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:20:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03F6285363;
	Tue, 14 May 2019 08:20:12 +0000 (UTC)
Received: from [10.36.117.118] (ovpn-117-118.ams2.redhat.com [10.36.117.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C4A05D720;
	Tue, 14 May 2019 08:19:53 +0000 (UTC)
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-3-pagupta@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
Date: Tue, 14 May 2019 10:19:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510155202.14737-3-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 14 May 2019 08:20:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
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
Cc: jack@suse.cz, mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
	lcapitulino@redhat.com, adilger.kernel@dilger.ca,
	zwisler@kernel.org, aarcange@redhat.com, dave.jiang@intel.com,
	jstaron@google.com, darrick.wong@oracle.com,
	vishal.l.verma@intel.com, willy@infradead.org, hch@infradead.org,
	jmoyer@redhat.com, nilal@redhat.com, lenb@kernel.org,
	kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, kwolf@redhat.com, tytso@mit.edu,
	xiaoguangrong.eric@gmail.com, cohuck@redhat.com,
	rjw@rjwysocki.net, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.05.19 17:51, Pankaj Gupta wrote:
> This patch adds virtio-pmem driver for KVM guest.
>=20
> Guest reads the persistent memory range information from
> Qemu over VIRTIO and registers it on nvdimm_bus. It also
> creates a nd_region object with the persistent memory
> range information so that existing 'nvdimm/pmem' driver
> can reserve this into system memory map. This way
> 'virtio-pmem' driver uses existing functionality of pmem
> driver to register persistent memory compatible for DAX
> capable filesystems.
>=20
> This also provides function to perform guest flush over
> VIRTIO from 'pmem' driver when userspace performs flush
> on DAX memory range.
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  drivers/nvdimm/Makefile          |   1 +
>  drivers/nvdimm/nd_virtio.c       | 129 +++++++++++++++++++++++++++++++
>  drivers/nvdimm/virtio_pmem.c     | 117 ++++++++++++++++++++++++++++
>  drivers/virtio/Kconfig           |  10 +++
>  include/linux/virtio_pmem.h      |  60 ++++++++++++++
>  include/uapi/linux/virtio_ids.h  |   1 +
>  include/uapi/linux/virtio_pmem.h |  10 +++
>  7 files changed, 328 insertions(+)
>  create mode 100644 drivers/nvdimm/nd_virtio.c
>  create mode 100644 drivers/nvdimm/virtio_pmem.c
>  create mode 100644 include/linux/virtio_pmem.h
>  create mode 100644 include/uapi/linux/virtio_pmem.h
>=20
> diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
> index 6f2a088afad6..cefe233e0b52 100644
> --- a/drivers/nvdimm/Makefile
> +++ b/drivers/nvdimm/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_ND_BTT) +=3D nd_btt.o
>  obj-$(CONFIG_ND_BLK) +=3D nd_blk.o
>  obj-$(CONFIG_X86_PMEM_LEGACY) +=3D nd_e820.o
>  obj-$(CONFIG_OF_PMEM) +=3D of_pmem.o
> +obj-$(CONFIG_VIRTIO_PMEM) +=3D virtio_pmem.o nd_virtio.o
> =20
>  nd_pmem-y :=3D pmem.o
> =20
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> new file mode 100644
> index 000000000000..ed7ddcc5a62c
> --- /dev/null
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * virtio_pmem.c: Virtio pmem Driver
> + *
> + * Discovers persistent memory range information
> + * from host and provides a virtio based flushing
> + * interface.
> + */
> +#include <linux/virtio_pmem.h>
> +#include "nd.h"
> +
> + /* The interrupt handler */
> +void host_ack(struct virtqueue *vq)
> +{
> +	unsigned int len;
> +	unsigned long flags;
> +	struct virtio_pmem_request *req, *req_buf;
> +	struct virtio_pmem *vpmem =3D vq->vdev->priv;

Nit: use reverse Christmas tree layout :)

> +
> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	while ((req =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
> +		req->done =3D true;
> +		wake_up(&req->host_acked);
> +
> +		if (!list_empty(&vpmem->req_list)) {
> +			req_buf =3D list_first_entry(&vpmem->req_list,
> +					struct virtio_pmem_request, list);
> +			req_buf->wq_buf_avail =3D true;
> +			wake_up(&req_buf->wq_buf);
> +			list_del(&req_buf->list);
> +		}
> +	}
> +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(host_ack);
> +
> + /* The request submission function */
> +int virtio_pmem_flush(struct nd_region *nd_region)
> +{
> +	int err, err1;
> +	unsigned long flags;
> +	struct scatterlist *sgs[2], sg, ret;
> +	struct virtio_device *vdev =3D nd_region->provider_data;
> +	struct virtio_pmem *vpmem =3D vdev->priv;
> +	struct virtio_pmem_request *req;

Nit: use reverse Christmas tree layout :)

> +
> +	might_sleep();
> +	req =3D kmalloc(sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->done =3D false;
> +	strcpy(req->name, "FLUSH");
> +	init_waitqueue_head(&req->host_acked);
> +	init_waitqueue_head(&req->wq_buf);
> +	INIT_LIST_HEAD(&req->list);
> +	sg_init_one(&sg, req->name, strlen(req->name));
> +	sgs[0] =3D &sg;
> +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> +	sgs[1] =3D &ret;
> +
> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	 /*
> +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> +	  * queue does not have free descriptor. We add the request
> +	  * to req_list and wait for host_ack to wake us up when free
> +	  * slots are available.
> +	  */
> +	while ((err =3D virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req,
> +					GFP_ATOMIC)) =3D=3D -ENOSPC) {
> +
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem"\
> +			"device, no free slots in the virtqueue\n");
> +		req->wq_buf_avail =3D false;
> +		list_add_tail(&req->list, &vpmem->req_list);
> +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +		/* When host has read buffer, this completes via host_ack */

"A host repsonse results in "host_ack" getting called" ... ?

> +		wait_event(req->wq_buf, req->wq_buf_avail);
> +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	}
> +	err1 =3D virtqueue_kick(vpmem->req_vq);
> +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +	/*
> +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can=
't
> +	 * do anything about that.
> +	 */
> +	if (err || !err1) {
> +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n=
");
> +		err =3D -EIO;
> +		goto ret;

Avoid the goto. Just move the following statements into an "else" case.

> +	}
> +
> +	/* When host has read buffer, this completes via host_ack */

"A host repsonse results in "host_ack" getting called" ... ?

> +	wait_event(req->host_acked, req->done);
> +	err =3D req->ret;
> +ret:
> +	kfree(req);
> +	return err;
> +};
> +
> +/* The asynchronous flush callback function */
> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> +{
> +	int rc =3D 0;
> +
> +	/* Create child bio for asynchronous flush and chain with
> +	 * parent bio. Otherwise directly call nd_region flush.
> +	 */
> +	if (bio && bio->bi_iter.bi_sector !=3D -1) {
> +		struct bio *child =3D bio_alloc(GFP_ATOMIC, 0);
> +
> +		if (!child)
> +			return -ENOMEM;
> +		bio_copy_dev(child, bio);
> +		child->bi_opf =3D REQ_PREFLUSH;
> +		child->bi_iter.bi_sector =3D -1;
> +		bio_chain(child, bio);
> +		submit_bio(child);

return 0;

Then, drop the "else" case and "int rc" and do directly

if (virtio_pmem_flush(nd_region))
	return -EIO;

> +	} else {
> +	=09
> +			rc =3D -EIO;
> +	}
> +
> +	return rc;
> +};
> +EXPORT_SYMBOL_GPL(async_pmem_flush);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.=
c
> new file mode 100644
> index 000000000000..cfc6381c4e5d
> --- /dev/null
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * virtio_pmem.c: Virtio pmem Driver
> + *
> + * Discovers persistent memory range information
> + * from host and registers the virtual pmem device
> + * with libnvdimm core.
> + */
> +#include <linux/virtio_pmem.h>
> +#include "nd.h"
> +
> +static struct virtio_device_id id_table[] =3D {
> +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> + /* Initialize virt queue */
> +static int init_vq(struct virtio_pmem *vpmem)
> +{
> +	/* single vq */
> +	vpmem->req_vq =3D virtio_find_single_vq(vpmem->vdev,
> +				host_ack, "flush_queue");

Nit: Wrong indentation of parameters.

> +	if (IS_ERR(vpmem->req_vq))
> +		return PTR_ERR(vpmem->req_vq);
> +
> +	spin_lock_init(&vpmem->pmem_lock);
> +	INIT_LIST_HEAD(&vpmem->req_list);

I would initialize the locks in the virtio_pmem_probe() directly,
earlier (directly after allocating vpmem).

> +
> +	return 0;
> +};
> +
> +static int virtio_pmem_probe(struct virtio_device *vdev)
> +{
> +	int err =3D 0;
> +	struct resource res;
> +	struct virtio_pmem *vpmem;
> +	struct nd_region_desc ndr_desc =3D {};
> +	int nid =3D dev_to_node(&vdev->dev);
> +	struct nd_region *nd_region;

Nit: use reverse Christmas tree layout :)

> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	vpmem =3D devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
> +	if (!vpmem) {
> +		err =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	vpmem->vdev =3D vdev;
> +	vdev->priv =3D vpmem;
> +	err =3D init_vq(vpmem);
> +	if (err)
> +		goto out_err;
> +
> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +			start, &vpmem->start);
> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +			size, &vpmem->size);
> +
> +	res.start =3D vpmem->start;
> +	res.end   =3D vpmem->start + vpmem->size-1;
> +	vpmem->nd_desc.provider_name =3D "virtio-pmem";
> +	vpmem->nd_desc.module =3D THIS_MODULE;
> +
> +	vpmem->nvdimm_bus =3D nvdimm_bus_register(&vdev->dev,
> +						&vpmem->nd_desc);
> +	if (!vpmem->nvdimm_bus)
> +		goto out_vq;
> +
> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> +
> +	ndr_desc.res =3D &res;
> +	ndr_desc.numa_node =3D nid;
> +	ndr_desc.flush =3D async_pmem_flush;
> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> +	nd_region =3D nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc)=
;
> +

I'd drop this empty line.

> +	if (!nd_region)
> +		goto out_nd;
> +	nd_region->provider_data =3D dev_to_virtio(nd_region->dev.parent->par=
ent);

Does it make sense to move some parts into separate functions for
readability? E.g., virtio_pmem_init_nvdimm_bus()

> +	return 0;
> +out_nd:
> +	err =3D -ENXIO;

I'd always initialize "err" along with the goto statement for
readability, especially because ...

> +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> +out_vq:

... you don't initialize err in this case. Err is here 0 if I am not wron=
g.

> +	vdev->config->del_vqs(vdev);
> +out_err:
> +	dev_err(&vdev->dev, "failed to register virtio pmem memory\n");

Should we try to give more meaning full messages? I can think of
scenarios like "memory region is not properly aligned" or "out of memory"=
.

> +	return err;
> +}
> +
> +static void virtio_pmem_remove(struct virtio_device *vdev)
> +{
> +	struct nvdimm_bus *nvdimm_bus =3D dev_get_drvdata(&vdev->dev);
> +

Is the nd_region implicitly cleaned up?

You are not freeing "vdev->priv".

> +	nvdimm_bus_unregister(nvdimm_bus);
> +	vdev->config->del_vqs(vdev);
> +	vdev->config->reset(vdev);
> +}
> +
> +static struct virtio_driver virtio_pmem_driver =3D {
> +	.driver.name		=3D KBUILD_MODNAME,
> +	.driver.owner		=3D THIS_MODULE,
> +	.id_table		=3D id_table,
> +	.probe			=3D virtio_pmem_probe,
> +	.remove			=3D virtio_pmem_remove,
> +};
> +
> +module_virtio_driver(virtio_pmem_driver);
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +MODULE_DESCRIPTION("Virtio pmem driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 35897649c24f..9f634a2ed638 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -42,6 +42,16 @@ config VIRTIO_PCI_LEGACY
> =20
>  	  If unsure, say Y.
> =20
> +config VIRTIO_PMEM
> +	tristate "Support for virtio pmem driver"
> +	depends on VIRTIO
> +	depends on LIBNVDIMM
> +	help
> +	This driver provides support for virtio based flushing interface
> +	for persistent memory range.

"This driver provides access to virtio-pmem devices, storage devices
that are mapped into the physical address space - similar to NVDIMMs -
with a virtio-based flushing interface." ... ?

> +
> +	If unsure, say M.
> +


--=20

Thanks,

David / dhildenb

