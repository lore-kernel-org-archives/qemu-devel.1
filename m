Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D86C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD28520675
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD28520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGwc-00032L-DK
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:01:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRGun-0001zj-Re
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRGum-0000BM-Q1
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:59:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRGum-0000AW-M7
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:59:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id i26so3922714qtr.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 06:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=4W8nxk4k4MVtLI1JLQcZmk+Bl22d4lanY5c6NY2cMcc=;
	b=OiDnz7mhu7g6cvxrFXCtys+wXdwZD0PZZDP+dhiqxOmsGv7war0KAjXjBwK1tx2K6u
	eMPhAIFq2BvqoY1V9LOTsFhYsoDkExFa8RAGZimWT5X4jTfldvRRUmXcAxF3yN+JpngL
	J1C1OgZynezk2iEd0nRGxJxt0sIMGFldTdMwIToOwaNcYAyoKZNL2grUbjPvFM1vokxi
	MjB3UvLN4qy22W8T4XZGnp3EfPOEmWiS+G5RK2Ug7qARc6L48ItynHF3npVeel2wXKdR
	+TIxMTijBn9MWJ9rfdx54nb0svn2tkIftxMiHgRmzDCbTQuUpKeanatqjR+fF7MINNpP
	qFRw==
X-Gm-Message-State: APjAAAWEYG8gggX4dUirdkZFja1AFZC3enBIlWL+Wir40ugcpJb0PR4B
	9q2TusWcZnGDGWRVLMC1Re9qmQ==
X-Google-Smtp-Source: APXvYqwNqjWbg9ip//OmA0nM3GR5PQZt9aCGRYqOitDJVOvfxjGNt2YWHJMFjse5jwjGBTbN3j6Jnw==
X-Received: by 2002:a0c:fe48:: with SMTP id u8mr39012393qvs.234.1558015159428; 
	Thu, 16 May 2019 06:59:19 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	o37sm3676500qta.86.2019.05.16.06.59.12
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 06:59:18 -0700 (PDT)
Date: Thu, 16 May 2019 09:59:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190516095618-mutt-send-email-mst@kernel.org>
References: <20190514145422.16923-1-pagupta@redhat.com>
	<20190514145422.16923-3-pagupta@redhat.com>
	<9f6b1d8e-ef90-7d8b-56da-61a426953ba3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6b1d8e-ef90-7d8b-56da-61a426953ba3@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
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
Cc: Pankaj Gupta <pagupta@redhat.com>, cohuck@redhat.com, jack@suse.cz,
	kvm@vger.kernel.org, jasowang@redhat.com, david@fromorbit.com,
	qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
	adilger.kernel@dilger.ca, zwisler@kernel.org,
	aarcange@redhat.com, dave.jiang@intel.com, jstaron@google.com,
	linux-nvdimm@lists.01.org, vishal.l.verma@intel.com,
	willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval.shaia@oracle.com, stefanha@redhat.com,
	pbonzini@redhat.com, dan.j.williams@intel.com,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong.eric@gmail.com,
	darrick.wong@oracle.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 10:46:00PM +0200, David Hildenbrand wrote:
> > +	vpmem->vdev = vdev;
> > +	vdev->priv = vpmem;
> > +	err = init_vq(vpmem);
> > +	if (err) {
> > +		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
> > +		goto out_err;
> > +	}
> > +
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			start, &vpmem->start);
> > +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> > +			size, &vpmem->size);
> > +
> > +	res.start = vpmem->start;
> > +	res.end   = vpmem->start + vpmem->size-1;
> 
> nit: " - 1;"
> 
> > +	vpmem->nd_desc.provider_name = "virtio-pmem";
> > +	vpmem->nd_desc.module = THIS_MODULE;
> > +
> > +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> > +						&vpmem->nd_desc);
> > +	if (!vpmem->nvdimm_bus) {
> > +		dev_err(&vdev->dev, "failed to register device with nvdimm_bus\n");
> > +		err = -ENXIO;
> > +		goto out_vq;
> > +	}
> > +
> > +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > +
> > +	ndr_desc.res = &res;
> > +	ndr_desc.numa_node = nid;
> > +	ndr_desc.flush = async_pmem_flush;
> > +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> > +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> > +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> > +	if (!nd_region) {
> > +		dev_err(&vdev->dev, "failed to create nvdimm region\n");
> > +		err = -ENXIO;
> > +		goto out_nd;
> > +	}
> > +	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
> > +	return 0;
> > +out_nd:
> > +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> > +out_vq:
> > +	vdev->config->del_vqs(vdev);
> > +out_err:
> > +	return err;
> > +}
> > +
> > +static void virtio_pmem_remove(struct virtio_device *vdev)
> > +{
> > +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> > +
> > +	nvdimm_bus_unregister(nvdimm_bus);
> > +	vdev->config->del_vqs(vdev);
> > +	vdev->config->reset(vdev);
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
> > diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> > new file mode 100644
> > index 000000000000..ab1da877575d
> > --- /dev/null
> > +++ b/drivers/nvdimm/virtio_pmem.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * virtio_pmem.h: virtio pmem Driver
> > + *
> > + * Discovers persistent memory range information
> > + * from host and provides a virtio based flushing
> > + * interface.
> > + **/
> > +
> > +#ifndef _LINUX_VIRTIO_PMEM_H
> > +#define _LINUX_VIRTIO_PMEM_H
> > +
> > +#include <linux/virtio_ids.h>
> > +#include <linux/module.h>
> > +#include <linux/virtio_config.h>
> > +#include <uapi/linux/virtio_pmem.h>
> > +#include <linux/libnvdimm.h>
> > +#include <linux/spinlock.h>
> > +
> > +struct virtio_pmem_request {
> > +	/* Host return status corresponding to flush request */
> > +	int ret;
> > +
> > +	/* command name*/
> > +	char name[16];
> 
> So ... why are we sending string commands and expect native-endianess
> integers and don't define a proper request/response structure + request
> types in include/uapi/linux/virtio_pmem.h like

passing names could be ok.
I missed the fact we return a native endian int.
Pls fix that.


> 
> struct virtio_pmem_resp {
> 	__virtio32 ret;
> }
> 
> #define VIRTIO_PMEM_REQ_TYPE_FLUSH	1
> struct virtio_pmem_req {
> 	__virtio16 type;
> }
> 
> ... and this way we also define a proper endianess format for exchange
> and keep it extensible
> 
> @MST, what's your take on this?

Extensions can always use feature bits so I don't think
it's a problem.

> 
> -- 
> 
> Thanks,
> 
> David / dhildenb

