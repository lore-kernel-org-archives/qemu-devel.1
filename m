Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A67DC3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 07:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4400621743
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 07:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYeGpuLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4400621743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hytYI-0004Lj-BV
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 03:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hytXK-0003oW-MY
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hytXJ-0000Tv-5i
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:54:06 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hytXF-0000Pj-W0; Sat, 17 Aug 2019 03:54:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id j7so11680634ota.9;
 Sat, 17 Aug 2019 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QducGt1kiXEU2n2Hi+Oiq8/yIY3AymjRQGsbtdusS8g=;
 b=CYeGpuLqOsnHzMeNFyWdEJwt1ilREaSXAAISvi8UyQMDu/dKLnp/z5jpVtTEhzmv+f
 2pkwX0icHawGiSQYczgNPAgy52eOS0plp0BqDmh5ZDvlobqmTCMLd3Qoo84fRWxDG6nP
 t4c7HcogNE8jMKgZxxiPQGzn41Ov+ccZ+iF3UkatbJay+Lc4sbRyXmL2BZ2rQHplc5JZ
 M4H/FWjcEwFf02Cmt/PLMfJjyPDNEnhjK2ocn7/0+UQzyQf2WTiKVQKsMZvcBvfA8tQh
 llL1FpaTdljf6wkRi7Ik1k0E1fw7/d0z8RM5e4vBg9V52Qz0UR6rdPkfQ3yVPrtX8EOb
 Xnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QducGt1kiXEU2n2Hi+Oiq8/yIY3AymjRQGsbtdusS8g=;
 b=TazlRvlB3vueBiq4jiT0NzLmaHZpMH1ddyq4sYTR7nNpn6puqcp8oE7zXwlhi2xvq/
 KC8ZW0roXrSEcD7CFqXNig7d9sIPwRs94/Y6uAzUdZKb4dER2bWIUkBiJYfMo7UiVlxt
 FAgcqQw11pWrXr9g8I5yfyEPmI/5W/nWIkSgAr5VTPh0NSmABBBRHJ9OP6TVEHweSxL7
 pvvAICVa7G9y7ZKWrET8QxWAZ/L92zxVbhyz6gBDVvPRyif68J4kxmkeoZ0yRBe3HX0U
 krqthp6Es++1rV4jzmEUpj8ZCYszUQEmgT7ZSmakvcmv4LAip68LvmPnEumgwBhAfntc
 hpHw==
X-Gm-Message-State: APjAAAUnasX9GY9Mh6zmpySwYPM2Dgvffwnsc2gkhDMuCDSmxEn9pBEw
 w0nYqQ+XaK7Cth0dYZSlk9ZmFtJhaY1fWLdx/Zo4lQ==
X-Google-Smtp-Source: APXvYqznTo9rcMBPmOismr5eGLQP28CaRRXpKCD86+08jPFPeod1+DtloQfbw2yUZClEgrcltZHXK2dDwlzlIiEllLU=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr9842611oti.121.1566028440281; 
 Sat, 17 Aug 2019 00:54:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Sat, 17 Aug 2019 00:53:59
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Sat, 17 Aug 2019 00:53:59
 -0700 (PDT)
In-Reply-To: <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 17 Aug 2019 09:53:59 +0200
Message-ID: <CAL1e-=hAcMMQMP4ecW_AW_3UM1yCjRE+P7QN3ytn2JaZeTFxUg@mail.gmail.com>
To: "Paul A. Clarke" <pc@us.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.08.2019. 00.59, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 16.08.2019. 21.28, "Paul A. Clarke" <pc@us.ibm.com> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > From: "Paul A. Clarke" <pc@us.ibm.com>
> >
> > - target/ppc/fpu_helper.c:
> >   - helper_todouble() was not properly converting INFINITY from 32 bit
> >   float to 64 bit double.
> >   - helper_todouble() was not properly converting any denormalized
> >   32 bit float to 64 bit double.
> >
> > - GCC, as of version 8 or so, takes advantage of the hardware's
> >   implementation of the xscvdpspn instruction to optimize the following
> >   sequence:
> >     xscvdpspn vs0,vs1
> >     mffprwz   r8,f0
> >   ISA 3.0B has xscvdpspn leaving its result in word 1 of the target
register,
> >   and mffprwz expecting its input to come from word 0 of the source
register.
> >   This sequence fails with QEMU, as a shift is required between those
two
> >   instructions.  However, the hardware splats the result to both word 0
and
> >   word 1 of its output register, so the shift is not necessary.
> >   Expect a future revision of the ISA to specify this behavior.
> >
>
> Hmmm... Isn't this a gcc bug (using undocumented hardware feature), given
everything you said here?
>

Paul, you are touching here a very sensitive area. If I were you, I would
most likely propose a similar patch, given thr info you presented. However,
in general, QEMU is a compiler-agnostic tool and should not depend on
compiler features, let alone fix its bugs, and therefore I think you should
more clearly spell out in your commit message that the code segment in
question is a workaround for an outright GCC bug, and just a kind of
"necessary evil" in given situation.

Let us also wait for David possibly coming up with the final verdict wrt
this issue.

Also, this patch should be split into two or three (infinity conversions
have nothing to do with xscvdpspn) - a patch deals with only one logical
unit.

Yours,
Aleksandar

> Sincerely,
> Aleksandar
>
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > ---
> >  target/ppc/fpu_helper.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> > index 5611cf0..82b5425 100644
> > --- a/target/ppc/fpu_helper.c
> > +++ b/target/ppc/fpu_helper.c
> > @@ -62,13 +62,14 @@ uint64_t helper_todouble(uint32_t arg)
> >          ret  =3D (uint64_t)extract32(arg, 30, 2) << 62;
> >          ret |=3D ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
> >          ret |=3D (uint64_t)extract32(arg, 0, 30) << 29;
> > +        ret |=3D (0x7ffULL * (extract32(arg, 23, 8) =3D=3D 0xff)) << 5=
2;
> >      } else {
> >          /* Zero or Denormalized operand.  */
> >          ret =3D (uint64_t)extract32(arg, 31, 1) << 63;
> >          if (unlikely(abs_arg !=3D 0)) {
> >              /* Denormalized operand.  */
> >              int shift =3D clz32(abs_arg) - 9;
> > -            int exp =3D -126 - shift + 1023;
> > +            int exp =3D -127 - shift + 1023;
> >              ret |=3D (uint64_t)exp << 52;
> >              ret |=3D abs_arg << (shift + 29);
> >          }
> > @@ -2871,10 +2872,14 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t
opcode,
> >
> >  uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
> >  {
> > +    uint64_t result;
> > +
> >      float_status tstat =3D env->fp_status;
> >      set_float_exception_flags(0, &tstat);
> >
> > -    return (uint64_t)float64_to_float32(xb, &tstat) << 32;
> > +    result =3D (uint64_t)float64_to_float32(xb, &tstat);
> > +    /* hardware replicates result to both words of the doubleword
result.  */
> > +    return (result << 32) | result;
> >  }
> >
> >  uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
> > --
> > 1.8.3.1
> >
> >
