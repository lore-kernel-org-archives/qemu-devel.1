Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F65C3A59F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 01:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F7420828
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 01:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F7420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ViZ-0001oD-Mi
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 21:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i3VgU-0001HI-8M
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i3VgQ-0001Q4-Kb
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:26:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i3VgQ-00012T-Cg
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:26:34 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A6CC3D96B
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 01:26:28 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id d19so3029500pgh.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=J8xs6JgARHOvC0h7SUc+Rl1pD46T03MbPQ7996XjJiU=;
 b=LBQ0HSs7dwdBUZZ0tyYsYYfMm4madozXqlDmPI5FeTEgPJDuKED3HOpsw38CP5mJbK
 tnPj7MWnMVDIOGhuEaXniWV6HinXEwK9onwMPkvpOBIoP9bJpimezf6Owa/8l7KgmJOU
 kgwEY45vXu1vrlySX6/wSg/LVW4lgkMLXkHolBvwCM7lFdOPl+xYHELLX3IWkAM/TMBE
 /QvWZpP50ln+K/C5Xth/tGPfiOSSC0+4P5r3lpBUJGCjW//BOBFc2MUTQZ/XjlfgEiwe
 M/wE1jwjNfin7qbqTTmp+IsWUISVaIPgV+btMg/BxZXp7hp5irPBo9BpVR3wD2NytqY0
 8/ew==
X-Gm-Message-State: APjAAAU/TZNQqIiU/qcVB+I4aztLMjMTSGMKhUifo0tNMVBs1ayOW8ZT
 AR8ok1J3GqrY36hKyC+rPmlvIu6kiwuNGgC4m/gerg+yIoIfLACZdCBoep/Nhuqzth4IQeh41jy
 ngLZBkfiYW9HlfJs=
X-Received: by 2002:a63:7a06:: with SMTP id v6mr11074375pgc.115.1567128387616; 
 Thu, 29 Aug 2019 18:26:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxDVOKm852j94mFVFljzZQPu3jt52NLmx+t9TZbas46N39wO37bg2TC4MUPIVO1aG3UbNx/aw==
X-Received: by 2002:a63:7a06:: with SMTP id v6mr11074355pgc.115.1567128387242; 
 Thu, 29 Aug 2019 18:26:27 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 19sm3339072pjc.25.2019.08.29.18.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 18:26:26 -0700 (PDT)
Date: Fri, 30 Aug 2019 09:26:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190830012614.GK8729@xz-x1>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-4-eric.auger@redhat.com>
 <20190815135400.GC8463@xz-x1>
 <f6a3b750-8439-7934-565b-37e1001f84d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6a3b750-8439-7934-565b-37e1001f84d4@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 03/15] virtio-iommu: Add
 skeleton
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 tn@semihalf.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 02:18:42PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> First of all, please forgive me for the delay.
> On 8/15/19 3:54 PM, Peter Xu wrote:
> > On Tue, Jul 30, 2019 at 07:21:25PM +0200, Eric Auger wrote:
> >> +static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
> >> +{
> >> +    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
> >> +    struct virtio_iommu_req_head head;
> >> +    struct virtio_iommu_req_tail tail;
> > 
> > [1]
> > 
> >> +    VirtQueueElement *elem;
> >> +    unsigned int iov_cnt;
> >> +    struct iovec *iov;
> >> +    size_t sz;
> >> +
> >> +    for (;;) {
> >> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> >> +        if (!elem) {
> >> +            return;
> >> +        }
> >> +
> >> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
> >> +            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
> >> +            virtio_error(vdev, "virtio-iommu bad head/tail size");
> >> +            virtqueue_detach_element(vq, elem, 0);
> >> +            g_free(elem);
> >> +            break;
> >> +        }
> >> +
> >> +        iov_cnt = elem->out_num;
> >> +        iov = g_memdup(elem->out_sg, sizeof(struct iovec) * elem->out_num);
> > 
> > Could I ask why memdup is needed here?
> Indeed I don't think it is needed and besides iov is not freed!
> 
> I got inspired from hw/net/virtio-net.c. To be honest I don't get why
> the g_memdup is needed there either. The out_sg gets duplicated and
> commands work on the duplicated data and not in place.

Oh true, I found that it's because of calling of iov_discard_front().
Please have a look at 771b6ed37e3.  Though it seems to me that
virtio-iommu does not truncate iovs so it should not be needed.

> > 
> >> +        sz = iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
> >> +        if (unlikely(sz != sizeof(head))) {
> >> +            tail.status = VIRTIO_IOMMU_S_DEVERR;
> > 
> > Do you need to zero the reserved bits to make sure it won't contain
> > garbage?  Same question to below uses of tail.
> yes. I initialized tail.
> > 
> >> +            goto out;
> >> +        }
> >> +        qemu_mutex_lock(&s->mutex);
> >> +        switch (head.type) {
> >> +        case VIRTIO_IOMMU_T_ATTACH:
> >> +            tail.status = virtio_iommu_handle_attach(s, iov, iov_cnt);
> >> +            break;
> >> +        case VIRTIO_IOMMU_T_DETACH:
> >> +            tail.status = virtio_iommu_handle_detach(s, iov, iov_cnt);
> >> +            break;
> >> +        case VIRTIO_IOMMU_T_MAP:
> >> +            tail.status = virtio_iommu_handle_map(s, iov, iov_cnt);
> >> +            break;
> >> +        case VIRTIO_IOMMU_T_UNMAP:
> >> +            tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
> >> +            break;
> >> +        default:
> >> +            tail.status = VIRTIO_IOMMU_S_UNSUPP;
> >> +        }
> >> +        qemu_mutex_unlock(&s->mutex);
> >> +
> >> +out:
> >> +        sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
> >> +                          &tail, sizeof(tail));
> >> +        assert(sz == sizeof(tail));
> >> +
> >> +        virtqueue_push(vq, elem, sizeof(tail));
> > 
> > s/tail/head/ (though they are the same size)?
> That's unclear to me. Similarly when checking against virtio-net.c, the
> element is pushed back to the used ring and len is set to the size of
> the status with:
> 
> /*
>  * Control virtqueue data structures
>  *
>  * The control virtqueue expects a header in the first sg entry
>  * and an ack/status response in the last entry.  Data for the
>  * command goes in between.
>  */

I was referencing the balloon code when reading the patch, e.g.,
virtio_balloon_handle_output().  Though after I read more carefully I
see that other places are using it as you described.  Now I tend to
agree with you, because virtqueue_push() who calls
virtqueue_unmap_sg() used the len to unmap in_sg[] rather than
out_sg[].  So please ignore my previous comment.

(then I'm not sure whether the usage in the balloon code was correct
 now...)

> > 
> >> +        virtio_notify(vdev, vq);
> >> +        g_free(elem);
> >> +    }
> >> +}
> > 
> > [...]
> > 
> >> +static void virtio_iommu_set_features(VirtIODevice *vdev, uint64_t val)
> >> +{
> >> +    VirtIOIOMMU *dev = VIRTIO_IOMMU(vdev);
> >> +
> >> +    dev->acked_features = val;
> >> +    trace_virtio_iommu_set_features(dev->acked_features);
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_virtio_iommu_device = {
> >> +    .name = "virtio-iommu-device",
> >> +    .unmigratable = 1,
> > 
> > Curious, is there explicit reason to not support migration from the
> > first version? :)
> The state is made of red black trees, lists. For the former there is no
> VMSTATE* ready. I am working on it but I think this should be handled
> separately

Fair enough.  Would you mind to add a similar comment above
unmigratable?

Thanks,

-- 
Peter Xu

