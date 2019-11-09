Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E2C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 14:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E161320869
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YlVtrbhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E161320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTRXv-00067i-4P
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 09:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tfiga@chromium.org>) id 1iTOjw-0005Xo-Qe
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 06:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tfiga@chromium.org>) id 1iTOjv-000898-JA
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 06:17:12 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:39572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tfiga@chromium.org>) id 1iTOjv-00088W-B3
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 06:17:11 -0500
Received: by mail-ed1-x52b.google.com with SMTP id l25so8029076edt.6
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 03:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2KJzeg38k9TKP9n2OHi7V1tXDJtLQP/OdiV4r/c9Qw4=;
 b=YlVtrbheqLjXbAWyZhaPH6O4RntSaSg6mNxZeDNdjviC/mLwwz5yZmdchc9K7fjO5r
 MV8hoOwJpyJkHyRuzgwyIbq1y1zftyhCam1YE8EA/XfOvhopBrdKxxZfHCChKYT8b4pd
 9vOBEHKK8ymvr5y1m0qq80cPB4FeqvV+7V0nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2KJzeg38k9TKP9n2OHi7V1tXDJtLQP/OdiV4r/c9Qw4=;
 b=KXEQ4GilhTSNi3tc3NB6lFozucCJjUdYUx0GG/UlWr2Vnv23/OV325l/TCvr+fsFTV
 6VuwSBDMbgnR1HNHpqYzCLf86oJGTxvGwkNUIiMj+CXA6fJorCDvW+VGBqN2VqQgvMmn
 t9XcjEo9n0dnZ956ri+Q5hR79mry2Tgg53Sa1LrOxwarJ9iCkYC5uaQDP7CnTYGh+wT6
 8TIXsDAKNANYxueZwKzpJGST8+82Dkf0TvGWU21VWAhDoxJQbo7eorZvQ5q/XkyDX5LF
 18WKVkDQJWvSS7C2YYO+CPJDeb6eS6CTnWpACKbBsrj6w2SgTiANB0c2/NBU+hv5LA6j
 IFqg==
X-Gm-Message-State: APjAAAVo5UzFz9A34/cYvmrXpERkQHX/aNU9qz0vb9VOHYzhAM4TsLk5
 hqcCeqIUWAF8GQP6RM0hmKOgfqPXOxXyvA==
X-Google-Smtp-Source: APXvYqxJe2G4k45iOE36CUZcnRC2d6OsmXJeFBTy+akih3+NXLhFV++BShcdFV5/ezwf2+34zHhcAw==
X-Received: by 2002:aa7:c048:: with SMTP id k8mr15546641edo.254.1573298229619; 
 Sat, 09 Nov 2019 03:17:09 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
 [209.85.221.54])
 by smtp.gmail.com with ESMTPSA id q5sm241854edg.66.2019.11.09.03.17.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2019 03:17:07 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id w9so2965205wrr.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 03:17:07 -0800 (PST)
X-Received: by 2002:a5d:4946:: with SMTP id r6mr11729096wrs.155.1573298226861; 
 Sat, 09 Nov 2019 03:17:06 -0800 (PST)
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
In-Reply-To: <CAJSP0QUF1YA0c7b2ENeDLo1T9OsfeTJbonOYug5Fc56--YqZJQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Sat, 9 Nov 2019 20:16:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C6mVEUQUP8-=GevM+rV1ksFg68kyWAjCj+cjB-iQiXaA@mail.gmail.com>
Message-ID: <CAAFQd5C6mVEUQUP8-=GevM+rV1ksFg68kyWAjCj+cjB-iQiXaA@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52b
X-Mailman-Approved-At: Sat, 09 Nov 2019 09:16:11 -0500
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

On Sat, Nov 9, 2019 at 7:12 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@chromium.=
org> wrote:
> >
> > On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> > >
> > > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> > > > > > Adding a list of common properties to the spec certainly makes =
sense,
> > > > > > so everybody uses the same names.  Adding struct-ed properties =
for
> > > > > > common use cases might be useful too.
> > > > >
> > > > > Why not define VIRTIO devices for wayland and friends?
> > > >
> > > > There is an out-of-tree implementation of that, so yes, that surely=
 is
> > > > an option.
> > > >
> > > > Wayland needs (a) shared buffers, mostly for gfx data, and (b) a st=
ream
> > > > pipe as control channel.  Pretty much the same for X11, except that
> > > > shared buffers are optional because the X protocol can also squeeze=
 all
> > > > display updates through the stream pipe.
> > > >
> > > > So, if you want allow guests talk to the host display server you ca=
n run
> > > > the stream pipe over vsock.  But there is nothing for the shared
> > > > buffers ...
> > > >
> > > > We could replicate vsock functionality elsewhere.  I think that hap=
pened
> > > > in the out-of-tree virtio-wayland implementation.  There also was s=
ome
> > > > discussion about adding streams to virtio-gpu, slightly pimped up s=
o you
> > > > can easily pass around virtio-gpu resource references for buffer
> > > > sharing.  But given that getting vsock right isn't exactly trivial
> > > > (consider all the fairness issues when multiplexing multiple stream=
s
> > > > over a virtqueue for example) I don't think this is a good plan.
> > >
> > > I also think vsock isn't the right fit.
> > >
> >
> > +1 we are using vsock right now and we have a few pains because of it.
> >
> > I think the high-level problem is that because it is a side channel,
> > we don't see everything that happens to the buffer in one place
> > (rendering + display) and we can't do things like reallocate the
> > format accordingly if needed, or we can't do flushing etc. on that
> > buffer where needed.
>
> Do you think a VIRTIO device designed for your use case is an
> appropriate solution?
>
> I have been arguing that these use cases should be addressed with
> dedicated VIRTIO devices, but I don't understand the use cases of
> everyone on the CC list so maybe I'm missing something :).  If there
> are reasons why having a VIRTIO device for your use case does not make
> sense then it would be good to discuss them.  Blockers like "VIRTIO is
> too heavyweight/complex for us because ...", "Our application can't
> make use of VIRTIO devices because ...", etc would be important to
> hear.

Do you have any idea on how to model Wayland as a VIRTIO device?

Stephane mentioned that we use vsock, but in fact we have our own
VIRTIO device, except that it's semantically almost the same as vsock,
with a difference being the ability to pass buffers and pipes across
the VM boundary.

Best regards,
Tomasz

