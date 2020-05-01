Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FAC28CBC
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 02:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA56208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 02:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccyXmpAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA56208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jULJh-0001Z3-Bw
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 22:22:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jULIs-0008VO-AP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 22:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jULIq-0001Ow-Ow
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 22:21:26 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:47038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jULIq-0001Gb-BG; Thu, 30 Apr 2020 22:21:24 -0400
Received: by mail-lj1-x235.google.com with SMTP id f18so1417382lja.13;
 Thu, 30 Apr 2020 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=jLBqpnV/nFdEIHBCIQmfwD32wi0ER+MY1f49On94ml0=;
 b=ccyXmpAGVH+NMHTkkGBQ3WESlnH3u04NIEqbXa/fQm3cO9Fw04S4+YGut5PeWJT4/0
 jk+aHM7DdA8gFgjhOw133yH9ASh0I5xb8OwFdtL8Ucy3mSA2TWU0xtgY5n7buk1IIzf8
 365LU5QNDPe5DORe9IVv4E0SyLWjvrhLIlERnn1/rHEiz2P1xao3UixQ6XGtlblvN+CV
 49v4NBH9Y1ODEZPJbf+bAablI2KEV5ZhI6nE/WyCVZj90rr1F9znrXjErAzEGaY/xwcs
 LitD+YWLgDcJ9O9D0WZJ922GYOqcCocqFWD8Jrsqwfd/7aK6FBykg2LCRhGtEqRTCXfz
 Kzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=jLBqpnV/nFdEIHBCIQmfwD32wi0ER+MY1f49On94ml0=;
 b=S0rzXuQBfc3+iH/zfTNsYAvuFkyyu1hId/0u958Tnn30ZYsGPY9EyX7ydeyYfgPb09
 K/LzUVZjgkajRhlpkCvpj8vPDNVRlIEczrlfQE9SeyQq2F210D496fuQsKZ6A1zWX06c
 whjWhrg+OMGlXGnkPg2piOfrEutfDHGY150sNRrh/FGl/SjAZ+rLMEGWUY6KovMGuU/k
 WXuiWiBRpiFA13CMls15noLK826NsX0oq1R3LyYj9/K9hAic5+/kXicYh3J7wZuH4Law
 vSY3Zw8DVSL1whXE//y6u5OzHp0cDEiyRn153O4GCpn9ehEHGthKBmNTkzzsEmnOO5+7
 3Vog==
X-Gm-Message-State: AGi0PubJeEojQ4rhYOtk7jAm7PRguZlNH/L3bLwUU4aTev6GVohdRv7R
 qxTwZ1RbZCofYz9p0dz0hYpYRywyS6xbEbevH6I=
X-Google-Smtp-Source: APiQypJSsi+LTP8pJe/eQlF//ZARcozFgPGzgncfch2pYRGM9Ri8z/v8TABCk2ZAPm1mIkFuzIt2aDH6MPBC7S5ulp0=
X-Received: by 2002:a2e:9117:: with SMTP id m23mr1026326ljg.43.1588299681547; 
 Thu, 30 Apr 2020 19:21:21 -0700 (PDT)
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
In-Reply-To: <FEA0FBA9-F5B7-4995-A2F3-5D8053637379@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 1 May 2020 10:21:10 +0800
Message-ID: <CAE2XoE_N_oWJwwGVfh+9mOh3dYR6JXk5XJKzv8fr2A4iE9h1OA@mail.gmail.com>
Subject: Re: About hardfloat in ppc
To: Programmingkid <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000050cc8005a48cd6e9"
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000050cc8005a48cd6e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's what I suggested,
We preserve a  float computing cache
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

Now the keypoint is how to tracking the read and write of FPSCR register,
The current code are
    cpu_fpscr =3D tcg_global_mem_new(cpu_env,
                                   offsetof(CPUPPCState, fpscr), "fpscr");

On Fri, May 1, 2020 at 9:59 AM Programmingkid <programmingkidx@gmail.com>
wrote:

>
> > On Apr 30, 2020, at 12:34 PM, Dino Papararo <skizzato73@msn.com> wrote:
> >
> > Maybe the fastest way to implement hardfloats for ppc could be run them
> by default and until some fpu instruction request for FPSCR register.
> > At this time probably we want to check for some exception.. so QEMU
> could come back to last fpu instruction executed and re-execute it in
> softfloat taking care this time of FPSCR flags, then continue in hardfloa=
ts
> unitl another instruction looking for FPSCR register and so on..
> >
> > Dino
>
> That sounds like a good idea.
>
> > -----Messaggio originale-----
> > Da: BALATON Zoltan <balaton@eik.bme.hu>
> > Inviato: gioved=C3=AC 30 aprile 2020 17:36
> > A: =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com>
> > Cc: Richard Henderson <richard.henderson@linaro.org>; Dino Papararo <
> skizzato73@msn.com>; qemu-devel@nongnu.org; Programmingkid <
> programmingkidx@gmail.com>; qemu-ppc@nongnu.org; Howard Spoelstra <
> hsp.cat7@gmail.com>; Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Oggetto: Re: R: R: About hardfloat in ppc
> >
> > On Thu, 30 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >> I propose a new way to computing the float flags, We preserve a  float
> >> computing cash typedef struct FpRecord {  uint8_t op;
> >> float32 A;
> >> float32 B;
> >> }  FpRecord;
> >> FpRecord fp_cache[1024];
> >> int fp_cache_length;
> >> uint32_t fp_exceptions;
> >>
> >> 1. For each new fp operation we push it to the  fp_cache, 2. Once we
> >> read the fp_exceptions , then we re-compute the fp_exceptions by
> >> re-running the fp FpRecord sequence.
> >> and clear  fp_cache_length.
> >> 3. If we clear the fp_exceptions , then we set fp_cache_length to 0
> >> and clear  fp_exceptions.
> >> 4. If the  fp_cache are full, then we re-compute the fp_exceptions by
> >> re-running the fp FpRecord sequence.
> >>
> >> Would this be a general method to use hard-float?
> >> The consued time should be  2*hard_float.
> >> Considerating read fp_exceptions are rare, then the amortized time
> >> complexity would be 1 * hard_float.
> >
> > It's hard to guess what the hit rate of such cache would be and if it's
> low then managing the cache is probably more expensive than running with
> softfloat. So to evaluate any proposed patch we also need some benchmarks
> which we can experiment with to tell if the results are good or not
> otherwise we're just guessing. Are there some existing tests and benchmar=
ks
> that we can use? Alex mentioned fp-bench I think and to evaluate the
> correctness of the FP implementation I've seen this other
> > conversation:
> >
> > https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg05107.html
> > https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg05126.html
> >
> > Is that something we can use for PPC as well to check the correctness?
> >
> > So I think before implementing any potential solution that came up in
> this brainstorming the first step would be to get and compile (or write i=
f
> not
> > available) some tests and benchmarks:
> >
> > 1. testing host behaviour for inexact and compare that for different
> archs 2. some FP tests that can be used to compare results with QEMU and
> real CPU to check correctness of emulation (if these check for inexact
> differences then could be used instead of 1.) 3. some benchmarks to
> evaluate QEMU performance (these could be same as FP tests or some real
> world FP heavy applications).
> >
> > Then we can see if the proposed solution is faster and still correct.
> >
> > Regards,
> > BALATON Zoltan
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000050cc8005a48cd6e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>That&#39;s what I suggested,</div><div><div>We preser=
ve a=C2=A0 float computing cache</div><div>typedef struct FpRecord {</div><=
div>=C2=A0 uint8_t op;</div><div>=C2=A0 float32 A;</div><div>=C2=A0 float32=
 B;</div><div>}=C2=A0 FpRecord;</div><div>FpRecord fp_cache[1024];<br></div=
><div>int fp_cache_length;</div><div>uint32_t fp_exceptions;</div><div><br>=
</div><div>1. For each new fp operation we push it to the=C2=A0 fp_cache,</=
div><div>2. Once we read the fp_exceptions , then we re-compute</div><div>t=
he fp_exceptions by re-running the fp FpRecord sequence.</div><div>=C2=A0an=
d clear=C2=A0 fp_cache_length.</div><div>3. If we clear the fp_exceptions ,=
 then we set=C2=A0fp_cache_length to 0 and</div><div>=C2=A0clear=C2=A0 fp_e=
xceptions.</div><div>4. If the=C2=A0 fp_cache are full, then we re-compute<=
/div><div>the fp_exceptions by re-running the fp FpRecord sequence.</div><d=
iv><br></div>Now the keypoint is how to tracking the read and write of FPSC=
R register,<br>The current code are <div><div style=3D"color:rgb(212,212,21=
2);background-color:rgb(30,30,30);font-family:Consolas,&quot;Courier New&qu=
ot;,monospace;font-size:14px;line-height:19px;white-space:pre"><div>=C2=A0=
=C2=A0=C2=A0=C2=A0cpu_fpscr=C2=A0=3D=C2=A0<span style=3D"color:rgb(220,220,=
170)">tcg_global_mem_new</span>(cpu_env,</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(220,220,170)">=
offsetof</span>(CPUPPCState,=C2=A0fpscr),=C2=A0<span style=3D"color:rgb(206=
,145,120)">&quot;fpscr&quot;</span>);</div></div></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 1, 2020 =
at 9:59 AM Programmingkid &lt;<a href=3D"mailto:programmingkidx@gmail.com">=
programmingkidx@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br>
&gt; On Apr 30, 2020, at 12:34 PM, Dino Papararo &lt;<a href=3D"mailto:skiz=
zato73@msn.com" target=3D"_blank">skizzato73@msn.com</a>&gt; wrote:<br>
&gt; <br>
&gt; Maybe the fastest way to implement hardfloats for ppc could be run the=
m by default and until some fpu instruction request for FPSCR register.<br>
&gt; At this time probably we want to check for some exception.. so QEMU co=
uld come back to last fpu instruction executed and re-execute it in softflo=
at taking care this time of FPSCR flags, then continue in hardfloats unitl =
another instruction looking for FPSCR register and so on..<br>
&gt; <br>
&gt; Dino<br>
<br>
That sounds like a good idea.<br>
<br>
&gt; -----Messaggio originale-----<br>
&gt; Da: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D=
"_blank">balaton@eik.bme.hu</a>&gt; <br>
&gt; Inviato: gioved=C3=AC 30 aprile 2020 17:36<br>
&gt; A: =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luo=
yonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; Cc: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.o=
rg" target=3D"_blank">richard.henderson@linaro.org</a>&gt;; Dino Papararo &=
lt;<a href=3D"mailto:skizzato73@msn.com" target=3D"_blank">skizzato73@msn.c=
om</a>&gt;; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu=
-devel@nongnu.org</a>; Programmingkid &lt;<a href=3D"mailto:programmingkidx=
@gmail.com" target=3D"_blank">programmingkidx@gmail.com</a>&gt;; <a href=3D=
"mailto:qemu-ppc@nongnu.org" target=3D"_blank">qemu-ppc@nongnu.org</a>; How=
ard Spoelstra &lt;<a href=3D"mailto:hsp.cat7@gmail.com" target=3D"_blank">h=
sp.cat7@gmail.com</a>&gt;; Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benn=
ee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt; Oggetto: Re: R: R: About hardfloat in ppc<br>
&gt; <br>
&gt; On Thu, 30 Apr 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<=
br>
&gt;&gt; I propose a new way to computing the float flags, We preserve a=C2=
=A0 float <br>
&gt;&gt; computing cash typedef struct FpRecord {=C2=A0 uint8_t op;<br>
&gt;&gt; float32 A;<br>
&gt;&gt; float32 B;<br>
&gt;&gt; }=C2=A0 FpRecord;<br>
&gt;&gt; FpRecord fp_cache[1024];<br>
&gt;&gt; int fp_cache_length;<br>
&gt;&gt; uint32_t fp_exceptions;<br>
&gt;&gt; <br>
&gt;&gt; 1. For each new fp operation we push it to the=C2=A0 fp_cache, 2. =
Once we <br>
&gt;&gt; read the fp_exceptions , then we re-compute the fp_exceptions by <=
br>
&gt;&gt; re-running the fp FpRecord sequence.<br>
&gt;&gt; and clear=C2=A0 fp_cache_length.<br>
&gt;&gt; 3. If we clear the fp_exceptions , then we set fp_cache_length to =
0 <br>
&gt;&gt; and clear=C2=A0 fp_exceptions.<br>
&gt;&gt; 4. If the=C2=A0 fp_cache are full, then we re-compute the fp_excep=
tions by <br>
&gt;&gt; re-running the fp FpRecord sequence.<br>
&gt;&gt; <br>
&gt;&gt; Would this be a general method to use hard-float?<br>
&gt;&gt; The consued time should be=C2=A0 2*hard_float.<br>
&gt;&gt; Considerating read fp_exceptions are rare, then the amortized time=
 <br>
&gt;&gt; complexity would be 1 * hard_float.<br>
&gt; <br>
&gt; It&#39;s hard to guess what the hit rate of such cache would be and if=
 it&#39;s low then managing the cache is probably more expensive than runni=
ng with softfloat. So to evaluate any proposed patch we also need some benc=
hmarks which we can experiment with to tell if the results are good or not =
otherwise we&#39;re just guessing. Are there some existing tests and benchm=
arks that we can use? Alex mentioned fp-bench I think and to evaluate the c=
orrectness of the FP implementation I&#39;ve seen this other<br>
&gt; conversation:<br>
&gt; <br>
&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-04/ms=
g05107.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/=
archive/html/qemu-devel/2020-04/msg05107.html</a><br>
&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-04/ms=
g05126.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/=
archive/html/qemu-devel/2020-04/msg05126.html</a><br>
&gt; <br>
&gt; Is that something we can use for PPC as well to check the correctness?=
<br>
&gt; <br>
&gt; So I think before implementing any potential solution that came up in =
this brainstorming the first step would be to get and compile (or write if =
not<br>
&gt; available) some tests and benchmarks:<br>
&gt; <br>
&gt; 1. testing host behaviour for inexact and compare that for different a=
rchs 2. some FP tests that can be used to compare results with QEMU and rea=
l CPU to check correctness of emulation (if these check for inexact differe=
nces then could be used instead of 1.) 3. some benchmarks to evaluate QEMU =
performance (these could be same as FP tests or some real world FP heavy ap=
plications).<br>
&gt; <br>
&gt; Then we can see if the proposed solution is faster and still correct.<=
br>
&gt; <br>
&gt; Regards,<br>
&gt; BALATON Zoltan<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000050cc8005a48cd6e9--

