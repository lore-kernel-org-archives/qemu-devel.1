Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 07:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B9420748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 07:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMjUyllP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B9420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbfKL-0001t4-TO
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 03:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <acourbot@chromium.org>)
 id 1jbfJo-0001DA-W1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:08:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <acourbot@chromium.org>)
 id 1jbfJk-0007v6-Ti
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:08:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id a68so4732789otb.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bmNcskkSnDNhXH+hbyhfCxoDQlszd78evwzTnTScQec=;
 b=jMjUyllPK/nbstlNSgLLO1uUHErio9nXmTdFsRxQ1a6WSCY+yIqeidN1vccPU9SXcv
 khsaRTd9+RDjBxecJmf733VQ8zxlw2NU5PR+Og/I+t7jrYtJNI1kZHrxVxeahFBSZkfM
 sO801Gps9eZyMbeoOAt5Z6sxQLZhGm5sp40ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bmNcskkSnDNhXH+hbyhfCxoDQlszd78evwzTnTScQec=;
 b=nxhE5GoyQgVr648jq/YXr92aLOK63ttfv9/MILRc25HZV4yGWyw1aZGZ+ZPD6HYq48
 2E4qUX5bNoDa9p0bu2gnm7Ba+vSqQUj3r1AW5QZFTtGuwPbK6x01O3fKgb2JN59BjoYj
 zbcrcvW/qwOA0XKv2yFopRA0wn0DSQo8hytNhN+5mWUqazyoTdfOaCOf0Su0QgfEQ5Lf
 b/Ff4SvO2vCdSEqQ72MpaqQJrAmAztsm6Sk1+pDJpsBXrP0oN/XGp4bFtNZeP593/3pH
 xKHIMqgLwQY44b1DV7tfv1zTtdcTo+XRLII/GZSSloYaE6V1J7j9mA0wSMEJLhQJEh/6
 p31Q==
X-Gm-Message-State: AOAM533nw4c9/JegzR3SqMwcoU7TgfcMG8EI6Zv2AY7SAtaPMlWcgOXT
 q5z8JeFX/B2KpnbLp9YvJ6Yia/aPmvRSUg==
X-Google-Smtp-Source: ABdhPJxAc2lcYUw6r9HeEYYdH4+lB0/5rmMcwsOmLhzgU7xJDykk+8b1GxoIOmiRkQuXajU/sEZOvw==
X-Received: by 2002:a9d:4a89:: with SMTP id i9mr6057822otf.277.1590044913452; 
 Thu, 21 May 2020 00:08:33 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com.
 [209.85.167.170])
 by smtp.gmail.com with ESMTPSA id h1sm1393251otg.57.2020.05.21.00.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 00:08:27 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id j145so5433879oib.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 00:08:25 -0700 (PDT)
X-Received: by 2002:aca:bf09:: with SMTP id p9mr5352255oif.55.1590044905168;
 Thu, 21 May 2020 00:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
 <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
 <92ac2db087ccf8fae853284ecc8bdf187e292097.camel@ndufresne.ca>
 <CAPBb6MXUsMtNhxEPAdn4aTN8kNgt1eL8oLDDyNtXrD9bew_kMA@mail.gmail.com>
 <17ef7d07c50d419324a9191b216c8cc9ee95b1ae.camel@ndufresne.ca>
In-Reply-To: <17ef7d07c50d419324a9191b216c8cc9ee95b1ae.camel@ndufresne.ca>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Thu, 21 May 2020 16:08:13 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWi1zFQ6Oc8UOP48L7HbCRs4VDpvi2LO5NuVz1a8TC9cA@mail.gmail.com>
Message-ID: <CAPBb6MWi1zFQ6Oc8UOP48L7HbCRs4VDpvi2LO5NuVz1a8TC9cA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=acourbot@chromium.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Samiullah Khawaja <samiullah.khawaja@opensynergy.com>,
 Saket Sinha <saket.sinha89@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Kiran Pawar <Kiran.Pawar@opensynergy.com>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Sepp <dmitry.sepp@opensynergy.com>,
 Emil Velikov <emil.velikov@collabora.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 1:21 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 20 mai 2020 =C3=A0 12:19 +0900, Alexandre Courbot a =C3=A9cri=
t :
> > On Wed, May 20, 2020 at 2:29 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > > Le mardi 19 mai 2020 =C3=A0 17:37 +0900, Keiichi Watanabe a =C3=A9cri=
t :
> > > > Hi Nicolas,
> > > >
> > > > On Fri, May 15, 2020 at 8:38 AM Nicolas Dufresne <
> > > > nicolas@ndufresne.ca
> > > > > wrote:
> > > > > Le lundi 11 mai 2020 =C3=A0 20:49 +0900, Keiichi Watanabe a =C3=
=A9crit :
> > > > > > Hi,
> > > > > >
> > > > > > Thanks Saket for your feedback. As Dmitry mentioned, we're focu=
sing on
> > > > > > video encoding and decoding, not camera. So, my reply was about=
 how to
> > > > > > implement paravirtualized video codec devices.
> > > > > >
> > > > > > On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <
> > > > > > dmitry.sepp@opensynergy.com
> > > > > > wrote:
> > > > > > > Hi Saket,
> > > > > > >
> > > > > > > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > > > > > > Hi Keiichi,
> > > > > > > >
> > > > > > > > I do not support the approach of  QEMU implementation forwa=
rding
> > > > > > > > requests to the host's vicodec module since  this can limit=
 the scope
> > > > > > > > of the virtio-video device only for testing,
> > > > > > >
> > > > > > > That was my understanding as well.
> > > > > >
> > > > > > Not really because the API which the vicodec provides is V4L2 s=
tateful
> > > > > > decoder interface [1], which are also used by other video drive=
rs on
> > > > > > Linux.
> > > > > > The difference between vicodec and actual device drivers is tha=
t
> > > > > > vicodec performs decoding in the kernel space without using spe=
cial
> > > > > > video devices. In other words, vicodec is a software decoder in=
 kernel
> > > > > > space which provides the same interface with actual video drive=
rs.
> > > > > > Thus, if the QEMU implementation can forward virtio-video reque=
sts to
> > > > > > vicodec, it can forward them to the actual V4L2 video decoder d=
evices
> > > > > > as well and VM gets access to a paravirtualized video device.
> > > > > >
> > > > > > The reason why we discussed vicodec in the previous thread was =
it'll
> > > > > > allow us to test the virtio-video driver without hardware requi=
rement.
> > > > > >
> > > > > > [1]
> > > > > > https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decod=
er.html
> > > > > >
> > > > > >
> > > > > > > > which instead can be used with multiple use cases such as -
> > > > > > > >
> > > > > > > > 1. VM gets access to paravirtualized  camera devices which =
shares the
> > > > > > > > video frames input through actual HW camera attached to Hos=
t.
> > > > > > >
> > > > > > > This use-case is out of the scope of virtio-video. Initially =
I had a plan to
> > > > > > > support capture-only streams like camera as well, but later t=
he decision was
> > > > > > > made upstream that camera should be implemented as separate d=
evice type. We
> > > > > > > still plan to implement a simple frame capture capability as =
a downstream
> > > > > > > patch though.
> > > > > > >
> > > > > > > > 2. If Host has multiple video devices (especially in ARM SO=
Cs over
> > > > > > > > MIPI interfaces or USB), different VM can be started or hot=
plugged
> > > > > > > > with selective video streams from actual HW video devices.
> > > > > > >
> > > > > > > We do support this in our device implementation. But spec in =
general has no
> > > > > > > requirements or instructions regarding this. And it is in fac=
t flexible
> > > > > > > enough
> > > > > > > to provide abstraction on top of several HW devices.
> > > > > > >
> > > > > > > > Also instead of using libraries like Gstreamer in Host user=
space, they
> > > > > > > > can also be used inside the VM userspace after getting acce=
ss to
> > > > > > > > paravirtualized HW camera devices .
> > > > > >
> > > > > > Regarding Gstreamer, I intended this video decoding API [2]. If=
 QEMU
> > > > > > can translate virtio-video requests to this API, we can easily =
support
> > > > > > multiple platforms.
> > > > > > I'm not sure how feasible it is though, as I have no experience=
 of
> > > > > > using this API by myself...
> > > > >
> > > > > Not sure which API you aim exactly, but what one need to remember=
 is that
> > > > > mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC=
 or other type
> > > > > of "stateless" CODEC is not trivial and can't be done without use=
rspace. Notably
> > > > > because we don't want to do bitstream parsing in the kernel on th=
e main CPU as
> > > > > security would otherwise be very hard to guaranty. The other driv=
er using same
> > > > > API as virtio-video do bitstream parsing on a dedicated co-proces=
sor (through
> > > > > firmware blobs though).
> > > > >
> > > > > Having bridges between virtio-video, qemu and some abstraction li=
brary like
> > > > > FFMPEG or GStreamer is certainly the best solution if you want to=
 virtualize any
> > > > > type of HW accelerated decoder or if you need to virtualized some=
thing
> > > > > proprietary (like NVDEC). Please shout if you need help.
> > > > >
> > > >
> > > > Yeah, I meant we should map virtio-video commands to a set of
> > > > abstracted userspace APIs to avoid having many platform-dependent c=
ode
> > > > in QEMU.
> > > > This is the same with what we implemented in crosvm, a VMM on
> > > > ChromiumOS. Crosvm's video device translates virtio-video commands
> > > > into our own video decoding APIs [1, 2] which supports VAAPI, V4L2
> > > > stateful and V4L2 stateless. Unfortunately, since our library is
> > > > highly depending on Chrome, we cannot reuse this for QEMU.
> > > >
> > > > So, I agree that using FFMPEG or GStreamer is a good idea. Probably=
,
> > > > APIs in my previous link weren't for this purpose.
> > > > Nicolas, do you know any good references for FFMPEG or GStreamer's
> > > > abstracted video decoding APIs? Then, I may be able to think about =
how
> > > > virtio-video protocols can be mapped to them.
> > >
> > > The FFMpeg API for libavcodec can be found here:
> > >
> > >   http://git.videolan.org/?p=3Dffmpeg.git;a=3Dblob;f=3Dlibavcodec/avc=
odec.h
> > >
> > > GStreamer does not really have such a low level CODEC API. So while
> > > it's possible to use it (Wine project uses it for it's parsers as an
> > > example, and Firefox use to have CODEC support wrapping GStreamer
> > > CODEC), there will not be any one-to-one mapping. GStreamer is often
> > > chosen as it's LGPL code does not carry directly any patented
> > > implementation. It instead rely on plugins, which maybe provided as
> > > third party, allowing to distribute your project while giving uses th=
e
> > > option to install potentially non-free technologies.
> > >
> > > But overall, I can describe GStreamer API for CODEC wrapping (pipelin=
e
> > > less) as:
> > >
> > >   - Push GstCaps describing the stream format
> > >   - Push bitstream buffer on sink pad
> > >   - When ready, buffers will be pushed through the push function
> > >     callback on src pad
> > >
> > > Of course nothing prevent adding something like the vda abstraction i=
n
> > > qemu and make this multi-backend capable.
> >
> > My understanding is that we don't need a particularly low-level API to
> > interact with. The host virtual device is receiving the whole encoded
> > data, and can thus easily reconstruct the original stream (minus the
> > container) and pass it to ffmpeg/gstreamer. So we can be pretty
> > high-level here.
> >
> > Now the choice of API will also determine whether we want to allow
> > emulation of codec devices, or whether we stay on a purely
> > para-virtual track. If we use e.g. gstreamer, then the host can
> > provide a virtual device that is backed by a purely software
> > implementation. This can be useful for testing purposes, but for
> > real-life usage the guest would be just as well using gstreamer
> > itself.
>
> Agreed.
>
> >
> > If we want to make sure that there is hardware on the host side, then
> > an API like libva might make more sense, but it would be more
> > complicated and may not support all hardware (I don't know if the V4L2
> > backends are usable for instance).
>
> To bring VAAPI into Qemu directly you'd have to introduce bitstream
> parser, DPB management and other CODEC specific bits. I cannot speak
> for the project, but that's re-inventing the wheel again with very
> little gain. Best is to open the discussion with them early.
>
> Note that it's relatively simple in both framework to only choose HW
> accelerated CODECs. In ffmpeg, HW accelerator codecs can only be used
> with HWContext, so your wrapper need to know specific HWContext for the
> specific accelerator. In GStreamer, since 1.16, we add a metadata that
> let the user know which decoder is hardware accelerated. (This is
> usually used to disable HW acceleration at the moment).

Good point, and that would also not close the door to exposing a
software-backed device for testing purposes.

