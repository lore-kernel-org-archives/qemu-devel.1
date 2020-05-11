Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C20C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9847206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxgmj0gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9847206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6HL-0002Js-Ty
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jY6GX-0001q5-1y
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:06:33 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jY6GV-0004ru-Ew
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:06:32 -0400
Received: by mail-lf1-x142.google.com with SMTP id x73so7149928lfa.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KSdV8YwHmMgDkf6Pwl9t/927NVpXsj0ABhibj8ETPcM=;
 b=uxgmj0gCX3b4PO/vmNX6t36IpMRSSmdEYZ/bwLOrf+zPWMLomjBbAXedUAIynSIYpW
 07CdCOpDEYoBiFHG83tpDzrIPh+fzWpl5BraatflAYDIZ8gDAIZUSLSpxQV5Ekui5Eky
 F8ov4qwzXnd9wKT1L2DQGojk4DLsx/A6vK8y6JhZiLXwNculi3W8HWtYHhaW/uiCl//z
 5rew024meoeqkW7zFvCQk52AAjsCur1KOw3Db7eBxsJV8kSN2kJaGRuRILcIuD+TjV2c
 0wJr7hXP3grSf5nXkgsWaNZJTzYtXyHeW0hVnwH6fCi88zfhNdsmtahPmi6mPxFz7/9s
 bGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KSdV8YwHmMgDkf6Pwl9t/927NVpXsj0ABhibj8ETPcM=;
 b=pRbI2uX6/W6YtbJ5iD+rCxzLHN6+iJoSGBO4efBga7yAnZUPnA7orF96+NV/PkaNv6
 farKdqpqOMgZh3bAFv9iVZM9KuhjKvsvmk88P8ZHfUlgOfAL4fOyCZ3QXJq40jBEYTaq
 DrUv//JgqUCyO3mhc8G1LH+UdORuavDGJ9F0gPFFpqB2qFECmpqxnW46wmEChFHha1tF
 BmXAf4FjH/oQ3M8GL7ZU2/3EPEYO/f+anVjDhkuYRBSmvuf80Zu6XvQIt/uEQQVTZpr1
 88VuQ5EKHnOb2MIum/JCsjT4YHCeKzObN0yOVuJCVJWxdF9na3sQzhbmZJY79d2vuSa9
 pngw==
X-Gm-Message-State: AOAM531xSToO8bBXtwuOlPT6pAjwOrG858WV7+q2gs4nuSHMVlT0+KnP
 yeqMZxjJK+SBqtw7IJr9s4EHNMDvsMGFGXh4DrI=
X-Google-Smtp-Source: ABdhPJwT39ClB4Ia2auEe6RFV5Mc/FVxWsDEMw16ZLKiZfalWxA3rYein0AC/ZeGa5OELIYcCKgIanksOJres51V2a0=
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr11144039lfm.63.1589195188918; 
 Mon, 11 May 2020 04:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAK25hWMj5PyQFZVN5AToHjdySvi6iZ4zjZeUJQR85jNgoeLeAw@mail.gmail.com>
 <CAK25hWOPS1wGORXgtv8hUNu9-mLO+5C_k3Cj=8pnoFWmjuhJdg@mail.gmail.com>
 <2405792.XL1faGB9W5@os-lin-dmo>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
In-Reply-To: <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
From: Saket Sinha <saket.sinha89@gmail.com>
Date: Mon, 11 May 2020 13:05:53 +0200
Message-ID: <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Keiichi Watanabe <keiichiw@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=saket.sinha89@gmail.com; helo=mail-lf1-x142.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Keiichi,

I do not support the approach of  QEMU implementation forwarding
requests to the host's vicodec module since  this can limit the scope
of the virtio-video device only for testing, which instead can be used
with multiple use cases such as -

1. VM gets access to paravirtualized  camera devices which shares the
video frames input through actual HW camera attached to Host.

2. If Host has multiple video devices (especially in ARM SOCs over
MIPI interfaces or USB), different VM can be started or hotplugged
with selective video streams from actual HW video devices.

Also instead of using libraries like Gstreamer in Host userspace, they
can also be used inside the VM userspace after getting access to
paravirtualized HW camera devices .

Regards,
Saket Sinha

On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <keiichiw@chromium.org> wrote:
>
> Hi Dmitry,
>
> On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
> >
> > Hi Saket and all,
> >
> > As we are working with automotive platforms, unfortunately we don't plan any
> > Qemu reference implementation so far.
> >
> > Of course we are ready to support the community if any help is needed. Is
> > there interest in support for the FWHT format only for testing purpose or you
> > want a full-featured implementation on the QEMU side?
>
> I guess we don't need to implement the codec algorithm in QEMU.
> Rather, QEMU forwards virtio-video requests to the host video device
> or a software library such as GStreamer or ffmpeg.
> So, what we need to implement in QEMU is a kind of API translation,
> which shouldn't care about actual video formats so much.
>
> Regarding the FWHT format discussed in the patch thread [1], in my
> understanding, Hans suggested to have QEMU implementation forwarding
> requests to the host's vicodec module [2].
> Then, we'll be able to test the virtio-video driver on QEMU on Linux
> even if the host Linux has no hardware video decoder.
> (Please correct me if I'm wrong.)
>
> Let me add Hans and Linux media ML in CC.
>
> [1]  https://patchwork.linuxtv.org/patch/61717/
> [2] https://lwn.net/Articles/760650/
>
> Best regards,
> Keiichi
>
> >
> > Please note that the spec is not finalized yet and a major update is now
> > discussed with upstream and the Chrome OS team, which is also interested and
> > deeply involved in the process. The update mostly implies some rewording and
> > reorganization of data structures, but for sure will require a driver rework.
> >
> > Best regards,
> > Dmitry.
> >
> > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > Hi,
> > >
> > > As suggested on #qemu-devel IRC channel, I am including virtio-dev, Gerd and
> > > Michael to point in the right direction how to move forward with Qemu
> > > support for Virtio Video V4L2 driver
> > > posted in [1].
> > >
> > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > >
> > > Regards,
> > > Saket Sinha
> > >
> > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com> wrote:
> > > > Hi ,
> > > >
> > > > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > > > posted in [1].
> > > > I am currently not aware of any upstream effort for Qemu reference
> > > > implementation and would like to discuss how to proceed with the same.
> > > >
> > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > >
> > > > Regards,
> > > > Saket Sinha
> >
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >

