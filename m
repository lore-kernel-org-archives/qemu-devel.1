Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D5CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17942071B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 10:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZUgrpV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17942071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWeAN-000597-VC
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 05:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iWe9b-0004Ss-Nv
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iWe9a-0001FJ-7g
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:21:07 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iWe9a-0001Es-40
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:21:06 -0500
Received: by mail-qk1-x744.google.com with SMTP id m16so13862206qki.11
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 02:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p9A0HQCTWo8IkEueIZ8gvaKdgMnDvJwnr6rC9+7dHTk=;
 b=pZUgrpV46Ejm0ly4g2aa4VANJRCg3njcAsKTWBbzIkV7v9jrgEa/PHjr/+JzVDC8XX
 xoXyCSlhJE0y1crHp0Q5hKtD3Md0iRErVhRhpa/5F7yWbVv4QN/kqYwuZkcDOAyc+6lX
 KIhrHYNvx9YB/+5SrEffvrOHh9LtC9awGCoJwh2KTULBsXA0Bgs4167r9HXcoIfvKzdL
 ppOh4RO1J6+dHQS4xGdYKEicbzBI1I7fRTame0sJT1y613dkEEB28MEMh12MUmCWrfTt
 PIKw2rYNgqGh1eU9ZNGBpo5WNmqblA0HGiqysXDym0ap0j1STzqEaSSoMU3lUXu8NMlN
 p8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p9A0HQCTWo8IkEueIZ8gvaKdgMnDvJwnr6rC9+7dHTk=;
 b=mC7asxcYBM3Hju5jcpNlKvN934YdzY2GIJX8uD6fwC++6iSsqaaOD4FWgx88vINAGI
 5B4XN2Phg/08p9OSMtJOABYJOIAheqxuXL+JIMbRrXQQ8+oiajwFRmsfEsHLeMf6LClH
 w8SDpa7IfWAdkKU4zmlab99PvTkPryWfrUtTo/w3zR3/o7EyV7bTT6kgMY6+9X+QAueY
 tzQBiQQjWM+Fe+O7oN2qR9ewKqINUj2SSj8b3h5C59HBwL3nGW+r7GOA3xniHOLzzdM5
 +Xg+Rh5aUav8uGL+CB22c9Np20W1GWO4BULffeNCvR09HXbX64Wsa/qcVx2C3538+2/T
 pbUw==
X-Gm-Message-State: APjAAAU2Oq8KoCV2//Go58xQ9hsw2Azv51JRHmh1LmU43O2kvbyzm9r/
 nh68aG0tYp59SJpKnn3DHgKIq2kVY6HFZnjIOQ4=
X-Google-Smtp-Source: APXvYqz48LbupXsRKsNJSGUqZn5aPb6LZVEB2oQg4AmlOsDZF8A3gLq6CbqzGhMwrDu+IyOPXG6rlv01vOsPaMddWxA=
X-Received: by 2002:a05:620a:14a2:: with SMTP id
 x2mr23572703qkj.236.1574072465398; 
 Mon, 18 Nov 2019 02:21:05 -0800 (PST)
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
In-Reply-To: <CAAFQd5DBiUta9HWYZX3N06J8bSqa=zBQvL5kdCLfWUfsf9s9Vw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 18 Nov 2019 10:20:54 +0000
Message-ID: <CAJSP0QX6ajvKpU6k6i6uBFwc9gFWoYGa6HZn7AfbGr9+975=WQ@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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

On Sat, Nov 9, 2019 at 3:12 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Sat, Nov 9, 2019 at 9:08 PM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> >
> > On Sat, Nov 9, 2019 at 12:17 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > On Sat, Nov 9, 2019 at 7:12 PM Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
> > > > On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@chr=
omium.org> wrote:
> > > > > On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> > > > > > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.com=
> wrote:
> > > > > > > > > Adding a list of common properties to the spec certainly =
makes sense,
> > > > > > > > > so everybody uses the same names.  Adding struct-ed prope=
rties for
> > > > > > > > > common use cases might be useful too.
> > > > > > > >
> > > > > > > > Why not define VIRTIO devices for wayland and friends?
> > > > > > >
> > > > > > > There is an out-of-tree implementation of that, so yes, that =
surely is
> > > > > > > an option.
> > > > > > >
> > > > > > > Wayland needs (a) shared buffers, mostly for gfx data, and (b=
) a stream
> > > > > > > pipe as control channel.  Pretty much the same for X11, excep=
t that
> > > > > > > shared buffers are optional because the X protocol can also s=
queeze all
> > > > > > > display updates through the stream pipe.
> > > > > > >
> > > > > > > So, if you want allow guests talk to the host display server =
you can run
> > > > > > > the stream pipe over vsock.  But there is nothing for the sha=
red
> > > > > > > buffers ...
> > > > > > >
> > > > > > > We could replicate vsock functionality elsewhere.  I think th=
at happened
> > > > > > > in the out-of-tree virtio-wayland implementation.  There also=
 was some
> > > > > > > discussion about adding streams to virtio-gpu, slightly pimpe=
d up so you
> > > > > > > can easily pass around virtio-gpu resource references for buf=
fer
> > > > > > > sharing.  But given that getting vsock right isn't exactly tr=
ivial
> > > > > > > (consider all the fairness issues when multiplexing multiple =
streams
> > > > > > > over a virtqueue for example) I don't think this is a good pl=
an.
> > > > > >
> > > > > > I also think vsock isn't the right fit.
> > > > > >
> > > > >
> > > > > +1 we are using vsock right now and we have a few pains because o=
f it.
> > > > >
> > > > > I think the high-level problem is that because it is a side chann=
el,
> > > > > we don't see everything that happens to the buffer in one place
> > > > > (rendering + display) and we can't do things like reallocate the
> > > > > format accordingly if needed, or we can't do flushing etc. on tha=
t
> > > > > buffer where needed.
> > > >
> > > > Do you think a VIRTIO device designed for your use case is an
> > > > appropriate solution?
> > > >
> > > > I have been arguing that these use cases should be addressed with
> > > > dedicated VIRTIO devices, but I don't understand the use cases of
> > > > everyone on the CC list so maybe I'm missing something :).  If ther=
e
> > > > are reasons why having a VIRTIO device for your use case does not m=
ake
> > > > sense then it would be good to discuss them.  Blockers like "VIRTIO=
 is
> > > > too heavyweight/complex for us because ...", "Our application can't
> > > > make use of VIRTIO devices because ...", etc would be important to
> > > > hear.
> > >
> > > Do you have any idea on how to model Wayland as a VIRTIO device?
> > >
> > > Stephane mentioned that we use vsock, but in fact we have our own
> > > VIRTIO device, except that it's semantically almost the same as vsock=
,
> > > with a difference being the ability to pass buffers and pipes across
> > > the VM boundary.
> >
> > I know neither Wayland nor your use case :).
> >
> > But we can discuss the design of your VIRTIO device.  Please post a
> > link to the code.
>
> The guest-side driver:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeo=
s-4.19/drivers/virtio/virtio_wl.c
>
> Protocol definitions:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeo=
s-4.19/include/uapi/linux/virtio_wl.h
>
> crosvm device implementation:
> https://chromium.googlesource.com/chromiumos/platform/crosvm/+/refs/heads=
/master/devices/src/virtio/wl.rs

Thanks, Tomasz!

Unfortunately I haven't had a chance to look or catch up on this email
thread due to other work that will keep me away for at least another
week :(.

Stefan

