Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEBCC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A71024653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alP5P6tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A71024653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1vM-0005mj-Jt
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 17:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iu1ua-0004pQ-0D
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iu1uY-0007sF-RH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:22:15 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:46688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iu1uY-0007qG-ND
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:22:14 -0500
Received: by mail-io1-xd30.google.com with SMTP id t26so4502670ioi.13
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=eFep3UJ4UyYiPrs0hVfgv1tsJDoYzRGxYGMFL71huU4=;
 b=alP5P6tN7iucvSyzQlqLjC2oYEsCMuK9mV8EapvV5SwP7V/6eQqJWEmbsOoa0mfpgb
 vu7j7JudKOkb9NkJkKg60IpkFrVZxg1Sa77l0vLqbqxgWodGzHY7+MD0HdSsHSHUQRdh
 obk+h1hGaIaSHqDIFfb2y5KmSxH/zwZJL7crAZTkAlcAbOAcMfxRLPIz5gr7rEtWhsvE
 iRaqiVngqQ1GYuzywR1qX+V+ua5PpxVenRDGJo56b7HlcWZhscBe8bgbsa4TMMoYZJvB
 xiAoNv7pd6lMvk9bjdf1vfd0Xcl68SdNmVl8fYKtsral8Xvnt2uiSQdccl8C5Xw9WtZ0
 kWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=eFep3UJ4UyYiPrs0hVfgv1tsJDoYzRGxYGMFL71huU4=;
 b=e88P3o24Mh9o9o7H+uhc4VLCXbrZf2dvaxraukv1OqyDZavai17tQvImjzCNzBSBfv
 whaK7g5YUEoR4G013ld3T7vIkxJsW+vy7WXMJRAvBig7Mvptqw1MuHCO/wERywBdD6or
 TjjjZHF67oTGEcSpuZ8If4DsatY82sHnzt2DnnHEe0NKhvQrIZGXRp2BX8WSp3w6I7sU
 Q8GfwoC0PUyu/EQ5msqpYGne2AED87mmMYPZ3YVeYGzL/2CLoFlJFgeT+mqefqH/hhr9
 zJGkTd/Pcb8ynHqJBf7OFwXVjqcP9RUpFGhkJmztOZE8wpJJHmA5UKfSyM8ISauNuzOx
 dbzA==
X-Gm-Message-State: APjAAAVDRuizcvRGWycjxBGQ/L30Z5kOn9w8+qAse2Qz4mfjUfEmAvwX
 s7zH0Q4HfMi5zf4LEMwxEn4rQdrHC5bHStv4NNY=
X-Google-Smtp-Source: APXvYqz6oyKdw6ZzDKHBAt9Phv7KtFdgKwlrtxp5xTegJzylOSJAMrOc0lj6Qq4xW90K+nTdOuGkR4w15vugpcSRYnk=
X-Received: by 2002:a05:6638:81:: with SMTP id
 v1mr4984618jao.143.1579645333791; 
 Tue, 21 Jan 2020 14:22:13 -0800 (PST)
MIME-Version: 1.0
References: <CAMAD20n_9Xj6HqgYzB-_Ra71f=_YyS4WkAFJK6VExOA50Bfcjw@mail.gmail.com>
 <CAKmqyKNzFeWcNP7Stz5TnjzEysGt3pSe8qNvq4rTtM4guaLDTg@mail.gmail.com>
In-Reply-To: <CAKmqyKNzFeWcNP7Stz5TnjzEysGt3pSe8qNvq4rTtM4guaLDTg@mail.gmail.com>
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Wed, 22 Jan 2020 06:22:02 +0800
Message-ID: <CAMAD20nF6oxJSAv=Vfk9qpoczxB2L5amWGe03aRu8gAf32iuKA@mail.gmail.com>
Subject: Re: riscv: How to check floating point support is currently enabled?
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d30
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alistair Francis <alistair23@gmail.com> =E4=BA=8E2020=E5=B9=B41=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:50=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Jan 21, 2020 at 11:12 AM Ian Jiang <ianjiang.ict@gmail.com> wrote=
:
> >
> > The function riscv_cpu_fp_enabled() is used for checking whether floati=
ng point support is currently enabled. In fact it checks the FS field in th=
e mstatus MSR.
> >
> > target/riscv/cpu_helper.c
> >  76 bool riscv_cpu_fp_enabled(CPURISCVState *env)
> >  77 {
> >  78     if (env->mstatus & MSTATUS_FS) {
> >  79         return true;
> >  80     }
> >  81
> >  82     return false;
> >  83 }
> >
> > This will cause a problem that the SD bit in mstatus is not set to 1 wh=
en  FS in mstatus is modified from '00'b to '11'b with write_mstatus().
>
> Thanks for looking into this.
>
> There are patches on list fixing floating point errors. Can you check
> if this branch fixes any issues you have:
> https://github.com/palmer-dabbelt/qemu/commits/for-master

Yes, there is:
https://github.com/palmer-dabbelt/qemu/commit/82f014671cf057de51c4a577c9e2a=
d637dcec6f9
Thanks!

>
> >
> > file target/riscv/csr.c, func write_mstatus():
> > 350     dirty =3D (riscv_cpu_fp_enabled(env) &&
> > 351              ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS)) |
> > 352             ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
> > 353     mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
> > 354     env->mstatus =3D mstatus;
> >
> > So checking fields D and F in the misa MSR (bit 3 and bit 5) may be an =
better way. That is
> > bool riscv_cpu_fp_enabled(CPURISCVState *env)
> >     if (env->misa & (MISA_F | MISA_F) {
> >         return true;
> >     }
> >     return false;
> > }
>
> This doesn't seem right, just because the HW supports it doesn't mean
> it's enabled.

OK.

>
> Alistair
>
> >
> >
> > --
> > Ian Jiang

