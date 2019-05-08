Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C50C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF48B20850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrAOaI1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF48B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOEYW-0007KI-8k
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 00:51:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hOEXg-0005yd-52
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hOEXe-0005eJ-5L
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:50:56 -0400
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d]:34027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fengyd81@gmail.com>) id 1hOEXa-0005ch-Cf
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:50:52 -0400
Received: by mail-it1-x12d.google.com with SMTP id p18so1313098itm.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 21:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=Ce8jbhz/dF27kWwn4habl+SHPZ1dlvDf6I+lxDXH1R8=;
	b=DrAOaI1IEia9Fxb9gzF70+d6refVKLs1bI1bfJDryOmzrm4q73Pej93L5owvTrO9ee
	+FcxvECbcaWHTIMYXEyX84jqB7PIZukSqhCw8DavzkHLJIaVaQbLS0SceAdTVS9756FU
	5nWRhfRpzV+tY4WYhUqSYLHwYNbAoHY6n1lvh2LzZVFLI+TElw82AuxRBh+vkXhXMQmQ
	VFmrZCsi4wgaiIpZ7H8dxCZdGRYV3+pDriApSYOJJctc4fPeTR+EGBdnmTQOAAmrptmZ
	Cmh1CjuQXf1mpOmEHHeaWl26G3B7mZkFvIiWGMZrqIO4YecM04sW9HniGloZd376BjO8
	Cnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=Ce8jbhz/dF27kWwn4habl+SHPZ1dlvDf6I+lxDXH1R8=;
	b=S2sg6xRvgE1+oJud2OIeWYOiNT6aPrir/u2h7lnT0brYWxpK4pH+rG6EMfiNvtr5R+
	wrM6DJ1zIVgxXJig/ykUraoocpDYYnc+YvbxkfDfOs25v3QYuOH1cw2uIW12svkj7wGk
	7omQffynXc3jFHt31JitFb6YzIJ7/DJ6cFN3corNtZpZwIh30srYspxu4FCN11sUVbn8
	otmkv6BCfIMCeIEM8ySjBfjm/GIKj9D77dqf8OGabORgucx9DwQWKZsVKfL6D25FUZAf
	6ySH7r+r+97tGptrSzeYsBJrEqf9sRqISFTJBsZVD1nHnVDTXC2vMkIrS+bnpVsQuYH/
	yTRA==
X-Gm-Message-State: APjAAAXun4h+2dQE9bGK/PqgRA7H+tXhB70azz6e5uSDViw7gX9V6WcX
	h6lJ8LFJzqFnf2YMs5/fXv/0OZRwvOH/qJRF5v+4pQ==
X-Google-Smtp-Source: APXvYqyDIH/wONXKQ0/oVeP0iEsOJzp2Edj0HghdeqEFC+nIHNsRv1XCZhjxwvDrbjSr+JQv1MI6Vq3REfXR6UAXTM4=
X-Received: by 2002:a24:4210:: with SMTP id i16mr1849020itb.37.1557291046058; 
	Tue, 07 May 2019 21:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
	<20190415145358.GA2893@work-vm>
	<CACnvu8a5DjAUhfAGmi6GtpD1V2hfoNLTkKEgbsFuL_6GrRc+pg@mail.gmail.com>
	<CACnvu8Y9Ub5PAOt18ukzvOoDxmfzwvygWWwOZaT5Q2Eig6YFTw@mail.gmail.com>
	<20190416084738.GA3123@work-vm>
	<CACnvu8Y7OQSYgGUXm5+bdB0owwmm+gSDpuaGQn=5QNhB5wcjvQ@mail.gmail.com>
	<CACnvu8aWowPEo=0fE+CXbdp+g9LFvxSNjRsAHdQiQzvJfoYjsQ@mail.gmail.com>
	<20190429162236.GJ2748@work-vm>
	<CACnvu8bBykwoSHOAwTa0L_FD3kF=i+KW+H1MZk-x3xu1tV9gkw@mail.gmail.com>
In-Reply-To: <CACnvu8bBykwoSHOAwTa0L_FD3kF=i+KW+H1MZk-x3xu1tV9gkw@mail.gmail.com>
From: fengyd <fengyd81@gmail.com>
Date: Wed, 8 May 2019 12:50:32 +0800
Message-ID: <CACnvu8ZVSSov9gRKje13_j0Si5vErdzxpBS4w+sAWsAoAK-BHg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::12d
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Fwd:  Fwd: How live migration work for vhost-user
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---------- Forwarded message ---------
From: fengyd <fengyd81@gmail.com>
Date: Wed, 8 May 2019 at 12:50
Subject: Re: [Qemu-devel] Fwd: How live migration work for vhost-user
To: Dr. David Alan Gilbert <dgilbert@redhat.com>


Hi,


I checked the DPDK code and found that the function rte_vhost_enqueue_burst
in virtio_net.c is used to receive message.

uint16_t
rte_vhost_enqueue_burst(int vid, uint16_t queue_id,

    struct rte_mbuf **pkts, uint16_t count)

{
    struct virtio_net *dev = get_device(vid);

    if (!dev)

        return 0;

    if (dev->features & (1 << VIRTIO_NET_F_MRG_RXBUF))
        return virtio_dev_merge_rx(dev, queue_id, pkts, count);
    else
        return virtio_dev_rx(dev, queue_id, pkts, count);

}

If VIRTIO_NET_F_MRG_RXBUF is supported by guest, virtio_dev_merge_rx is
called, otherwise virtio_dev_rx is called.
And in virtio_dev_merge_rx, last_avail_idx will be updated, and in
virtio_dev_rx, last_avail_idx will not be touched, so it is kept as the
initial value 0.

Our guest virito driver doesn't support VIRTIO_NET_F_MRG_RXBUF, so
last_avail_idx QEMU read from DPDK is always 0?


And The strange thing is the function vhost_user_get_vring_base in
vhost_user.c which returns last_avail_idx to QEMU.
I checked the code in v18.05
<https://git.dpdk.org/dpdk/tree/lib/librte_vhost/vhost_user.c?h=v18.05>,
last_avail_idx is assigned to the return message.
msg->payload.state.num = vq->last_avail_idx;

And in DPDK v17.11
<https://git.dpdk.org/dpdk/tree/lib/librte_vhost/vhost_user.c?h=v17.11>,
last_used_idx is assigned to the return message.
msg->payload.state.num = vq->last_used_idx;

On Tue, 30 Apr 2019 at 00:22, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * fengyd (fengyd81@gmail.com) wrote:
> > Hi,
> >
> > For vhost,  *last_avail_idx*  is maintained in vhost_virtqueue
> > but during live migration, *last_avail_idx*  is fetched from VirtQueue.
> > Do you know how these two *last_avail_idx *are synchronized?
> >
> > virtio_load related code which is called during live migration:
> >
> > * vdev->vq[i].inuse = (uint16_t)(vdev->vq[i].last_avail_idx -*
> > *                                vdev->vq[i].used_idx);*
> > *            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {*
> > *                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "*
> > *                             "used_idx 0x%x",*
> > *                             i, vdev->vq[i].vring.num,*
> > *                             vdev->vq[i].last_avail_idx,*
>
> I don't know that code well; but I think the answer is that since the
> queues themselves are in guest memory, the guest memory is migrated
> by the normal migration code and so the queues version of last_avail_idx
> should be correct.  The 'log' mechanism I previously mentioned will
> need to make sure the queue pages are marked dirty to make sure these
> are updated correctly.
>
> Dave
>
> >
> >
> > Thanks
> >
> > On Tue, 23 Apr 2019 at 14:20, fengyd <fengyd81@gmail.com> wrote:
> >
> > > Hi,
> > >
> > > I want to add some log to qemu-kvm-ev.
> > > Do you know how to compile qemu-kvm-ev from source code?
> > >
> > > Thanks
> > >
> > > Yafeng
> > >
> > > On Tue, 16 Apr 2019 at 16:47, Dr. David Alan Gilbert <
> dgilbert@redhat.com>
> > > wrote:
> > >
> > >> * fengyd (fengyd81@gmail.com) wrote:
> > >> > ---------- Forwarded message ---------
> > >> > From: fengyd <fengyd81@gmail.com>
> > >> > Date: Tue, 16 Apr 2019 at 09:17
> > >> > Subject: Re: [Qemu-devel] How live migration work for vhost-user
> > >> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > >> >
> > >> >
> > >> > Hi,
> > >> >
> > >> > Any special feature needs to be supported on guest driver?
> > >> > Because it's OK for standard Linux VM, but not OK for our VM where
> > >> virtio
> > >> > is  implemented by ourself.
> > >>
> > >> I'm not sure; you do have to support that 'log' mechanism but I don't
> > >> know what else is needed.
> > >>
> > >> > And with qemu-kvm-ev-2.6, live migration can work with our VM where
> > >> virtio
> > >> > is  implemented by ourself.
> > >>
> > >> 2.6 is pretty old, so there's a lot of changes - not sure what's
> > >> relevant.
> > >>
> > >> Dave
> > >>
> > >> > Thanks
> > >> > Yafeng
> > >> >
> > >> > On Mon, 15 Apr 2019 at 22:54, Dr. David Alan Gilbert <
> > >> dgilbert@redhat.com>
> > >> > wrote:
> > >> >
> > >> > > * fengyd (fengyd81@gmail.com) wrote:
> > >> > > > Hi,
> > >> > > >
> > >> > > > During live migration,  the folloing log can see in
> > >> nova-compute.log in
> > >> > > my
> > >> > > > environment:
> > >> > > >  ERROR nova.virt.libvirt.driver
> > >> [req-039a85e1-e7a1-4a63-bc6d-c4b9a044aab6
> > >> > > > 0cdab20dc79f4bc6ae5790e7b4a898ac
> 3363c319773549178acc67f32c78310e -
> > >> > > default
> > >> > > > default] [instance: 5ec719f4-1865-4afe-a207-3d9fae22c410] Live
> > >> Migration
> > >> > > > failure: internal error: qemu unexpectedly closed the monitor:
> > >> > > > 2019-04-15T02:58:22.213897Z qemu-kvm: VQ 0
> > >> > > > size 0x100 < last_avail_idx 0x1e - used_idx 0x23
> > >> > > >
> > >> > > > It's OK for standard Linux VM, but not OK for our VM where
> virtio is
> > >> > > > implemented by ourself.
> > >> > > > KVM version as follow:
> > >> > > > qemu-kvm-common-ev-2.12.0-18.el7_6.3.1.x86_64
> > >> > > > qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
> > >> > > > libvirt-daemon-kvm-3.9.0-14.2.el7.centos.ncir.8.x86_64
> > >> > > >
> > >> > > > Do you know what's the difference between virtio and vhost-user
> > >> during
> > >> > > > migration?
> > >> > > > The function virtio_load in Qemu is called for virtio and
> vhost-user
> > >> > > during
> > >> > > > migration.
> > >> > > > For virtio,  last_avail_idx  and used_idx are stored in Qemu,
> Qemu
> > >> is
> > >> > > > responsible for updating their values accordingly
> > >> > > > For vhost-user, last_avail_idx  and used_idx are stored in
> > >> vhost-user
> > >> > > app,
> > >> > > > eg. DPDK, not in Qemu?
> > >> > > > How does migration work for vhost-user?
> > >> > >
> > >> > > I don't know the details, but my understanding is that vhost-user
> > >> > > tells the vhost-user client about an area of 'log' memory, where
> the
> > >> > > vhost-user client must mark pages as dirty.
> > >> > >
> > >> > > In the qemu source, see docs/interop/vhost-user.txt and see
> > >> > > the VHOST_SET_LOG_BASE and VHOST_USER_SET_LOG_FD calls.
> > >> > >
> > >> > > If the client correctly marks the areas as dirty, then qemu
> > >> > > should resend those pages across.
> > >> > >
> > >> > >
> > >> > > Dave
> > >> > >
> > >> > > > Thanks in advance
> > >> > > > Yafeng
> > >> > > --
> > >> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >> > >
> > >> --
> > >> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >>
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
