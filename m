Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B26C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5889206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n3b7+DIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5889206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9BD-0003fE-P6
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jY951-0002Zw-OO
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:06:51 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jY94x-0002Or-SW
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:06:51 -0400
Received: by mail-lj1-x242.google.com with SMTP id j3so9609733ljg.8
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=haJMwOvTf5fIl1NGZ/2blWPLBhZV7nR/CzNYhK0YNtE=;
 b=n3b7+DIaKbaJmEW0MOOdepTs9odKwvh9njPSmX33PZuzNcsHSDv4wcNL+zteym8y9v
 uchnC8mXHH90NCTwe+7m75OrDXq8d7DIMq37JOc1KHKC8LmQM7MH7ilxQ1AdTWAjf3Ty
 oHI3GCazdgs0X92bI+TDo9xWGu31EV6mzm9ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=haJMwOvTf5fIl1NGZ/2blWPLBhZV7nR/CzNYhK0YNtE=;
 b=b/lZta7KAER5+wSHc/z+U7syIRqlD6VEjcDWpDj7lhqcGodEKJu5T7Myh0YjiJBDe7
 GorMchvmk54HLqSsC+b/piHvy73a8VkkSfaOD/8yFVTEUoV4FO+8o209I629krSxCsN4
 5G5iMxzKAK8cFKPuToBT+p3eEbyvPOebdFhKUyzBCrxGJDXo+QcgPDI+42HW/khrIz+k
 2nU8XIWSyUBlv2xWZutJFIxsBBRptWis8FZVmotmt2gQbP1RfgnPxaMGg/3XBmuTJ6wZ
 9/knKgxFK2lhTE2lgLcUEAQIeQ6x2QBU04DSS1yFoZO/SceDfQlrEUW5g9weLnJe/lP2
 NGmw==
X-Gm-Message-State: AOAM533a2RD4jW3+QL2j6RYw1fchgZG/3T2VHva6rmk7Fys85sYMxBmF
 ELvNBqsL9P65wNkVK+RikvmqN1uwGvHWyfKf1Iu0/g==
X-Google-Smtp-Source: ABdhPJwBH1E+ecdt/FDIZFNnCScP8N2GvNenf9y6DgFEQTQkGQSP9zS/tKDGLkdIcNibwUzh5C9ZKuEYv8PXGjGaVso=
X-Received: by 2002:a05:651c:32e:: with SMTP id
 b14mr10453920ljp.277.1589206005853; 
 Mon, 11 May 2020 07:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <CAK25hWNR0WdpddU1kDChUB+PWiLG2A76KJW5u5F-LNkGBREj_g@mail.gmail.com>
In-Reply-To: <CAK25hWNR0WdpddU1kDChUB+PWiLG2A76KJW5u5F-LNkGBREj_g@mail.gmail.com>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 11 May 2020 23:06:34 +0900
Message-ID: <CAD90VcYJe7+R256RdOQKxFQciq54+PwbyDRF1cynjOzdQBrq-g@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Saket Sinha <saket.sinha89@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=keiichiw@chromium.org; helo=mail-lj1-x242.google.com
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
X-Mailman-Approved-At: Mon, 11 May 2020 10:09:20 -0400
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
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 libcamera-devel@lists.libcamera.org, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Sepp <dmitry.sepp@opensynergy.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Saket,

On Mon, May 11, 2020 at 9:33 PM Saket Sinha <saket.sinha89@gmail.com> wrote:
>
> Hi Keiichi,
>
> > > > I do not support the approach of  QEMU implementation forwarding
> > > > requests to the host's vicodec module since  this can limit the scope
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
> > [1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html
> >
>
> Thanks for clarification.
>
> Could  you provide your views if it would be possible to support also
> paravirtualized v4l-subdev devices which is enabled by media
> controller to expose ISP processing blocks to linux userspace.
> Ofcourse, we might need to change implementation and spec to support that
> Please refer (1) for details.

Again, the current virtio-video protocol and driver only support video
encoding and decoding. We had no detailed discussion about camera
supports.
Moreover, I personally disagree with supporting video capturing in
virtio-video protocol. Instead, I believe it's better to have a
separate protocol like "virtio-camera". Decoupling video codec APIs
and camera APIs should make protocols simpler and easier to maintain.
I suggested this idea in [1].

So, the answer to your question is:
No in virtio-video protocol. But, it's possible to start designing a
new "virtio-camera" protocol that supports camera features including
image processing.

[1] https://markmail.org/message/4q2g5oqniw62pmqd

>
> > >
> > > > which instead can be used with multiple use cases such as -
> > > >
> > > > 1. VM gets access to paravirtualized  camera devices which shares the
> > > > video frames input through actual HW camera attached to Host.
> > >
> > > This use-case is out of the scope of virtio-video. Initially I had a plan to
> > > support capture-only streams like camera as well, but later the decision was
> > > made upstream that camera should be implemented as separate device type. We
> > > still plan to implement a simple frame capture capability as a downstream
> > > patch though.
> > >
> > > >
> > > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > > with selective video streams from actual HW video devices.
> > >
> > > We do support this in our device implementation. But spec in general has no
> > > requirements or instructions regarding this. And it is in fact flexible enough
> > > to provide abstraction on top of several HW devices.
> > >
> > > >
> > > > Also instead of using libraries like Gstreamer in Host userspace, they
> > > > can also be used inside the VM userspace after getting access to
> > > > paravirtualized HW camera devices .
> >
> > Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> > can translate virtio-video requests to this API, we can easily support
> > multiple platforms.
> > I'm not sure how feasible it is though, as I have no experience of
> > using this API by myself...
> >
> > [2] https://gstreamer.freedesktop.org/documentation/tutorials/playback/hardware-accelerated-video-decoding.html
> >
>
> Like pointed out above, Gstreamer is not the only framework present there.
> We have the newer libcamera framework [2] and then Openmax (used in
> Android Hal )
> Refer [3] for comparison.

It seems that we had miscommunication here. While I had mentioned
Gstreamer as a generic implementation to cover "video decoding" APIs
on various platforms, you were talking about "camera" APIs.
As I said above, virtio-video is NOT designed for cameras.

For abstraction of video decoding APIs, I don't know any better
library than Gstreamer. For cameras, libcamera sounds good, but I'm
not so familiar with this area...

Best regards,
Keiichi


>
> My intentions are to make the implementation more generic so that it
> can be used by different frameworks on different platforms.
>
> [1]: https://static.sched.com/hosted_files/osseu19/21/libcamera.pdf
> [2]: http://libcamera.org
> [3]: https://processors.wiki.ti.com/images/7/7e/OMX_Android_GST_Comparison.pdf
>
> Regards,
> Saket Sinha

