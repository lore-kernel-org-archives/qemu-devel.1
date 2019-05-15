Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51FFC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1CF2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIYCzaP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1CF2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQr5Z-0003BJ-L2
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:24:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hQr4O-0002cd-UH
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hQr4N-0003j5-TT
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:23:32 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hQr4N-0003fy-NE
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:23:31 -0400
Received: by mail-ot1-x332.google.com with SMTP id c3so1759052otr.3
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=cEgmwfK51Q1Ba+5zStcZUA6pkbEUl9FMIXfkZaTlZpo=;
	b=KIYCzaP36AOcS8D1XSe6TDAhKWEAsLsMB4KaM30NQx9or9vKKM+zsuIdxFw9wMKLhg
	87iYpIcNY4P+TexgqaBRufbZu3JQQFs55lwIZBG3DLpbtxVj5TYGAnMO6sUII1xJLR72
	+EOCIwlvVUFST5YzkGywRDWTSE3SypvOkbNl611j30oHNPjwHhZFBdZJgDjzoKDk2U7A
	lnK25aDwCeyEYRWh33v7ZhSsfHRPD1cmru1f4MnjBXD0nLdD/WSttJucIFO1r/EB57RO
	WL49TkBqSHnCSA/CuNZUI0bvokGMPmPfquPZ6834su1fsKGB5+gLpbsKKT1b8gcb08e5
	ClCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=cEgmwfK51Q1Ba+5zStcZUA6pkbEUl9FMIXfkZaTlZpo=;
	b=bHOEgUtUM2d+kjAin/TZMKNu3DoiK/ES/1Eq+YzpkfIJITIw7XTyNsbslIz28LMLuQ
	2zoKwbDsdMRnbzuK8+qC1ppAawYxl6rR1LZuF0cR000U4AYtBA8iJgsQEtCQENvnt+x3
	JALH01nNORNcZaL7kbBcCirM+oEpfg957HlbBvXVGkCZyVgn21M6kTIqhBLNawtu7NaQ
	mdPKHaZ5hxFXplmnJGhWa7WAlI18g9us1xtUkboKGA3jNjVg6KLpB2L0CVncWcMuG+Ry
	A2jxyvwa6q0I0inkrwPaermDGvORIDRQo3dPQG+Sn/xndAsq2SaahZbSL7ar4NXKuUNi
	CNLw==
X-Gm-Message-State: APjAAAW4R9U9eyI64pcA+/ci5cJvSi6fu8sWStnvqIX3I7YbV+GeBvSY
	grKFIguj4eYMRWXAThLrAdq2b06fU0Kp99OzapQ=
X-Google-Smtp-Source: APXvYqwHOAiI0I+UKhI4fsHyrF0SRZD38KQHcCqmZt1UjXdSYIkkQgaZPzeh3SY8ttdU6kKaK7osuRG8otbfaEiFvf4=
X-Received: by 2002:a9d:7443:: with SMTP id p3mr17502297otk.72.1557915810623; 
	Wed, 15 May 2019 03:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6SKBgMcq+p7EB1kRWLSbg9NvZg1Mr24UrX8S+kpzq-GR4Q@mail.gmail.com>
	<c707e882-e194-355a-d96c-bfb00a8db247@redhat.com>
In-Reply-To: <c707e882-e194-355a-d96c-bfb00a8db247@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 May 2019 18:22:54 +0800
Message-ID: <CAKXe6SKetRL1uEww7wZeOCU5d8t+qrDDjzk3uBsQuhiQzt5S6w@mail.gmail.com>
To: Auger Eric <eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::332
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Question about the vfio device interrupt
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.williamson@redhat.com,
	Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Auger Eric <eric.auger@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:16=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On 5/15/19 12:01 PM, Li Qiang wrote:
> > Hello Paolo, Alex and all,
> >
> > In vfio_intx_enable_kvm(qemu) I see we associate a resamplefd with the
> > umask function(vfio_pci_intx_unmask_handler in linux).
> >
> >     irq_set =3D g_malloc0(argsz);
> >     irq_set->argsz =3D argsz;
> >     irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> VFIO_IRQ_SET_ACTION_UNMASK;
> >     irq_set->index =3D VFIO_PCI_INTX_IRQ_INDEX;
> >     irq_set->start =3D 0;
> >     irq_set->count =3D 1;
> >     pfd =3D (int32_t *)&irq_set->data;
> >
> >     *pfd =3D irqfd.resamplefd;
> >
> >     ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> >
> > I know this resamplefd is triggered when the interrupt controller
> receives
> > an EOI and
> > then we unmask and re-enabled the VFIO devices' interrupt.
> >
> > So I think there  there must be a mask process(so we unmask it later), =
I
> > mean there must a
> > call of function vfio_pci_set_intx_mask(in linux).
> >
> > What I can't understand is when this process(mask VFIO devices'
> interrupt)
> > occurs?
> It is done in the VFIO interrupt handler:
> vfio_intx_handler/disable_irq_nosync for VFIO PCI (vfio_pci_intrs.c) or
> vfio_automasked_irq_handler (vfio_platform_irq.c) for VFIO PLATFORM .
>
>
Thanks Eric,

Got it.
I just forget to look at the interrupt handler(vfio_intx_handler)!


Thanks,
Li Qiang



> Thanks
>
> Eric
>
> > I only find a place(vfio_basic_config_write) calls vfio_pci_intx_mask> =
I
> think when the guest process the interrupt it may mask this
> > interrupt(finally call vfio_pci_set_intx_mask), but I can't find the co=
de
> > path related with vfio_basic_config_write.
> >
> >
> > Any hints?
> >
> > Thanks,
> > Li Qiang
> >
>
