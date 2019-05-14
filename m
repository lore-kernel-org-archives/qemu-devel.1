Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06212C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED9321473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED9321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44165 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTqA-0004xp-4D
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:35:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hQTpJ-0004eM-BV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hQTpH-0007xF-D5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hQTpF-0007nj-G4
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41D56C1306E5;
	Tue, 14 May 2019 09:34:20 +0000 (UTC)
Received: from [10.36.117.118] (ovpn-117-118.ams2.redhat.com [10.36.117.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 132E0608AC;
	Tue, 14 May 2019 09:34:05 +0000 (UTC)
To: Pankaj Gupta <pagupta@redhat.com>
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-3-pagupta@redhat.com>
	<f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
	<752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
Date: Tue, 14 May 2019 11:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 14 May 2019 09:34:20 +0000 (UTC)
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

>>
>>> +	}
>>> +
>>> +	/* When host has read buffer, this completes via host_ack */
>>
>> "A host repsonse results in "host_ack" getting called" ... ?
>>
>>> +	wait_event(req->host_acked, req->done);
>>> +	err =3D req->ret;
>>> +ret:
>>> +	kfree(req);
>>> +	return err;
>>> +};
>>> +
>>> +/* The asynchronous flush callback function */
>>> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>>> +{
>>> +	int rc =3D 0;
>>> +
>>> +	/* Create child bio for asynchronous flush and chain with
>>> +	 * parent bio. Otherwise directly call nd_region flush.
>>> +	 */
>>> +	if (bio && bio->bi_iter.bi_sector !=3D -1) {
>>> +		struct bio *child =3D bio_alloc(GFP_ATOMIC, 0);
>>> +
>>> +		if (!child)
>>> +			return -ENOMEM;
>>> +		bio_copy_dev(child, bio);
>>> +		child->bi_opf =3D REQ_PREFLUSH;
>>> +		child->bi_iter.bi_sector =3D -1;
>>> +		bio_chain(child, bio);
>>> +		submit_bio(child);
>>
>> return 0;
>>
>> Then, drop the "else" case and "int rc" and do directly
>>
>> if (virtio_pmem_flush(nd_region))
>> 	return -EIO;
>=20
> and another 'return 0' here :)
>=20
> I don't like return from multiple places instead I prefer
> single exit point from function.

Makes this function more complicated than necessary. I agree when there
are locks involved.

> =20
>>
>>> +
>>> +	return 0;
>>> +};
>>> +
>>> +static int virtio_pmem_probe(struct virtio_device *vdev)
>>> +{
>>> +	int err =3D 0;
>>> +	struct resource res;
>>> +	struct virtio_pmem *vpmem;
>>> +	struct nd_region_desc ndr_desc =3D {};
>>> +	int nid =3D dev_to_node(&vdev->dev);
>>> +	struct nd_region *nd_region;
>>
>> Nit: use reverse Christmas tree layout :)
>=20
> Done.
>=20
>>
>>> +
>>> +	if (!vdev->config->get) {
>>> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> +			__func__);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	vpmem =3D devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
>>> +	if (!vpmem) {
>>> +		err =3D -ENOMEM;
>>> +		goto out_err;
>>> +	}
>>> +
>>> +	vpmem->vdev =3D vdev;
>>> +	vdev->priv =3D vpmem;
>>> +	err =3D init_vq(vpmem);
>>> +	if (err)
>>> +		goto out_err;
>>> +
>>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
>>> +			start, &vpmem->start);
>>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
>>> +			size, &vpmem->size);
>>> +
>>> +	res.start =3D vpmem->start;
>>> +	res.end   =3D vpmem->start + vpmem->size-1;
>>> +	vpmem->nd_desc.provider_name =3D "virtio-pmem";
>>> +	vpmem->nd_desc.module =3D THIS_MODULE;
>>> +
>>> +	vpmem->nvdimm_bus =3D nvdimm_bus_register(&vdev->dev,
>>> +						&vpmem->nd_desc);
>>> +	if (!vpmem->nvdimm_bus)
>>> +		goto out_vq;
>>> +
>>> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
>>> +
>>> +	ndr_desc.res =3D &res;
>>> +	ndr_desc.numa_node =3D nid;
>>> +	ndr_desc.flush =3D async_pmem_flush;
>>> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
>>> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>>> +	nd_region =3D nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_des=
c);
>>> +
>>
>> I'd drop this empty line.
>=20
> hmm.
>=20

The common pattern after allocating something, immediately check for it
in the next line (like you do throughout this patch ;) )

...
>> You are not freeing "vdev->priv".
>=20
> vdev->priv is vpmem which is allocated using devm API.

I'm confused. Looking at drivers/virtio/virtio_balloon.c:

static void virtballoon_remove(struct virtio_device *vdev)
{
	struct virtio_balloon *vb =3D vdev->priv;

	...

	kfree(vb);
}

I think you should do the same here, vdev->priv is allocated in
virtio_pmem_probe.

But maybe I am missing something important here :)

>>
>>> +	nvdimm_bus_unregister(nvdimm_bus);
>>> +	vdev->config->del_vqs(vdev);
>>> +	vdev->config->reset(vdev);
>>> +}
>>> +

--=20

Thanks,

David / dhildenb

