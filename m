Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F08C17441
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 02:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1403D214DA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 02:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S7Ja/TiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1403D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTGKg-00070v-7i
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 21:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcheu@google.com>) id 1iTFkg-0000HP-8e
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 20:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcheu@google.com>) id 1iTFkf-00044n-08
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 20:41:22 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133]:38263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcheu@google.com>) id 1iTFke-00041A-Nn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 20:41:20 -0500
Received: by mail-il1-x133.google.com with SMTP id u17so1905830ilq.5
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 17:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wVtEFg/Qou+aYXahULIg4Ddk9uw4TDjxaxbD5XH4JVs=;
 b=S7Ja/TiGlPkwGljdD/iajvmhHtBPABLFf+GeQU9NhSJftJ5DYnEhmRClF/OVp7pyj2
 I+vI3Z150NjX/t6quJ9JBX7l6ZSxi410Oq4lJPoW0T28FDVLf6oAiBcMvmB+TRuUupAl
 PoYg/UknnwucQ1CO3eC98JAtBBqzEiT+FMkrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wVtEFg/Qou+aYXahULIg4Ddk9uw4TDjxaxbD5XH4JVs=;
 b=jmuRei4QMsOxYHKqLX7OrQg0yKgn1cwHdYgnO0+CdpSz8VmCNML8QVCL3itpDhZKar
 MFnvjpkE+4EljZMLTbSwMeU95Um3ZswprEGF8JBmCyy/ZWjkRl5LlAEqbht8rcS7bt+m
 DirsbbLsmylUrsPAExautApURRXAemMY+J4tNkeXYzgIZtOrkBMbW/pkxIFUbjCiFdKi
 RuZe91y0Ru9pPeR3R1yIMWi1D0CRVM6GYqecHrajELzIMKwobgovZTUbo3A6WN8XFCoM
 OgIVHBA8ZTdlKmkatemhPfehcINZh3GnDGin5XefFxhYc8LwCQTEWpjBkKT73PKOs8yu
 LNZA==
X-Gm-Message-State: APjAAAWom9fmCE7pxiqTDX4l8s4RziECcB7DsOJsHDbqQV+zZ4mew9EF
 jkYC77urnVh7D+zviBoRZvw/B6TAjt33QvT9lSoDYw==
X-Google-Smtp-Source: APXvYqyH9hhaGKo/8SsZPmZFQrsL0XDoeeBeKZspgW0B81ZfhsLOgDMjyjHCpc90IJaEKILodBC9tZm0Wuo1ZEWPa3Q=
X-Received: by 2002:a92:5d88:: with SMTP id e8mr16072462ilg.95.1573263676306; 
 Fri, 08 Nov 2019 17:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org>
 <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
 <20191108072210.ywyneaoc2y4slth6@sirius.home.kraxel.org>
 <CAJSP0QWZc=z56CHEKa8WVe9Cw2-EhDFU+7NeGgL+g-Go5q3K5Q@mail.gmail.com>
In-Reply-To: <CAJSP0QWZc=z56CHEKa8WVe9Cw2-EhDFU+7NeGgL+g-Go5q3K5Q@mail.gmail.com>
From: =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>
Date: Fri, 8 Nov 2019 17:41:04 -0800
Message-ID: <CADMs+9ZrfEt4QfCM9pC243KTejvbORQ-Nzo0eHjU0FJ8y-2kwQ@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::133
X-Mailman-Approved-At: Fri, 08 Nov 2019 21:15:51 -0500
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
 Alex Lau <alexlau@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > Adding a list of common properties to the spec certainly makes sens=
e,
> > > > so everybody uses the same names.  Adding struct-ed properties for
> > > > common use cases might be useful too.
> > >
> > > Why not define VIRTIO devices for wayland and friends?
> >
> > There is an out-of-tree implementation of that, so yes, that surely is
> > an option.
> >
> > Wayland needs (a) shared buffers, mostly for gfx data, and (b) a stream
> > pipe as control channel.  Pretty much the same for X11, except that
> > shared buffers are optional because the X protocol can also squeeze all
> > display updates through the stream pipe.
> >
> > So, if you want allow guests talk to the host display server you can ru=
n
> > the stream pipe over vsock.  But there is nothing for the shared
> > buffers ...
> >
> > We could replicate vsock functionality elsewhere.  I think that happene=
d
> > in the out-of-tree virtio-wayland implementation.  There also was some
> > discussion about adding streams to virtio-gpu, slightly pimped up so yo=
u
> > can easily pass around virtio-gpu resource references for buffer
> > sharing.  But given that getting vsock right isn't exactly trivial
> > (consider all the fairness issues when multiplexing multiple streams
> > over a virtqueue for example) I don't think this is a good plan.
>
> I also think vsock isn't the right fit.
>

+1 we are using vsock right now and we have a few pains because of it.

I think the high-level problem is that because it is a side channel,
we don't see everything that happens to the buffer in one place
(rendering + display) and we can't do things like reallocate the
format accordingly if needed, or we can't do flushing etc. on that
buffer where needed.

Best,
St=C3=A9phane

>
> Defining a virtio-wayland device makes sense to me: you get the guest
> RAM access via virtqueues, plus the VIRTIO infrastructure (device IDs,
> configuration space, feature bits, and existing reusable
> kernel/userspace/QEMU code).
>
> Stefan

