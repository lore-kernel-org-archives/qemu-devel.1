Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A734C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 10:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B85207FF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg+SrodF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B85207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTNkX-0002JG-Cx
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 05:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iTNjd-0001rt-Go
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 05:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iTNjc-0007ti-E3
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 05:12:49 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:44067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iTNjc-0007tO-AV
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 05:12:48 -0500
Received: by mail-qv1-xf42.google.com with SMTP id d3so1632922qvs.11
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/yDxKfaCobqqzZutamm85Fz/wK48lxRhYxv8Xzm0V+I=;
 b=Kg+SrodFSpfLJeEKDt5D55MCIHsY+reC20V1VQQ5x6/Y47fJoL3K5E+xP4USpG/Aem
 GMg5olXFc7cO+GYg9yhZWzk4coG352ZVxC2NyA4ZSthpCrlyYWy2ts0E+XeavOaQAV93
 vaASKP0CvuArYKkjm4Lllz2Mlg6adb9uHEQIaVMTqcExwIvTaQGnYeNSNi0GPXNbQrMz
 vK+zGCyavvCc3E3spVPe8x+67gvWqXJbP7Blf6TuZzSviGG3r2FXPx5xm6buUoa7xcx4
 XZn6Pt9TXtcpKGTrWwvcqsIfr0N4KBOFcZrXsgpt7hwAQ0TUDMvwJWryAiqlZMYKegC0
 ynDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/yDxKfaCobqqzZutamm85Fz/wK48lxRhYxv8Xzm0V+I=;
 b=VA2ItW04VGln5tc75s9YDGgDQ3UpV6Vg9PKlsDibpSYLaCuhAdIvg9h7bw6kjB/epA
 ojaGbPU6/2TOjnokvWfN525sDWVB/JwhIS6Y6/MccDyQ/7KjrPJLcdvju+FoWj7fPQsF
 ziWu7Gz+QupzlVFHw5H5XdEOx6Tlk1EHKDNuKTk72E9rUOTuI9fF9nI0TfGCzVfnX/9U
 o7E5Ftu7hIRMSQR1IYw9BF9mNZ6KPv73H3wllHrY7A5DhE7pKbad9j9WmcgEdEGaEi6h
 3RjnyogNDbJfz/Y3dltQMRDJmAKePF1KKBu4z/fcAQO8d//WfqSE4uarH/DQ55TR3eSi
 LT1Q==
X-Gm-Message-State: APjAAAVkEVi6/J0tCyasf9fOXvYSxUEofbDDNeGxrSxNDlM9wEtff/+h
 ORipDOlbkhgCmscE+zeIMHzDqj8P9qOVTXdhiQ0=
X-Google-Smtp-Source: APXvYqz2axpTHWnDn7wE0RLT7BKV/b0Ae5JGwDuSD7H3n7uPQfkSRsyKvVHb31AID2mojlrlzoRSHMGD6G6xgrfm840=
X-Received: by 2002:a0c:9637:: with SMTP id 52mr14055274qvx.174.1573294367054; 
 Sat, 09 Nov 2019 02:12:47 -0800 (PST)
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
In-Reply-To: <CADMs+9ZrfEt4QfCM9pC243KTejvbORQ-Nzo0eHjU0FJ8y-2kwQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 9 Nov 2019 11:12:35 +0100
Message-ID: <CAJSP0QUF1YA0c7b2ENeDLo1T9OsfeTJbonOYug5Fc56--YqZJQ@mail.gmail.com>
Subject: Re: guest / host buffer sharing ...
To: =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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

On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@chromium.or=
g> wrote:
>
> On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> >
> > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > > Adding a list of common properties to the spec certainly makes se=
nse,
> > > > > so everybody uses the same names.  Adding struct-ed properties fo=
r
> > > > > common use cases might be useful too.
> > > >
> > > > Why not define VIRTIO devices for wayland and friends?
> > >
> > > There is an out-of-tree implementation of that, so yes, that surely i=
s
> > > an option.
> > >
> > > Wayland needs (a) shared buffers, mostly for gfx data, and (b) a stre=
am
> > > pipe as control channel.  Pretty much the same for X11, except that
> > > shared buffers are optional because the X protocol can also squeeze a=
ll
> > > display updates through the stream pipe.
> > >
> > > So, if you want allow guests talk to the host display server you can =
run
> > > the stream pipe over vsock.  But there is nothing for the shared
> > > buffers ...
> > >
> > > We could replicate vsock functionality elsewhere.  I think that happe=
ned
> > > in the out-of-tree virtio-wayland implementation.  There also was som=
e
> > > discussion about adding streams to virtio-gpu, slightly pimped up so =
you
> > > can easily pass around virtio-gpu resource references for buffer
> > > sharing.  But given that getting vsock right isn't exactly trivial
> > > (consider all the fairness issues when multiplexing multiple streams
> > > over a virtqueue for example) I don't think this is a good plan.
> >
> > I also think vsock isn't the right fit.
> >
>
> +1 we are using vsock right now and we have a few pains because of it.
>
> I think the high-level problem is that because it is a side channel,
> we don't see everything that happens to the buffer in one place
> (rendering + display) and we can't do things like reallocate the
> format accordingly if needed, or we can't do flushing etc. on that
> buffer where needed.

Do you think a VIRTIO device designed for your use case is an
appropriate solution?

I have been arguing that these use cases should be addressed with
dedicated VIRTIO devices, but I don't understand the use cases of
everyone on the CC list so maybe I'm missing something :).  If there
are reasons why having a VIRTIO device for your use case does not make
sense then it would be good to discuss them.  Blockers like "VIRTIO is
too heavyweight/complex for us because ...", "Our application can't
make use of VIRTIO devices because ...", etc would be important to
hear.

Stefan

