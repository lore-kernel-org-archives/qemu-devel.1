Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E3DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 00:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2ACE2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 00:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCXI8l+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ACE2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6NyX-0007Rw-1O
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 20:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6Nxe-0006lp-Lt
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 20:52:46 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k6Nxd-0000tx-2k
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 20:52:46 -0400
Received: by mail-oi1-x243.google.com with SMTP id u24so5656456oic.7
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 17:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4sTkmoBa3mInqVfbl+WSyjRHDrOfLLI1rqsVPYfUHjs=;
 b=CCXI8l+54rqcYl7ose1Rzxv8xHR+Shymk6e6YAST7IxCCrElUL9s6abZOCuW67v9gi
 HCLHZmXLeh7sLuALwFgxc7FlhOZ9zbv0LJC4mCzMIR+HZJCte/tZZhkSBAnQOnEKAjG7
 Xp5yrIkhR5VdvHgTJa59qNbaz7k/ersR/r/rmjgwy/EzEkRFQnNh9h649yVSA/QdMNE7
 miiRBTJdBMsny3kxcTt4POsP6WXl5DB4sHYBlPAt/mpRPconJ7Rewd3MlFjWOa0twx0D
 Ol0fbI+5NksqOON+ieICERctW5Ht/rcpFMbtCWqGlm8St73BEPRgLqkBxFIBXTQWsw50
 nl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4sTkmoBa3mInqVfbl+WSyjRHDrOfLLI1rqsVPYfUHjs=;
 b=EjeC816Z0XuorwSWaI1QYB2vN8CGyRpxuH0HwgpgQ/8ZfMYbzpVF3IcY6Ae13ORZot
 rs9we1q/7bhakIX/q5r002faMBQx8I2JQ3SG1PGeGNBmBPQ+BjPuyF6ttRoft2F1KTez
 Rg9OekuYjgwDoRjXKf6pr25hRssojTbIDzB1d1qBdOD7qgbeFbIoscTsD+SP5LfCQIoI
 zfh4X7BjmaBKp6JOM6hUpn1WfkSH/pxFHAF8WXyWoYbqcYeA8Z4rWbcWaPssycEhYM7l
 3uKxTD3faFDwfjI72kDpHAkPgNj/TzwY7cMt1Uen7+yNBzwbB6NHbL0EYtnGMoc8PkuU
 vVcA==
X-Gm-Message-State: AOAM5326Siys8N79jppS383AYPYCIDumZFkwQ2tQ9x8cBYLiJb70WSQJ
 fU/GAo0gkwHis5G/XHwepbX8+rfCgtvcegpHDxY=
X-Google-Smtp-Source: ABdhPJzs9zprbKdK6Aowb49b2LlpCCfhI01fa3IbS+y/pPFpafe1yhq+Xioba3UfoOLjuIBjf+SiNQj3jsycIJ8vwEM=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr174085oif.56.1597366362912; 
 Thu, 13 Aug 2020 17:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200813153614.39917-1-liq3ea@163.com>
 <47b9f12f-2874-1e1c-2fc1-7ea1a81cc401@redhat.com>
In-Reply-To: <47b9f12f-2874-1e1c-2fc1-7ea1a81cc401@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 14 Aug 2020 08:52:07 +0800
Message-ID: <CAKXe6SJukoG8NqUuvvnC6oEMTOrs4hM7H_0_JP5LqtL=oYtEvg@mail.gmail.com>
Subject: Re: [PATCH] hw: virtio-gpu: remove duplicated 'virtqueue_pop'
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liq3ea@163.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laszlo Ersek <lersek@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On 08/13/20 17:36, Li Qiang wrote:
> > Just use 'while (true)' to avoid duplicated.
> > No function change.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/display/virtio-gpu.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 5f0dd7c150..9cef313f5e 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -869,13 +869,15 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *=
vdev, VirtQueue *vq)
> >      }
> >  #endif
> >
> > -    cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> > -    while (cmd) {
> > +    while (true) {
> > +        cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_comman=
d));
> > +        if (!cmd) {
> > +            break;
> > +        }
> >          cmd->vq =3D vq;
> >          cmd->error =3D 0;
> >          cmd->finished =3D false;
> >          QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
> > -        cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_comman=
d));
> >      }
> >
> >      virtio_gpu_process_cmdq(g);
> >
>
> There are (at least) three styles:
>
> (1)
>
>     thing =3D get_next();
>     while (is_valid(thing)) {
>         ...
>         thing =3D get_next();
>     }
>
> (2)
>
>     while (true) {
>         thing =3D get_next();
>         if (!is_valid(thing)) {
>             break;
>         }
>         ...
>      }
>
> (3)
>
>     while (is_valid(thing =3D get_next())) {
>         ...
>     }
>
> My opinion:
>
> - If the get_next() invocation is simple, then style (1) is perfectly fin=
e.
>
> - Style (2) is the worst of all.
>
> - If style (1) is not appropriate for whatever reason, then style (3) is =
frequently a good replacement. Style (3) is sometimes rejected by coding st=
yle documents though. Style (3) is not usable if is_valid() is a function-l=
ike macro that does not evaluate its argument exactly once. Frequently, is_=
valid() is simply open-coded with C operators (using extra parens), for exa=
mple:
>
>     while ((cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_comma=
nd)))) {
>
> or more verbosely
>
>     while ((cmd =3D virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_comma=
nd))) !=3D
>            NULL) {
>
> If we really dislike style (1), then I'd propose style (3). I think the p=
resent patch (style (2)) is a step back.
>

I have no strong opinion about the style(2) and style(3), just don't
like the dup of style(1).

Anyway, let Gerd do the choice. AFAICS, the qemu uses a lot of
stype(2)  to populate virtio requests.

Thanks,
Li Qiang

> Just my opinion of course; I don't feel too strongly about this.
>
> Laszlo
>

