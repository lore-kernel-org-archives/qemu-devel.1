Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EA8C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1A72054F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3v6nwnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1A72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJvRd-0005Th-HG
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 04:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJvQd-0004xh-4z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJvQa-0003tY-TX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:10:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iJvQa-0003rt-NR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:10:04 -0400
Received: by mail-oi1-x243.google.com with SMTP id t84so13020412oih.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=UWhMEtb8QXln0RTdqREfA2kOqvTC70sU7b8OgzgNbYo=;
 b=i3v6nwnkBxR+Ex2f8ff3wbBiB/E1JO2LPwMJbdN2x4kqw51TyCwBn6r+3jzC6Sy4gT
 POEo6DYzgplCDDlx8qcdoY+P2otcBsDNOk/PKMwrZgZ+kAYQtVjR1qKoCCzcjEWUN4Wg
 QQZPtLONA2mzU+uSOjkm633hT+lgsQdvxKulDoWRLVVzyRTrrOAjEkoGBqOUrci0YMS/
 XFRXgpbqI50JR8N9b9xVEkILXMe0PJkVUhaKiz+v1JbxZA67zmct0E8OVXVy6xVbt7ez
 urw1a0JReFPHJwno2lf7tbkzew7mefTfk+3BgWDJM6i3p0Y5LFBsqpFPnNviiZ1IivMu
 0zWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=UWhMEtb8QXln0RTdqREfA2kOqvTC70sU7b8OgzgNbYo=;
 b=DUuKyN6IrU54l2BCGGkgTtmZzEQBGrsJCt8ElxMjlWK8g4jniLnkAyfQAQbgE88t5W
 5fe/aHcVZJ+eZQQFfxKITYcpJ0hbWyoXcshD/pF4PZD5WrNU9ticQXXTw3siuR75K3XA
 8Ao0D1uwSs8ililvf65RrBDPuxXd8LQc/C/GzxwvXvRE+RsNlQnPKBu/kXSX7Ud5Gp88
 tEu5p6lLCvufKcbbkmutVTQc8yUU2XoAK2uHysYBV/PpCzgEJ0abTZN5z7slgMTSSELd
 2R9T+oCNtCtw+3zYmcEMsqFSR9XM8sI+MvZcRXaEXxxVJ1w1l+kHv5WUTDYKwVyw25fg
 TajA==
X-Gm-Message-State: APjAAAWbwoEV65vrinqVZ/ZUhIPNhLiurJRAlQjmF3zk4m1fpreGxZts
 jxdx4+b5MrAxdv5CxjSf35d4AmCLCvZUh8zKbwQ=
X-Google-Smtp-Source: APXvYqw1aq9J1jBc5cHWy/SqGgf7yiYlwSEqzlEJkvWQ8TpQvU6v5tkZE4vgmiiRs6SsCYakDu5xlL54VFf23fPT96E=
X-Received: by 2002:a54:460c:: with SMTP id p12mr23695625oip.62.1571040602353; 
 Mon, 14 Oct 2019 01:10:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 14 Oct 2019 01:10:01
 -0700 (PDT)
In-Reply-To: <87a7a36awg.fsf@dusky.pond.sub.org>
References: <1570991178-5511-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1570991178-5511-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <87a7a36awg.fsf@dusky.pond.sub.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 14 Oct 2019 10:10:01 +0200
Message-ID: <CAL1e-=gD629LfDPokJ6XAnR_xxE-vHw3RZqg=JDai-xAcJC0Dg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] target/mips: Clean up helper.c
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000007f6800594da656e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000007f6800594da656e
Content-Type: text/plain; charset="UTF-8"

On Monday, October 14, 2019, Markus Armbruster <armbru@redhat.com> wrote:

> Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:
>
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  target/mips/helper.c | 128 ++++++++++++++++++++++++++++++
> +--------------------
> >  1 file changed, 78 insertions(+), 50 deletions(-)
> >
> > diff --git a/target/mips/helper.c b/target/mips/helper.c
> > index a2b6459..2411a2c 100644
> > --- a/target/mips/helper.c
> > +++ b/target/mips/helper.c
> > @@ -39,8 +39,8 @@ enum {
> >  #if !defined(CONFIG_USER_ONLY)
> >
> >  /* no MMU emulation */
> > -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> > -                        target_ulong address, int rw, int access_type)
> > +int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> > +                       target_ulong address, int rw, int access_type)
> >  {
> >      *physical = address;
> >      *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> > @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr
> *physical, int *prot,
> >  }
> >
> >  /* fixed mapping MMU emulation */
> > -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int
> *prot,
> > -                           target_ulong address, int rw, int
> access_type)
> > +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int
> *prot,
> > +                          target_ulong address, int rw, int access_type)
> >  {
> >      if (address <= (int32_t)0x7FFFFFFFUL) {
> > -        if (!(env->CP0_Status & (1 << CP0St_ERL)))
> > +        if (!(env->CP0_Status & (1 << CP0St_ERL))) {
> >              *physical = address + 0x40000000UL;
> > -        else
> > +        } else {
> >              *physical = address;
> > -    } else if (address <= (int32_t)0xBFFFFFFFUL)
> > +        }
> > +    } else if (address <= (int32_t)0xBFFFFFFFUL) {
> >          *physical = address & 0x1FFFFFFF;
> > -    else
> > +    } else {
> >          *physical = address;
> > +    }
> >
> >      *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >      return TLBRET_MATCH;
> >  }
> >
> >  /* MIPS32/MIPS64 R4000-style MMU emulation */
> > -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> > -                     target_ulong address, int rw, int access_type)
> > +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> > +                    target_ulong address, int rw, int access_type)
> >  {
> >      uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
> >      int i;
> > @@ -99,8 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr
> *physical, int *prot,
> >              if (rw != MMU_DATA_STORE || (n ? tlb->D1 : tlb->D0)) {
> >                  *physical = tlb->PFN[n] | (address & (mask >> 1));
> >                  *prot = PAGE_READ;
> > -                if (n ? tlb->D1 : tlb->D0)
> > +                if (n ? tlb->D1 : tlb->D0) {
> >                      *prot |= PAGE_WRITE;
> > +                }
> >                  if (!(n ? tlb->XI1 : tlb->XI0)) {
> >                      *prot |= PAGE_EXEC;
> >                  }
> > @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool
> eu, int mmu_idx)
> >      int32_t adetlb_mask;
> >
> >      switch (mmu_idx) {
> > -    case 3 /* ERL */:
> > -        /* If EU is set, always unmapped */
> > +    case 3:
> > +        /*
> > +         * ERL
> > +         * If EU is set, always unmapped
> > +         */
> >          if (eu) {
> >              return 0;
> >          }
>
> This changes from the usual way we format switch case comments to an
> unusual way.
>
> If you want to pursue this change, please put it in a separate patch,
> so this one is really about fixing "errors and warnings reported by
> 'checkpatch.pl -f'", as your commit message promises.
>
>

Hi, Markus. Thank you for your response.

There must be some misunderstanding here:

The line:

   case 3 /* ERL */:

generates a checkpatch warning. I don't know why I would put it in a
separate patch, if this patch is about fixing checkpatch warnings. Please
explain.

Secondly, I don't see that this is a usual way we format switch statement.
I found just several cases in the whole QEMU code base (and you claimed in
previous comments that there are thousands).

I am just guessing that you somehow mixed this line with the line:

   case 3: /* ERL */

that would have not generated checkpatch warning.

I don't see any reason to change this patch. Please let me know it you
still think I should do something else. And you are welcome to analyse any
patches of mine.

Aleksandar


> [...]
>
>

--00000000000007f6800594da656e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 14, 2019, Markus Armbruster &lt;<a href=3D"mailt=
o:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.markovic=
@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; writes:<br>
<br>
&gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com=
">amarkovic@wavecomp.com</a>&gt;<br>
&gt;<br>
&gt; Mostly fix errors and warnings reported by &#39;<a href=3D"http://chec=
kpatch.pl" target=3D"_blank">checkpatch.pl</a> -f&#39;.<br>
&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wav=
ecomp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/mips/helper.c | 128 ++++++++++++++++++++++++++++++<wbr>+-=
-------------------<br>
&gt;=C2=A0 1 file changed, 78 insertions(+), 50 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/mips/helper.c b/target/mips/helper.c<br>
&gt; index a2b6459..2411a2c 100644<br>
&gt; --- a/target/mips/helper.c<br>
&gt; +++ b/target/mips/helper.c<br>
&gt; @@ -39,8 +39,8 @@ enum {<br>
&gt;=C2=A0 #if !defined(CONFIG_USER_ONLY)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* no MMU emulation */<br>
&gt; -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *pro=
t,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 target_ulong address, int rw, int access_type)<br>
&gt; +int no_mmu_map_address(<wbr>CPUMIPSState *env, hwaddr *physical, int =
*prot,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0target_ulong address, int rw, int access_type)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *physical =3D address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;<br>
&gt; @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr =
*physical, int *prot,<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* fixed mapping MMU emulation */<br>
&gt; -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *=
prot,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong address, int rw, int access_type)<=
br>
&gt; +int fixed_mmu_map_address(<wbr>CPUMIPSState *env, hwaddr *physical, i=
nt *prot,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 target_ulong address, int rw, int access_type)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (address &lt;=3D (int32_t)0x7FFFFFFFUL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &lt;&lt=
; CP0St_ERL)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &lt;&lt=
; CP0St_ERL))) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address =
+ 0x40000000UL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address;=
<br>
&gt; -=C2=A0 =C2=A0 } else if (address &lt;=3D (int32_t)0xBFFFFFFFUL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (address &lt;=3D (int32_t)0xBFFFFFFFUL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address &amp; 0x1FFFFF=
FF;<br>
&gt; -=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return TLBRET_MATCH;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* MIPS32/MIPS64 R4000-style MMU emulation */<br>
&gt; -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0target_ulong address, int rw, int access_type)<br>
&gt; +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 target_ulong address, int rw, int access_type)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint16_t ASID =3D env-&gt;CP0_EntryHi &amp; env-&g=
t;CP0_EntryHi_ASID_mask;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; @@ -99,8 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *phy=
sical, int *prot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rw !=3D MMU_DATA_S=
TORE || (n ? tlb-&gt;D1 : tlb-&gt;D0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physica=
l =3D tlb-&gt;PFN[n] | (address &amp; (mask &gt;&gt; 1));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *prot =
=3D PAGE_READ;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n ? tlb-&=
gt;D1 : tlb-&gt;D0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n ? tlb-&=
gt;D1 : tlb-&gt;D0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *prot |=3D PAGE_WRITE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(n =
? tlb-&gt;XI1 : tlb-&gt;XI0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *prot |=3D PAGE_EXEC;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool=
 eu, int mmu_idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int32_t adetlb_mask;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (mmu_idx) {<br>
&gt; -=C2=A0 =C2=A0 case 3 /* ERL */:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If EU is set, always unmapped */<br>
&gt; +=C2=A0 =C2=A0 case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERL<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If EU is set, always unmapped<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (eu) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This changes from the usual way we format switch case comments to an<br>
unusual way.<br>
<br>
If you want to pursue this change, please put it in a separate patch,<br>
so this one is really about fixing &quot;errors and warnings reported by<br=
>
&#39;<a href=3D"http://checkpatch.pl" target=3D"_blank">checkpatch.pl</a> -=
f&#39;&quot;, as your commit message promises.<br>
<br></blockquote><div><br></div><div><br></div><div>Hi, Markus. Thank you f=
or your response.</div><div><br></div><div>There must be some misunderstand=
ing here:</div><div><br></div><div>The line:</div><div><br></div><div>=C2=
=A0=C2=A0 case 3 /* ERL */:<br></div><div><br></div><div>generates a checkp=
atch warning. I don&#39;t know why I would put it in a separate patch, if t=
his patch is about fixing checkpatch warnings. Please explain.</div><div><b=
r></div><div>Secondly, I don&#39;t see that this is a usual way we format s=
witch statement. I found just several cases in the whole QEMU code base (an=
d you claimed in previous comments that there are thousands).</div><div><br=
></div><div>I am just guessing that you somehow mixed this line with the li=
ne:</div><div><br></div><div>=C2=A0 =C2=A0case 3: /* ERL */<br></div><div><=
br></div><div>that would have not generated checkpatch warning.</div><div><=
br></div><div>I don&#39;t see any reason to change this patch. Please let m=
e know it you still think I should do something else. And you are welcome t=
o analyse any patches of mine.</div><div><br></div><div>Aleksandar</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
[...]<br>
<br>
</blockquote>

--00000000000007f6800594da656e--

