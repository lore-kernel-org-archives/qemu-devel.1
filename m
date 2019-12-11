Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4703C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 05:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E78C20652
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 05:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQhbo4CZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E78C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieuFU-0008IM-Hk
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 00:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ieuEa-0007X1-89
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 00:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ieuEY-000230-JD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 00:08:24 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ieuEY-00021l-Cy
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 00:08:22 -0500
Received: by mail-qk1-x742.google.com with SMTP id c17so8680595qkg.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 21:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=13NpB549RTiez4xpnMDT0FGVuUUTjC2Z6ZWN3TT4Vxw=;
 b=fQhbo4CZTZAKQQi+k4zC2vXK+P/7YfcBdIbGqWp+n3T84MYmrEQN8S5jjxuYUQixxm
 ZsN5Yo/+TueJH+arp4tchOKiSc3RoqDtbaucWLigYyUZ4lmKlWsv8syyzuYdjOfdS/qc
 0oU6lnSXOTVAbhh3i0ED9CDobfxWBaQqzqBww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=13NpB549RTiez4xpnMDT0FGVuUUTjC2Z6ZWN3TT4Vxw=;
 b=sDl3Qh3Xlm5SoTSkU9qmgvxAf4CdjxF6eTNAediSMn8pi9/XcpNIijq2uBTJj+jQTV
 hcx8y1gYhGr1oakyIgn2IagsMAXHDfZnBfrdUr8WqNAI+dCxyIXwNJLNSyB53BcQamem
 RFndtL09c11HrH2KeAER5KBJ0MwqLhLpbQffpXeW4GYomq8QrwoB7RmIGgnu8nML5/ip
 Sz5vpRvOjqAvuY8OlA4ZH6Mk+lfjsRtCC+ktm1CAOWGLZ2ldgA2nwbSjicSYUS5pAdJ1
 DHjGIzhtm5WWpfDZrzDkePqHRvoOcX0WWvbvmajwUoJFhvQCISOUAmW+Qb7u3NoWqPbL
 rkCg==
X-Gm-Message-State: APjAAAW3JnmyA+x9Ss0iTDZnGPc2QPcTHJ2yz826EgN6Mo9EFW4547ic
 zJOAC3xCq5t0Idgah+1cxLCcgGfQEvXkKo4Xh3d5wg==
X-Google-Smtp-Source: APXvYqxgElEEBnxsuMOS8vYNVs3ziV7cgJhHrroNDr9xuYZhJF+2TSpKtR6UBQgzp3nGIhuQ8EWaol/dHsfhtQK+opk=
X-Received: by 2002:a37:a68f:: with SMTP id p137mr1246162qke.328.1576040900973; 
 Tue, 10 Dec 2019 21:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
In-Reply-To: <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 11 Dec 2019 14:08:10 +0900
Message-ID: <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Dylan Reid <dgreid@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Zach Reizner <zachr@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>,
 Alex Lau <alexlau@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are three issues being discussed here that aren't being clearly
delineated: sharing guest allocated memory with the host, sharing host
allocated memory with the guest, and sharing buffers between devices.

Right now, guest allocated memory can be shared with the host through
the virtqueues or by passing a scatterlist in the virtio payload (i.e.
what virtio-gpu does). Host memory can be shared with the guest using
the new shared memory regions. As far as I can tell, these mechanisms
should be sufficient for sharing memory between the guest and host and
vice versa.

Where things are not sufficient is when we talk about sharing buffers
between devices. For starters, a 'buffer' as we're discussing here is
not something that is currently defined by the virtio spec. The
original proposal defines a buffer as a generic object that is guest
ram+id+metadata, and is created by a special buffer allocation device.
With this approach, buffers can be cleanly shared between devices.

An alternative that Tomasz suggested would be to avoid defining a
generic buffer object, and instead state that the scatterlist which
virtio-gpu currently uses is the 'correct' way for virtio device
protocols to define buffers. With this approach, sharing buffers
between devices potentially requires the host to map different
scatterlists back to a consistent representation of a buffer.

None of the proposals directly address the use case of sharing host
allocated buffers between devices, but I think they can be extended to
support it. Host buffers can be identified by the following tuple:
(transport type enum, transport specific device address, shmid,
offset). I think this is sufficient even for host-allocated buffers
that aren't visible to the guest (e.g. protected memory, vram), since
they can still be given address space in some shared memory region,
even if those addresses are actually inaccessible to the guest. At
this point, the host buffer identifier can simply be passed in place
of the guest ram scatterlist with either proposed buffer sharing
mechanism.

I think the main question here is whether or not the complexity of
generic buffers and a buffer sharing device is worth it compared to
the more implicit definition of buffers. Personally, I lean towards
the implicit definition of buffers, since a buffer sharing device
brings a lot of complexity and there aren't any clear clients of the
buffer metadata feature.

Cheers,
David

On Thu, Dec 5, 2019 at 7:22 AM Dylan Reid <dgreid@chromium.org> wrote:
>
> On Thu, Nov 21, 2019 at 4:59 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Thu, Nov 21, 2019 at 6:41 AM Geoffrey McRae <geoff@hostfission.com> wrote:
> > >
> > >
> > >
> > > On 2019-11-20 23:13, Tomasz Figa wrote:
> > > > Hi Geoffrey,
> > > >
> > > > On Thu, Nov 7, 2019 at 7:28 AM Geoffrey McRae <geoff@hostfission.com>
> > > > wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2019-11-06 23:41, Gerd Hoffmann wrote:
> > > >> > On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
> > > >> >> > (1) The virtio device
> > > >> >> > =====================
> > > >> >> >
> > > >> >> > Has a single virtio queue, so the guest can send commands to register
> > > >> >> > and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
> > > >> >> > has a list of memory ranges for the data. Each buffer also has some
> > > >> >>
> > > >> >> Allocating from guest ram would work most of the time, but I think
> > > >> >> it's insufficient for many use cases. It doesn't really support things
> > > >> >> such as contiguous allocations, allocations from carveouts or <4GB,
> > > >> >> protected buffers, etc.
> > > >> >
> > > >> > If there are additional constrains (due to gpu hardware I guess)
> > > >> > I think it is better to leave the buffer allocation to virtio-gpu.
> > > >>
> > > >> The entire point of this for our purposes is due to the fact that we
> > > >> can
> > > >> not allocate the buffer, it's either provided by the GPU driver or
> > > >> DirectX. If virtio-gpu were to allocate the buffer we might as well
> > > >> forget
> > > >> all this and continue using the ivshmem device.
> > > >
> > > > I don't understand why virtio-gpu couldn't allocate those buffers.
> > > > Allocation doesn't necessarily mean creating new memory. Since the
> > > > virtio-gpu device on the host talks to the GPU driver (or DirectX?),
> > > > why couldn't it return one of the buffers provided by those if
> > > > BIND_SCANOUT is requested?
> > > >
> > >
> > > Because in our application we are a user-mode application in windows
> > > that is provided with buffers that were allocated by the video stack in
> > > windows. We are not using a virtual GPU but a physical GPU via vfio
> > > passthrough and as such we are limited in what we can do. Unless I have
> > > completely missed what virtio-gpu does, from what I understand it's
> > > attempting to be a virtual GPU in its own right, which is not at all
> > > suitable for our requirements.
> >
> > Not necessarily. virtio-gpu in its basic shape is an interface for
> > allocating frame buffers and sending them to the host to display.
> >
> > It sounds to me like a PRIME-based setup similar to how integrated +
> > discrete GPUs are handled on regular systems could work for you. The
> > virtio-gpu device would be used like the integrated GPU that basically
> > just drives the virtual screen. The guest component that controls the
> > display of the guest (typically some sort of a compositor) would
> > allocate the frame buffers using virtio-gpu and then import those to
> > the vfio GPU when using it for compositing the parts of the screen.
> > The parts of the screen themselves would be rendered beforehand by
> > applications into local buffers managed fully by the vfio GPU, so
> > there wouldn't be any need to involve virtio-gpu there. Only the
> > compositor would have to be aware of it.
> >
> > Of course if your guest is not Linux, I have no idea if that can be
> > handled in any reasonable way. I know those integrated + discrete GPU
> > setups do work on Windows, but things are obviously 100% proprietary,
> > so I don't know if one could make them work with virtio-gpu as the
> > integrated GPU.
> >
> > >
> > > This discussion seems to have moved away completely from the original
> > > simple feature we need, which is to share a random block of guest
> > > allocated ram with the host. While it would be nice if it's contiguous
> > > ram, it's not an issue if it's not, and with udmabuf (now I understand
> > > it) it can be made to appear contigous if it is so desired anyway.
> > >
> > > vhost-user could be used for this if it is fixed to allow dynamic
> > > remapping, all the other bells and whistles that are virtio-gpu are
> > > useless to us.
> > >
> >
> > As far as I followed the thread, my impression is that we don't want
> > to have an ad-hoc interface just for sending memory to the host. The
> > thread was started to look for a way to create identifiers for guest
> > memory, which proper virtio devices could use to refer to the memory
> > within requests sent to the host.
> >
> > That said, I'm not really sure if there is any benefit of making it
> > anything other than just the specific virtio protocol accepting
> > scatterlist of guest pages directly.
> >
> > Putting the ability to obtain the shared memory itself, how do you
> > trigger a copy from the guest frame buffer to the shared memory?
>
> Adding Zach for more background on virtio-wl particular use cases.

