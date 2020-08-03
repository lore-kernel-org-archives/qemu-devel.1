Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF4AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99EC2206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQy4EnOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EC2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2aG3-00005u-NU
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k2aFS-0007n1-Q6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:11:26 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k2aFR-0002Op-4W
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:11:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id b22so7231194oic.8
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xMGwUCBLAzCk8gnEvQK7mFHvwtkksyn++Rzj8tcAbSw=;
 b=pQy4EnObiWveBKJFM+QNlCImDBozQPzfEHifgyb3y0LVPMRHXyFwwN+E49ynGl5uB/
 JfjPVBb9uq9JPhk4L8gqcHtoTJE1QVTL7EvtzLKhdy4IzgHhvNrFgAGTY5uAC9OurSAK
 DtXG6IHr1LcIV3xgEPUDnMQ+baPP0BVQCU6l2u5T+EyuhT3MXKJAyYD8hoONAjSK4T5a
 3aCaakAj86ICO5/oAnAh1ywQZp5h9mKrwRJB/zJcYQNHrFhEBMAXFkHj6KD/zFkUOq3W
 3gICB4iGPZdiMOD6cVT2T4c2X05iF9GzUuHEqalgbqaHePMLQ5wivQjgFrsMdOpF5lGP
 Ccww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xMGwUCBLAzCk8gnEvQK7mFHvwtkksyn++Rzj8tcAbSw=;
 b=g8yeU1pbmjJq/oxjjPjtEggtVgIktI3iuXuA1bBqZe2q/jSiDk5WbDJDgbpIkbDVFq
 je3v135PxQgBsiXUOas7HU1IOIfen5GwiNU0lo0AzCRC9Xbs7cbHxN+Tjbr1ESiOMOiA
 SM9sJfXqm+M4KzVgYqFIKA8F/T++QHqS6AcjD324ORwB0PzpvHU3kEaGXjyMPtF6E2RT
 RmOpLxQSG8Z9Jo8xFgNGEoudtaj5uzz9mp/YZAUe1I90r3WPsx5Ll2kchSDaSpEtI4px
 KbqkEbZqjg4LDGKLE+BwL4fwlwSswcEEqSfzu/GMpF4uNdROz60rBtvxOBwC3o18or1p
 WgyQ==
X-Gm-Message-State: AOAM531FEvtr4nTnJrOXkSJy32tBW9OKza8vJ4xeKL0R7GkTXM7/rCdX
 0TjBxPCeZAyabCnF4tQ2hzUH+7C5KKMljNnlRN4=
X-Google-Smtp-Source: ABdhPJzeQyFB1XyUaBSgeqF1gRA/caZ7UZMXpgUcODChSe9PDnmMW3ZZOOdAluM86bWN5bSazPWyLeyH+CtHDPcmuTo=
X-Received: by 2002:aca:fd46:: with SMTP id b67mr12228775oii.150.1596460281769; 
 Mon, 03 Aug 2020 06:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <159548011952.31456.8249433335836304327.malonedeb@chaenomeles.canonical.com>
 <20200723153726.m6eckrxwkoooreh3@mozz.bu.edu>
 <20200803065604.lvvplrxwc5yomwl7@sirius.home.kraxel.org>
In-Reply-To: <20200803065604.lvvplrxwc5yomwl7@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 3 Aug 2020 21:10:45 +0800
Message-ID: <CAKXe6SLj1hkUUOOjCMinjbS27dJd9Ogzv=ON7LPmhd6S+qHBFQ@mail.gmail.com>
Subject: Re: [Bug 1888606] [NEW] Heap-use-after-free in
 virtio_gpu_ctrl_response
To: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 Bug 1888606 <1888606@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=882:57=E5=86=99=E9=81=93=EF=BC=9A
>
>   Hi,
>
> > > The ASAN trace:
> > > =3D=3D29798=3D=3DERROR: AddressSanitizer: heap-use-after-free on addr=
ess 0x60d0000050e8 at pc 0x560629814761 bp 0x7ffe916eb1e0 sp 0x7ffe916eb1d8
> > > READ of size 8 at 0x60d0000050e8 thread T0
> > >     #0 0x560629814760 in virtio_gpu_ctrl_response /home/alxndr/Develo=
pment/qemu/hw/display/virtio-gpu.c:181:42
> > >     #4 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/ut=
il/async.c:164:13
>
> > >     #1 0x560629827730 in virtio_gpu_reset /home/alxndr/Development/qe=
mu/hw/display/virtio-gpu.c:1160:9
>
> So it looks like the bottom half accesses stuff released by reset.
>
> Guess the reset should cancel any scheduled bh calls to avoid that ...
>

Gerd, the root case is we do DMA to MMIO. Following happens

1. bh -> virtio_gpu_handle_ctrl
here we alloc 'cmd'

2. Next, virtio_gpu_handle_ctrl...->virtqueue_push->...write virtio
used ring(but here we write to the virtio-gpu's MMIO
and then we go virtio_gpu_reset).
In the virtio_gpu_reset, we free the 'cmd'

3. In the 'virtio_gpu_ctrl_response', we use the 'cmd' again after
'virtqueue_push'
But the 'cmd' has been freed in step two.

So the root cause is the DMA do write to MMIO.
This is a general issue we have discussed in the e1000e case.

We still don't think out a solution for this.

Thanks,
Li Qiang

> Does the patch below help?
>
> thanks,
>   Gerd
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f0dd7c15002..18f0011b5a0a 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1144,6 +1144,9 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
>      struct virtio_gpu_simple_resource *res, *tmp;
>      struct virtio_gpu_ctrl_command *cmd;
>
> +    qemu_bh_cancel(g->ctrl_bh);
> +    qemu_bh_cancel(g->cursor_bh);
> +
>  #ifdef CONFIG_VIRGL
>      if (g->parent_obj.use_virgl_renderer) {
>          virtio_gpu_virgl_reset(g);
>
>

