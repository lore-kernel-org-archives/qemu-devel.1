Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A714C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 03:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D0A218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 03:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="araSHSko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D0A218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ8Ns-0002KD-Bo
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 23:15:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hJ8Ms-00020W-5G
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hJ8Mo-0004wc-1p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:14:41 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e]:45411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fengyd81@gmail.com>) id 1hJ8Ml-0004Tq-DH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:14:35 -0400
Received: by mail-io1-xd2e.google.com with SMTP id e8so2248124ioe.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 20:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=FNrGQS2JXlw0O7nz2lyXEUXZXZWfDdIfXxDdyjcBigw=;
	b=araSHSko0R5Z2PlYgvwCy18GCo73iKBezcv3+rIvZYh9dY+nKucZliPoI79ZM6BEd1
	CHLiU05eE0gmpFd6XT+R60C5Ulo+GZ3gSS1KAMFkbG36UNY17CF+HRR1Ajc1DWvduTCU
	wsIMTI55utmQkEvQ34iXxUjYXe88mJ+StGlDAjgJKTdyfb7LlKLJDmfLp//5ZmYCFRGt
	yi6eOK1YiiJu8Ku7PLEbqmCOnJsdbFkbd9Mc1Ip+auK2flpbQt6/TYLmnqHIf3ru0A0P
	XgpfhPruWSq+Ifg2scbGhFQqTBtvlMe4d2j6LvDitYoUosKjV1kyzTurub13sK1Rd8Ft
	mliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=FNrGQS2JXlw0O7nz2lyXEUXZXZWfDdIfXxDdyjcBigw=;
	b=SAXyS6QgkXtwCa2hDFDVxmvddetLDhKiYp2ahyoqJR8BqK9ICXOt+WtInIHuGP8Jzk
	pTKaSled+N/PQKVb5Yc4lpkdrkW2nZTm0E/oRIfdxmeXcqOURh4U4uqH8mmVSYwJbPXE
	WGg+EUIhSp0cGcSGUmqvGPVQMYiu9SMnaQFhniKzp6HxUNxZdVxXe91kYf5YLuvEzkkV
	lwALi3s6LgpSMLafsioBIpMjblzvh57dgwVdtAVWwLClICTpPBRtgpLO5Yl0Xy4auMk1
	os3Dk9xohgmYOW2sO1POZiSn4hG71cRu5Mqc1hbuRXWTVR/OTR5FTzKaa29EzNYcyHks
	l3Lg==
X-Gm-Message-State: APjAAAUCdho1xOKqEhfDWvM0jBV6bLYzO3Dd/3BdeQWrNyUjmRrk9YoN
	GEXToho5lK2cM1juIJYrVpUqaeFwWqDHRTdDkaw=
X-Google-Smtp-Source: APXvYqyhCcetm4KmOYEcTGF0VljCqGvqfISCx88DUUD3Ut89Ntl+17027AokktoFmkaWD+HvvQjaAcclX643M2qgbHk=
X-Received: by 2002:a5d:9d84:: with SMTP id 4mr2520578ion.124.1556075666727;
	Tue, 23 Apr 2019 20:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
	<20190415145358.GA2893@work-vm>
	<CACnvu8a5DjAUhfAGmi6GtpD1V2hfoNLTkKEgbsFuL_6GrRc+pg@mail.gmail.com>
	<CACnvu8Y9Ub5PAOt18ukzvOoDxmfzwvygWWwOZaT5Q2Eig6YFTw@mail.gmail.com>
	<20190416084738.GA3123@work-vm>
	<CACnvu8Y7OQSYgGUXm5+bdB0owwmm+gSDpuaGQn=5QNhB5wcjvQ@mail.gmail.com>
In-Reply-To: <CACnvu8Y7OQSYgGUXm5+bdB0owwmm+gSDpuaGQn=5QNhB5wcjvQ@mail.gmail.com>
From: fengyd <fengyd81@gmail.com>
Date: Wed, 24 Apr 2019 11:14:15 +0800
Message-ID:
 <CACnvu8aWowPEo=0fE+CXbdp+g9LFvxSNjRsAHdQiQzvJfoYjsQ@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d2e
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Fwd: How live migration work for vhost-user
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424031415.6xfiahFDDMaVWbNEo0eN3y2alZKbeMg9nbXXVOb9I6I@z>

Hi,

For vhost,  *last_avail_idx*  is maintained in vhost_virtqueue
but during live migration, *last_avail_idx*  is fetched from VirtQueue.
Do you know how these two *last_avail_idx *are synchronized?

virtio_load related code which is called during live migration:

* vdev->vq[i].inuse = (uint16_t)(vdev->vq[i].last_avail_idx -*

*                                vdev->vq[i].used_idx);*

*            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {*

*                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "*

*                             "used_idx 0x%x",*

*                             i, vdev->vq[i].vring.num,*

*                             vdev->vq[i].last_avail_idx,*


Thanks

On Tue, 23 Apr 2019 at 14:20, fengyd <fengyd81@gmail.com> wrote:

> Hi,
>
> I want to add some log to qemu-kvm-ev.
> Do you know how to compile qemu-kvm-ev from source code?
>
> Thanks
>
> Yafeng
>
> On Tue, 16 Apr 2019 at 16:47, Dr. David Alan Gilbert <dgilbert@redhat.com>
> wrote:
>
>> * fengyd (fengyd81@gmail.com) wrote:
>> > ---------- Forwarded message ---------
>> > From: fengyd <fengyd81@gmail.com>
>> > Date: Tue, 16 Apr 2019 at 09:17
>> > Subject: Re: [Qemu-devel] How live migration work for vhost-user
>> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >
>> >
>> > Hi,
>> >
>> > Any special feature needs to be supported on guest driver?
>> > Because it's OK for standard Linux VM, but not OK for our VM where
>> virtio
>> > is  implemented by ourself.
>>
>> I'm not sure; you do have to support that 'log' mechanism but I don't
>> know what else is needed.
>>
>> > And with qemu-kvm-ev-2.6, live migration can work with our VM where
>> virtio
>> > is  implemented by ourself.
>>
>> 2.6 is pretty old, so there's a lot of changes - not sure what's
>> relevant.
>>
>> Dave
>>
>> > Thanks
>> > Yafeng
>> >
>> > On Mon, 15 Apr 2019 at 22:54, Dr. David Alan Gilbert <
>> dgilbert@redhat.com>
>> > wrote:
>> >
>> > > * fengyd (fengyd81@gmail.com) wrote:
>> > > > Hi,
>> > > >
>> > > > During live migration,  the folloing log can see in
>> nova-compute.log in
>> > > my
>> > > > environment:
>> > > >  ERROR nova.virt.libvirt.driver
>> [req-039a85e1-e7a1-4a63-bc6d-c4b9a044aab6
>> > > > 0cdab20dc79f4bc6ae5790e7b4a898ac 3363c319773549178acc67f32c78310e -
>> > > default
>> > > > default] [instance: 5ec719f4-1865-4afe-a207-3d9fae22c410] Live
>> Migration
>> > > > failure: internal error: qemu unexpectedly closed the monitor:
>> > > > 2019-04-15T02:58:22.213897Z qemu-kvm: VQ 0
>> > > > size 0x100 < last_avail_idx 0x1e - used_idx 0x23
>> > > >
>> > > > It's OK for standard Linux VM, but not OK for our VM where virtio is
>> > > > implemented by ourself.
>> > > > KVM version as follow:
>> > > > qemu-kvm-common-ev-2.12.0-18.el7_6.3.1.x86_64
>> > > > qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
>> > > > libvirt-daemon-kvm-3.9.0-14.2.el7.centos.ncir.8.x86_64
>> > > >
>> > > > Do you know what's the difference between virtio and vhost-user
>> during
>> > > > migration?
>> > > > The function virtio_load in Qemu is called for virtio and vhost-user
>> > > during
>> > > > migration.
>> > > > For virtio,  last_avail_idx  and used_idx are stored in Qemu, Qemu
>> is
>> > > > responsible for updating their values accordingly
>> > > > For vhost-user, last_avail_idx  and used_idx are stored in
>> vhost-user
>> > > app,
>> > > > eg. DPDK, not in Qemu?
>> > > > How does migration work for vhost-user?
>> > >
>> > > I don't know the details, but my understanding is that vhost-user
>> > > tells the vhost-user client about an area of 'log' memory, where the
>> > > vhost-user client must mark pages as dirty.
>> > >
>> > > In the qemu source, see docs/interop/vhost-user.txt and see
>> > > the VHOST_SET_LOG_BASE and VHOST_USER_SET_LOG_FD calls.
>> > >
>> > > If the client correctly marks the areas as dirty, then qemu
>> > > should resend those pages across.
>> > >
>> > >
>> > > Dave
>> > >
>> > > > Thanks in advance
>> > > > Yafeng
>> > > --
>> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> > >
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>
