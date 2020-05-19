Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428D2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED96204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aeH8mDOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED96204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxlv-0005f1-1a
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jaxl9-0004uK-53
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:37:59 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:43830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jaxl7-0001Ms-FD
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:37:58 -0400
Received: by mail-lf1-x144.google.com with SMTP id c12so7038101lfc.10
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3meCrqUzQ4qWfUeiNRFLORv6n/bO5GiRYPVRfRv/yRs=;
 b=aeH8mDOQWQOPeDS6LICxagP8stCxb6difr5TnTjbrLv81QkYx5GG+EdzufKq2KfzCe
 zBSurAGaM6Oaf3lVih5RpNnnVlgLMzMp+0HGS922vmn5GiAzuTpYTxtxEqjYm1c5qdzl
 SeOPO6JqYaA+xc/uqxl5aWr/ZKG+AAb7i0Ec0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3meCrqUzQ4qWfUeiNRFLORv6n/bO5GiRYPVRfRv/yRs=;
 b=UiKA9pfe+By1ZcDdXMOx0E1YHEG9ld30E/b4pVWypH1BKD/hXC3wbDDMIzpwnDExNi
 +aIaVyZAVyvBzo+BMOSQpetlX0wztAobkY70ttePxpgwosKGglZNdlU/0o10GwKX58KU
 46BXe0w6Yueg3ppMLf9oFOjXu7KtKYiObCFTC6e3zGk8FKTJgctJoxUe8OVHT1a8M/s+
 btyCQaLcheinUdVu5/U0SaH+zYScW55kMmaPstKjVm/X5hxNwPWZnsPSU+2wm2j5SwE6
 L85LffxRk/ipwEwAM3WlYUuT4Co6mQGCEU9v4h7yFMgBFyQcdgOaHDmtWGxHY/EedMKl
 +nYQ==
X-Gm-Message-State: AOAM532CmW2nSaV3q/7e0zgg9ogE1TAhMLY0ypNeJG/xCamRMb4HUQTO
 nh2Xey5uCbeVLzS0uHA5J2FrXLOoTi8/T1h/rUnGlA==
X-Google-Smtp-Source: ABdhPJyrzHve/jhiPASrKZ8qdktEzM2yhyRztFth2jqdg5jGYYMo7caL+l/CdYJt6vJmmqVzDCr1Itl01cTXwBLXI4Y=
X-Received: by 2002:ac2:596e:: with SMTP id h14mr14288227lfp.215.1589877474998; 
 Tue, 19 May 2020 01:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
In-Reply-To: <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 19 May 2020 17:37:43 +0900
Message-ID: <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=keiichiw@chromium.org; helo=mail-lf1-x144.google.com
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
 virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>,
 Kiran Pawar <Kiran.Pawar@opensynergy.com>,
 Alexandre Courbot <acourbot@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Saket Sinha <saket.sinha89@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Sepp <dmitry.sepp@opensynergy.com>,
 Emil Velikov <emil.velikov@collabora.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Nicolas,

On Fri, May 15, 2020 at 8:38 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le lundi 11 mai 2020 =C3=A0 20:49 +0900, Keiichi Watanabe a =C3=A9crit :
> > Hi,
> >
> > Thanks Saket for your feedback. As Dmitry mentioned, we're focusing on
> > video encoding and decoding, not camera. So, my reply was about how to
> > implement paravirtualized video codec devices.
> >
> > On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <dmitry.sepp@opensynergy.co=
m>
> > wrote:
> > > Hi Saket,
> > >
> > > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > > Hi Keiichi,
> > > >
> > > > I do not support the approach of  QEMU implementation forwarding
> > > > requests to the host's vicodec module since  this can limit the sco=
pe
> > > > of the virtio-video device only for testing,
> > >
> > > That was my understanding as well.
> >
> > Not really because the API which the vicodec provides is V4L2 stateful
> > decoder interface [1], which are also used by other video drivers on
> > Linux.
> > The difference between vicodec and actual device drivers is that
> > vicodec performs decoding in the kernel space without using special
> > video devices. In other words, vicodec is a software decoder in kernel
> > space which provides the same interface with actual video drivers.
> > Thus, if the QEMU implementation can forward virtio-video requests to
> > vicodec, it can forward them to the actual V4L2 video decoder devices
> > as well and VM gets access to a paravirtualized video device.
> >
> > The reason why we discussed vicodec in the previous thread was it'll
> > allow us to test the virtio-video driver without hardware requirement.
> >
> > [1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.h=
tml
> >
> > > > which instead can be used with multiple use cases such as -
> > > >
> > > > 1. VM gets access to paravirtualized  camera devices which shares t=
he
> > > > video frames input through actual HW camera attached to Host.
> > >
> > > This use-case is out of the scope of virtio-video. Initially I had a =
plan to
> > > support capture-only streams like camera as well, but later the decis=
ion was
> > > made upstream that camera should be implemented as separate device ty=
pe. We
> > > still plan to implement a simple frame capture capability as a downst=
ream
> > > patch though.
> > >
> > > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > > with selective video streams from actual HW video devices.
> > >
> > > We do support this in our device implementation. But spec in general =
has no
> > > requirements or instructions regarding this. And it is in fact flexib=
le
> > > enough
> > > to provide abstraction on top of several HW devices.
> > >
> > > > Also instead of using libraries like Gstreamer in Host userspace, t=
hey
> > > > can also be used inside the VM userspace after getting access to
> > > > paravirtualized HW camera devices .
> >
> > Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> > can translate virtio-video requests to this API, we can easily support
> > multiple platforms.
> > I'm not sure how feasible it is though, as I have no experience of
> > using this API by myself...
>
> Not sure which API you aim exactly, but what one need to remember is that
> mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC or othe=
r type
> of "stateless" CODEC is not trivial and can't be done without userspace. =
Notably
> because we don't want to do bitstream parsing in the kernel on the main C=
PU as
> security would otherwise be very hard to guaranty. The other driver using=
 same
> API as virtio-video do bitstream parsing on a dedicated co-processor (thr=
ough
> firmware blobs though).
>
> Having bridges between virtio-video, qemu and some abstraction library li=
ke
> FFMPEG or GStreamer is certainly the best solution if you want to virtual=
ize any
> type of HW accelerated decoder or if you need to virtualized something
> proprietary (like NVDEC). Please shout if you need help.
>

Yeah, I meant we should map virtio-video commands to a set of
abstracted userspace APIs to avoid having many platform-dependent code
in QEMU.
This is the same with what we implemented in crosvm, a VMM on
ChromiumOS. Crosvm's video device translates virtio-video commands
into our own video decoding APIs [1, 2] which supports VAAPI, V4L2
stateful and V4L2 stateless. Unfortunately, since our library is
highly depending on Chrome, we cannot reuse this for QEMU.

So, I agree that using FFMPEG or GStreamer is a good idea. Probably,
APIs in my previous link weren't for this purpose.
Nicolas, do you know any good references for FFMPEG or GStreamer's
abstracted video decoding APIs? Then, I may be able to think about how
virtio-video protocols can be mapped to them.

[1] libvda's C interface:
https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/=
arc/vm/libvda/libvda_decode.h
[2] libvda's Rust interface:
https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/=
arc/vm/libvda/rust/

Best regards,
Keiichi

> >
> > [2]
> > https://gstreamer.freedesktop.org/documentation/tutorials/playback/hard=
ware-accelerated-video-decoding.html
> >
> > Best regards,
> > Keiichi
> >
> > >
> > > Regarding the cameras, unfortunately same as above.
> > >
> > > Best regards,
> > > Dmitry.
> > >
> > > > Regards,
> > > > Saket Sinha
> > > >
> > > > On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <keiichiw@chromiu=
m.org>
> > > wrote:
> > > > > Hi Dmitry,
> > > > >
> > > > > On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensyne=
rgy.com
> > > > > >
> > > wrote:
> > > > > > Hi Saket and all,
> > > > > >
> > > > > > As we are working with automotive platforms, unfortunately we d=
on't
> > > > > > plan
> > > > > > any Qemu reference implementation so far.
> > > > > >
> > > > > > Of course we are ready to support the community if any help is =
needed.
> > > > > > Is
> > > > > > there interest in support for the FWHT format only for testing =
purpose
> > > > > > or you want a full-featured implementation on the QEMU side?
> > > > >
> > > > > I guess we don't need to implement the codec algorithm in QEMU.
> > > > > Rather, QEMU forwards virtio-video requests to the host video dev=
ice
> > > > > or a software library such as GStreamer or ffmpeg.
> > > > > So, what we need to implement in QEMU is a kind of API translatio=
n,
> > > > > which shouldn't care about actual video formats so much.
> > > > >
> > > > > Regarding the FWHT format discussed in the patch thread [1], in m=
y
> > > > > understanding, Hans suggested to have QEMU implementation forward=
ing
> > > > > requests to the host's vicodec module [2].
> > > > > Then, we'll be able to test the virtio-video driver on QEMU on Li=
nux
> > > > > even if the host Linux has no hardware video decoder.
> > > > > (Please correct me if I'm wrong.)
> > > > >
> > > > > Let me add Hans and Linux media ML in CC.
> > > > >
> > > > > [1]  https://patchwork.linuxtv.org/patch/61717/
> > > > > [2] https://lwn.net/Articles/760650/
> > > > >
> > > > > Best regards,
> > > > > Keiichi
> > > > >
> > > > > > Please note that the spec is not finalized yet and a major upda=
te is
> > > > > > now
> > > > > > discussed with upstream and the Chrome OS team, which is also
> > > > > > interested
> > > > > > and deeply involved in the process. The update mostly implies s=
ome
> > > > > > rewording and reorganization of data structures, but for sure w=
ill
> > > > > > require a driver rework.
> > > > > >
> > > > > > Best regards,
> > > > > > Dmitry.
> > > > > >
> > > > > > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > As suggested on #qemu-devel IRC channel, I am including virti=
o-dev,
> > > > > > > Gerd and Michael to point in the right direction how to move =
forward
> > > > > > > with Qemu support for Virtio Video V4L2 driver
> > > > > > > posted in [1].
> > > > > > >
> > > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > > >
> > > > > > > Regards,
> > > > > > > Saket Sinha
> > > > > > >
> > > > > > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gma=
il.com>
> > > wrote:
> > > > > > > > Hi ,
> > > > > > > >
> > > > > > > > This is to inquire about Qemu support for Virtio Video V4L2=
 driver
> > > > > > > > posted in [1].
> > > > > > > > I am currently not aware of any upstream effort for Qemu re=
ference
> > > > > > > > implementation and would like to discuss how to proceed wit=
h the
> > > > > > > > same.
> > > > > > > >
> > > > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Saket Sinha
> > > > > >
> > > > > > ---------------------------------------------------------------=
------
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open=
.org
> > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-op=
en.org
>

