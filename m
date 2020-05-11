Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B010C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9AF20722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzdxTYYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9AF20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7qu-0002pf-FG
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jY7cV-0001U9-RB
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:33:21 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jY7cQ-0007AB-Ln
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:33:17 -0400
Received: by mail-lj1-x242.google.com with SMTP id o14so8199669ljp.4
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oHhlRVxZKnZbliAUXL2ki5LHIVcU18t1hWnVODIM8kE=;
 b=tzdxTYYuQDgOTkQaCQIpnv7DeeXpVWH/O+8LNEoRIv98ECHBTZzGk2ub9QLoiz6oKh
 gnThiTBNSw6U8W+V642JnmG1VkQVmCmIhmDTp3P/DbpR8Leur56gTP2MQGqM8iRLkrw8
 z9fo/syVfmXAG7cY1S7A/2PNxE+6chb3tGSqtsyVo82NTi03+hU5S05/t6om9A455YXe
 C4A54P5DURMrEjlrZ7aNLe37qRTzttlPDgkaTUzSSn51aRlsBj0zgiIWu2GX1iqvTYnS
 ienq5BjE9menV4KKH5fLmZBuxo5G4sfQ4BuBda6wn5A/B0OC3AvdahaeYJ4zhLbGUVeW
 M7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oHhlRVxZKnZbliAUXL2ki5LHIVcU18t1hWnVODIM8kE=;
 b=jP/7ux9HHysm9zew2NGQWw9fik9cOqhMtmfVq51GreWWTgzejzVAel+qBtjORiY3s0
 N0ZYRV1EKlTF73EhMymSQv9qnw3kFN8SP7ac9panXiOaBDuQ17tDMssfoRhO062YofiT
 1JWGbBlOVLRKiYYU4LXv/kr0nhny//LbNKor3rYMSADaGyDhq1eksaNsba9X0pp4Qisr
 7paGryF1HhjbnaxgVWcs+LkVhutVtxGHyHfuBxkDXkO2GiJ6b0kC+vwcvTyZb1L6atia
 D7DHqLruChY24N5Hizgqpg3UQO2dLrPJtNkwC1BHNCGEDRe2hsx6INQGhOM8Nkb3k+A4
 CYMA==
X-Gm-Message-State: AOAM533T8bed2sCwgMqO7jZOOUZxbedadpsV0gXYFqK03HkwMXE07ARl
 vIhLTFVbxpmbcAz4huiffuqkqFxxe12AyJL+xYw=
X-Google-Smtp-Source: ABdhPJzRdnYM649Rfmf9USadLnN2By7FRNOk0ZZcMrrjzxwxjn0Wu8vexdR+iPvR1HwfNsuojV+tOqXNMrbF6iMOimQ=
X-Received: by 2002:a05:651c:54f:: with SMTP id
 q15mr10457298ljp.145.1589200392494; 
 Mon, 11 May 2020 05:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
In-Reply-To: <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
From: Saket Sinha <saket.sinha89@gmail.com>
Date: Mon, 11 May 2020 14:32:36 +0200
Message-ID: <CAK25hWNR0WdpddU1kDChUB+PWiLG2A76KJW5u5F-LNkGBREj_g@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Keiichi Watanabe <keiichiw@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=saket.sinha89@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 libcamera-devel@lists.libcamera.org, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Sepp <dmitry.sepp@opensynergy.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Keiichi,

> > > I do not support the approach of  QEMU implementation forwarding
> > > requests to the host's vicodec module since  this can limit the scope
> > > of the virtio-video device only for testing,
> >
> > That was my understanding as well.
>
> Not really because the API which the vicodec provides is V4L2 stateful
> decoder interface [1], which are also used by other video drivers on
> Linux.
> The difference between vicodec and actual device drivers is that
> vicodec performs decoding in the kernel space without using special
> video devices. In other words, vicodec is a software decoder in kernel
> space which provides the same interface with actual video drivers.
> Thus, if the QEMU implementation can forward virtio-video requests to
> vicodec, it can forward them to the actual V4L2 video decoder devices
> as well and VM gets access to a paravirtualized video device.
>
> The reason why we discussed vicodec in the previous thread was it'll
> allow us to test the virtio-video driver without hardware requirement.
>
> [1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html
>

Thanks for clarification.

Could  you provide your views if it would be possible to support also
paravirtualized v4l-subdev devices which is enabled by media
controller to expose ISP processing blocks to linux userspace.
Ofcourse, we might need to change implementation and spec to support that
Please refer (1) for details.

> >
> > > which instead can be used with multiple use cases such as -
> > >
> > > 1. VM gets access to paravirtualized  camera devices which shares the
> > > video frames input through actual HW camera attached to Host.
> >
> > This use-case is out of the scope of virtio-video. Initially I had a plan to
> > support capture-only streams like camera as well, but later the decision was
> > made upstream that camera should be implemented as separate device type. We
> > still plan to implement a simple frame capture capability as a downstream
> > patch though.
> >
> > >
> > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > with selective video streams from actual HW video devices.
> >
> > We do support this in our device implementation. But spec in general has no
> > requirements or instructions regarding this. And it is in fact flexible enough
> > to provide abstraction on top of several HW devices.
> >
> > >
> > > Also instead of using libraries like Gstreamer in Host userspace, they
> > > can also be used inside the VM userspace after getting access to
> > > paravirtualized HW camera devices .
>
> Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> can translate virtio-video requests to this API, we can easily support
> multiple platforms.
> I'm not sure how feasible it is though, as I have no experience of
> using this API by myself...
>
> [2] https://gstreamer.freedesktop.org/documentation/tutorials/playback/hardware-accelerated-video-decoding.html
>

Like pointed out above, Gstreamer is not the only framework present there.
We have the newer libcamera framework [2] and then Openmax (used in
Android Hal )
Refer [3] for comparison.

My intentions are to make the implementation more generic so that it
can be used by different frameworks on different platforms.

[1]: https://static.sched.com/hosted_files/osseu19/21/libcamera.pdf
[2]: http://libcamera.org
[3]: https://processors.wiki.ti.com/images/7/7e/OMX_Android_GST_Comparison.pdf

Regards,
Saket Sinha

