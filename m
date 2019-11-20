Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497CEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E9B224E6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZcP4atg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E9B224E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOr2-0001PI-05
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tfiga@chromium.org>) id 1iXOpV-0000Kh-MN
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tfiga@chromium.org>) id 1iXOpU-0001AM-AQ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:11:29 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:38414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tfiga@chromium.org>) id 1iXOpU-00018V-02
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:11:28 -0500
Received: by mail-ed1-x536.google.com with SMTP id s10so20062930edi.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GJbs7n+zbw4hCGFWh3KaaayfoAgFwo37GAAN1vh7zzY=;
 b=YZcP4atgYjSzIfOqrZjvHul/q9RDnRbhtxo/pWadKnmoSONh9KRg4NqnYnwBhiHuaJ
 YP/KHX7xe5/MnrJWF9bp6hEZOQhnRIkDMrs7z7mXmkM2Xue+TrBSRD+8PbB3w7wN4Rxi
 QfEu2ZEwh+A02vUs6VeBP2NoVs6omlpzekwdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GJbs7n+zbw4hCGFWh3KaaayfoAgFwo37GAAN1vh7zzY=;
 b=LWRsQcxHHNUJvtpUAZl2wccFgY16xqmLl/pezoZ7H0l9aXZk1ZZcmkNcJQMR6Bw5+t
 ymh8OZYJEBCSv9Rc9gc6j35Yl3fsDWWnxz7uaWOwrZEdIo+UM43YKbcNOhsIvPKGpnY8
 iOWqJj+VcCpPkndr7irFQTA6b8hEYFLcQGWeisph4ym3DcSch1sPP0dXhbn/fF98iKPd
 uKeg6drzNqNd6cOwOYlfZroawZlFbHYZljARfE0r5Sn9homZnvQnbn0VlBdXuAsJImzL
 wIki+lpHgJAH/2rngQVnUKXJPJxOfAosRPcLzLvOcgXWoVsLs8n/LGM4m1RwCBKroLit
 dhHw==
X-Gm-Message-State: APjAAAX5Fk2gFjBwBo4XD3klWoTJSnbhfBP8VXGYcTg6et2CpFpcNyzm
 GOMyJGIjIB+EPvNGPTuoOq5uLhh8Xi5FZQ==
X-Google-Smtp-Source: APXvYqzuBRuOxk/AV/Byfq482U7Y0gL9Md+jnPlNHg6hIWOv4SL0wwAORUYDQj9DX8bipNuigG/bsQ==
X-Received: by 2002:a17:906:c293:: with SMTP id
 r19mr5016435ejz.69.1574251886197; 
 Wed, 20 Nov 2019 04:11:26 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41])
 by smtp.gmail.com with ESMTPSA id e13sm1382746edv.42.2019.11.20.04.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 04:11:25 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id b11so6710729wmb.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:11:24 -0800 (PST)
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr2863103wmd.10.1574251884421; 
 Wed, 20 Nov 2019 04:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
In-Reply-To: <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 21:11:12 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BVXv7SU2JWf_pa__tWydd6UqNpMo6aQHLDjjU+Vch75A@mail.gmail.com>
Message-ID: <CAAFQd5BVXv7SU2JWf_pa__tWydd6UqNpMo6aQHLDjjU+Vch75A@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 6:51 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> > > resources" is really a good answer for all the different use cases
> > > we have collected over time.  Maybe it is better to have a dedicated
> > > buffer sharing virtio device?  Here is the rough idea:
> >
> > My concern is that buffer sharing isn't a "device".  It's a primitive
> > used in building other devices.  When someone asks for just buffer
> > sharing it's often because they do not intend to upstream a
> > specification for their device.
>
> Well, "vsock" isn't a classic device (aka nic/storage/gpu/...) either.
> It is more a service to allow communication between host and guest
>
> That buffer sharing device falls into the same category.  Maybe it even
> makes sense to build that as virtio-vsock extension.  Not sure how well
> that would work with the multi-transport architecture of vsock though.
>
> > If this buffer sharing device's main purpose is for building proprietary
> > devices without contributing to VIRTIO, then I don't think it makes
> > sense for the VIRTIO community to assist in its development.
>
> One possible use case would be building a wayland proxy, using vsock for
> the wayland protocol messages and virtio-buffers for the shared buffers
> (wayland client window content).
>
> It could also simplify buffer sharing between devices (feed decoded
> video frames from decoder to gpu), although in that case it is less
> clear that it'll actually simplify things because virtio-gpu is
> involved anyway.
>
> We can't prevent people from using that for proprietary stuff (same goes
> for vsock).
>
> There is the option to use virtio-gpu instead, i.e. add support to qemu
> to export dma-buf handles for virtio-gpu resources to other processes
> (such as a wayland proxy).  That would provide very similar
> functionality (and thereby create the same loophole).
>
> > VIRTIO recently gained a shared memory resource concept for access to
> > host memory.  It is being used in virtio-pmem and virtio-fs (and
> > virtio-gpu?).
>
> virtio-gpu is in progress still unfortunately (all kinds of fixes for
> the qemu drm drivers and virtio-gpu guest driver refactoring kept me
> busy for quite a while ...).
>
> > If another flavor of shared memory is required it can be
> > added to the spec and new VIRTIO device types can use it.  But it's not
> > clear why this should be its own device.
>
> This is not about host memory, buffers are in guest ram, everything else
> would make sharing those buffers between drivers inside the guest (as
> dma-buf) quite difficult.

I wonder if we're not forgetting about the main reason we ended up
with all this chaos - the host-allocated buffers. ;)

Do we really have an issue with sharing guest memory between different
virtio devices? Each of those devices could just accept a scatterlist
of guest pages and import that memory to whatever host component it's
backed by.

The case that really needs some support from VIRTIO is when the
buffers are allocated in the host. Sharing buffers from virtio-gpu
with a virtio video decoder or Wayland (be it a dedicated virtio
device or vsock) are some of the examples.

Best regards,
Tomasz

