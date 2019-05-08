Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E5C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 15:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C912020644
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 15:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C912020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOOQk-0003yr-T0
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 11:24:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hOOPv-0003fw-Rq
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hOOPu-00027U-VG
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hOOPu-00027D-NB
	for qemu-devel@nongnu.org; Wed, 08 May 2019 11:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 924EB3007149;
	Wed,  8 May 2019 15:23:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE972E09B;
	Wed,  8 May 2019 15:23:33 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id B6B4B41F56;
	Wed,  8 May 2019 15:23:32 +0000 (UTC)
Date: Wed, 8 May 2019 11:23:32 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Jakub =?utf-8?Q?Staro=C5=84?= <jstaron@google.com>
Message-ID: <1482604497.27348783.1557329012320.JavaMail.zimbra@redhat.com>
In-Reply-To: <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-3-pagupta@redhat.com>
	<3d6479ae-6c39-d614-f1d9-aa1978e2e438@google.com>
	<1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.32, 10.4.195.26]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: PGqRBxt7ac04jwyhY+CEFoY6aRdKvNGTIbxd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 08 May 2019 15:23:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 2/6] virtio-pmem: Add virtio pmem driver
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
	adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com,
	zwisler@kernel.org, aarcange@redhat.com,
	dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
	vishal l verma <vishal.l.verma@intel.com>, david@redhat.com,
	willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
	stefanha@redhat.com, imammedo@redhat.com,
	dan j williams <dan.j.williams@intel.com>,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> > 
> > > +int virtio_pmem_flush(struct nd_region *nd_region)
> > > +{
> > > +        int err;
> > > +        unsigned long flags;
> > > +        struct scatterlist *sgs[2], sg, ret;
> > > +        struct virtio_device *vdev = nd_region->provider_data;
> > > +        struct virtio_pmem *vpmem = vdev->priv;
> > > +        struct virtio_pmem_request *req;
> > > +
> > > +        might_sleep();
> > > +        req = kmalloc(sizeof(*req), GFP_KERNEL);
> > > +        if (!req)
> > > +                return -ENOMEM;
> > > +
> > > +        req->done = req->wq_buf_avail = false;
> > > +        strcpy(req->name, "FLUSH");
> > > +        init_waitqueue_head(&req->host_acked);
> > > +        init_waitqueue_head(&req->wq_buf);
> > > +        sg_init_one(&sg, req->name, strlen(req->name));
> > > +        sgs[0] = &sg;
> > > +        sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > > +        sgs[1] = &ret;
> > > +
> > > +        spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > > +        err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> > > +        if (err) {
> > > +                dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> > > +
> > > +                list_add_tail(&vpmem->req_list, &req->list);
> > > +                spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > > +
> > > +                /* When host has read buffer, this completes via host_ack */
> > > +                wait_event(req->wq_buf, req->wq_buf_avail);
> > > +                spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > > +        }
> > 
> > Aren't the arguments in `list_add_tail` swapped? The element we are adding
> 

Yes, arguments for 'list_add_tail' should be swapped.

list_add_tail(&req->list, &vpmem->req_list);


Thank you,
Pankaj

