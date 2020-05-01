Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA18EC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FB721582
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Y/WXpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FB721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUSG-0000ry-MT
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jUURL-00007t-FB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jUUPq-0008U4-DV
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:06:47 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:39326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUUPp-0008Ln-SE; Fri, 01 May 2020 08:05:13 -0400
Received: by mail-lf1-x129.google.com with SMTP id h26so742542lfg.6;
 Fri, 01 May 2020 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=F9OVaBWgvDEElS4jdWBGWlE94CgvOfqai2bAGMzO3lw=;
 b=d1Y/WXpIswvH5z60JivHROzDq13Ch1xI6wEeD2/FV8E/eN/c6NpapJ9I+1ftbHXNYK
 qEEJEa3YsQBIiJ2EPP1t27wKQbND/jl5nFxc+s4VEn743gNMruxm5xEA9wDzRWPeqVfm
 /w/iZ83h/CSHXX5Ae4hfNfi8FJSTWHwTKOLw1W5hbaMjX6cAmptW3WfZYIzmC4IhqYbY
 z4yo81nf4JfDGK40V0lrqf15BEOsH/2OuT1hevNrttWa1+Og+faF727kr1kkzXRDX59D
 4t5+oFFpU80qyl3Yn27FwQzRQ6cIO1MumfKfeFeY0CAQ7yIeTqStnPM+7vzUInfvkOwb
 PygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=F9OVaBWgvDEElS4jdWBGWlE94CgvOfqai2bAGMzO3lw=;
 b=c0qD68FBZlhjPISPxSC1XmvOmH8RurdZXQEdWTXigA3ok1aM8r2eO7pLGJuXVdlYON
 iE/Z8hpCN8Rk8v5G5tAYbybnKqf6UO6ijbQKNy8JbaZfhsg00qqgnYFDbrfG+KyKqNL8
 4thKsQeVApDcl+h0EpggbvqYl6zapxat6ILwctWZYFdEAPN7awy0ZJ8FeCMUVEFmbvw7
 doSZopay5TX5FT0NiDEzvpchXF5e2XHn1VK5vYy/tp68l8nJ3sfWAg9e+LPvYBZDlCxC
 Ah7OsoQrW6KR4Cgyazj67f9rwzrj9hjws1mh3EyvujudW/gA6LvkXPA0cqSLcorqNHtx
 DvtQ==
X-Gm-Message-State: AGi0PuZ8n932zBB8Zuf0bi+dkyQ0zMBv+efL6q7Q0mhtWecK+zo/+6BG
 SPu6rTi6TfEv0XlQV+arut9ex8jVozVBVJtLBSI=
X-Google-Smtp-Source: APiQypKshPjpVIF2oJe/hkNxKxNDWmJ2MU9DgWp36yKHj9LGjfzk04u5xPsd3moSgVnKJn6tsWpge77bFU/Xg1sxAkE=
X-Received: by 2002:a19:5206:: with SMTP id m6mr2329343lfb.33.1588334711436;
 Fri, 01 May 2020 05:05:11 -0700 (PDT)
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
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
 <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <FEA0FBA9-F5B7-4995-A2F3-5D8053637379@gmail.com>
 <CAE2XoE_N_oWJwwGVfh+9mOh3dYR6JXk5XJKzv8fr2A4iE9h1OA@mail.gmail.com>
 <alpine.BSF.2.22.395.2005011347390.29385@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2005011347390.29385@zero.eik.bme.hu>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 1 May 2020 20:04:59 +0800
Message-ID: <CAE2XoE-0=SgjeXddZXDOYPeUC1xsD5V=A5xBoa1yHS8gL2=MQg@mail.gmail.com>
Subject: Re: About hardfloat in ppc
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000427b5205a494fe83"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x129.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::129
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000427b5205a494fe83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2020 at 7:58 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Fri, 1 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > That's what I suggested,
> > We preserve a  float computing cache
> > typedef struct FpRecord {
> >  uint8_t op;
> >  float32 A;
> >  float32 B;
> > }  FpRecord;
> > FpRecord fp_cache[1024];
> > int fp_cache_length;
> > uint32_t fp_exceptions;
> >
> > 1. For each new fp operation we push it to the  fp_cache,
> > 2. Once we read the fp_exceptions , then we re-compute
> > the fp_exceptions by re-running the fp FpRecord sequence.
> > and clear  fp_cache_length.
>
> Why do you need to store more than the last fp op? The cumulative bits ca=
n
> be tracked like it's done for other targets by not clearing fp_status the=
n
> you can read it from there. Only the non-sticky FI bit needs to be
> computed but that's only determined by the last op so it's enough to
> remember that and run that with softfloat (or even hardfloat after
> clearing status but softfloat may be faster for this) to get the bits for
> last op when status is read.
>
Yeap, store only the last fp op is also an option. Do you means that store
the last fp op,
and calculate it when necessary?  I am thinking about a general fp
optmize method that suite
for all target.

>
> > 3. If we clear the fp_exceptions , then we set fp_cache_length to 0 and
> > clear  fp_exceptions.
> > 4. If the  fp_cache are full, then we re-compute
> > the fp_exceptions by re-running the fp FpRecord sequence.
>
> All this cache management and more than one element seems unnecessary to
> me although I may be missing something.
>
> > Now the keypoint is how to tracking the read and write of FPSCR registe=
r,
> > The current code are
> >    cpu_fpscr =3D tcg_global_mem_new(cpu_env,
> >                                   offsetof(CPUPPCState, fpscr), "fpscr"=
);
>
> Maybe you could search where the value is read which should be the places
> where we need to handle it but changes may be needed to make a clear API
> for this between target/ppc, TCG and softfloat which likely does not
> exist yet.
>
> Regards,
> BALATON Zoltan



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000427b5205a494fe83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 1, 2020 at 7:58 PM BALATO=
N Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri=
, 1 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; That&#39;s what I suggested,<br>
&gt; We preserve a=C2=A0 float computing cache<br>
&gt; typedef struct FpRecord {<br>
&gt;=C2=A0 uint8_t op;<br>
&gt;=C2=A0 float32 A;<br>
&gt;=C2=A0 float32 B;<br>
&gt; }=C2=A0 FpRecord;<br>
&gt; FpRecord fp_cache[1024];<br>
&gt; int fp_cache_length;<br>
&gt; uint32_t fp_exceptions;<br>
&gt;<br>
&gt; 1. For each new fp operation we push it to the=C2=A0 fp_cache,<br>
&gt; 2. Once we read the fp_exceptions , then we re-compute<br>
&gt; the fp_exceptions by re-running the fp FpRecord sequence.<br>
&gt; and clear=C2=A0 fp_cache_length.<br>
<br>
Why do you need to store more than the last fp op? The cumulative bits can =
<br>
be tracked like it&#39;s done for other targets by not clearing fp_status t=
hen <br>
you can read it from there. Only the non-sticky FI bit needs to be <br>
computed but that&#39;s only determined by the last op so it&#39;s enough t=
o <br>
remember that and run that with softfloat (or even hardfloat after <br>
clearing status but softfloat may be faster for this) to get the bits for <=
br>
last op when status is read.<br></blockquote><div>Yeap, store only the last=
 fp op is also an option. Do you means that store the last fp op,</div><div=
>and calculate it when necessary?=C2=A0 I am thinking about a general fp op=
tmize=C2=A0method that suite=C2=A0</div><div>for all target.</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; 3. If we clear the fp_exceptions , then we set fp_cache_length to 0 an=
d<br>
&gt; clear=C2=A0 fp_exceptions.<br>
&gt; 4. If the=C2=A0 fp_cache are full, then we re-compute<br>
&gt; the fp_exceptions by re-running the fp FpRecord sequence.<br>
<br>
All this cache management and more than one element seems unnecessary to <b=
r>
me although I may be missing something.<br>
<br>
&gt; Now the keypoint is how to tracking the read and write of FPSCR regist=
er,<br>
&gt; The current code are<br>
&gt;=C2=A0 =C2=A0 cpu_fpscr =3D tcg_global_mem_new(cpu_env,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUPPCState=
, fpscr), &quot;fpscr&quot;);<br>
<br>
Maybe you could search where the value is read which should be the places <=
br>
where we need to handle it but changes may be needed to make a clear API <b=
r>
for this between target/ppc, TCG and softfloat which likely does not <br>
exist yet.<br>
<br>
Regards,<br>
BALATON Zoltan</blockquote></div><br clear=3D"all"><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000427b5205a494fe83--

