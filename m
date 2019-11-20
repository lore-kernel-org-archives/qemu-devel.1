Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E46C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D9B22311
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lDa6MWbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9B22311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMzK-0003g5-Qy
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tfiga@chromium.org>) id 1iXMy6-0002lY-Rl
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tfiga@chromium.org>) id 1iXMy5-000575-9H
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:12:14 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:46428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tfiga@chromium.org>) id 1iXMy5-00055E-0W
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:12:13 -0500
Received: by mail-ed1-x535.google.com with SMTP id t11so13800684eds.13
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k0eJ6rySdlpAX4BY9OLA/pzu+RYxPKTylT0yhkAx2x8=;
 b=lDa6MWbxkoAcBE1WDpHJD32hmuqJ8H2y9qhPgl095mw5QjXZtpdBgnIBayjwwX3eU2
 akCqWDNmQEcJ3Wc5h6NHCWAidyQZZBigVxAe3LTLCxA2UAgmD5sY6LFRuM0Ijcm7Ltyj
 8iyTi1H9C9VCNkFwrUYfC2YMmAqL0BNIm+Em8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k0eJ6rySdlpAX4BY9OLA/pzu+RYxPKTylT0yhkAx2x8=;
 b=i6b4yDbSpEpyfTYQOMlK9GRpz9E7rXeJXYUpQ0NXsqU1XhM4MA5I5lMj6AQ4YGpA/k
 wGSbFg9wZI1KfgDmu2xipEyEuTRJpCJVxOByj8Ryi0LpLqZbrBduJ4b3rTvaH/84PVvO
 N+KFBs6EiG9kRsQWteELkOQXzMSJmfpo+FoLeUIhG9VY4naYfanFt8QAVLKVvBhrBv9F
 4V24YhFYIV3WW8cZ6Vg7XBaptRqMFqHF7VZcVENQaiaudItkwh4kUuzZD+YmEj/X5lHQ
 DqBg3g5QBMmEPO8KL69nwh5BAJS2Hd1fJQQysNTi1+weoKfwBMCebd9B+pSpk/7pXfjr
 chvA==
X-Gm-Message-State: APjAAAVEptaPtf7CgxV7uaxZ5iIQnE7MShGPPtFQX3qN5JdSPXZutpJa
 NxeCnfvhFViU7SqSqWvkkdvdBNo42Q7Z9A==
X-Google-Smtp-Source: APXvYqwLjlG6TFT/ub9yaUq9dU3qAgSdttEOToR8+kVgm2EDCwLzE3R+LXL8lZd8zNbFIPkXwwy6Fw==
X-Received: by 2002:a17:906:d210:: with SMTP id
 w16mr4372730ejz.86.1574244730807; 
 Wed, 20 Nov 2019 02:12:10 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47])
 by smtp.gmail.com with ESMTPSA id b20sm1608256edu.15.2019.11.20.02.12.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 02:12:10 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id j18so4694110wmk.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:12:10 -0800 (PST)
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr2297809wmi.64.1574244729507; 
 Wed, 20 Nov 2019 02:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org>
 <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
 <20191108072210.ywyneaoc2y4slth6@sirius.home.kraxel.org>
 <CAJSP0QWZc=z56CHEKa8WVe9Cw2-EhDFU+7NeGgL+g-Go5q3K5Q@mail.gmail.com>
 <CADMs+9ZrfEt4QfCM9pC243KTejvbORQ-Nzo0eHjU0FJ8y-2kwQ@mail.gmail.com>
 <CAJSP0QUF1YA0c7b2ENeDLo1T9OsfeTJbonOYug5Fc56--YqZJQ@mail.gmail.com>
 <CAAFQd5C6mVEUQUP8-=GevM+rV1ksFg68kyWAjCj+cjB-iQiXaA@mail.gmail.com>
 <CAJSP0QXk9XkrOeiMZ=yQCbStkXATv+AUwqqGDfcSbqL05j1kbg@mail.gmail.com>
 <CAAFQd5DBiUta9HWYZX3N06J8bSqa=zBQvL5kdCLfWUfsf9s9Vw@mail.gmail.com>
 <CAJSP0QX6ajvKpU6k6i6uBFwc9gFWoYGa6HZn7AfbGr9+975=WQ@mail.gmail.com>
In-Reply-To: <CAJSP0QX6ajvKpU6k6i6uBFwc9gFWoYGa6HZn7AfbGr9+975=WQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 19:11:56 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B5t-2-3PfEfUe8DPvDKabfUnnK_svhcKExPRYUavx1yA@mail.gmail.com>
Message-ID: <CAAFQd5B5t-2-3PfEfUe8DPvDKabfUnnK_svhcKExPRYUavx1yA@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On Mon, Nov 18, 2019 at 7:21 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sat, Nov 9, 2019 at 3:12 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Sat, Nov 9, 2019 at 9:08 PM Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > >
> > > On Sat, Nov 9, 2019 at 12:17 PM Tomasz Figa <tfiga@chromium.org> wrot=
e:
> > > > On Sat, Nov 9, 2019 at 7:12 PM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> > > > > On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@c=
hromium.org> wrote:
> > > > > > On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > > > > > > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.c=
om> wrote:
> > > > > > > > > > Adding a list of common properties to the spec certainl=
y makes sense,
> > > > > > > > > > so everybody uses the same names.  Adding struct-ed pro=
perties for
> > > > > > > > > > common use cases might be useful too.
> > > > > > > > >
> > > > > > > > > Why not define VIRTIO devices for wayland and friends?
> > > > > > > >
> > > > > > > > There is an out-of-tree implementation of that, so yes, tha=
t surely is
> > > > > > > > an option.
> > > > > > > >
> > > > > > > > Wayland needs (a) shared buffers, mostly for gfx data, and =
(b) a stream
> > > > > > > > pipe as control channel.  Pretty much the same for X11, exc=
ept that
> > > > > > > > shared buffers are optional because the X protocol can also=
 squeeze all
> > > > > > > > display updates through the stream pipe.
> > > > > > > >
> > > > > > > > So, if you want allow guests talk to the host display serve=
r you can run
> > > > > > > > the stream pipe over vsock.  But there is nothing for the s=
hared
> > > > > > > > buffers ...
> > > > > > > >
> > > > > > > > We could replicate vsock functionality elsewhere.  I think =
that happened
> > > > > > > > in the out-of-tree virtio-wayland implementation.  There al=
so was some
> > > > > > > > discussion about adding streams to virtio-gpu, slightly pim=
ped up so you
> > > > > > > > can easily pass around virtio-gpu resource references for b=
uffer
> > > > > > > > sharing.  But given that getting vsock right isn't exactly =
trivial
> > > > > > > > (consider all the fairness issues when multiplexing multipl=
e streams
> > > > > > > > over a virtqueue for example) I don't think this is a good =
plan.
> > > > > > >
> > > > > > > I also think vsock isn't the right fit.
> > > > > > >
> > > > > >
> > > > > > +1 we are using vsock right now and we have a few pains because=
 of it.
> > > > > >
> > > > > > I think the high-level problem is that because it is a side cha=
nnel,
> > > > > > we don't see everything that happens to the buffer in one place
> > > > > > (rendering + display) and we can't do things like reallocate th=
e
> > > > > > format accordingly if needed, or we can't do flushing etc. on t=
hat
> > > > > > buffer where needed.
> > > > >
> > > > > Do you think a VIRTIO device designed for your use case is an
> > > > > appropriate solution?
> > > > >
> > > > > I have been arguing that these use cases should be addressed with
> > > > > dedicated VIRTIO devices, but I don't understand the use cases of
> > > > > everyone on the CC list so maybe I'm missing something :).  If th=
ere
> > > > > are reasons why having a VIRTIO device for your use case does not=
 make
> > > > > sense then it would be good to discuss them.  Blockers like "VIRT=
IO is
> > > > > too heavyweight/complex for us because ...", "Our application can=
't
> > > > > make use of VIRTIO devices because ...", etc would be important t=
o
> > > > > hear.
> > > >
> > > > Do you have any idea on how to model Wayland as a VIRTIO device?
> > > >
> > > > Stephane mentioned that we use vsock, but in fact we have our own
> > > > VIRTIO device, except that it's semantically almost the same as vso=
ck,
> > > > with a difference being the ability to pass buffers and pipes acros=
s
> > > > the VM boundary.
> > >
> > > I know neither Wayland nor your use case :).
> > >
> > > But we can discuss the design of your VIRTIO device.  Please post a
> > > link to the code.
> >
> > The guest-side driver:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrom=
eos-4.19/drivers/virtio/virtio_wl.c
> >
> > Protocol definitions:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrom=
eos-4.19/include/uapi/linux/virtio_wl.h
> >
> > crosvm device implementation:
> > https://chromium.googlesource.com/chromiumos/platform/crosvm/+/refs/hea=
ds/master/devices/src/virtio/wl.rs
>
> Thanks, Tomasz!
>
> Unfortunately I haven't had a chance to look or catch up on this email
> thread due to other work that will keep me away for at least another
> week :(.

Thanks for the note. Waiting patiently. :)

Best regards,
Tomasz

