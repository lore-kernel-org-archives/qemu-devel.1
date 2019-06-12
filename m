Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1FBC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C38920874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 06:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C38920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawtz-0006vp-N8
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 02:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38207)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hawtL-0006X4-Ga
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hawtK-0004FZ-AF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hawtK-0004FB-2D
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 02:37:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95C7F308421A;
 Wed, 12 Jun 2019 06:37:43 +0000 (UTC)
Received: from gondolin (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4994173C3;
 Wed, 12 Jun 2019 06:37:14 +0000 (UTC)
Date: Wed, 12 Jun 2019 08:37:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190612083711.2c0cfd7e.cohuck@redhat.com>
In-Reply-To: <1003601865.34513553.1560310490030.JavaMail.zimbra@redhat.com>
References: <20190611163802.25352-1-pagupta@redhat.com>
 <20190611163802.25352-3-pagupta@redhat.com>
 <20190611190209.0b25033e.cohuck@redhat.com>
 <1003601865.34513553.1560310490030.JavaMail.zimbra@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 06:37:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v12 2/7] virtio-pmem: Add virtio pmem driver
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
Cc: rdunlap@infradead.org, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
 aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, jstaron@google.com,
 linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org,
 lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com,
 yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, pbonzini@redhat.com,
 dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, snitzer@redhat.com,
 darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pankaj,

On Tue, 11 Jun 2019 23:34:50 -0400 (EDT)
Pankaj Gupta <pagupta@redhat.com> wrote:

> Hi Cornelia,
> 
> > On Tue, 11 Jun 2019 22:07:57 +0530
> > Pankaj Gupta <pagupta@redhat.com> wrote:


> > > +	err1 = virtqueue_kick(vpmem->req_vq);
> > > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > > +	/*
> > > +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> > > +	 * do anything about that.
> > > +	 */  
> > 
> > Does it make sense to kick if you couldn't add at all?  
> 
> When we could not add because of -ENOSPC we are waiting and when buffer is added
> then only we do a kick. For any other error which might be a rare occurrence, I think
> kick is harmless here and keeps the code clean?

Yes, I agree it does not hurt. Let's keep it as-is.


> Sure, Thank you. Attaching below on top changes on current patch2 based on
> your suggestions. Let me know if these are okay and then will send official
> v13 to for upstream merging.

Looks good to me, except for one change.

[Again sorry for the late review, did not want to get the version
numbers up :)]

> 
> Thanks,
> Pankaj
> 
> ===============
> 
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index efc535723517..5b8d2367da0b 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -10,7 +10,7 @@
>  #include "nd.h"
>  
>   /* The interrupt handler */
> -void host_ack(struct virtqueue *vq)
> +void virtio_pmem_host_ack(struct virtqueue *vq)
>  {
>         struct virtio_pmem *vpmem = vq->vdev->priv;
>         struct virtio_pmem_request *req_data, *req_buf;
> @@ -32,10 +32,10 @@ void host_ack(struct virtqueue *vq)
>         }
>         spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
>  }
> -EXPORT_SYMBOL_GPL(host_ack);
> +EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
>  
>   /* The request submission function */
> -int virtio_pmem_flush(struct nd_region *nd_region)
> +static int virtio_pmem_flush(struct nd_region *nd_region)
>  {
>         struct virtio_device *vdev = nd_region->provider_data;
>         struct virtio_pmem *vpmem  = vdev->priv;
> @@ -69,7 +69,7 @@ int virtio_pmem_flush(struct nd_region *nd_region)
>         while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
>                                         GFP_ATOMIC)) == -ENOSPC) {
>  
> -               dev_err(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
> +               dev_info(&vdev->dev, "failed to send command to virtio pmem device, no free slots in the virtqueue\n");
>                 req_data->wq_buf_avail = false;
>                 list_add_tail(&req_data->list, &vpmem->req_list);
>                 spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> @@ -90,7 +90,8 @@ int virtio_pmem_flush(struct nd_region *nd_region)
>         } else {
>                 /* A host repsonse results in "host_ack" getting called */
>                 wait_event(req_data->host_acked, req_data->done);
> -               err = virtio32_to_cpu(vdev, req_data->resp.ret);
> +               if ((err = virtio32_to_cpu(vdev, req_data->resp.ret)))
> +                       err = -EIO;

Hm, why are you making this change? I think the previous code was fine.

>         }
>  
>         kfree(req_data);
> @@ -100,7 +101,8 @@ int virtio_pmem_flush(struct nd_region *nd_region)
>  /* The asynchronous flush callback function */
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  {
> -       /* Create child bio for asynchronous flush and chain with
> +       /*
> +        * Create child bio for asynchronous flush and chain with
>          * parent bio. Otherwise directly call nd_region flush.
>          */
>         if (bio && bio->bi_iter.bi_sector != -1) {
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index b60ebd8cd2fd..5e3d07b47e0c 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -19,7 +19,7 @@ static int init_vq(struct virtio_pmem *vpmem)
>  {
>         /* single vq */
>         vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
> -                                               host_ack, "flush_queue");
> +                                       virtio_pmem_host_ack, "flush_queue");
>         if (IS_ERR(vpmem->req_vq))
>                 return PTR_ERR(vpmem->req_vq);
>  
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index 6e47521be158..998efbc7660c 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -50,6 +50,6 @@ struct virtio_pmem {
>         uint64_t size;
>  };
>  
> -void host_ack(struct virtqueue *vq);
> +void virtio_pmem_host_ack(struct virtqueue *vq);
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
>  #endif


