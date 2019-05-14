Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B765620879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B765620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44383 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQU9u-00026l-W7
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:55:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hQU8A-0000qT-DM
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hQU1s-0001tU-DB
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hQU1s-0001s1-4y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D76F308427C;
	Tue, 14 May 2019 09:47:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA275D6A6;
	Tue, 14 May 2019 09:47:23 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id BDAEA18089CC;
	Tue, 14 May 2019 09:47:22 +0000 (UTC)
Date: Tue, 14 May 2019 05:47:22 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <712871093.28555872.1557827242385.JavaMail.zimbra@redhat.com>
In-Reply-To: <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-3-pagupta@redhat.com>
	<f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
	<752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
	<86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.148, 10.4.195.13]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: 8wNBImudyN2CQ1nMcWyCrDq+wnVDqg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 14 May 2019 09:47:23 +0000 (UTC)
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
	jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org,
	adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
	aarcange@redhat.com, dave jiang <dave.jiang@intel.com>,
	jstaron@google.com, linux-nvdimm@lists.01.org,
	vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org,
	hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com,
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


> 
> >>
> >>> +	}
> >>> +
> >>> +	/* When host has read buffer, this completes via host_ack */
> >>
> >> "A host repsonse results in "host_ack" getting called" ... ?
> >>
> >>> +	wait_event(req->host_acked, req->done);
> >>> +	err = req->ret;
> >>> +ret:
> >>> +	kfree(req);
> >>> +	return err;
> >>> +};
> >>> +
> >>> +/* The asynchronous flush callback function */
> >>> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> >>> +{
> >>> +	int rc = 0;
> >>> +
> >>> +	/* Create child bio for asynchronous flush and chain with
> >>> +	 * parent bio. Otherwise directly call nd_region flush.
> >>> +	 */
> >>> +	if (bio && bio->bi_iter.bi_sector != -1) {
> >>> +		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> >>> +
> >>> +		if (!child)
> >>> +			return -ENOMEM;
> >>> +		bio_copy_dev(child, bio);
> >>> +		child->bi_opf = REQ_PREFLUSH;
> >>> +		child->bi_iter.bi_sector = -1;
> >>> +		bio_chain(child, bio);
> >>> +		submit_bio(child);
> >>
> >> return 0;
> >>
> >> Then, drop the "else" case and "int rc" and do directly
> >>
> >> if (virtio_pmem_flush(nd_region))
> >> 	return -EIO;
> > 
> > and another 'return 0' here :)
> > 
> > I don't like return from multiple places instead I prefer
> > single exit point from function.
> 
> Makes this function more complicated than necessary. I agree when there
> are locks involved.

o.k. I will change as you suggest :)

> 
> >  
> >>
> >>> +
> >>> +	return 0;
> >>> +};
> >>> +
> >>> +static int virtio_pmem_probe(struct virtio_device *vdev)
> >>> +{
> >>> +	int err = 0;
> >>> +	struct resource res;
> >>> +	struct virtio_pmem *vpmem;
> >>> +	struct nd_region_desc ndr_desc = {};
> >>> +	int nid = dev_to_node(&vdev->dev);
> >>> +	struct nd_region *nd_region;
> >>
> >> Nit: use reverse Christmas tree layout :)
> > 
> > Done.
> > 
> >>
> >>> +
> >>> +	if (!vdev->config->get) {
> >>> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> >>> +			__func__);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
> >>> +	if (!vpmem) {
> >>> +		err = -ENOMEM;
> >>> +		goto out_err;
> >>> +	}
> >>> +
> >>> +	vpmem->vdev = vdev;
> >>> +	vdev->priv = vpmem;
> >>> +	err = init_vq(vpmem);
> >>> +	if (err)
> >>> +		goto out_err;
> >>> +
> >>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >>> +			start, &vpmem->start);
> >>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >>> +			size, &vpmem->size);
> >>> +
> >>> +	res.start = vpmem->start;
> >>> +	res.end   = vpmem->start + vpmem->size-1;
> >>> +	vpmem->nd_desc.provider_name = "virtio-pmem";
> >>> +	vpmem->nd_desc.module = THIS_MODULE;
> >>> +
> >>> +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> >>> +						&vpmem->nd_desc);
> >>> +	if (!vpmem->nvdimm_bus)
> >>> +		goto out_vq;
> >>> +
> >>> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> >>> +
> >>> +	ndr_desc.res = &res;
> >>> +	ndr_desc.numa_node = nid;
> >>> +	ndr_desc.flush = async_pmem_flush;
> >>> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> >>> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> >>> +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> >>> +
> >>
> >> I'd drop this empty line.
> > 
> > hmm.
> > 
> 
> The common pattern after allocating something, immediately check for it
> in the next line (like you do throughout this patch ;) )

Right. But rare times when I see space will beauty the code I tend to
add it. Maybe I should not :)

> 
> ...
> >> You are not freeing "vdev->priv".
> > 
> > vdev->priv is vpmem which is allocated using devm API.
> 
> I'm confused. Looking at drivers/virtio/virtio_balloon.c:
> 
> static void virtballoon_remove(struct virtio_device *vdev)
> {
> 	struct virtio_balloon *vb = vdev->priv;
> 
> 	...
> 
> 	kfree(vb);
> }
> 
> I think you should do the same here, vdev->priv is allocated in
> virtio_pmem_probe.
> 
> But maybe I am missing something important here :)

Because virtio_balloon use "kzalloc" for allocation and needs to be freed. 
But virtio pmem uses "devm_kzalloc" which takes care of automatically deleting 
the device memory when associated device is detached.

Thanks,
Pankaj
> 
> >>
> >>> +	nvdimm_bus_unregister(nvdimm_bus);
> >>> +	vdev->config->del_vqs(vdev);
> >>> +	vdev->config->reset(vdev);
> >>> +}
> >>> +
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 

