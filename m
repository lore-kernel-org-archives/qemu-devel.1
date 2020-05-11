Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89615C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E05206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sikc5W36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E05206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9AO-0002Go-Gb
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jY5YL-0001Si-Iv
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:20:53 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <keiichiw@chromium.org>)
 id 1jY5YJ-0003Rx-S0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:20:53 -0400
Received: by mail-lf1-x142.google.com with SMTP id b26so7029155lfa.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7l3aJuCw1ZmCkBeYJdf5n98EOG+qDwjoqW0w6aiK8Jw=;
 b=Sikc5W36ZX6VLf4vxIpmICrDhJ9qmRTG+teL0qUfwHpirI6RkJ0v/hdzb+V3cF37dh
 poqmBP9D3KmtU4xWW4uVxU1M/fLBVgjGL/GEtQNHvCviUoj0IopFFElfZVB028qoKj7i
 Ag+GhK48JROPwo+bKXsnuOf+mgnNWfkx9wMmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7l3aJuCw1ZmCkBeYJdf5n98EOG+qDwjoqW0w6aiK8Jw=;
 b=LbMl6+jtDheATyA3IA3JI7YiMy+7wThPwl0pnVtVYfniFCMPCaCHVzN0SEvXLzLbvq
 ntPT8Sy5W1BDPK93h/MWEiAb+Yadlnsh5G08Xh12yEa9kOJ/niEEpd47kdDg/c8+93O8
 VHH6G3CLQ3x/Jq2srxWayeZyO/ibRXAFhBWfs1GZ2ofXXO+RQyiy46FQ+8EwkNoldD5w
 FKSOh/oa7/Og8ZRAA39VjGAdf/2+YPn95OzC4MFILQLi58ajNeYkASWOb/Jgln1T45r0
 qoqoIAg4TH5n0C09i0qk0vQHG3HuOkSIFJ542+iWBYfey6l6SNpxVQ8X8jz704mxvK3+
 vM0Q==
X-Gm-Message-State: AOAM532GnzQgky577aEUbHYZU1d7mpJFAFps9smhYqx3RuGivVH/iXF5
 E/9q4xPonCXqMTCnuGNkdJ0nxjM07xiaqSYNhIVZTw==
X-Google-Smtp-Source: ABdhPJwQliO9vuZUSjoSithFIp6Rh4GnLng2aK/kW3AYtqC4jRKZQweyrqj0jcFbUxqjG+HiYZc8QabdBuaOZVk+23w=
X-Received: by 2002:ac2:504c:: with SMTP id a12mr10601082lfm.110.1589192449476; 
 Mon, 11 May 2020 03:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAK25hWMj5PyQFZVN5AToHjdySvi6iZ4zjZeUJQR85jNgoeLeAw@mail.gmail.com>
 <CAK25hWOPS1wGORXgtv8hUNu9-mLO+5C_k3Cj=8pnoFWmjuhJdg@mail.gmail.com>
 <2405792.XL1faGB9W5@os-lin-dmo>
In-Reply-To: <2405792.XL1faGB9W5@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 11 May 2020 19:20:38 +0900
Message-ID: <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=keiichiw@chromium.org; helo=mail-lf1-x142.google.com
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

Hi Dmitry,

On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wrote:
>
> Hi Saket and all,
>
> As we are working with automotive platforms, unfortunately we don't plan any
> Qemu reference implementation so far.
>
> Of course we are ready to support the community if any help is needed. Is
> there interest in support for the FWHT format only for testing purpose or you
> want a full-featured implementation on the QEMU side?

I guess we don't need to implement the codec algorithm in QEMU.
Rather, QEMU forwards virtio-video requests to the host video device
or a software library such as GStreamer or ffmpeg.
So, what we need to implement in QEMU is a kind of API translation,
which shouldn't care about actual video formats so much.

Regarding the FWHT format discussed in the patch thread [1], in my
understanding, Hans suggested to have QEMU implementation forwarding
requests to the host's vicodec module [2].
Then, we'll be able to test the virtio-video driver on QEMU on Linux
even if the host Linux has no hardware video decoder.
(Please correct me if I'm wrong.)

Let me add Hans and Linux media ML in CC.

[1]  https://patchwork.linuxtv.org/patch/61717/
[2] https://lwn.net/Articles/760650/

Best regards,
Keiichi

>
> Please note that the spec is not finalized yet and a major update is now
> discussed with upstream and the Chrome OS team, which is also interested and
> deeply involved in the process. The update mostly implies some rewording and
> reorganization of data structures, but for sure will require a driver rework.
>
> Best regards,
> Dmitry.
>
> On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > Hi,
> >
> > As suggested on #qemu-devel IRC channel, I am including virtio-dev, Gerd and
> > Michael to point in the right direction how to move forward with Qemu
> > support for Virtio Video V4L2 driver
> > posted in [1].
> >
> > [1]: https://patchwork.linuxtv.org/patch/61717/
> >
> > Regards,
> > Saket Sinha
> >
> > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com> wrote:
> > > Hi ,
> > >
> > > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > > posted in [1].
> > > I am currently not aware of any upstream effort for Qemu reference
> > > implementation and would like to discuss how to proceed with the same.
> > >
> > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > >
> > > Regards,
> > > Saket Sinha
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

