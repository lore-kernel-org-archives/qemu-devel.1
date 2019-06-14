Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21863C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E257E20851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZUPl+O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E257E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbfPO-0000k1-6j
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 02:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51105)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbfOu-0000IZ-BC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbfOt-0002vM-1U
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:09:24 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hbfOs-0002v1-PL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:09:22 -0400
Received: by mail-oi1-x244.google.com with SMTP id q186so1166390oia.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=/7QEfr0z5fhgFoHiF6fj/6MO50l2+10grnsg0/HpydM=;
 b=oZUPl+O6n78EEhrWedKIrt/DMslTp83zO0NDXY66hPDPyD300o9s/GRasrccnXAA8A
 PVWCYkmQPNRqqJJL3ALfyyimtCDH4DIOUFb9fbyALC/jqFXdwBmE9LaVTbiu5+U639ZX
 oOj+nPKJIvUb/+CkMD7Rz8qpftL+4fh2igQ9A3O2OKoryewH0IbY2CECwNmy8od7TV3x
 +WY9YKpQeSWg56PW+l6//yL/7BBZ5eLEdEN88t48jS+7EYw1CKeTL7ryexp2OlbfoJEL
 4G+UiL0Dx3Sq1QC0O8W/KTZ+mDfx//lbx+tlIKVQ4q6EqwBwMXdQC6w379w/3aEhaRmo
 zzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=/7QEfr0z5fhgFoHiF6fj/6MO50l2+10grnsg0/HpydM=;
 b=b6bcksM3uHNsrTFedOKFvcdcQKB9dWoZK+0f+xCSeo/JVF9i784cxCb18b+G2r2q0V
 tMC6bKnAcfGTBEZ1Wau5h2Wiz8kjiJDvsYpXPS/dvCh5mnr4fB/dNDXeEDuOMO6nS0f3
 TWcOGz26/EkPbzqR7rMTmTtXOZVt9vhDgebDLINOKvujR0l7+L2LwRp7GM6QP7btMloU
 6t9afdvm3sGwpzCcM3f4niXECrqIttj0sqkESXfE2WLxgRv7VjaO7S1sKXoiMryyZj4v
 6TBHyh6eLzyzQ4mqUkxhTSAfFAU7UKb//RLaEKOrDc8kSb78iBPXR7RD1mgnQ3O9/Qaa
 l1pA==
X-Gm-Message-State: APjAAAWPneIPYVr/0RIyjtQdKuQitW+iKatDXJtqKEBX9GTPykaqvxN/
 PBZPcZ6L5rhIuxaRYAOFuli3lBQx3qleLmj300g=
X-Google-Smtp-Source: APXvYqzqAtkesAr6NLJx9CUtVMN/95EJqSdGPTDqcP4rNim8hVwnjm+MLWqE0horXpECLxS7LI+kePp0I6qmE/VgiMI=
X-Received: by 2002:aca:310a:: with SMTP id x10mr839853oix.62.1560492561889;
 Thu, 13 Jun 2019 23:09:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 23:09:21
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 23:09:21
 -0700 (PDT)
In-Reply-To: <CAL1e-=hQG9roHkg5vf364_A5eit1McpwWAuHYj5Sqaz=KVzK3Q@mail.gmail.com>
References: <20190613041619.32102-1-richard.henderson@linaro.org>
 <20190613041619.32102-2-richard.henderson@linaro.org>
 <CAL1e-=iHb5khAaQeV1za8SnW=9O8mP-xg=t2Eaw818Yc9zdPPw@mail.gmail.com>
 <CAL1e-=hQG9roHkg5vf364_A5eit1McpwWAuHYj5Sqaz=KVzK3Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 14 Jun 2019 08:09:21 +0200
Message-ID: <CAL1e-=j5i4hG07svv9Ponnk77LZCy5cWT-AnChwKyStzXqVCMA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/1] tcg: Fix typos in helper_gvec_sar{8, 32,
 64}v
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 14, 2019 8:03 AM, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com=
>
wrote:
>
>
> On Jun 14, 2019 7:22 AM, "Aleksandar Markovic" <
aleksandar.m.mail@gmail.com> wrote:
> >
> >
> > On Jun 13, 2019 6:16 AM, "Richard Henderson" <
richard.henderson@linaro.org> wrote:
> > >
>
> I just noticed that this patch is already applied to the upstream - no
pull request, no waiting time for community review -
>

Peter, would you please explain to me what was going on with this patch? I
am truly confused, since all rules and procedures seem to be somehow
circumvented, don't they?

Yours,
Aleksandar

> > > The loop is written with scalars, not vectors.
> > > Use the correct type when incrementing.
> > >
> > > Fixes: 5ee5c14cacd
> > > Reported-by: Laurent Vivier <lvivier@redhat.com>
> > > Tested-by: Laurent Vivier <lvivier@redhat.com>
> > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > ---
> >
> > This is certainly not a case of =E2=80=9Ctypo=E2=80=9D (which would mea=
n that you
accidentally typed =E2=80=9Cvec8=E2=80=9D instead od =E2=80=9Cint8_t=E2=80=
=9D). So, change the title to
=E2=80=9Ctcg: Fix loop step in
> > helper_gvec_sar{8, 32, 64}v=E2=80=9D or similar.
> >
> > >  accel/tcg/tcg-runtime-gvec.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/accel/tcg/tcg-runtime-gvec.c
b/accel/tcg/tcg-runtime-gvec.c
> > > index 3b6052fe97..51cb29ca79 100644
> > > --- a/accel/tcg/tcg-runtime-gvec.c
> > > +++ b/accel/tcg/tcg-runtime-gvec.c
> > > @@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void
*b, uint32_t desc)
> > >      intptr_t oprsz =3D simd_oprsz(desc);
> > >      intptr_t i;
> > >
> > > -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec8)) {
> > > +    for (i =3D 0; i < oprsz; i +=3D sizeof(int8_t)) {
> > >          uint8_t sh =3D *(uint8_t *)(b + i) & 7;
> > >          *(int8_t *)(d + i) =3D *(int8_t *)(a + i) >> sh;
> > >      }
> > > @@ -898,7 +898,7 @@ void HELPER(gvec_sar32v)(void *d, void *a, void
*b, uint32_t desc)
> > >      intptr_t oprsz =3D simd_oprsz(desc);
> > >      intptr_t i;
> > >
> > > -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec32)) {
> > > +    for (i =3D 0; i < oprsz; i +=3D sizeof(int32_t)) {
> > >          uint8_t sh =3D *(uint32_t *)(b + i) & 31;
> > >          *(int32_t *)(d + i) =3D *(int32_t *)(a + i) >> sh;
> > >      }
> > > @@ -910,7 +910,7 @@ void HELPER(gvec_sar64v)(void *d, void *a, void
*b, uint32_t desc)
> > >      intptr_t oprsz =3D simd_oprsz(desc);
> > >      intptr_t i;
> > >
> > > -    for (i =3D 0; i < oprsz; i +=3D sizeof(vec64)) {
> > > +    for (i =3D 0; i < oprsz; i +=3D sizeof(int64_t)) {
> > >          uint8_t sh =3D *(uint64_t *)(b + i) & 63;
> > >          *(int64_t *)(d + i) =3D *(int64_t *)(a + i) >> sh;
> > >      }
> > > --
> > > 2.17.1
> > >
> > >
