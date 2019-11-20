Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF9C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D47224F5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAUV3zjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D47224F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOuC-0004cD-2I
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tfiga@chromium.org>) id 1iXOra-0002QG-SG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tfiga@chromium.org>) id 1iXOrZ-00048z-0f
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:13:38 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:33455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tfiga@chromium.org>) id 1iXOrY-00048E-QD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:13:36 -0500
Received: by mail-ed1-x536.google.com with SMTP id a24so20085148edt.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mGcmhF1AeGlRclaIsN+R7xnqH8qeuJyrlBhHK9eKZzE=;
 b=kAUV3zjbKnavIr46v61GGUitObrj1k4aJWZWZL08fkeRNDfTi4HxKZ6wOpMLrmUehd
 LZGpxuQx6PaBWD4GLhQ4UsPy4/HULeEbqBj+rmZN48r5ucBqQ2BVPRO7We5q8uAFhsnv
 6ao+GGaWWzRmK1un6Cw+h4cvU2UpePizNCNMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mGcmhF1AeGlRclaIsN+R7xnqH8qeuJyrlBhHK9eKZzE=;
 b=N2eTpoBkVvrD0GJezYKvMoxW6isubu5fqEQ9A49DiGfHtGqBMgIuG/zZ9qBNafCjSO
 aaddykXfmT+Bekc+uLmrV+8x/C9JiE1+Fm62gJ7ENOHEunJIoN32DYA2BiXW15cmktYg
 9nLjT5GinPi2VKECaAermY7HIaSfgXbDtUt7BfifV7P8rCFmKtl8l8JwPDeZ3sqnBVkX
 /LWlWauNHGhdcZY8uxkKVP55seXtou7tv+MvQbFvzhJFt1hej6xrNjnIR7+vA4NaQpUO
 7pLudVyZ3ZI8MK/OdlvqzEg/6pR+QpnXbYQTXbOycBRZ3LgGjhBSG4VJRW8M2H+NVQu3
 aZlA==
X-Gm-Message-State: APjAAAWuuRRula+nKXWYMC7VG1FjzCzAQln7F2mcf9N1SuJG6DSOqV4t
 kHRAFw9ZUyCNFjNXPduzyWNc3Ky5rVHW8Q==
X-Google-Smtp-Source: APXvYqxe+GTKCYRCVgkfb+U8pT8sPN7PJImz6UDRclR/h4jaCyCrcKI2TLZkYAMXl5h45Y8lk9FicQ==
X-Received: by 2002:a17:906:c57:: with SMTP id
 t23mr5088011ejf.240.1574252015671; 
 Wed, 20 Nov 2019 04:13:35 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53])
 by smtp.gmail.com with ESMTPSA id x31sm1366345ede.0.2019.11.20.04.13.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 04:13:35 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id t1so27866451wrv.4
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:13:32 -0800 (PST)
X-Received: by 2002:a05:6000:1206:: with SMTP id
 e6mr2899864wrx.113.1574252011420; 
 Wed, 20 Nov 2019 04:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
In-Reply-To: <72712fe048af1489368f7416faa92c45@hostfission.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 21:13:18 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
Message-ID: <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Geoffrey McRae <geoff@hostfission.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::536
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

Hi Geoffrey,

On Thu, Nov 7, 2019 at 7:28 AM Geoffrey McRae <geoff@hostfission.com> wrote:
>
>
>
> On 2019-11-06 23:41, Gerd Hoffmann wrote:
> > On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
> >> > (1) The virtio device
> >> > =====================
> >> >
> >> > Has a single virtio queue, so the guest can send commands to register
> >> > and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
> >> > has a list of memory ranges for the data. Each buffer also has some
> >>
> >> Allocating from guest ram would work most of the time, but I think
> >> it's insufficient for many use cases. It doesn't really support things
> >> such as contiguous allocations, allocations from carveouts or <4GB,
> >> protected buffers, etc.
> >
> > If there are additional constrains (due to gpu hardware I guess)
> > I think it is better to leave the buffer allocation to virtio-gpu.
>
> The entire point of this for our purposes is due to the fact that we can
> not allocate the buffer, it's either provided by the GPU driver or
> DirectX. If virtio-gpu were to allocate the buffer we might as well
> forget
> all this and continue using the ivshmem device.

I don't understand why virtio-gpu couldn't allocate those buffers.
Allocation doesn't necessarily mean creating new memory. Since the
virtio-gpu device on the host talks to the GPU driver (or DirectX?),
why couldn't it return one of the buffers provided by those if
BIND_SCANOUT is requested?

>
> Our use case is niche, and the state of things may change if vendors
> like
> AMD follow through with their promises and give us SR-IOV on consumer
> GPUs, but even then we would still need their support to achieve the
> same
> results as the same issue would still be present.
>
> Also don't forget that QEMU already has a non virtio generic device
> (IVSHMEM). The only difference is, this device doesn't allow us to
> attain
> zero-copy transfers.
>
> Currently IVSHMEM is used by two projects that I am aware of, Looking
> Glass and SCREAM. While Looking Glass is solving a problem that is out
> of
> scope for QEMU, SCREAM is working around the audio problems in QEMU that
> have been present for years now.
>
> While I don't agree with SCREAM being used this way (we really need a
> virtio-sound device, and/or intel-hda needs to be fixed), it again is an
> example of working around bugs/faults/limitations in QEMU by those of us
> that are unable to fix them ourselves and seem to have low priority to
> the
> QEMU project.
>
> What we are trying to attain is freedom from dual boot Linux/Windows
> systems, not migrate-able enterprise VPS configurations. The Looking
> Glass project has brought attention to several other bugs/problems in
> QEMU, some of which were fixed as a direct result of this project (i8042
> race, AMD NPT).
>
> Unless there is another solution to getting the guest GPUs frame-buffer
> back to the host, a device like this will always be required. Since the
> landscape could change at any moment, this device should not be a LG
> specific device, but rather a generic device to allow for other
> workarounds like LG to be developed in the future should they be
> required.
>
> Is it optimal? no
> Is there a better solution? not that I am aware of
>
> >
> > virtio-gpu can't do that right now, but we have to improve virtio-gpu
> > memory management for vulkan support anyway.
> >
> >> > properties to carry metadata, some fixed (id, size, application), but
> >>
> >> What exactly do you mean by application?
> >
> > Basically some way to group buffers.  A wayland proxy for example would
> > add a "application=wayland-proxy" tag to the buffers it creates in the
> > guest, and the host side part of the proxy could ask qemu (or another
> > vmm) to notify about all buffers with that tag.  So in case multiple
> > applications are using the device in parallel they don't interfere with
> > each other.
> >
> >> > also allow free form (name = value, framebuffers would have
> >> > width/height/stride/format for example).
> >>
> >> Is this approach expected to handle allocating buffers with
> >> hardware-specific constraints such as stride/height alignment or
> >> tiling? Or would there need to be some alternative channel for
> >> determining those values and then calculating the appropriate buffer
> >> size?
> >
> > No parameter negotiation.
> >
> > cheers,
> >   Gerd

