Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857E82082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857E82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEFJt-0008NG-RO
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:39:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hEFIa-0007cC-17
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hEFIY-0002Pj-J9
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hEFIY-0002P3-3r
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D956181114;
	Wed, 10 Apr 2019 15:38:00 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BD0155DA5B;
	Wed, 10 Apr 2019 15:38:00 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7000F3FA45;
	Wed, 10 Apr 2019 15:38:00 +0000 (UTC)
Date: Wed, 10 Apr 2019 11:38:00 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <1663006162.20832248.1554910680080.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190410142426.5bf0d9a4.cohuck@redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-3-pagupta@redhat.com>
	<20190410142426.5bf0d9a4.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.117, 10.4.195.26]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: ni96j4d6FUDPJPNtE4chnh/uKdN03w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 10 Apr 2019 15:38:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/5] virtio-pmem: Add virtio pmem driver
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
Cc: jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	david@fromorbit.com, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org,
	adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
	aarcange@redhat.com, dave jiang <dave.jiang@intel.com>,
	linux-nvdimm@lists.01.org,
	vishal l verma <vishal.l.verma@intel.com>, david@redhat.com,
	willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
	stefanha@redhat.com, pbonzini@redhat.com,
	dan j williams <dan.j.williams@intel.com>,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410153800.szNCAQEe_fSQskt9Q8xy4922aNLvrrCzXCklOs1f1gE@z>


> 
> > This patch adds virtio-pmem driver for KVM guest.
> > 
> > Guest reads the persistent memory range information from
> > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > creates a nd_region object with the persistent memory
> > range information so that existing 'nvdimm/pmem' driver
> > can reserve this into system memory map. This way
> > 'virtio-pmem' driver uses existing functionality of pmem
> > driver to register persistent memory compatible for DAX
> > capable filesystems.
> > 
> > This also provides function to perform guest flush over
> > VIRTIO from 'pmem' driver when userspace performs flush
> > on DAX memory range.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/virtio_pmem.c     |  88 ++++++++++++++++++++++
> >  drivers/virtio/Kconfig           |  10 +++
> >  drivers/virtio/Makefile          |   1 +
> >  drivers/virtio/pmem.c            | 124 +++++++++++++++++++++++++++++++
> >  include/linux/virtio_pmem.h      |  60 +++++++++++++++
> >  include/uapi/linux/virtio_ids.h  |   1 +
> >  include/uapi/linux/virtio_pmem.h |  10 +++
> >  7 files changed, 294 insertions(+)
> >  create mode 100644 drivers/nvdimm/virtio_pmem.c
> >  create mode 100644 drivers/virtio/pmem.c
> >  create mode 100644 include/linux/virtio_pmem.h
> >  create mode 100644 include/uapi/linux/virtio_pmem.h
> > 
> (...)
> > diff --git a/drivers/virtio/pmem.c b/drivers/virtio/pmem.c
> > new file mode 100644
> > index 000000000000..cc9de9589d56
> > --- /dev/null
> > +++ b/drivers/virtio/pmem.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * virtio_pmem.c: Virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and registers the virtual pmem device
> > + * with libnvdimm core.
> > + */
> > +#include <linux/virtio_pmem.h>
> > +#include <../../drivers/nvdimm/nd.h>
> > +
> > +static struct virtio_device_id id_table[] = {
> > +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> > +	{ 0 },
> > +};
> > +
> > + /* Initialize virt queue */
> > +static int init_vq(struct virtio_pmem *vpmem)
> 
> IMHO, you don't gain much by splitting off this function...

o.k. I kept this for better code structure.

> 
> > +{
> > +	struct virtqueue *vq;
> > +
> > +	/* single vq */
> > +	vpmem->req_vq = vq = virtio_find_single_vq(vpmem->vdev,
> > +				host_ack, "flush_queue");
> > +	if (IS_ERR(vq))
> > +		return PTR_ERR(vq);
> 
> I'm personally not a fan of chained assignments... I think I'd just
> drop the 'vq' variable and operate on vpmem->req_vq directly.

Sure.

> 
> > +
> > +	spin_lock_init(&vpmem->pmem_lock);
> > +	INIT_LIST_HEAD(&vpmem->req_list);
> > +
> > +	return 0;
> > +};
> > +
> > +static int virtio_pmem_probe(struct virtio_device *vdev)
> > +{
> > +	int err = 0;
> > +	struct resource res;
> > +	struct virtio_pmem *vpmem;
> > +	struct nvdimm_bus *nvdimm_bus;
> > +	struct nd_region_desc ndr_desc = {};
> > +	int nid = dev_to_node(&vdev->dev);
> > +	struct nd_region *nd_region;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config disabled\n",
> 
> Maybe s/config disabled/config access disabled/ ? That seems to be the
> more common message.

This is better.

> 
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	vdev->priv = vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem),
> > +					GFP_KERNEL);
> 
> Here, the vpmem variable makes sense for convenience, but I'm again not
> a fan of the chaining :)

Sure will change :)

> 
> > +	if (!vpmem) {
> > +		err = -ENOMEM;
> > +		goto out_err;
> > +	}
> > +
> > +	vpmem->vdev = vdev;
> > +	err = init_vq(vpmem);
> > +	if (err)
> > +		goto out_err;
> > +
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			start, &vpmem->start);
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			size, &vpmem->size);
> > +
> > +	res.start = vpmem->start;
> > +	res.end   = vpmem->start + vpmem->size-1;
> > +	vpmem->nd_desc.provider_name = "virtio-pmem";
> > +	vpmem->nd_desc.module = THIS_MODULE;
> > +
> > +	vpmem->nvdimm_bus = nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> > +						&vpmem->nd_desc);
> 
> And here :)

Sure.

> 
> > +	if (!nvdimm_bus)
> > +		goto out_vq;
> > +
> > +	dev_set_drvdata(&vdev->dev, nvdimm_bus);
> > +
> > +	ndr_desc.res = &res;
> > +	ndr_desc.numa_node = nid;
> > +	ndr_desc.flush = virtio_pmem_flush;
> > +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > +	nd_region = nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc);
> > +	nd_region->provider_data =  dev_to_virtio
> > +					(nd_region->dev.parent->parent);
> 
> Isn't it clear that this parent chain will always end up at &vdev->dev?

Yes, It will resolve to &vdev->dev.

> Maybe simply set ->provider_data to vdev directly? (Does it need to
> grab a reference count of the device, BTW?)

reference is already taken when registering the device with nvdimm_bus.

> 
> > +
> > +	if (!nd_region)
> > +		goto out_nd;
> 
> Probably better to do this check before you access nd_region's
> members :)

ah Sorry! Will correct this.

> 
> > +
> > +	return 0;
> > +out_nd:
> > +	err = -ENXIO;
> > +	nvdimm_bus_unregister(nvdimm_bus);
> > +out_vq:
> > +	vdev->config->del_vqs(vdev);
> > +out_err:
> > +	dev_err(&vdev->dev, "failed to register virtio pmem memory\n");
> > +	return err;
> > +}
> > +
> > +static void virtio_pmem_remove(struct virtio_device *vdev)
> > +{
> > +	struct virtio_pmem *vpmem = vdev->priv;
> > +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> > +
> > +	nvdimm_bus_unregister(nvdimm_bus);
> 
> I haven't followed this around the nvdimm code, but is the nd_region
> you created during probe cleaned up automatically, or would you need to
> do something here?

'nvdimm_bus_unregister' does that.
> 
> > +	vdev->config->del_vqs(vdev);
> > +	vdev->config->reset(vdev);
> > +	kfree(vpmem);
> 
> You allocated vpmem via devm_kzalloc; isn't it freed automatically on
> remove?

yes. Will remove free(vpmem).

> 
> > +}
> > +
> > +static struct virtio_driver virtio_pmem_driver = {
> > +	.driver.name		= KBUILD_MODNAME,
> > +	.driver.owner		= THIS_MODULE,
> > +	.id_table		= id_table,
> > +	.probe			= virtio_pmem_probe,
> > +	.remove			= virtio_pmem_remove,
> > +};
> > +
> > +module_virtio_driver(virtio_pmem_driver);
> > +MODULE_DEVICE_TABLE(virtio, id_table);
> > +MODULE_DESCRIPTION("Virtio pmem driver");
> > +MODULE_LICENSE("GPL");
> 
> Only looked at this from the general virtio driver angle; seems fine
> apart from some easy-to-fix issues and some personal style preference
> things.

Thank you for the review.

Best regards,
Pankaj
> 

