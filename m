Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A9AC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0A62073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt4y9kVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0A62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4LK-0002Jc-Fl
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jU4KL-0001gc-UW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jU4KK-0004NL-LM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:13:49 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:44922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jU4KK-0004HH-5p; Thu, 30 Apr 2020 04:13:48 -0400
Received: by mail-lf1-x131.google.com with SMTP id d25so446913lfi.11;
 Thu, 30 Apr 2020 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=AnNn1Bqlm/DOgFmSH5FiHbVy71H2eedKWrlRue9i1Xk=;
 b=Gt4y9kVkmw7gUNT4BOqjqa8sOAKUBxHpV0dOzWltjPSCo6CCNJCiRZGS0ScL7H4CQ3
 zSKBTbX0MapCtS7FISnsT7sk7iWEJhNjNgLHfDAPBUpoliYNOjLA2yOiM4Ns5ADdYYtk
 xaCf7IllmEHcZtGvGr++DJWRx4w4xpMaVVoyfju8PHr5Hg9BlHQ1K/NI43KzWnidyOCk
 jjj2et9cF+w637LbI495W6vMjH/u+aM7NNLGcxzEzpbfOEzQ/9xL6eSZW1htXByFFsMI
 JDjfXrHJA2qAb8vbcuLc8iiDbJnboePoqF7hcMOeOgmKGVXPhnfKMaL/8PDLyNCFnvQg
 02ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=AnNn1Bqlm/DOgFmSH5FiHbVy71H2eedKWrlRue9i1Xk=;
 b=RAJJ86Um2a4lBGQuTEPfchNpVSFS8Kmh+MQRysf0uPr99bo7bXsrel5ec5Z/+goy9U
 fO2sIExm3kbd3jKwsF+b6bz9dfwf6EhiscSOzryhNKweoJ0CKqyIWfSd6FWgByly0QLZ
 4bvQp+GVaDn9ftF/HRT6aFSV3Hr//+iXmHnYOW651mpuFYw6WSWKWLt73tbHtJva5UqS
 8JvdK6oD5f6da9ZN0OMjDvwVnbqfy5XC2q9fstq2sg6XnywOvlK1nUG9DRxcDKDXQY7W
 aY+a5n15yIqnDl+y5fFKNuYhLsL2rNsWNH5xat7k+pV3SwY48KkgXQelvD/lvweSSMoM
 Tckg==
X-Gm-Message-State: AGi0PuYMpBsZNpP3WOpSYtJawhXdx2xfxgXMY5NrqxziKnIlV7pvh2Da
 by7V0DWe3o94D/WlavwbkNGe7zYM1mmAOShRyQ8=
X-Google-Smtp-Source: APiQypKuN4Bv4pYUaXuF0qqb/FgFg2QgpwTBtEti/UygVd31aNXlL30YF7UV/cCql2Z+ZOj0Mheh8nEgKmpz/uD0Crk=
X-Received: by 2002:a19:5206:: with SMTP id m6mr1328687lfb.33.1588234425799;
 Thu, 30 Apr 2020 01:13:45 -0700 (PDT)
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
Date: Thu, 30 Apr 2020 16:13:33 +0800
Message-ID: <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
Subject: Re: R: R: About hardfloat in ppc
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c5176905a47da433"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x131.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::131
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

--000000000000c5176905a47da433
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I propose a new way to computing the float flags,
We preserve a  float computing cash
typedef struct FpRecord {
  uint8_t op;
  float32 A;
  float32 B;
}  FpRecord;
FpRecord fp_cache[1024];
int fp_cache_length;
uint32_t fp_exceptions;

1. For each new fp operation we push it to the  fp_cache,
2. Once we read the fp_exceptions , then we re-compute
the fp_exceptions by re-running the fp FpRecord sequence.
 and clear  fp_cache_length.
3. If we clear the fp_exceptions , then we set fp_cache_length to 0 and
 clear  fp_exceptions.
4. If the  fp_cache are full, then we re-compute
the fp_exceptions by re-running the fp FpRecord sequence.

Would this be a general method to use hard-float?
The consued time should be  2*hard_float.
Considerating read fp_exceptions are rare, then the amortized time
complexity
would be 1 * hard_float.



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

--000000000000c5176905a47da433
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I propose=C2=A0a new way to computing the=
 float flags,<div>We preserve a=C2=A0 float computing cash</div><div>typede=
f struct FpRecord {</div><div>=C2=A0 uint8_t op;</div><div>=C2=A0 float32 A=
;</div><div>=C2=A0=20

float32 B;</div><div>}=C2=A0

FpRecord;</div><div>FpRecord fp_cache[1024];<br></div><div>int fp_cache_len=
gth;</div><div>uint32_t fp_exceptions;</div><div><br></div><div>1. For each=
 new fp operation we push it to the=C2=A0

fp_cache,</div><div>2. Once we read the=20

fp_exceptions

, then we re-compute</div><div>the fp_exceptions by re-running the fp=20

FpRecord=20

 sequence.</div><div>=C2=A0and clear=C2=A0

fp_cache_length.</div><div>3. If we clear the=20

fp_exceptions , then we set=C2=A0fp_cache_length to 0 and</div><div>=C2=A0c=
lear=C2=A0

fp_exceptions.</div><div>4. If the=C2=A0

fp_cache are full, then we re-compute</div><div>the fp_exceptions by re-run=
ning the fp=20

FpRecord=20

 sequence.</div><div><br></div><div>Would this be a general method to use h=
ard-float?</div><div>The consued time should be=C2=A0 2*hard_float.</div><d=
iv>Considerating=C2=A0read fp_exceptions are rare, then the amortized time =
complexity</div><div>would be 1 * hard_float.=C2=A0</div><div><br></div><di=
v><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Thu, Apr 30, 2020 at 10:18 AM Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/2=
9/20 5:20 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
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
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000c5176905a47da433--

