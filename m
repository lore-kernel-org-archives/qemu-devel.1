Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FF9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 02:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B77206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 02:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B77206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMMf5-00018a-B9
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 22:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jMMeU-0000iK-FC
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 22:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jMMeR-0007Pg-Su
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 22:10:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jMMeQ-0007PF-Q5
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 22:10:43 -0400
Received: by mail-io1-f65.google.com with SMTP id f3so2340439ioj.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 19:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=txBN6c9y45hiNoUHbDgNuAN71/Bb2u7MuJtMIjOd4bI=;
 b=qalATGYaz61qva0/utxEY/reXk7rTbFBXc/zog5aD/y+7FS2oa4yUhrKBzGRioq10x
 lAQzgrxAKsOZekXm3t7v9c646hIamlHy3bnu79geQiDuTpBUE55Ew/ain/HuZlFLskOo
 aU5rVE2eMcKguS9NPsgiObHNj/vVz+o1/1nK1rEzJdZ/e4kGGNc1s6v+yBLYKJRW0dTJ
 HpQapOseX5q4lMFLXrISGnhToLvK5sgnvBrqkD4Dr0RNG3xp6JeZextpAG60mgZ9GEvs
 1axF1TQSaxoD7Cm5lxBCDbKNTd6ccqs+u6iSqqiwn3Q5xs41WqjCLL30TIM1JO2ixGE3
 ZqlQ==
X-Gm-Message-State: AGi0PuY05jg6u3a5jfXyRkZ5Wu413FQmABdP8TArBsOVv6yVjd3avf4O
 n0P+zNWrZ6vzVyt0/i+csKijk45w4152NGFAUfo=
X-Google-Smtp-Source: APiQypKS32yyeojtKXClBTDifoUDnn+IV7HBdtFsSyfDrgny1zHLrRgYfZA5bfvTDbHZFMnnOc+vPSkStyDf4d5GMyA=
X-Received: by 2002:a6b:6c01:: with SMTP id a1mr10001969ioh.196.1586398242027; 
 Wed, 08 Apr 2020 19:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-3-git-send-email-chenhc@lemote.com>
 <CAHiYmc61GZSvvwhCaC0B5q0GrEUN3CevDvNTEEWLE9PCJqVbvw@mail.gmail.com>
In-Reply-To: <CAHiYmc61GZSvvwhCaC0B5q0GrEUN3CevDvNTEEWLE9PCJqVbvw@mail.gmail.com>
From: Huacai Chen <chenhc@lemote.com>
Date: Thu, 9 Apr 2020 10:17:46 +0800
Message-ID: <CAAhV-H5moZ8kD5WAM1GvLRmg9spO7m=2DZZL+uUXAoo4iWZyVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as fulong2e co-maintainer
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.166.65
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Wed, Apr 8, 2020 at 11:30 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> 11:08 Sre, 08.04.2020. Huacai Chen <chenhc@lemote.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > I submitted the MIPS/fulong2e support about ten years ago, and after
> > that I became a MIPS kernel developer. Last year, Philippe Mathieu-
> > Daud=C3=A9 asked me that whether I can be a reviewer of MIPS/fulong2e, =
and I
> > promised that I will do some QEMU work in the next year (i.e., 2020 and
> > later). I think now (and also in future) I can have some spare time, so
> > I can finally do some real work on QEMU/MIPS. And if possible, I hope I
> > can be a co-maintainer of MIPS/fulong2e.
> >
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 642c8e0..3281ff2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c
> >  Fulong 2E
> >  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > +M: Huacai Chen <chenhc@lemote.com>
> >  S: Odd Fixes
> >  F: hw/mips/mips_fulong2e.c
> >  F: hw/isa/vt82c686.c
> > --
> > 2.7.0
> >
>
> First of all, I want to express great pleasure and delight seing your ser=
ies, and this patch in particular.
>
> A warm welcome to QEMU developers communities!
>
> We are currenyly very busy preparing QEMU 5.0 release, and additionaly, E=
aster holidays are in next few days or week (different parts od Christian w=
orld have different calendars), so, fot thay and other reasons, don't expec=
t promot replies from us.
>
> I would also like to see Jiaxng at least having official reviewer status,=
 but, of course, only if he wants that.
Thank you for your best wishes, I'm also very glad to see Jiaxun be an revi=
ewer.

Regards,
Huacai
>
> Yours,
> and wishing you and all people from China best health!
>
> Aleksandar

