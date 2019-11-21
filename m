Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A516C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 05:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EB620715
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 05:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kGnrbLYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EB620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXfTh-0004a3-7q
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 00:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tfiga@chromium.org>) id 1iXfSv-0004AF-Vj
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 00:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tfiga@chromium.org>) id 1iXfSu-0002NA-AX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 00:57:17 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:38583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tfiga@chromium.org>) id 1iXfSu-0002Mp-0S
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 00:57:16 -0500
Received: by mail-ed1-x535.google.com with SMTP id s10so1699310edi.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 21:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2eHBuXmXmspsJPRCU+yNkYKvjiNseTm4kip/wzjn18c=;
 b=kGnrbLYMDZeT2caToobPNwp98jJBSk3eoRepF1AtB0wyhRSehLQUMBbnoNub6UrV78
 s4wAigChgHERrKl2hqspHpsLrwU/Op1Mui8aafjBcefN5UR9mLQ8cm1pvFejiRooXT8R
 n4RgZD/TfPdetJrHNQboCfWLrmj8U5ig3u0RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2eHBuXmXmspsJPRCU+yNkYKvjiNseTm4kip/wzjn18c=;
 b=RZBjKxMQPLaNL/YsaRQNKypxIHIAoAal5LT6OU+429fZEmtb+k1kspPQBCTPcF4gJM
 omMWzT78xV7ouwg9Zd2RUpPURdut43TzKF3DI+M6THHyE6GmWwXUFFIKfnz2YB+xT9A5
 8FNDZY3dBOj8ccvKg+kllo05AnrcMxEeue/b/xboDCmPlrmUKtZ6yI6HudupiXPTCHWJ
 hqkPavCYSuH2o1SHlEdJvDRrqUArBkgo/jUZZ0V6iEnFUy/+LQwfLUGWAX6BJVpPGlTK
 q1E/QISxZmOD6Bv0Hon///ohTdacEftLUCJsdJTyTVT3wG5j2qFLIksp7+JrdtJQUPzp
 Nr3w==
X-Gm-Message-State: APjAAAUtzN1fY6wrYWNqkr46iCCCMofHFGTqfAk74yyVrzzqFxUEB7mM
 bCKUnPmGsXi7Ws5DSbnh2tw3PBevKG0=
X-Google-Smtp-Source: APXvYqyokDAMkEfLeQabFVcKJlCmUZr/XViVsutQNrLtaQZVvhiwQAONRhZBwIcOvICmMvI6LtCT/Q==
X-Received: by 2002:a17:906:f10:: with SMTP id
 z16mr11438916eji.211.1574315834124; 
 Wed, 20 Nov 2019 21:57:14 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com.
 [209.85.128.43])
 by smtp.gmail.com with ESMTPSA id z31sm51729edz.13.2019.11.20.21.57.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 21:57:14 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id n188so359980wme.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 21:57:13 -0800 (PST)
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr8128845wma.90.1574315484024; 
 Wed, 20 Nov 2019 21:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
In-Reply-To: <d65bec5074eda5f389668e28922c1609@hostfission.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 21 Nov 2019 14:51:11 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
Message-ID: <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Geoffrey McRae <geoff@hostfission.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::535
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Alex Lau <alexlau@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org,
 qemu-devel <qemu-devel@nongnu.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 6:41 AM Geoffrey McRae <geoff@hostfission.com> wrote:
>
>
>
> On 2019-11-20 23:13, Tomasz Figa wrote:
> > Hi Geoffrey,
> >
> > On Thu, Nov 7, 2019 at 7:28 AM Geoffrey McRae <geoff@hostfission.com>
> > wrote:
> >>
> >>
> >>
> >> On 2019-11-06 23:41, Gerd Hoffmann wrote:
> >> > On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
> >> >> > (1) The virtio device
> >> >> > =====================
> >> >> >
> >> >> > Has a single virtio queue, so the guest can send commands to register
> >> >> > and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
> >> >> > has a list of memory ranges for the data. Each buffer also has some
> >> >>
> >> >> Allocating from guest ram would work most of the time, but I think
> >> >> it's insufficient for many use cases. It doesn't really support things
> >> >> such as contiguous allocations, allocations from carveouts or <4GB,
> >> >> protected buffers, etc.
> >> >
> >> > If there are additional constrains (due to gpu hardware I guess)
> >> > I think it is better to leave the buffer allocation to virtio-gpu.
> >>
> >> The entire point of this for our purposes is due to the fact that we
> >> can
> >> not allocate the buffer, it's either provided by the GPU driver or
> >> DirectX. If virtio-gpu were to allocate the buffer we might as well
> >> forget
> >> all this and continue using the ivshmem device.
> >
> > I don't understand why virtio-gpu couldn't allocate those buffers.
> > Allocation doesn't necessarily mean creating new memory. Since the
> > virtio-gpu device on the host talks to the GPU driver (or DirectX?),
> > why couldn't it return one of the buffers provided by those if
> > BIND_SCANOUT is requested?
> >
>
> Because in our application we are a user-mode application in windows
> that is provided with buffers that were allocated by the video stack in
> windows. We are not using a virtual GPU but a physical GPU via vfio
> passthrough and as such we are limited in what we can do. Unless I have
> completely missed what virtio-gpu does, from what I understand it's
> attempting to be a virtual GPU in its own right, which is not at all
> suitable for our requirements.

Not necessarily. virtio-gpu in its basic shape is an interface for
allocating frame buffers and sending them to the host to display.

It sounds to me like a PRIME-based setup similar to how integrated +
discrete GPUs are handled on regular systems could work for you. The
virtio-gpu device would be used like the integrated GPU that basically
just drives the virtual screen. The guest component that controls the
display of the guest (typically some sort of a compositor) would
allocate the frame buffers using virtio-gpu and then import those to
the vfio GPU when using it for compositing the parts of the screen.
The parts of the screen themselves would be rendered beforehand by
applications into local buffers managed fully by the vfio GPU, so
there wouldn't be any need to involve virtio-gpu there. Only the
compositor would have to be aware of it.

Of course if your guest is not Linux, I have no idea if that can be
handled in any reasonable way. I know those integrated + discrete GPU
setups do work on Windows, but things are obviously 100% proprietary,
so I don't know if one could make them work with virtio-gpu as the
integrated GPU.

>
> This discussion seems to have moved away completely from the original
> simple feature we need, which is to share a random block of guest
> allocated ram with the host. While it would be nice if it's contiguous
> ram, it's not an issue if it's not, and with udmabuf (now I understand
> it) it can be made to appear contigous if it is so desired anyway.
>
> vhost-user could be used for this if it is fixed to allow dynamic
> remapping, all the other bells and whistles that are virtio-gpu are
> useless to us.
>

As far as I followed the thread, my impression is that we don't want
to have an ad-hoc interface just for sending memory to the host. The
thread was started to look for a way to create identifiers for guest
memory, which proper virtio devices could use to refer to the memory
within requests sent to the host.

That said, I'm not really sure if there is any benefit of making it
anything other than just the specific virtio protocol accepting
scatterlist of guest pages directly.

Putting the ability to obtain the shared memory itself, how do you
trigger a copy from the guest frame buffer to the shared memory?

> >>
> >> Our use case is niche, and the state of things may change if vendors
> >> like
> >> AMD follow through with their promises and give us SR-IOV on consumer
> >> GPUs, but even then we would still need their support to achieve the
> >> same
> >> results as the same issue would still be present.
> >>
> >> Also don't forget that QEMU already has a non virtio generic device
> >> (IVSHMEM). The only difference is, this device doesn't allow us to
> >> attain
> >> zero-copy transfers.
> >>
> >> Currently IVSHMEM is used by two projects that I am aware of, Looking
> >> Glass and SCREAM. While Looking Glass is solving a problem that is out
> >> of
> >> scope for QEMU, SCREAM is working around the audio problems in QEMU
> >> that
> >> have been present for years now.
> >>
> >> While I don't agree with SCREAM being used this way (we really need a
> >> virtio-sound device, and/or intel-hda needs to be fixed), it again is
> >> an
> >> example of working around bugs/faults/limitations in QEMU by those of
> >> us
> >> that are unable to fix them ourselves and seem to have low priority to
> >> the
> >> QEMU project.
> >>
> >> What we are trying to attain is freedom from dual boot Linux/Windows
> >> systems, not migrate-able enterprise VPS configurations. The Looking
> >> Glass project has brought attention to several other bugs/problems in
> >> QEMU, some of which were fixed as a direct result of this project
> >> (i8042
> >> race, AMD NPT).
> >>
> >> Unless there is another solution to getting the guest GPUs
> >> frame-buffer
> >> back to the host, a device like this will always be required. Since
> >> the
> >> landscape could change at any moment, this device should not be a LG
> >> specific device, but rather a generic device to allow for other
> >> workarounds like LG to be developed in the future should they be
> >> required.
> >>
> >> Is it optimal? no
> >> Is there a better solution? not that I am aware of
> >>
> >> >
> >> > virtio-gpu can't do that right now, but we have to improve virtio-gpu
> >> > memory management for vulkan support anyway.
> >> >
> >> >> > properties to carry metadata, some fixed (id, size, application), but
> >> >>
> >> >> What exactly do you mean by application?
> >> >
> >> > Basically some way to group buffers.  A wayland proxy for example would
> >> > add a "application=wayland-proxy" tag to the buffers it creates in the
> >> > guest, and the host side part of the proxy could ask qemu (or another
> >> > vmm) to notify about all buffers with that tag.  So in case multiple
> >> > applications are using the device in parallel they don't interfere with
> >> > each other.
> >> >
> >> >> > also allow free form (name = value, framebuffers would have
> >> >> > width/height/stride/format for example).
> >> >>
> >> >> Is this approach expected to handle allocating buffers with
> >> >> hardware-specific constraints such as stride/height alignment or
> >> >> tiling? Or would there need to be some alternative channel for
> >> >> determining those values and then calculating the appropriate buffer
> >> >> size?
> >> >
> >> > No parameter negotiation.
> >> >
> >> > cheers,
> >> >   Gerd

