Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE240C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C300206B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFUeygle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C300206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnz1-0008Ez-3t
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1kHnpr-0005eX-65
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:43:56 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:42133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1kHnpo-0001u9-0I
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:43:54 -0400
Received: by mail-ej1-x62f.google.com with SMTP id q13so23005407ejo.9
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X8HTmlSEB7mAUp42RsUe3PwWp1bbT/3zNHcbnsauupQ=;
 b=dFUeyglelLwnZ3Axb2URiNMAIcjzcJ7Ad/P2ROCpnx3n3g80YWF6zm7sEJ7dFuL4Il
 TEarMCPwyLhT3MZ/UKzokRhWEU33KsbXYcsn73H0Eug1liiwJ4d9pJmpREu18Ivfprk4
 iM89qiVYBllAP8m7veK84tDCK7lfRVyq3hThDPlLvJqlaO8145Ey/Y9RJ5Wfo9t3s//P
 sV++vHDrwms5JcMjocXkQzU68h7rNv+up6jnseQKKygH+GYXNSkBKDREBYZ4rqIyTW7L
 sDmwovYI3DRTWD4NdfhWsuK4xmlq46g+x1iiSQdL5bYTkKkFHhRTm2MmSqCs6ZYRIIo2
 YAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X8HTmlSEB7mAUp42RsUe3PwWp1bbT/3zNHcbnsauupQ=;
 b=Jdgxi7Ubv0BCYMsdCQ/8dxDWcumfMZPaSs/4JuAmghXeK4WjQq7BEDHt5qVjMrCqVE
 0xL9oqHHz681gkcYJNJLe1YI0ZeyaC04nYP4GP2UstMbVGaadqBHjlLwBUKGK2bU5R1s
 qxC2qpZXvO+0pDnto4lGKt/FRt332WwJBapPnqy4t1YQJs53K2gC/9DcE7e6d4uHbmRf
 jho1D+tQ5TKA3rn+f/4hHGMAug9Bd7FrP8jTkyMOZaoSbapug3UsrLiSjQWb5fRB49eM
 wFZP1f9D/qe3hPnFtGldxlAcj3dzJnqF3vOfolWToWWMXXyhlacKhhDixnteeb+yYChv
 LMGw==
X-Gm-Message-State: AOAM531xJ3P0YOXJ2JvmTG9uTaGLYg168vx5pnMs+QAdNnP43ftVM/bf
 8OCHthRCmebgAaAc6S/8zi2l70fu+30uYUJeKNQ=
X-Google-Smtp-Source: ABdhPJxupDrExKhkHs5uTDh4cxF5VmtVwucs3k+VYFFlVfkXJDRlgwCSMLs3scWmePrVbxVAlRxMokBSD1jUgcvnFp4=
X-Received: by 2002:a17:906:fa8a:: with SMTP id
 lt10mr14254418ejb.307.1600087430003; 
 Mon, 14 Sep 2020 05:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <5f5e9831.1c69fb81.bdbec.98b8@mx.google.com>
 <ea64c109-6bd9-c0f1-964c-46be5c6ba020@amsat.org>
 <CALTWKrW-U261HNc8mSxmu1uYKqrZxZM4+661ZK_m-W_Ky8eiFQ@mail.gmail.com>
In-Reply-To: <CALTWKrW-U261HNc8mSxmu1uYKqrZxZM4+661ZK_m-W_Ky8eiFQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 14 Sep 2020 14:43:39 +0200
Message-ID: <CAL1e-=hivWj2zvE9hXPdyfVFyBCYn5np0Y8wuFQHg9s0qtQsMg@mail.gmail.com>
Subject: Re: [REPORT] Nightly Performance Tests - Sunday, September 13, 2020
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e000f005af456260"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e000f005af456260
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 12:52 PM Ahmed Karaman <ahmedkhaledkaraman@gmail.co=
m>
wrote:

> On Mon, Sep 14, 2020 at 8:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
> wrote:
> >
> > Hi Ahmed,
> >
> > On 9/14/20 12:07 AM, Ahmed Karaman wrote:
> > > Host CPU         : Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
> > > Host Memory      : 15.49 GB
> > >
> > > Start Time (UTC) : 2020-09-13 21:35:01
> > > End Time (UTC)   : 2020-09-13 22:07:44
> > > Execution Time   : 0:32:42.230467
> > >
> > > Status           : SUCCESS
> > >
> > > Note:
> > > Changes denoted by '-----' are less than 0.01%.
> > >
> > > --------------------------------------------------------
> > >             SUMMARY REPORT - COMMIT f00f57f3
> > > --------------------------------------------------------
> >
> > (Maybe this was already commented earlier but I missed it).
> >
> > What change had a so significant impact on the m68k target?
> > At a glance I only see mostly changes in softfloat:
> >
> > $ git log --oneline v5.1.0..f00f57f3 tcg target/m68k fpu
> > fe4b0b5bfa9 tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem
> > 6a17646176e tcg: Eliminate one store for in-place 128-bit dup_mem
> > e7e8f33fb60 tcg: Fix tcg gen for vectorized absolute value
> > 5ebf5f4be66 softfloat: Define misc operations for bfloat16
> > 34f0c0a98a5 softfloat: Define convert operations for bfloat16
> > 8282310d853 softfloat: Define operations for bfloat16
> > 0d93d8ec632 softfloat: Add fp16 and uint8/int8 conversion functions
> > fbcc38e4cb1 softfloat: add xtensa specialization for pickNaNMulAdd
> > 913602e3ffe softfloat: pass float_status pointer to pickNaN
> > cc43c692511 softfloat: make NO_SIGNALING_NANS runtime property
> > 73ebe95e8e5 target/ppc: add vmulld to INDEX_op_mul_vec case
> >
> > > --------------------------------------------------------
> > > --------------------------------------------------------
> > > Test Program: matmult_double
> > > --------------------------------------------------------
> > > Target              Instructions      Latest      v5.1.0
> > > ----------  --------------------  ----------  ----------
> > > aarch64            1 412 412 599       -----     +0.311%
> > > alpha              3 233 957 639       -----     +7.472%
> > > arm                8 545 302 995       -----      +1.09%
> > > hppa               3 483 527 330       -----     +4.466%
> > > m68k               3 919 110 506       -----    +18.433%
> > > mips               2 344 641 840       -----     +4.085%
> > > mipsel             3 329 912 425       -----     +5.177%
> > > mips64             2 359 024 910       -----     +4.075%
> > > mips64el           3 343 650 686       -----     +5.166%
> > > ppc                3 209 505 701       -----     +3.248%
> > > ppc64              3 287 495 266       -----     +3.173%
> > > ppc64le            3 287 135 580       -----     +3.171%
> > > riscv64            1 221 617 903       -----     +0.278%
> > > s390x              2 874 160 417       -----     +5.826%
> > > sh4                3 544 094 841       -----      +6.42%
> > > sparc64            3 426 094 848       -----     +7.138%
> > > x86_64             1 249 076 697       -----     +0.335%
> > > --------------------------------------------------------
> > ...
> > > --------------------------------------------------------
> > > Test Program: qsort_double
> > > --------------------------------------------------------
> > > Target              Instructions      Latest      v5.1.0
> > > ----------  --------------------  ----------  ----------
> > > aarch64            2 709 839 947       -----     +2.423%
> > > alpha              1 969 432 086       -----     +3.679%
> > > arm                8 323 168 267       -----     +2.589%
> > > hppa               3 188 316 726       -----       +2.9%
> > > m68k               4 953 947 225       -----    +15.153%
> > > mips               2 123 789 120       -----     +3.049%
> > > mipsel             2 124 235 492       -----     +3.049%
> > > mips64             1 999 025 951       -----     +3.404%
> > > mips64el           1 996 433 190       -----     +3.409%
> > > ppc                2 819 299 843       -----     +5.436%
> > > ppc64              2 768 177 037       -----     +5.512%
> > > ppc64le            2 724 766 044       -----     +5.602%
> > > riscv64            1 638 324 190       -----     +4.021%
> > > s390x              2 519 117 806       -----     +3.364%
> > > sh4                2 595 696 102       -----       +3.0%
> > > sparc64            3 988 892 763       -----     +2.744%
> > > x86_64             2 033 624 062       -----     +3.242%
> > > --------------------------------------------------------
>
> Hi Mr. Philippe,
> The performance degradation from v5.1.0 of all targets, and especially
> m68k, was introduced between the two nightly tests below:
>
> [REPORT] Nightly Performance Tests - Thursday, August 20, 2020:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg04923.html
>
> [REPORT] Nightly Performance Tests - Saturday, August 22, 2020
> https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg05537.html
>
> It looks like the new build system is the culprit.
>
> The "bisect.py" script introduced during the "TCG Continuous
> Benchmarking" GSoC project can be very handy in these cases. I wrote
> about the tool and how to use it in the report below:
>
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Finding-Commits-A=
ffecting-QEMU-Performance/
>
>
Hi, Ahmed.

I think the bisect.py script will work only if both "start" and "end"
commits are before build system change, or if both of them are after build
system change.

In other words, the script is unlikely to work if "start" is before, and
"end" is after build system change.

This means that, most probably, one should resort to manual analysis of
origins of performance degradation on Aug 22nd.

One area that definitely might be the culprit is the difference in CFLAGS
before and after.

Yours,
Aleksandar


> Best regards,
> Ahmed Karaman
>
>

--000000000000e000f005af456260
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14, 2020 at 12:52 PM Ahme=
d Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledka=
raman@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Mon, Sep 14, 2020 at 8:46 AM Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a=
>&gt; wrote:<br>
&gt;<br>
&gt; Hi Ahmed,<br>
&gt;<br>
&gt; On 9/14/20 12:07 AM, Ahmed Karaman wrote:<br>
&gt; &gt; Host CPU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: Intel(R) Core(TM) i7-=
8750H CPU @ 2.20GHz<br>
&gt; &gt; Host Memory=C2=A0 =C2=A0 =C2=A0 : 15.49 GB<br>
&gt; &gt;<br>
&gt; &gt; Start Time (UTC) : 2020-09-13 21:35:01<br>
&gt; &gt; End Time (UTC)=C2=A0 =C2=A0: 2020-09-13 22:07:44<br>
&gt; &gt; Execution Time=C2=A0 =C2=A0: 0:32:42.230467<br>
&gt; &gt;<br>
&gt; &gt; Status=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: SUCCESS<br>
&gt; &gt;<br>
&gt; &gt; Note:<br>
&gt; &gt; Changes denoted by &#39;-----&#39; are less than 0.01%.<br>
&gt; &gt;<br>
&gt; &gt; --------------------------------------------------------<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SUMMARY REPORT - C=
OMMIT f00f57f3<br>
&gt; &gt; --------------------------------------------------------<br>
&gt;<br>
&gt; (Maybe this was already commented earlier but I missed it).<br>
&gt;<br>
&gt; What change had a so significant impact on the m68k target?<br>
&gt; At a glance I only see mostly changes in softfloat:<br>
&gt;<br>
&gt; $ git log --oneline v5.1.0..f00f57f3 tcg target/m68k fpu<br>
&gt; fe4b0b5bfa9 tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem<br>
&gt; 6a17646176e tcg: Eliminate one store for in-place 128-bit dup_mem<br>
&gt; e7e8f33fb60 tcg: Fix tcg gen for vectorized absolute value<br>
&gt; 5ebf5f4be66 softfloat: Define misc operations for bfloat16<br>
&gt; 34f0c0a98a5 softfloat: Define convert operations for bfloat16<br>
&gt; 8282310d853 softfloat: Define operations for bfloat16<br>
&gt; 0d93d8ec632 softfloat: Add fp16 and uint8/int8 conversion functions<br=
>
&gt; fbcc38e4cb1 softfloat: add xtensa specialization for pickNaNMulAdd<br>
&gt; 913602e3ffe softfloat: pass float_status pointer to pickNaN<br>
&gt; cc43c692511 softfloat: make NO_SIGNALING_NANS runtime property<br>
&gt; 73ebe95e8e5 target/ppc: add vmulld to INDEX_op_mul_vec case<br>
&gt;<br>
&gt; &gt; --------------------------------------------------------<br>
&gt; &gt; --------------------------------------------------------<br>
&gt; &gt; Test Program: matmult_double<br>
&gt; &gt; --------------------------------------------------------<br>
&gt; &gt; Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructio=
ns=C2=A0 =C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
&gt; &gt; ----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----=
------<br>
&gt; &gt; aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 412 412 599=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.311%<br>
&gt; &gt; alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 233 957 6=
39=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+7.472%<br>
&gt; &gt; arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8 545 =
302 995=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +1.09%<br>
&gt; &gt; hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 483 =
527 330=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.466%<br>
&gt; &gt; m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 919 =
110 506=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 +18.433%<br>
&gt; &gt; mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 344 =
641 840=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.085%<br>
&gt; &gt; mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 329 912 4=
25=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.177%<br>
&gt; &gt; mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 359 024 9=
10=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.075%<br>
&gt; &gt; mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 343 650 686=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.166%<br>
&gt; &gt; ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 209 =
505 701=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.248%<br>
&gt; &gt; ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 287 495 2=
66=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.173%<br>
&gt; &gt; ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 287 135 580=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.171%<br>
&gt; &gt; riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 221 617 903=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.278%<br>
&gt; &gt; s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 874 160 4=
17=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.826%<br>
&gt; &gt; sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 544 =
094 841=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 +6.42%<br>
&gt; &gt; sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 426 094 848=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+7.138%<br>
&gt; &gt; x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 249 076 6=
97=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+0.335%<br>
&gt; &gt; --------------------------------------------------------<br>
&gt; ...<br>
&gt; &gt; --------------------------------------------------------<br>
&gt; &gt; Test Program: qsort_double<br>
&gt; &gt; --------------------------------------------------------<br>
&gt; &gt; Target=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Instructio=
ns=C2=A0 =C2=A0 =C2=A0 Latest=C2=A0 =C2=A0 =C2=A0 v5.1.0<br>
&gt; &gt; ----------=C2=A0 --------------------=C2=A0 ----------=C2=A0 ----=
------<br>
&gt; &gt; aarch64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 709 839 947=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.423%<br>
&gt; &gt; alpha=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 969 432 0=
86=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.679%<br>
&gt; &gt; arm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8 323 =
168 267=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.589%<br>
&gt; &gt; hppa=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03 188 =
316 726=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 =C2=A0+2.9%<br>
&gt; &gt; m68k=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04 953 =
947 225=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 +15.153%<br>
&gt; &gt; mips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 123 =
789 120=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.049%<br>
&gt; &gt; mipsel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 124 235 4=
92=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.049%<br>
&gt; &gt; mips64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 999 025 9=
51=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.404%<br>
&gt; &gt; mips64el=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 996 433 190=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.409%<br>
&gt; &gt; ppc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 819 =
299 843=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.436%<br>
&gt; &gt; ppc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 768 177 0=
37=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.512%<br>
&gt; &gt; ppc64le=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 724 766 044=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+5.602%<br>
&gt; &gt; riscv64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 638 324 190=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+4.021%<br>
&gt; &gt; s390x=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 519 117 8=
06=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.364%<br>
&gt; &gt; sh4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2 595 =
696 102=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0 =C2=A0+3.0%<br>
&gt; &gt; sparc64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 988 892 763=C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+2.744%<br>
&gt; &gt; x86_64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 033 624 0=
62=C2=A0 =C2=A0 =C2=A0 =C2=A0-----=C2=A0 =C2=A0 =C2=A0+3.242%<br>
&gt; &gt; --------------------------------------------------------<br>
<br>
Hi Mr. Philippe,<br>
The performance degradation from v5.1.0 of all targets, and especially<br>
m68k, was introduced between the two nightly tests below:<br>
<br>
[REPORT] Nightly Performance Tests - Thursday, August 20, 2020:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg0492=
3.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-08/msg04923.html</a><br>
<br>
[REPORT] Nightly Performance Tests - Saturday, August 22, 2020<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg0553=
7.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-08/msg05537.html</a><br>
<br>
It looks like the new build system is the culprit.<br>
<br>
The &quot;bisect.py&quot; script introduced during the &quot;TCG Continuous=
<br>
Benchmarking&quot; GSoC project can be very handy in these cases. I wrote<b=
r>
about the tool and how to use it in the report below:<br>
<a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Finding-=
Commits-Affecting-QEMU-Performance/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Finding-Commits-Affe=
cting-QEMU-Performance/</a><br>
<br></blockquote><div><br></div><div>Hi, Ahmed.<br></div><div><br></div><di=
v>I think the bisect.py script will work only if both &quot;start&quot; and=
 &quot;end&quot; commits are before build system change, or if both of them=
 are after build system change.</div><div><br></div><div>In other words, th=
e script is unlikely to work if &quot;start&quot; is before, and &quot;end&=
quot; is after build system change.</div><div><br></div><div>This means tha=
t, most probably, one should resort to manual analysis of origins of perfor=
mance degradation on Aug 22nd.</div><div><br></div><div>One area that defin=
itely might be the culprit is the difference in CFLAGS before and after.<br=
></div><div><br></div><div>Yours,</div><div>Aleksandar<br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
Best regards,<br>
Ahmed Karaman<br>
<br>
</blockquote></div></div>

--000000000000e000f005af456260--

