Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D75C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6B2206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd1sJZNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6B2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIoo6-0000UU-EE
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 02:21:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hIonF-0008Bn-4g
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengyd81@gmail.com>) id 1hIonD-0003M7-8c
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:20:37 -0400
Received: from mail-it1-x12b.google.com ([2607:f8b0:4864:20::12b]:53332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fengyd81@gmail.com>) id 1hIonA-0003IJ-3y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:20:34 -0400
Received: by mail-it1-x12b.google.com with SMTP id y204so21645628itf.3
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=wvnyIWa4IqiKRLAr/8B57zbicMvzC390HfjLMGBoTxw=;
	b=Yd1sJZNCYthVuXLcPQ3YqhpP7HYa613ebnT8EDIaLvF+E2FhfO0qanCXHeIy1IfqnI
	PN3Inq85Fl3Emrphu7DHZFNfm1CRF0rZnlQ6pWHmErsU7+/HdqUMaXwq70Xs0KCy812O
	rtmvjRKhMfoRnaO1zvxNIUdMdLboSru02/x4G2EOgZoDb/F22CagvX7KAhIJ1A9nfUtc
	mE/l0vkaiQZabT2Bksj6+c4sJhWs8TPZreTObeiFF1cP44A4LRBMbn1Lv2FSjPeackOL
	luK1xrvS8BFC/jy2tQJXU2DxTdBmbdJkn2F/nMTA/FIHnKow48mmXiK28qprk5GFZKpl
	3bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=wvnyIWa4IqiKRLAr/8B57zbicMvzC390HfjLMGBoTxw=;
	b=HconHQtNT2amchR7tv1LAkgSJQGSzVT3pqNL0f20/ts6BPzayjkDc+zZ2h4nreeItg
	2PVqY9ASBrlTx0tED5ocbBS4wgxCa2fVsjsObjB6UChXZ4wIBz4qOlFE52+p2QMkHJ89
	g71rhiz4Tt772QVZo3Ofd7m8mB+kl5w1Q9SAumZgIhs6Co1DFs98F/N3ChN4Q3DnjN7a
	6veRFavhTd3kbvdCKmE+H+qYxm9hzqxK+d8Px++HQEZc7JfSjWRpuL0t0CXY+y6InmTG
	0mWG7d190KpYgCX7o9iv08eOCjPLDSpYZFsVe7L8v31fRNt+nRY3aGr8kSTBG1TuuvKL
	vNmQ==
X-Gm-Message-State: APjAAAWj1QWSPcXpMSMStIsBjVxUvS2+Rf4ERZelp7KauaCJIMUJYnMW
	92Ww8+XNqmbfrLXGaJMhb8zuMQ4WGOqKmagWzp4=
X-Google-Smtp-Source: APXvYqzMHWbsPTKQfFVRmgOo3BrBIwB9zYDVt+9Ddf9D0m0juJsffMRNZLz2HjYEdu6MiaUES4EIfOGgoaE5b/E+WcE=
X-Received: by 2002:a24:c544:: with SMTP id f65mr818277itg.90.1556000429661;
	Mon, 22 Apr 2019 23:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
	<20190415145358.GA2893@work-vm>
	<CACnvu8a5DjAUhfAGmi6GtpD1V2hfoNLTkKEgbsFuL_6GrRc+pg@mail.gmail.com>
	<CACnvu8Y9Ub5PAOt18ukzvOoDxmfzwvygWWwOZaT5Q2Eig6YFTw@mail.gmail.com>
	<20190416084738.GA3123@work-vm>
In-Reply-To: <20190416084738.GA3123@work-vm>
From: fengyd <fengyd81@gmail.com>
Date: Tue, 23 Apr 2019 14:20:17 +0800
Message-ID:
 <CACnvu8Y7OQSYgGUXm5+bdB0owwmm+gSDpuaGQn=5QNhB5wcjvQ@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::12b
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
Message-ID: <20190423062017.CvislGVe6t_PfSx7xDx7GQ7SEygYLo_ss6v6_c-ngrg@z>

Hi,

I want to add some log to qemu-kvm-ev.
Do you know how to compile qemu-kvm-ev from source code?

Thanks

Yafeng

On Tue, 16 Apr 2019 at 16:47, Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * fengyd (fengyd81@gmail.com) wrote:
> > ---------- Forwarded message ---------
> > From: fengyd <fengyd81@gmail.com>
> > Date: Tue, 16 Apr 2019 at 09:17
> > Subject: Re: [Qemu-devel] How live migration work for vhost-user
> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> >
> > Hi,
> >
> > Any special feature needs to be supported on guest driver?
> > Because it's OK for standard Linux VM, but not OK for our VM where virtio
> > is  implemented by ourself.
>
> I'm not sure; you do have to support that 'log' mechanism but I don't
> know what else is needed.
>
> > And with qemu-kvm-ev-2.6, live migration can work with our VM where
> virtio
> > is  implemented by ourself.
>
> 2.6 is pretty old, so there's a lot of changes - not sure what's
> relevant.
>
> Dave
>
> > Thanks
> > Yafeng
> >
> > On Mon, 15 Apr 2019 at 22:54, Dr. David Alan Gilbert <
> dgilbert@redhat.com>
> > wrote:
> >
> > > * fengyd (fengyd81@gmail.com) wrote:
> > > > Hi,
> > > >
> > > > During live migration,  the folloing log can see in nova-compute.log
> in
> > > my
> > > > environment:
> > > >  ERROR nova.virt.libvirt.driver
> [req-039a85e1-e7a1-4a63-bc6d-c4b9a044aab6
> > > > 0cdab20dc79f4bc6ae5790e7b4a898ac 3363c319773549178acc67f32c78310e -
> > > default
> > > > default] [instance: 5ec719f4-1865-4afe-a207-3d9fae22c410] Live
> Migration
> > > > failure: internal error: qemu unexpectedly closed the monitor:
> > > > 2019-04-15T02:58:22.213897Z qemu-kvm: VQ 0
> > > > size 0x100 < last_avail_idx 0x1e - used_idx 0x23
> > > >
> > > > It's OK for standard Linux VM, but not OK for our VM where virtio is
> > > > implemented by ourself.
> > > > KVM version as follow:
> > > > qemu-kvm-common-ev-2.12.0-18.el7_6.3.1.x86_64
> > > > qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
> > > > libvirt-daemon-kvm-3.9.0-14.2.el7.centos.ncir.8.x86_64
> > > >
> > > > Do you know what's the difference between virtio and vhost-user
> during
> > > > migration?
> > > > The function virtio_load in Qemu is called for virtio and vhost-user
> > > during
> > > > migration.
> > > > For virtio,  last_avail_idx  and used_idx are stored in Qemu, Qemu is
> > > > responsible for updating their values accordingly
> > > > For vhost-user, last_avail_idx  and used_idx are stored in vhost-user
> > > app,
> > > > eg. DPDK, not in Qemu?
> > > > How does migration work for vhost-user?
> > >
> > > I don't know the details, but my understanding is that vhost-user
> > > tells the vhost-user client about an area of 'log' memory, where the
> > > vhost-user client must mark pages as dirty.
> > >
> > > In the qemu source, see docs/interop/vhost-user.txt and see
> > > the VHOST_SET_LOG_BASE and VHOST_USER_SET_LOG_FD calls.
> > >
> > > If the client correctly marks the areas as dirty, then qemu
> > > should resend those pages across.
> > >
> > >
> > > Dave
> > >
> > > > Thanks in advance
> > > > Yafeng
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
