Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EE0C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DF8214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZ18dPik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DF8214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLlo-0002aK-NK
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1iSGnt-0000K1-5b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1iSGnr-00044n-Mu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:36:37 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:44931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1iSGnr-00043p-HE
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:36:35 -0500
Received: by mail-qt1-x82d.google.com with SMTP id o11so27805596qtr.11
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 00:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D288lyijPXwamjKxXMPNTuJhKFkBSR4imFrkU4/G3RA=;
 b=JZ18dPikwE7MF0VWSE2olCmAPIHJ16CZwNMa0ZG5+0DiJtIhVWhjSM5hcYipBDGzKC
 byL6wCyjc6yqct77kf/SuryK2kUiERMZwmLCuytfgVgAfKtP13JckHxdWhv8VG0t+J44
 yk1TGtJCNBu2PUMWNKRdhuzC0ojmSKBcLO8Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D288lyijPXwamjKxXMPNTuJhKFkBSR4imFrkU4/G3RA=;
 b=re4KhpdJpW/h0afbUModLgPfGqiO3qDCaxzx0fEuvBANAoGt1bApRcBMhsoC3mf4o5
 /KBFoBNEGe1P2qRjOXp6qzA+mrIHVoVIIlVV3ep/hddbhKk/Ej4z5pMCAEt080iHOJJ+
 hWI2vanMFv+dy1WYzSkivQtJij7TkuMWnMFU1ftJZif+7spuC1m+oFZd/kEBwJ+BvjsG
 KCIYuyMvdKGNMRDhoS+3YuLiQ46v6nqi4CM8H4ZP9uztbBrk4LWCk/oQ0HP+9kAzFj19
 h1wGUJkcR0ar5SJHjxXIvR2Pel0JOiHZKJ6oR+Zdg1b3fgHOfoqYWYhAztPxuzM+egkK
 OSZw==
X-Gm-Message-State: APjAAAUBkZWDiEhGgxsY3LnE5AW5L1EutLWj9emHAOtdPBQDwtm8ai1V
 PLGXNgDD/hI3iQDg+5+yNC4vDgq6iutIsQDi/qZkdw==
X-Google-Smtp-Source: APXvYqzr/oTuJVWFtg55xeb32V3dy0sTrZaPlfsggUy15MdQTndaWW0MlrbdefS0roopbd9zUwA2Ih85DU0W+kBq2Fo=
X-Received: by 2002:aed:3f57:: with SMTP id q23mr1338619qtf.116.1573029393500; 
 Wed, 06 Nov 2019 00:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
In-Reply-To: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 6 Nov 2019 17:36:22 +0900
Message-ID: <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82d
X-Mailman-Approved-At: Wed, 06 Nov 2019 08:46:39 -0500
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
Cc: geoff@hostfission.com, Hans Verkuil <hverkuil@xs4all.nl>,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> (1) The virtio device
> =====================
>
> Has a single virtio queue, so the guest can send commands to register
> and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
> has a list of memory ranges for the data. Each buffer also has some

Allocating from guest ram would work most of the time, but I think
it's insufficient for many use cases. It doesn't really support things
such as contiguous allocations, allocations from carveouts or <4GB,
protected buffers, etc.

> properties to carry metadata, some fixed (id, size, application), but

What exactly do you mean by application?

> also allow free form (name = value, framebuffers would have
> width/height/stride/format for example).

Is this approach expected to handle allocating buffers with
hardware-specific constraints such as stride/height alignment or
tiling? Or would there need to be some alternative channel for
determining those values and then calculating the appropriate buffer
size?

-David

On Tue, Nov 5, 2019 at 7:55 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi folks,
>
> The issue of sharing buffers between guests and hosts keeps poping
> up again and again in different contexts.  Most recently here:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg656685.html
>
> So, I'm grabbing the recipient list of the virtio-vdec thread and some
> more people I know might be interested in this, hoping to have everyone
> included.
>
> Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> resources" is really a good answer for all the different use cases
> we have collected over time.  Maybe it is better to have a dedicated
> buffer sharing virtio device?  Here is the rough idea:
>
>
> (1) The virtio device
> =====================
>
> Has a single virtio queue, so the guest can send commands to register
> and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
> has a list of memory ranges for the data.  Each buffer also has some
> properties to carry metadata, some fixed (id, size, application), but
> also allow free form (name = value, framebuffers would have
> width/height/stride/format for example).
>
>
> (2) The linux guest implementation
> ==================================
>
> I guess I'd try to make it a drm driver, so we can re-use drm
> infrastructure (shmem helpers for example).  Buffers are dumb drm
> buffers.  dma-buf import and export is supported (shmem helpers
> get us that for free).  Some device-specific ioctls to get/set
> properties and to register/unregister the buffers on the host.
>
>
> (3) The qemu host implementation
> ================================
>
> qemu (likewise other vmms) can use the udmabuf driver to create
> host-side dma-bufs for the buffers.  The dma-bufs can be passed to
> anyone interested, inside and outside qemu.  We'll need some protocol
> for communication between qemu and external users interested in those
> buffers, to receive dma-bufs (via unix file descriptor passing) and
> update notifications.  Dispatching updates could be done based on the
> application property, which could be "virtio-vdec" or "wayland-proxy"
> for example.
>
>
> commments?
>
> cheers,
>   Gerd
>

