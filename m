Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E2AC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 15:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8188221848
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TymgvK/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8188221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTSQd-0008D9-Fs
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 10:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tfiga@chromium.org>) id 1iTSPd-0007lw-MW
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tfiga@chromium.org>) id 1iTSPc-0004fo-6M
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:12:29 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:43611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tfiga@chromium.org>) id 1iTSPb-0004dO-UR
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:12:28 -0500
Received: by mail-ed1-x533.google.com with SMTP id w6so8412089edx.10
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I5aoCc9fhlcAHUeVvXS2BisbghVNdu1/cPTG1nycIkY=;
 b=TymgvK/SkkrRHBlsMJdJ/6A0ZUrDfbPwbVMZg6TykgCLfkU3EWh8IKsDo5HH7+SdLm
 JQJjHqtsuxI8PQM3KJHya4lFNrgtDg8EtYjBXrRdHZ9vYtoBefDwkIbgy7NQck+sae4D
 f0NYwK/iYefWKNpz04s7HSMkVwPbXCbjuvp68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I5aoCc9fhlcAHUeVvXS2BisbghVNdu1/cPTG1nycIkY=;
 b=CRtX9U0iTmRaU9I/ufhA8RSMHZ4zpyIZq9dLlkbIs/9tJ5RcjiATwPMlp/r9KBWncT
 R6m9Qyfs/W4q75CaLvL3NTkc6hORiG6GDNfm2C0NIhS12RS/4TFGf9N5oUIUvx62Fi8D
 ZYdyYDc5sr/8xMV6mluGOJXl7UabW1S6EEORovNkAQr4X23EV8BBHw0HrY5fQKssyqQN
 NnMxMBBJodtW2M+8jcXvvzRmd5On8IngQwWwePg1CBubp8EXcpr3t8vCoC+m6aYkavJT
 szALb3PCQ0CeoLKGJnBJ/T/2vuKA6tYLGDO/oByr9bSMRbmSkddz5u4+2/ez9+DIFBdC
 KrLA==
X-Gm-Message-State: APjAAAXYGZ7qRTnmWjFataKQl/fcvcUDhm3N3N590Xnomjci9vtN+tzW
 tfHMHACSnDqsDQr3EurYYvVQM9FqI2fX7A==
X-Google-Smtp-Source: APXvYqzPAIVpq6CQ/huifzOT1erZdKhGr0r78LrKncSZQGV8+ggvG/dMLGD8LZFdHI6CEsiGi8EoLQ==
X-Received: by 2002:a17:906:1c4d:: with SMTP id
 l13mr14073577ejg.308.1573312346398; 
 Sat, 09 Nov 2019 07:12:26 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47])
 by smtp.gmail.com with ESMTPSA id s8sm303679edj.6.2019.11.09.07.12.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2019 07:12:24 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id t26so9077319wmi.4
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 07:12:23 -0800 (PST)
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr14165628wma.90.1573312343284; 
 Sat, 09 Nov 2019 07:12:23 -0800 (PST)
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
In-Reply-To: <CAJSP0QXk9XkrOeiMZ=yQCbStkXATv+AUwqqGDfcSbqL05j1kbg@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Sun, 10 Nov 2019 00:12:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DBiUta9HWYZX3N06J8bSqa=zBQvL5kdCLfWUfsf9s9Vw@mail.gmail.com>
Message-ID: <CAAFQd5DBiUta9HWYZX3N06J8bSqa=zBQvL5kdCLfWUfsf9s9Vw@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::533
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

On Sat, Nov 9, 2019 at 9:08 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sat, Nov 9, 2019 at 12:17 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > On Sat, Nov 9, 2019 at 7:12 PM Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > > On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@chrom=
ium.org> wrote:
> > > > On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
> > > > > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
> > > > > > > > Adding a list of common properties to the spec certainly ma=
kes sense,
> > > > > > > > so everybody uses the same names.  Adding struct-ed propert=
ies for
> > > > > > > > common use cases might be useful too.
> > > > > > >
> > > > > > > Why not define VIRTIO devices for wayland and friends?
> > > > > >
> > > > > > There is an out-of-tree implementation of that, so yes, that su=
rely is
> > > > > > an option.
> > > > > >
> > > > > > Wayland needs (a) shared buffers, mostly for gfx data, and (b) =
a stream
> > > > > > pipe as control channel.  Pretty much the same for X11, except =
that
> > > > > > shared buffers are optional because the X protocol can also squ=
eeze all
> > > > > > display updates through the stream pipe.
> > > > > >
> > > > > > So, if you want allow guests talk to the host display server yo=
u can run
> > > > > > the stream pipe over vsock.  But there is nothing for the share=
d
> > > > > > buffers ...
> > > > > >
> > > > > > We could replicate vsock functionality elsewhere.  I think that=
 happened
> > > > > > in the out-of-tree virtio-wayland implementation.  There also w=
as some
> > > > > > discussion about adding streams to virtio-gpu, slightly pimped =
up so you
> > > > > > can easily pass around virtio-gpu resource references for buffe=
r
> > > > > > sharing.  But given that getting vsock right isn't exactly triv=
ial
> > > > > > (consider all the fairness issues when multiplexing multiple st=
reams
> > > > > > over a virtqueue for example) I don't think this is a good plan=
.
> > > > >
> > > > > I also think vsock isn't the right fit.
> > > > >
> > > >
> > > > +1 we are using vsock right now and we have a few pains because of =
it.
> > > >
> > > > I think the high-level problem is that because it is a side channel=
,
> > > > we don't see everything that happens to the buffer in one place
> > > > (rendering + display) and we can't do things like reallocate the
> > > > format accordingly if needed, or we can't do flushing etc. on that
> > > > buffer where needed.
> > >
> > > Do you think a VIRTIO device designed for your use case is an
> > > appropriate solution?
> > >
> > > I have been arguing that these use cases should be addressed with
> > > dedicated VIRTIO devices, but I don't understand the use cases of
> > > everyone on the CC list so maybe I'm missing something :).  If there
> > > are reasons why having a VIRTIO device for your use case does not mak=
e
> > > sense then it would be good to discuss them.  Blockers like "VIRTIO i=
s
> > > too heavyweight/complex for us because ...", "Our application can't
> > > make use of VIRTIO devices because ...", etc would be important to
> > > hear.
> >
> > Do you have any idea on how to model Wayland as a VIRTIO device?
> >
> > Stephane mentioned that we use vsock, but in fact we have our own
> > VIRTIO device, except that it's semantically almost the same as vsock,
> > with a difference being the ability to pass buffers and pipes across
> > the VM boundary.
>
> I know neither Wayland nor your use case :).
>
> But we can discuss the design of your VIRTIO device.  Please post a
> link to the code.

The guest-side driver:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-=
4.19/drivers/virtio/virtio_wl.c

Protocol definitions:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-=
4.19/include/uapi/linux/virtio_wl.h

crosvm device implementation:
https://chromium.googlesource.com/chromiumos/platform/crosvm/+/refs/heads/m=
aster/devices/src/virtio/wl.rs

Best regards,
Tomasz

