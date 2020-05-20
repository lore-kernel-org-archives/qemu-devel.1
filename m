Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C74C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662E0207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Py/oK423"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662E0207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbP00-0001Lw-KR
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <acourbot@chromium.org>)
 id 1jbFGX-0000Xl-5b
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:19:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <acourbot@chromium.org>)
 id 1jbFGV-0004Hf-Px
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:19:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id 69so1379348otv.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6TLItYFdmLhLv8377X8Q79d5QCaK908HiuEnRS/pI7U=;
 b=Py/oK423a9fblk27GVPLDrEfx+5NS+wWBi8gO+k4eeO43RqPU4mD+5T39nTl8pG+Uv
 eYcD9XUasb6xje8IqXyMiU03xLKDcDwcBiULAhVRQmfPIcdiZdDQ/kT6LVzh63KW6RVK
 AEtnVaQ7B4FS3eCsRW9A+Guh9J48MwkU4YuzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6TLItYFdmLhLv8377X8Q79d5QCaK908HiuEnRS/pI7U=;
 b=ug/FRdE/q+v3pmAEsLIJ7tkq+nUEzJ8u7MoFFQOY9vke191XNwjRLUJ+LWtije1MGD
 RGMuBUdrFTQXh+C3NhAdKwXK7qsxzfG5px0cmz7Cu851FIrlR3IAL7vOxpHYxKD6bjQt
 mx9MmFeuYxsgHPDXX3BFRb2wgcsbbjNanozoEmRXDysUD+rQbLxPRVjO6AVSmiNWgpeI
 0ZsSCuKEoBRLEy9ebcGBWNERjakvk0SGTPFNBMVfNmGdgZGDSqj0mgRtwP3giyTvdzhU
 BwUVxIAdm91r0PrNA+Vh/p0RSFtHHoihuSHK2751EuMySB9bVNK2N/h21yPrBk2Ycyre
 7EIA==
X-Gm-Message-State: AOAM530NpdG5TdVjt/NqvvRqsIfXozSv87hUrcdFWR137RX7/tuyoirf
 JPXD7lckK2DiFMStnKNnx+dPzOoidXc=
X-Google-Smtp-Source: ABdhPJyHCuhT6qHB9AhxbDjRbou+zfuZF/wlMU9CbswUrZJF3RqwhN3oh23cAakMxctm/EmXbnQiUQ==
X-Received: by 2002:a9d:2603:: with SMTP id a3mr1739674otb.340.1589944768513; 
 Tue, 19 May 2020 20:19:28 -0700 (PDT)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com.
 [209.85.167.170])
 by smtp.gmail.com with ESMTPSA id d64sm471541oig.53.2020.05.19.20.19.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 20:19:26 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id b3so1676460oib.13
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 20:19:26 -0700 (PDT)
X-Received: by 2002:aca:3a55:: with SMTP id h82mr1790729oia.71.1589944765505; 
 Tue, 19 May 2020 20:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
 <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
 <92ac2db087ccf8fae853284ecc8bdf187e292097.camel@ndufresne.ca>
In-Reply-To: <92ac2db087ccf8fae853284ecc8bdf187e292097.camel@ndufresne.ca>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Wed, 20 May 2020 12:19:14 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXUsMtNhxEPAdn4aTN8kNgt1eL8oLDDyNtXrD9bew_kMA@mail.gmail.com>
Message-ID: <CAPBb6MXUsMtNhxEPAdn4aTN8kNgt1eL8oLDDyNtXrD9bew_kMA@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 20 May 2020 09:42:13 -0400
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

On Wed, May 20, 2020 at 2:29 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mardi 19 mai 2020 =C3=A0 17:37 +0900, Keiichi Watanabe a =C3=A9crit :
> > Hi Nicolas,
> >
> > On Fri, May 15, 2020 at 8:38 AM Nicolas Dufresne <
> > nicolas@ndufresne.ca
> > > wrote:
> > > Le lundi 11 mai 2020 =C3=A0 20:49 +0900, Keiichi Watanabe a =C3=A9cri=
t :
> > > > Hi,
> > > >
> > > > Thanks Saket for your feedback. As Dmitry mentioned, we're focusing=
 on
> > > > video encoding and decoding, not camera. So, my reply was about how=
 to
> > > > implement paravirtualized video codec devices.
> > > >
> > > > On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <
> > > > dmitry.sepp@opensynergy.com
> > > > >
> > > > wrote:
> > > > > Hi Saket,
> > > > >
> > > > > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > > > > Hi Keiichi,
> > > > > >
> > > > > > I do not support the approach of  QEMU implementation forwardin=
g
> > > > > > requests to the host's vicodec module since  this can limit the=
 scope
> > > > > > of the virtio-video device only for testing,
> > > > >
> > > > > That was my understanding as well.
> > > >
> > > > Not really because the API which the vicodec provides is V4L2 state=
ful
> > > > decoder interface [1], which are also used by other video drivers o=
n
> > > > Linux.
> > > > The difference between vicodec and actual device drivers is that
> > > > vicodec performs decoding in the kernel space without using special
> > > > video devices. In other words, vicodec is a software decoder in ker=
nel
> > > > space which provides the same interface with actual video drivers.
> > > > Thus, if the QEMU implementation can forward virtio-video requests =
to
> > > > vicodec, it can forward them to the actual V4L2 video decoder devic=
es
> > > > as well and VM gets access to a paravirtualized video device.
> > > >
> > > > The reason why we discussed vicodec in the previous thread was it'l=
l
> > > > allow us to test the virtio-video driver without hardware requireme=
nt.
> > > >
> > > > [1]
> > > > https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.h=
tml
> > > >
> > > >
> > > > > > which instead can be used with multiple use cases such as -
> > > > > >
> > > > > > 1. VM gets access to paravirtualized  camera devices which shar=
es the
> > > > > > video frames input through actual HW camera attached to Host.
> > > > >
> > > > > This use-case is out of the scope of virtio-video. Initially I ha=
d a plan to
> > > > > support capture-only streams like camera as well, but later the d=
ecision was
> > > > > made upstream that camera should be implemented as separate devic=
e type. We
> > > > > still plan to implement a simple frame capture capability as a do=
wnstream
> > > > > patch though.
> > > > >
> > > > > > 2. If Host has multiple video devices (especially in ARM SOCs o=
ver
> > > > > > MIPI interfaces or USB), different VM can be started or hotplug=
ged
> > > > > > with selective video streams from actual HW video devices.
> > > > >
> > > > > We do support this in our device implementation. But spec in gene=
ral has no
> > > > > requirements or instructions regarding this. And it is in fact fl=
exible
> > > > > enough
> > > > > to provide abstraction on top of several HW devices.
> > > > >
> > > > > > Also instead of using libraries like Gstreamer in Host userspac=
e, they
> > > > > > can also be used inside the VM userspace after getting access t=
o
> > > > > > paravirtualized HW camera devices .
> > > >
> > > > Regarding Gstreamer, I intended this video decoding API [2]. If QEM=
U
> > > > can translate virtio-video requests to this API, we can easily supp=
ort
> > > > multiple platforms.
> > > > I'm not sure how feasible it is though, as I have no experience of
> > > > using this API by myself...
> > >
> > > Not sure which API you aim exactly, but what one need to remember is =
that
> > > mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC or =
other type
> > > of "stateless" CODEC is not trivial and can't be done without userspa=
ce. Notably
> > > because we don't want to do bitstream parsing in the kernel on the ma=
in CPU as
> > > security would otherwise be very hard to guaranty. The other driver u=
sing same
> > > API as virtio-video do bitstream parsing on a dedicated co-processor =
(through
> > > firmware blobs though).
> > >
> > > Having bridges between virtio-video, qemu and some abstraction librar=
y like
> > > FFMPEG or GStreamer is certainly the best solution if you want to vir=
tualize any
> > > type of HW accelerated decoder or if you need to virtualized somethin=
g
> > > proprietary (like NVDEC). Please shout if you need help.
> > >
> >
> > Yeah, I meant we should map virtio-video commands to a set of
> > abstracted userspace APIs to avoid having many platform-dependent code
> > in QEMU.
> > This is the same with what we implemented in crosvm, a VMM on
> > ChromiumOS. Crosvm's video device translates virtio-video commands
> > into our own video decoding APIs [1, 2] which supports VAAPI, V4L2
> > stateful and V4L2 stateless. Unfortunately, since our library is
> > highly depending on Chrome, we cannot reuse this for QEMU.
> >
> > So, I agree that using FFMPEG or GStreamer is a good idea. Probably,
> > APIs in my previous link weren't for this purpose.
> > Nicolas, do you know any good references for FFMPEG or GStreamer's
> > abstracted video decoding APIs? Then, I may be able to think about how
> > virtio-video protocols can be mapped to them.
>
> The FFMpeg API for libavcodec can be found here:
>
>   http://git.videolan.org/?p=3Dffmpeg.git;a=3Dblob;f=3Dlibavcodec/avcodec=
.h
>
> GStreamer does not really have such a low level CODEC API. So while
> it's possible to use it (Wine project uses it for it's parsers as an
> example, and Firefox use to have CODEC support wrapping GStreamer
> CODEC), there will not be any one-to-one mapping. GStreamer is often
> chosen as it's LGPL code does not carry directly any patented
> implementation. It instead rely on plugins, which maybe provided as
> third party, allowing to distribute your project while giving uses the
> option to install potentially non-free technologies.
>
> But overall, I can describe GStreamer API for CODEC wrapping (pipeline
> less) as:
>
>   - Push GstCaps describing the stream format
>   - Push bitstream buffer on sink pad
>   - When ready, buffers will be pushed through the push function
>     callback on src pad
>
> Of course nothing prevent adding something like the vda abstraction in
> qemu and make this multi-backend capable.

My understanding is that we don't need a particularly low-level API to
interact with. The host virtual device is receiving the whole encoded
data, and can thus easily reconstruct the original stream (minus the
container) and pass it to ffmpeg/gstreamer. So we can be pretty
high-level here.

Now the choice of API will also determine whether we want to allow
emulation of codec devices, or whether we stay on a purely
para-virtual track. If we use e.g. gstreamer, then the host can
provide a virtual device that is backed by a purely software
implementation. This can be useful for testing purposes, but for
real-life usage the guest would be just as well using gstreamer
itself.

If we want to make sure that there is hardware on the host side, then
an API like libva might make more sense, but it would be more
complicated and may not support all hardware (I don't know if the V4L2
backends are usable for instance).

