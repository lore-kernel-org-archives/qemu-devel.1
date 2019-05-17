Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDAFC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 05:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22982206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 05:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22982206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42623 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRVU6-0003g0-U8
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 01:32:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hRVTE-0003Fv-W2
	for qemu-devel@nongnu.org; Fri, 17 May 2019 01:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hRVTD-0001cM-Az
	for qemu-devel@nongnu.org; Fri, 17 May 2019 01:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hRVTA-0001Xt-Tw
	for qemu-devel@nongnu.org; Fri, 17 May 2019 01:31:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7FAE811DC;
	Fri, 17 May 2019 05:31:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC4660BE5;
	Fri, 17 May 2019 05:31:43 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7045B1806B10;
	Fri, 17 May 2019 05:31:41 +0000 (UTC)
Date: Fri, 17 May 2019 01:31:40 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
Message-ID: <1808083054.29407926.1558071100913.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190516095618-mutt-send-email-mst@kernel.org>
References: <20190514145422.16923-1-pagupta@redhat.com>
	<20190514145422.16923-3-pagupta@redhat.com>
	<9f6b1d8e-ef90-7d8b-56da-61a426953ba3@redhat.com>
	<20190516095618-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.188, 10.4.195.6]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: FMi3zX+ydzvNE+LRIfWGkFwCXnTU+g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 17 May 2019 05:31:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
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
Cc: jack@suse.cz, kvm@vger.kernel.org, jasowang@redhat.com, david@fromorbit.com,
	qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
	adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
	aarcange@redhat.com, dave jiang <dave.jiang@intel.com>,
	jstaron@google.com, linux-nvdimm@lists.01.org,
	vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org,
	hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
	stefanha@redhat.com, imammedo@redhat.com,
	dan j williams <dan.j.williams@intel.com>,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	cohuck@redhat.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
	darrick wong <darrick.wong@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
> On Wed, May 15, 2019 at 10:46:00PM +0200, David Hildenbrand wrote:
> > > +	vpmem->vdev = vdev;
> > > +	vdev->priv = vpmem;
> > > +	err = init_vq(vpmem);
> > > +	if (err) {
> > > +		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
> > > +		goto out_err;
> > > +	}
> > > +
> > > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > > +			start, &vpmem->start);
> > > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > > +			size, &vpmem->size);
> > > +
> > > +	res.start = vpmem->start;
> > > +	res.end   = vpmem->start + vpmem->size-1;
> > 
> > nit: " - 1;"
> > 
> > > +	vpmem->nd_desc.provider_name = "virtio-pmem";
> > > +	vpmem->nd_desc.module = THIS_MODULE;
> > > +
> > > +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> > > +						&vpmem->nd_desc);
> > > +	if (!vpmem->nvdimm_bus) {
> > > +		dev_err(&vdev->dev, "failed to register device with nvdimm_bus\n");
> > > +		err = -ENXIO;
> > > +		goto out_vq;
> > > +	}
> > > +
> > > +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > > +
> > > +	ndr_desc.res = &res;
> > > +	ndr_desc.numa_node = nid;
> > > +	ndr_desc.flush = async_pmem_flush;
> > > +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > > +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > > +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> > > +	if (!nd_region) {
> > > +		dev_err(&vdev->dev, "failed to create nvdimm region\n");
> > > +		err = -ENXIO;
> > > +		goto out_nd;
> > > +	}
> > > +	nd_region->provider_data =
> > > dev_to_virtio(nd_region->dev.parent->parent);
> > > +	return 0;
> > > +out_nd:
> > > +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> > > +out_vq:
> > > +	vdev->config->del_vqs(vdev);
> > > +out_err:
> > > +	return err;
> > > +}
> > > +
> > > +static void virtio_pmem_remove(struct virtio_device *vdev)
> > > +{
> > > +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> > > +
> > > +	nvdimm_bus_unregister(nvdimm_bus);
> > > +	vdev->config->del_vqs(vdev);
> > > +	vdev->config->reset(vdev);
> > > +}
> > > +
> > > +static struct virtio_driver virtio_pmem_driver = {
> > > +	.driver.name		= KBUILD_MODNAME,
> > > +	.driver.owner		= THIS_MODULE,
> > > +	.id_table		= id_table,
> > > +	.probe			= virtio_pmem_probe,
> > > +	.remove			= virtio_pmem_remove,
> > > +};
> > > +
> > > +module_virtio_driver(virtio_pmem_driver);
> > > +MODULE_DEVICE_TABLE(virtio, id_table);
> > > +MODULE_DESCRIPTION("Virtio pmem driver");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> > > new file mode 100644
> > > index 000000000000..ab1da877575d
> > > --- /dev/null
> > > +++ b/drivers/nvdimm/virtio_pmem.h
> > > @@ -0,0 +1,60 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * virtio_pmem.h: virtio pmem Driver
> > > + *
> > > + * Discovers persistent memory range information
> > > + * from host and provides a virtio based flushing
> > > + * interface.
> > > + **/
> > > +
> > > +#ifndef _LINUX_VIRTIO_PMEM_H
> > > +#define _LINUX_VIRTIO_PMEM_H
> > > +
> > > +#include <linux/virtio_ids.h>
> > > +#include <linux/module.h>
> > > +#include <linux/virtio_config.h>
> > > +#include <uapi/linux/virtio_pmem.h>
> > > +#include <linux/libnvdimm.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +struct virtio_pmem_request {
> > > +	/* Host return status corresponding to flush request */
> > > +	int ret;
> > > +
> > > +	/* command name*/
> > > +	char name[16];
> > 
> > So ... why are we sending string commands and expect native-endianess
> > integers and don't define a proper request/response structure + request
> > types in include/uapi/linux/virtio_pmem.h like
> 
> passing names could be ok.
> I missed the fact we return a native endian int.
> Pls fix that.

Sure. will fix this.

> 
> 
> > 
> > struct virtio_pmem_resp {
> > 	__virtio32 ret;
> > }
> > 
> > #define VIRTIO_PMEM_REQ_TYPE_FLUSH	1
> > struct virtio_pmem_req {
> > 	__virtio16 type;
> > }
> > 
> > ... and this way we also define a proper endianess format for exchange
> > and keep it extensible
> > 
> > @MST, what's your take on this?
> 
> Extensions can always use feature bits so I don't think
> it's a problem.

That was exactly my thought when I implemented this. Though I am
fine with separate structures for request/response and I made the
change. 

Thank you for all the comments.

Best regards,
Pankaj 
> > 
> > --
> > 
> > Thanks,
> > 
> > David / dhildenb
> 
> 

