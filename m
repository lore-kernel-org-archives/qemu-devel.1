Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09ADC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 12:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A76821882
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXLDNgur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A76821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTPYU-0003zQ-Gd
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 07:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iTPXo-0003Yn-9X
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 07:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iTPXn-0006YW-36
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 07:08:44 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iTPXm-0006YE-Vf
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 07:08:43 -0500
Received: by mail-qk1-x744.google.com with SMTP id m16so7405391qki.11
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n5Qbym5TxXMyoBu03mDyavFd/uNaJE6OrBVeeYHwKjk=;
 b=AXLDNgurFK0okSdujH8B3g1fODPa3stO+RYC/yAf1jFqZVQ5H9N+96vmO+whEeHW8N
 OEAM0oTbHy9qSjUl9icjVu/HXOz2pOI+p254kjJMtkpwEbb9vEaEktWe31c7jbQ8Far6
 4+a0UEkHsrrhZLQ8E4A9FmQp+69TXUSEuBzl4jufW6W1D/oF3n/yp49D+60oWyoxe9DB
 WgoZ6bvL/oZ9HQQf52972qLpQNYluXAVTvkPJnL7lo9Wj8KpRa4gASq+PNHs2CakniKU
 l00QRa3GyZt3TM5W3gTTFm+pU88+tcmtgYvhFkxQwYCis9EPzPTsF2ZN4VmBoH9MaU5q
 3Zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n5Qbym5TxXMyoBu03mDyavFd/uNaJE6OrBVeeYHwKjk=;
 b=lRSxBQjoFMwvlqH77bhSAWP1amuqUlYgVKl7S0N7lYsyiL44eZ3/i+rMwz7Jv0DHml
 PsOkitM7y/0IZQOxad4s2lhvwIiRBfKO8y58FpMeibORwt33VptgYsdVfu9wpT2MYzGi
 Vn3VKXMEKoq0aLKVPlqNikzA79fVUR0/lGRmv7Uya8Itg/0YKHs+Dd36514obqTJzOd5
 9rF4oYArDM6ZfvTZ69ilpHo8y7WM0lputLvdik/cesahtR6XTnH1RCOeqz9gIMOBuRh3
 Dle7IclM3I0QvziUu5rd4dKztdkOH4OvgPmrnNNI1a+tAP2vhwjaxMIO55vsmWrNXE81
 uHbA==
X-Gm-Message-State: APjAAAWRMevp+rLg9Frk5oqDNVSha31wowSsJdFSfvcLVh/grpevJIvR
 B+F634O9jtXO/IsZBCeWYOFM8oWGjy4o8Yvz45Q=
X-Google-Smtp-Source: APXvYqwQ99oAarsq7llnHHQBZTDtd8YlR9q3KeLkk4fQnWg72eMPEhoKd06XNYPhhYyUpYbCe5igbkj9bKoqwa/pnP8=
X-Received: by 2002:a37:bc3:: with SMTP id 186mr1735320qkl.196.1573301321941; 
 Sat, 09 Nov 2019 04:08:41 -0800 (PST)
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
In-Reply-To: <CAAFQd5C6mVEUQUP8-=GevM+rV1ksFg68kyWAjCj+cjB-iQiXaA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 9 Nov 2019 13:08:30 +0100
Message-ID: <CAJSP0QXk9XkrOeiMZ=yQCbStkXATv+AUwqqGDfcSbqL05j1kbg@mail.gmail.com>
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

On Sat, Nov 9, 2019 at 12:17 PM Tomasz Figa <tfiga@chromium.org> wrote:
> On Sat, Nov 9, 2019 at 7:12 PM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> > On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@chromiu=
m.org> wrote:
> > > On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
> > > > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
> > > > > > > Adding a list of common properties to the spec certainly make=
s sense,
> > > > > > > so everybody uses the same names.  Adding struct-ed propertie=
s for
> > > > > > > common use cases might be useful too.
> > > > > >
> > > > > > Why not define VIRTIO devices for wayland and friends?
> > > > >
> > > > > There is an out-of-tree implementation of that, so yes, that sure=
ly is
> > > > > an option.
> > > > >
> > > > > Wayland needs (a) shared buffers, mostly for gfx data, and (b) a =
stream
> > > > > pipe as control channel.  Pretty much the same for X11, except th=
at
> > > > > shared buffers are optional because the X protocol can also squee=
ze all
> > > > > display updates through the stream pipe.
> > > > >
> > > > > So, if you want allow guests talk to the host display server you =
can run
> > > > > the stream pipe over vsock.  But there is nothing for the shared
> > > > > buffers ...
> > > > >
> > > > > We could replicate vsock functionality elsewhere.  I think that h=
appened
> > > > > in the out-of-tree virtio-wayland implementation.  There also was=
 some
> > > > > discussion about adding streams to virtio-gpu, slightly pimped up=
 so you
> > > > > can easily pass around virtio-gpu resource references for buffer
> > > > > sharing.  But given that getting vsock right isn't exactly trivia=
l
> > > > > (consider all the fairness issues when multiplexing multiple stre=
ams
> > > > > over a virtqueue for example) I don't think this is a good plan.
> > > >
> > > > I also think vsock isn't the right fit.
> > > >
> > >
> > > +1 we are using vsock right now and we have a few pains because of it=
.
> > >
> > > I think the high-level problem is that because it is a side channel,
> > > we don't see everything that happens to the buffer in one place
> > > (rendering + display) and we can't do things like reallocate the
> > > format accordingly if needed, or we can't do flushing etc. on that
> > > buffer where needed.
> >
> > Do you think a VIRTIO device designed for your use case is an
> > appropriate solution?
> >
> > I have been arguing that these use cases should be addressed with
> > dedicated VIRTIO devices, but I don't understand the use cases of
> > everyone on the CC list so maybe I'm missing something :).  If there
> > are reasons why having a VIRTIO device for your use case does not make
> > sense then it would be good to discuss them.  Blockers like "VIRTIO is
> > too heavyweight/complex for us because ...", "Our application can't
> > make use of VIRTIO devices because ...", etc would be important to
> > hear.
>
> Do you have any idea on how to model Wayland as a VIRTIO device?
>
> Stephane mentioned that we use vsock, but in fact we have our own
> VIRTIO device, except that it's semantically almost the same as vsock,
> with a difference being the ability to pass buffers and pipes across
> the VM boundary.

I know neither Wayland nor your use case :).

But we can discuss the design of your VIRTIO device.  Please post a
link to the code.

Stefan

