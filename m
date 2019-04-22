Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6757C10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9112075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS1pIiqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9112075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hINgd-0006iW-R2
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 21:23:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINfu-0006Pr-J4
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINft-0004XS-F4
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:23:14 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:35800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hINft-0004Wu-9r
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:23:13 -0400
Received: by mail-oi1-x22b.google.com with SMTP id j132so7474011oib.2
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=k4nJxvQQRhp+S76oLNJNlWo03RNG09QNa8z25mzpgjU=;
	b=nS1pIiqh8nH7YrLcenAHAgQxWBeEu7P9e8/q1+xcFyMo7Arq0FXBAELE0R+MEnNLzv
	vvULmcqo4UZwJeIIdLs6WJUFTl/MaxfCpZx+R65vt9njnbBflFQHT4OlBQOBodpBRuD8
	Hy/RTt6RPshYv+huqe74RCPRRdXaZT697au7YNEyebbVbLUcG0nmDEVsWSEsZGtGJQPf
	ABdCoKSiVmDtP1q5huDB9Mkm9GkGE6urE8xSFBs/hScdxR6qehlw9DEMF0UAwXq0AMmc
	QF9lhSq2jaOy3nJwXA22M8fuKwdlXxapmVp+BU8OkrkEvs8A05G+ALOOB/S8+2kBemql
	/UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=k4nJxvQQRhp+S76oLNJNlWo03RNG09QNa8z25mzpgjU=;
	b=JSAR/Q/psMWh9L7F4poWSPSTELO3KSPxSvTqeVAJ/mx8O/qFdkV2aLArgiRjr6sqo0
	HvSwzrv/sYS3MuGXwzUYWYPpcyT2pUCcY0SYZuQDrQBe3mvP5ClGytCAoSdgInYznUr5
	/uSs9OuBdNBHqPoW3dSKo4zetHpoTGYy2N3rSWnyIUVcMvBUQKc3UTs/dr/oNLdq3EDx
	wKg8IvGMfFO3oG+7HD5uzcvusVLz6h+cgAI6dZmrpQAmllE8AFzaSB9PK2Uu4Oc9fWGE
	SECYBFXtQQUkRgSo7NTn6y8r3hX46J2z+ubBAzPUqT4pp/efdt5JAn8fc40hqQMNUxtB
	QhCw==
X-Gm-Message-State: APjAAAV9qqF6TlJj8fT8LZKCSYAHUgfKFaGy00WnTPGeQWZXPxBEpAL9
	y1xe5fvlkkL2sWr7Yf4T/+A7S70ToBAERK6dI34=
X-Google-Smtp-Source: APXvYqyNz9F3By2BhlMSG5VFABJa4qsC1Kz/eIvwSSgrIQW0jDeZa40VjUI7D6kavS96HFqxS2o2kJl5DV4TR8iL0Kk=
X-Received: by 2002:aca:e18b:: with SMTP id y133mr9213062oig.157.1555896192131;
	Sun, 21 Apr 2019 18:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-3-liq3ea@163.com>
	<51d2ae28-267a-2710-8401-bad769e2d2c0@redhat.com>
In-Reply-To: <51d2ae28-267a-2710-8401-bad769e2d2c0@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 22 Apr 2019 09:22:35 +0800
Message-ID:
 <CAKXe6SJLyUwLOQhmkoWENwLE-bFrVmUYxbRgh7pmYKtS5C9d8A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/3] edu: mmio: allow mmio read dispatch
 accept 8 bytes
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
Cc: Jiri Slaby <jslaby@suse.cz>, Li Qiang <liq3ea@163.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422012235.2DFz9fJrcv6fgnqrWQqoWjVYRA2o6mlpzeXgacL6Ing@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:44=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Li,
>
> On 4/20/19 6:14 PM, Li Qiang wrote:
> > The edu spec said when address >=3D 0x80, the MMIO area can
>
> "says"
>
> > be accessed by 8 bytes.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/misc/edu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> > index 65fc32b928..4018dddcb8 100644
> > --- a/hw/misc/edu.c
> > +++ b/hw/misc/edu.c
> > @@ -189,6 +189,10 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr
> addr, unsigned size)
>
> Completing the diff ...:
>
>        if (size !=3D 4) {
>
> >          return val;
> >      }
> >
> > +    if (addr >=3D 0x80 && size !=3D 4 && size !=3D 8) {
>
> ... to show this code is unreachable for size =3D=3D 8.
>
>
Ohhh, yes



> > +        return val;
> > +    }
> > +
> >      switch (addr) {
> >      case 0x00:
> >          val =3D 0x010000edu;
> >
>
> I think the change you wanted is:
>
> -- >8 --
> @@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr
> addr, unsigned size)
>      EduState *edu =3D opaque;
>      uint64_t val =3D ~0ULL;
>
> -    if (size !=3D 4) {
> +    if (addr < 0x80 && size !=3D 4) {
> +        return val;
> +    }
> +
> +    if (addr >=3D 0x80 && size !=3D 4 && size !=3D 8) {
>          return val;
>      }
>
>

Yes, this is what I want. Thanks, will change to this in next revision.

Thanks,
Li Qiang



> ---
>
> Another cleaner way to solve this is use 2 MemoryRegionOps, one for the
> first 0x80 addresses and another for the rest.
>
> Regards,
>
> Phil.
>
