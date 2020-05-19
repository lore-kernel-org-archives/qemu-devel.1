Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE39C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9A22075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="n+OsgAYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9A22075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb64u-00036R-VD
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas@ndufresne.ca>)
 id 1jb63i-0001In-B8
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:29:43 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:44852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicolas@ndufresne.ca>)
 id 1jb63f-0006Fz-8F
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:29:41 -0400
Received: by mail-qt1-x844.google.com with SMTP id d7so216353qtn.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=wkAQrt/QZ02YfB0Dlvt6hkvv0K9Gt8A3M2LmM+q+IYc=;
 b=n+OsgAYn6ku0Pc2ck7u0bL9hFV8sjFkFcV57lIKqgh9bcoOMz1PWnTir5mqhWeqvbI
 hXXPsPe59N3DA0+863kjIFZcQlU/8x4gSIcSjF71GlOaVVbsPBYb8BCoJBxH0LNzY5Jb
 fDK7RyOYHtnT+bsoz6VrydwL4KMMDAl5Tymh1ynXIp71+DeG4xCzui41AK4SRp6r3p2N
 xg/M8oGpxtHu2RKpQbSJvT91/7o7NPC555ACPVk1KnelaWOieUu2UJFiJWLEHz6YHukL
 oADRQ3FyqQlljmsXUREOjnsJsoR5i9pTQxmvLKBLUjVyZRFky2YZiZ1LTo4GFMCSWG2J
 6WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=wkAQrt/QZ02YfB0Dlvt6hkvv0K9Gt8A3M2LmM+q+IYc=;
 b=MU2KSV6itHuNE4oo1TjxRZ2VypJqddFrV7rQW6PUQJrbBOdCYdKg5w9WAfJQauCZKI
 f3QpA8eCFbEstda/LwCAk4mTncX7sJBFYwmAerbGoSwBeB1pjeIaxHcbIxx4imiLlcBa
 JMN6lyNXV6xQbgfyenfE3L+YR4Ey6qHZcXNhNodqMiD4niQqo5pc08ZmYWbJfYv3NdYP
 TBMZkIgLFrK4Ki+Lf0r9J3w1THVNsE+1GCB1wikPOBIj9EYvdQzJly3LiZrsKc9uZ60Q
 pFaRdO+jPVbcYmmKXTQHvj1mDBWtXk+MMWkQhB/GKMfM0nrOcFoSO3ONySDZi4yS5Yab
 qJUg==
X-Gm-Message-State: AOAM5339MXAHVq6hO8HzJ51Qu1ku6L8hlzLnVUzNuYwK+eCWRWL/LX6X
 YylJ9B2hyn85HoevaokP1hDK4g==
X-Google-Smtp-Source: ABdhPJyG/+SPtbPU7sgZkWnIlc7Q8EUY+74vFhMeoDGz0YrICiPi+rzcx78sEKbplJvjubXnHYZjeg==
X-Received: by 2002:ac8:5504:: with SMTP id j4mr851837qtq.383.1589909377528;
 Tue, 19 May 2020 10:29:37 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
 by smtp.gmail.com with ESMTPSA id 4sm111319qky.130.2020.05.19.10.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 10:29:36 -0700 (PDT)
Message-ID: <92ac2db087ccf8fae853284ecc8bdf187e292097.camel@ndufresne.ca>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 19 May 2020 13:29:35 -0400
In-Reply-To: <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
 <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::844;
 envelope-from=nicolas@ndufresne.ca; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

Le mardi 19 mai 2020 à 17:37 +0900, Keiichi Watanabe a écrit :
> Hi Nicolas,
> 
> On Fri, May 15, 2020 at 8:38 AM Nicolas Dufresne <
> nicolas@ndufresne.ca
> > wrote:
> > Le lundi 11 mai 2020 à 20:49 +0900, Keiichi Watanabe a écrit :
> > > Hi,
> > > 
> > > Thanks Saket for your feedback. As Dmitry mentioned, we're focusing on
> > > video encoding and decoding, not camera. So, my reply was about how to
> > > implement paravirtualized video codec devices.
> > > 
> > > On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <
> > > dmitry.sepp@opensynergy.com
> > > >
> > > wrote:
> > > > Hi Saket,
> > > > 
> > > > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > > > Hi Keiichi,
> > > > > 
> > > > > I do not support the approach of  QEMU implementation forwarding
> > > > > requests to the host's vicodec module since  this can limit the scope
> > > > > of the virtio-video device only for testing,
> > > > 
> > > > That was my understanding as well.
> > > 
> > > Not really because the API which the vicodec provides is V4L2 stateful
> > > decoder interface [1], which are also used by other video drivers on
> > > Linux.
> > > The difference between vicodec and actual device drivers is that
> > > vicodec performs decoding in the kernel space without using special
> > > video devices. In other words, vicodec is a software decoder in kernel
> > > space which provides the same interface with actual video drivers.
> > > Thus, if the QEMU implementation can forward virtio-video requests to
> > > vicodec, it can forward them to the actual V4L2 video decoder devices
> > > as well and VM gets access to a paravirtualized video device.
> > > 
> > > The reason why we discussed vicodec in the previous thread was it'll
> > > allow us to test the virtio-video driver without hardware requirement.
> > > 
> > > [1] 
> > > https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html
> > > 
> > > 
> > > > > which instead can be used with multiple use cases such as -
> > > > > 
> > > > > 1. VM gets access to paravirtualized  camera devices which shares the
> > > > > video frames input through actual HW camera attached to Host.
> > > > 
> > > > This use-case is out of the scope of virtio-video. Initially I had a plan to
> > > > support capture-only streams like camera as well, but later the decision was
> > > > made upstream that camera should be implemented as separate device type. We
> > > > still plan to implement a simple frame capture capability as a downstream
> > > > patch though.
> > > > 
> > > > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > > > with selective video streams from actual HW video devices.
> > > > 
> > > > We do support this in our device implementation. But spec in general has no
> > > > requirements or instructions regarding this. And it is in fact flexible
> > > > enough
> > > > to provide abstraction on top of several HW devices.
> > > > 
> > > > > Also instead of using libraries like Gstreamer in Host userspace, they
> > > > > can also be used inside the VM userspace after getting access to
> > > > > paravirtualized HW camera devices .
> > > 
> > > Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> > > can translate virtio-video requests to this API, we can easily support
> > > multiple platforms.
> > > I'm not sure how feasible it is though, as I have no experience of
> > > using this API by myself...
> > 
> > Not sure which API you aim exactly, but what one need to remember is that
> > mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC or other type
> > of "stateless" CODEC is not trivial and can't be done without userspace. Notably
> > because we don't want to do bitstream parsing in the kernel on the main CPU as
> > security would otherwise be very hard to guaranty. The other driver using same
> > API as virtio-video do bitstream parsing on a dedicated co-processor (through
> > firmware blobs though).
> > 
> > Having bridges between virtio-video, qemu and some abstraction library like
> > FFMPEG or GStreamer is certainly the best solution if you want to virtualize any
> > type of HW accelerated decoder or if you need to virtualized something
> > proprietary (like NVDEC). Please shout if you need help.
> > 
> 
> Yeah, I meant we should map virtio-video commands to a set of
> abstracted userspace APIs to avoid having many platform-dependent code
> in QEMU.
> This is the same with what we implemented in crosvm, a VMM on
> ChromiumOS. Crosvm's video device translates virtio-video commands
> into our own video decoding APIs [1, 2] which supports VAAPI, V4L2
> stateful and V4L2 stateless. Unfortunately, since our library is
> highly depending on Chrome, we cannot reuse this for QEMU.
> 
> So, I agree that using FFMPEG or GStreamer is a good idea. Probably,
> APIs in my previous link weren't for this purpose.
> Nicolas, do you know any good references for FFMPEG or GStreamer's
> abstracted video decoding APIs? Then, I may be able to think about how
> virtio-video protocols can be mapped to them.

The FFMpeg API for libavcodec can be found here:

  http://git.videolan.org/?p=ffmpeg.git;a=blob;f=libavcodec/avcodec.h

GStreamer does not really have such a low level CODEC API. So while
it's possible to use it (Wine project uses it for it's parsers as an
example, and Firefox use to have CODEC support wrapping GStreamer
CODEC), there will not be any one-to-one mapping. GStreamer is often
chosen as it's LGPL code does not carry directly any patented
implementation. It instead rely on plugins, which maybe provided as
third party, allowing to distribute your project while giving uses the
option to install potentially non-free technologies.

But overall, I can describe GStreamer API for CODEC wrapping (pipeline
less) as:

  - Push GstCaps describing the stream format
  - Push bitstream buffer on sink pad
  - When ready, buffers will be pushed through the push function 
    callback on src pad

Of course nothing prevent adding something like the vda abstraction in
qemu and make this multi-backend capable.

> 
> [1] libvda's C interface:
> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/arc/vm/libvda/libvda_decode.h
> 
> [2] libvda's Rust interface:
> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/arc/vm/libvda/rust/
> 
> 
> Best regards,
> Keiichi
> 
> > > [2]
> > > https://gstreamer.freedesktop.org/documentation/tutorials/playback/hardware-accelerated-video-decoding.html
> > > 
> > > 
> > > Best regards,
> > > Keiichi
> > > 
> > > > Regarding the cameras, unfortunately same as above.
> > > > 
> > > > Best regards,
> > > > Dmitry.
> > > > 
> > > > > Regards,
> > > > > Saket Sinha
> > > > > 
> > > > > On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <
> > > > > keiichiw@chromium.org
> > > > > >
> > > > 
> > > > wrote:
> > > > > > Hi Dmitry,
> > > > > > 
> > > > > > On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <
> > > > > > dmitry.sepp@opensynergy.com
> > > > > > 
> > > > 
> > > > wrote:
> > > > > > > Hi Saket and all,
> > > > > > > 
> > > > > > > As we are working with automotive platforms, unfortunately we don't
> > > > > > > plan
> > > > > > > any Qemu reference implementation so far.
> > > > > > > 
> > > > > > > Of course we are ready to support the community if any help is needed.
> > > > > > > Is
> > > > > > > there interest in support for the FWHT format only for testing purpose
> > > > > > > or you want a full-featured implementation on the QEMU side?
> > > > > > 
> > > > > > I guess we don't need to implement the codec algorithm in QEMU.
> > > > > > Rather, QEMU forwards virtio-video requests to the host video device
> > > > > > or a software library such as GStreamer or ffmpeg.
> > > > > > So, what we need to implement in QEMU is a kind of API translation,
> > > > > > which shouldn't care about actual video formats so much.
> > > > > > 
> > > > > > Regarding the FWHT format discussed in the patch thread [1], in my
> > > > > > understanding, Hans suggested to have QEMU implementation forwarding
> > > > > > requests to the host's vicodec module [2].
> > > > > > Then, we'll be able to test the virtio-video driver on QEMU on Linux
> > > > > > even if the host Linux has no hardware video decoder.
> > > > > > (Please correct me if I'm wrong.)
> > > > > > 
> > > > > > Let me add Hans and Linux media ML in CC.
> > > > > > 
> > > > > > [1]  
> > > > > > https://patchwork.linuxtv.org/patch/61717/
> > > > > > 
> > > > > > [2] 
> > > > > > https://lwn.net/Articles/760650/
> > > > > > 
> > > > > > 
> > > > > > Best regards,
> > > > > > Keiichi
> > > > > > 
> > > > > > > Please note that the spec is not finalized yet and a major update is
> > > > > > > now
> > > > > > > discussed with upstream and the Chrome OS team, which is also
> > > > > > > interested
> > > > > > > and deeply involved in the process. The update mostly implies some
> > > > > > > rewording and reorganization of data structures, but for sure will
> > > > > > > require a driver rework.
> > > > > > > 
> > > > > > > Best regards,
> > > > > > > Dmitry.
> > > > > > > 
> > > > > > > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > As suggested on #qemu-devel IRC channel, I am including virtio-dev,
> > > > > > > > Gerd and Michael to point in the right direction how to move forward
> > > > > > > > with Qemu support for Virtio Video V4L2 driver
> > > > > > > > posted in [1].
> > > > > > > > 
> > > > > > > > [1]: 
> > > > > > > > https://patchwork.linuxtv.org/patch/61717/
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > > Saket Sinha
> > > > > > > > 
> > > > > > > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <
> > > > > > > > saket.sinha89@gmail.com
> > > > > > > > >
> > > > 
> > > > wrote:
> > > > > > > > > Hi ,
> > > > > > > > > 
> > > > > > > > > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > > > > > > > > posted in [1].
> > > > > > > > > I am currently not aware of any upstream effort for Qemu reference
> > > > > > > > > implementation and would like to discuss how to proceed with the
> > > > > > > > > same.
> > > > > > > > > 
> > > > > > > > > [1]: 
> > > > > > > > > https://patchwork.linuxtv.org/patch/61717/
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Regards,
> > > > > > > > > Saket Sinha
> > > > > > > 
> > > > > > > ---------------------------------------------------------------------
> > > > > > > To unsubscribe, e-mail: 
> > > > > > > virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > > 
> > > > > > > For additional commands, e-mail: 
> > > > > > > virtio-dev-help@lists.oasis-open.org
> > > > > > > 


