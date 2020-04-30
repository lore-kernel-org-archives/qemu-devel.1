Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F4DC83002
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5C720757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtLxSEa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5C720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3dN-0006tX-IP
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jU3aV-0001vR-Tz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jU3aU-0003cF-N2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:26:27 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:35806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jU3aU-0003bd-7d; Thu, 30 Apr 2020 03:26:26 -0400
Received: by mail-lj1-x235.google.com with SMTP id g4so5379677ljl.2;
 Thu, 30 Apr 2020 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Blh+bXYzCm61tiI/O9Zciaud0yS5iEonxC4HBJB49kE=;
 b=UtLxSEa/W1kQ7XfiMiJuXGEmgV+KuwoDENH0SiqG/xBOn1fluhJxak0TVBAD/U/Vth
 +chnO8mG22gxerzn52lxH5eJybFvzgclu7lWrvUlWwWiYut8/TE7WvNK4ElSAEaotbNE
 GoXZHL9zdmBmyu1b4rMIx34kQBGeg5Vj1LRYSToD3cAvKgqKzSUjfY+oRkceO4siXn6f
 md7jAt7H4LblVd83mkjs5R9MNwjt1hz3WWv+dC0SMePlxRa4JMutejQAR7DOU5qL0wm5
 oYmrpC1yi6MWTKnPFhOY0csGgvfnEQRAxwnevk7wZRRhIhRPC3kkhO/rAdoz0xmtb5mc
 gWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Blh+bXYzCm61tiI/O9Zciaud0yS5iEonxC4HBJB49kE=;
 b=BMTORN7/avW0ZeMMwRX5K+j7duViZvuMBTFZihbcfZl36L9d0mV4g3aE0EryHNj16k
 7bMSximo9Mye+3I0dNTcYgx+Ryc/TZ9RoVPdC8gUPj36vxPaveVrEI7upEDS5iinrkDp
 wDi3MTd3sYIIPMtku2fCXh1waLslqn2jM8pc2cjMhx7nxGZTMa93VORPuIw1u+sEr86v
 wYaFeAacfbstdfFMMSoFyHssLy+K61Fd62TPgduJBq9wajKGOI9jBfUjOczoq2ltfj3y
 4AzkdZqHWlsoPF8QY5hGJRV00i8pJQ7p1i8kxCacgJzEKSWPALJF+bDtjwf7wRLy9M0j
 sqCA==
X-Gm-Message-State: AGi0Pua3hhtp4lvtna4Fp3tq8ngT103maUnQQSh2OCMSpLQCQ+0yyg5v
 Oxj2nWxw7l/uTpe2rXcF2AICTeDWxyRBulupInA=
X-Google-Smtp-Source: APiQypI5bjsy9CG+9krEu+yPM53Fh6bAT5A7WvMJnz//U8TFTb1f/g2jXrAlM0PrmR0Jq2z8Wq9e5tFHYfSoql1DU9w=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr1225753ljm.165.1588231583877; 
 Thu, 30 Apr 2020 00:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
In-Reply-To: <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 30 Apr 2020 15:26:11 +0800
Message-ID: <CAE2XoE-MM6AR8fmExnst7o9wL4Q_nZkw=gyemMJmZSdPd_ydmg@mail.gmail.com>
Subject: Re: R: R: About hardfloat in ppc
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000060cf7e05a47cfb68"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::235
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
Reply-To: luoyonggang@gmail.com
Cc: Dino Papararo <skizzato73@msn.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000060cf7e05a47cfb68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 10:18 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 4/29/20 5:20 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > Question, in hard-float, if we don't want to read the fp register.
> > for example: If we wanna compute c =3D a + b in fp32
> > if c =3D a + b In hard float
> > and if b1 =3D c - a in hard float
> > if b1 !=3D b at bitwise level, the we se the inexat to 1, otherwsie
> > we set inexat bit to 0? are this valid?
> >
> > we can also do it for a * b, a - b, a / b.
> >
>
> That does seem plausible, for all of the normal values for which we would
> apply
> the hard-float optimization anyway.  But we already check for the
> exceptional
> cases:
>
>     if (unlikely(f32_is_inf(ur))) {
>         s->float_exception_flags |=3D float_flag_overflow;
>     } else if (unlikely(fabsf(ur.h) <=3D FLT_MIN)) {
>         if (post =3D=3D NULL || post(ua, ub)) {
>             goto soft;
>         }
>     }
>
> I means remove of all thse  exceptional cases, and detecting float
exception by hard float operation.

>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000060cf7e05a47cfb68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 30, 2020 at 10:18 AM Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 4/29/20 5:20 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang=
 Luo) wrote:<br>
&gt; Question, in hard-float, if we don&#39;t want to read the fp register.=
<br>
&gt; for example: If we wanna compute c =3D a=C2=A0+ b in fp32<br>
&gt; if c =3D a=C2=A0+ b In hard float<br>
&gt; and if b1 =3D c - a in hard float<br>
&gt; if b1 !=3D b at bitwise level, the we se the=C2=A0inexat=C2=A0to 1, ot=
herwsie=C2=A0<br>
&gt; we set inexat=C2=A0bit to 0? are this valid?<br>
&gt; <br>
&gt; we can also do it for a * b, a - b, a / b.=C2=A0<br>
&gt; <br>
<br>
That does seem plausible, for all of the normal values for which we would a=
pply<br>
the hard-float optimization anyway.=C2=A0 But we already check for the exce=
ptional<br>
cases:<br>
<br>
=C2=A0 =C2=A0 if (unlikely(f32_is_inf(ur))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;float_exception_flags |=3D float_flag_ove=
rflow;<br>
=C2=A0 =C2=A0 } else if (unlikely(fabsf(ur.h) &lt;=3D FLT_MIN)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (post =3D=3D NULL || post(ua, ub)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto soft;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
<br></blockquote><div>I means remove of all thse=C2=A0 exceptional cases, a=
nd detecting float exception by hard float operation.=C2=A0=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000060cf7e05a47cfb68--

