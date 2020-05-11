Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3688FC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01307206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A53Unz8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01307206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9Cj-0005Ox-4K
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jY6wP-0001js-4b
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:49:49 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jY6wN-0003uU-P0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:49:48 -0400
Received: by mail-lf1-x143.google.com with SMTP id a4so7222716lfh.12
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 04:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B21F7CiOg+DDDaqcnQJW0RYfm2fpIW2cEenamiuDnaA=;
 b=A53Unz8Owy5JTyr9M5bWp9gLHNtWnSvJtGt1v6oqr3IeXsxJ0ugGzoCAjVun/M/448
 mYD/I+0FPQMyINWyPxjg898kLjLdGFL2kILNGhDnTlefdcj34ZjP1MJpzch+FlY+yW79
 6X+0zmCJbzk0LggSaFKu/+39KHg4CtDlf/hqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B21F7CiOg+DDDaqcnQJW0RYfm2fpIW2cEenamiuDnaA=;
 b=CL3nR+7xkDVWGdCOfcGKss6VSSqFiXtufN+uV7J7uXjQ9mQw9bwjL/lSls2vPsetm/
 OBjN8cJxl/OQ+Cv4PyaeMt9bUHNoKg4Rd3V1nuRIpuPJ1/4CRJaZWp9ht8vttB0MK+as
 epO9NxM0UyL/e0YeXhYhCQZ8ylRTZGTe+WrkY8r61gsBNmsCYjCV1W9cBp92NUDjL1f5
 owwWSdyq4VKOSZMYpEwI0FPGdkp/DlHT396teOdAME1rfbnRRASVv5uiSYRFt2ngovTO
 c0pGmCgy/gej58l8VVHlPyRfhvpTya1o41OVugVHomnlwTYIS/465Nrjr2phC5bW7P5+
 nEmA==
X-Gm-Message-State: AOAM530YV8lulACcQhPcksEVFACfa16cmPoP6ZpAaKVJ0GI0EXuyX1RP
 +572CefdpolQzRufml58hDaNQqK1S/tn2w/hOniEeg==
X-Google-Smtp-Source: ABdhPJy2dm/OSzYbLWWpaDMwsa/U0AXERYmQvZeMpWlmx2lpQWzJ5BXYK0R27wI7E9fHJmoZpAWuq7QjCsf4UJPK3RE=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr11026821lfa.126.1589197785384; 
 Mon, 11 May 2020 04:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
In-Reply-To: <2515515.r9knKAEANn@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 11 May 2020 20:49:33 +0900
Message-ID: <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=keiichiw@chromium.org; helo=mail-lf1-x143.google.com
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
 Tomasz Figa <tfiga@chromium.org>, Saket Sinha <saket.sinha89@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Thanks Saket for your feedback. As Dmitry mentioned, we're focusing on
video encoding and decoding, not camera. So, my reply was about how to
implement paravirtualized video codec devices.

On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
>
> Hi Saket,
>
> On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > Hi Keiichi,
> >
> > I do not support the approach of  QEMU implementation forwarding
> > requests to the host's vicodec module since  this can limit the scope
> > of the virtio-video device only for testing,
>
> That was my understanding as well.

Not really because the API which the vicodec provides is V4L2 stateful
decoder interface [1], which are also used by other video drivers on
Linux.
The difference between vicodec and actual device drivers is that
vicodec performs decoding in the kernel space without using special
video devices. In other words, vicodec is a software decoder in kernel
space which provides the same interface with actual video drivers.
Thus, if the QEMU implementation can forward virtio-video requests to
vicodec, it can forward them to the actual V4L2 video decoder devices
as well and VM gets access to a paravirtualized video device.

The reason why we discussed vicodec in the previous thread was it'll
allow us to test the virtio-video driver without hardware requirement.

[1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.html

>
> > which instead can be used with multiple use cases such as -
> >
> > 1. VM gets access to paravirtualized  camera devices which shares the
> > video frames input through actual HW camera attached to Host.
>
> This use-case is out of the scope of virtio-video. Initially I had a plan to
> support capture-only streams like camera as well, but later the decision was
> made upstream that camera should be implemented as separate device type. We
> still plan to implement a simple frame capture capability as a downstream
> patch though.
>
> >
> > 2. If Host has multiple video devices (especially in ARM SOCs over
> > MIPI interfaces or USB), different VM can be started or hotplugged
> > with selective video streams from actual HW video devices.
>
> We do support this in our device implementation. But spec in general has no
> requirements or instructions regarding this. And it is in fact flexible enough
> to provide abstraction on top of several HW devices.
>
> >
> > Also instead of using libraries like Gstreamer in Host userspace, they
> > can also be used inside the VM userspace after getting access to
> > paravirtualized HW camera devices .

Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
can translate virtio-video requests to this API, we can easily support
multiple platforms.
I'm not sure how feasible it is though, as I have no experience of
using this API by myself...

[2] https://gstreamer.freedesktop.org/documentation/tutorials/playback/hardware-accelerated-video-decoding.html

Best regards,
Keiichi

> >
>
> Regarding the cameras, unfortunately same as above.
>
> Best regards,
> Dmitry.
>
> > Regards,
> > Saket Sinha
> >
> > On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <keiichiw@chromium.org>
> wrote:
> > > Hi Dmitry,
> > >
> > > On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensynergy.com>
> wrote:
> > > > Hi Saket and all,
> > > >
> > > > As we are working with automotive platforms, unfortunately we don't plan
> > > > any Qemu reference implementation so far.
> > > >
> > > > Of course we are ready to support the community if any help is needed.
> > > > Is
> > > > there interest in support for the FWHT format only for testing purpose
> > > > or you want a full-featured implementation on the QEMU side?
> > >
> > > I guess we don't need to implement the codec algorithm in QEMU.
> > > Rather, QEMU forwards virtio-video requests to the host video device
> > > or a software library such as GStreamer or ffmpeg.
> > > So, what we need to implement in QEMU is a kind of API translation,
> > > which shouldn't care about actual video formats so much.
> > >
> > > Regarding the FWHT format discussed in the patch thread [1], in my
> > > understanding, Hans suggested to have QEMU implementation forwarding
> > > requests to the host's vicodec module [2].
> > > Then, we'll be able to test the virtio-video driver on QEMU on Linux
> > > even if the host Linux has no hardware video decoder.
> > > (Please correct me if I'm wrong.)
> > >
> > > Let me add Hans and Linux media ML in CC.
> > >
> > > [1]  https://patchwork.linuxtv.org/patch/61717/
> > > [2] https://lwn.net/Articles/760650/
> > >
> > > Best regards,
> > > Keiichi
> > >
> > > > Please note that the spec is not finalized yet and a major update is now
> > > > discussed with upstream and the Chrome OS team, which is also interested
> > > > and deeply involved in the process. The update mostly implies some
> > > > rewording and reorganization of data structures, but for sure will
> > > > require a driver rework.
> > > >
> > > > Best regards,
> > > > Dmitry.
> > > >
> > > > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > > > Hi,
> > > > >
> > > > > As suggested on #qemu-devel IRC channel, I am including virtio-dev,
> > > > > Gerd and Michael to point in the right direction how to move forward
> > > > > with Qemu support for Virtio Video V4L2 driver
> > > > > posted in [1].
> > > > >
> > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > >
> > > > > Regards,
> > > > > Saket Sinha
> > > > >
> > > > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com>
> wrote:
> > > > > > Hi ,
> > > > > >
> > > > > > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > > > > > posted in [1].
> > > > > > I am currently not aware of any upstream effort for Qemu reference
> > > > > > implementation and would like to discuss how to proceed with the
> > > > > > same.
> > > > > >
> > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > >
> > > > > > Regards,
> > > > > > Saket Sinha
> > > >
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

