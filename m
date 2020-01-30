Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4966C33CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 01:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F03F206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 01:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ORJxZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F03F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54713 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwykp-0004vw-Nb
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 20:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwykC-0004Rh-5y
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 20:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwykB-0008Gj-1R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 20:35:43 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwykA-0008Cr-Qh; Wed, 29 Jan 2020 20:35:42 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so1644773otd.2;
 Wed, 29 Jan 2020 17:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CwlJMsYFI+TiLEnDgAzX0LeVjXyN4utWw1TTBvdaaAE=;
 b=F5ORJxZ4mui8UKXnJS0F5rMc9dHZJJhUDMarOeIPyojT+yKECqNjc0tuch8FMruGbc
 4E2CaQIC92K4hmuq0W8TWZNlFgao9mKEL5ZYEDFPsHtps/dqM5UqpBQMxyQJhUVtJC77
 +Pu40CSpNEkipxNToX9nSw+xCuy3zGKUutZ6+ckzZEtkBkykM4v3ZMnTYhPmnbZzOF/C
 eArYsP1Rqbzee8GxhQlHbhaq9/nOiswKASfcArnL4h9aYceLIz3quYPAUY16RXECJEoT
 2U6aZNRt+LPuR26XQzzzfdpRoJZ1T0Xi1nwM34/oL6xH7lNL1TrfSEDLIw/YQ//tBRfQ
 viEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CwlJMsYFI+TiLEnDgAzX0LeVjXyN4utWw1TTBvdaaAE=;
 b=SZ7IYaNL/t0rAyNGDY8FXqKRGQxLHQQ3hJzfTQykFCfHZSvE22FnEjj3nAlwPMOD25
 85weHwXeZZuAuYK7A+8r01IoaFu6mCN5YH7gCDsD9oAKbqWc1sa7p1SFwOHBUHr3MFGB
 pRwD7sjLMzO/L+LemcD4ywohn4zNY0ncHj1/iSnJuQF9Yk7Mi9Ut6zFQ4nFMZfcuGLrj
 xY6VfuXbca6tO2QRkka8G3e91DEu/W+C0dzz2ikYlP9kahUunWZZzpVyB9Ns27sERU+r
 yrPzFyVDxPQGonvMovWnQ+uqsmc6XwXiIit5yMAA4k9SNR6p1kgXQ3JhXWC3ZD1Uys8Z
 wIig==
X-Gm-Message-State: APjAAAV3sl2BL2QvHVigHSqVeOU70rnwohm5oR6DirmFEfbQvf8Rhnt6
 MfBtSTffx/77jk+Iu+2bMdn5oZ3wfPHHKAXhZ98=
X-Google-Smtp-Source: APXvYqzlYlDRT+8Z1G6OcVaUsTu1GkE3iUtZSFeKLqhyLFN9ULU9rwnZJO5kEqV0v54PzHrJZ3+XtwbsxPVXBz8pOII=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr1702436otp.306.1580348141478; 
 Wed, 29 Jan 2020 17:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20200129235040.24022-1-richard.henderson@linaro.org>
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 30 Jan 2020 02:35:22 +0100
Message-ID: <CAL1e-=jbTY6a-B4RkoR9hL_h5LiOwio=A6pp3=KqqjUu7bEWUQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/ppc: Use probe_access
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009826b6059d517979"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009826b6059d517979
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

00:51 =C4=8Cet, 30.01.2020. Richard Henderson <richard.henderson@linaro.org=
> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The first two address the performance regression noticed
> by Howard Spoelstra.  The last two are just something I
> noticed at the same time.
>

But, performance regression, according to Howard bisect analysis, happened
because of the change in target-independant code, and the fix presented
here is in target-specific code. This defies basic logic and deserves clear
and detailed explanation.

My additional concern, of course, is: Are other targets exposed to
performance degradation, and why?

Thanks,
Aleksandar

>
> r~
>
>
> Richard Henderson (4):
>   target/ppc: Use probe_access for LSW, STSW
>   target/ppc: Use probe_access for LMW, STMW
>   target/ppc: Remove redundant mask in DCBZ
>   target/ppc: Use probe_write for DCBZ
>
>  target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 162 insertions(+), 35 deletions(-)
>
> --
> 2.20.1
>
>

--0000000000009826b6059d517979
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">00:51 =C4=8Cet, 30.01.2020. Richard Henderson &lt;<a href=3D=
"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; =
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; The first two address the performance regression noticed<br>
&gt; by Howard Spoelstra.=C2=A0 The last two are just something I<br>
&gt; noticed at the same time.<br>
&gt;</p>
<p dir=3D"ltr">But, performance regression, according to Howard bisect anal=
ysis, happened because of the change in target-independant code, and the fi=
x presented here is in target-specific code. This defies basic logic and de=
serves clear and detailed explanation.</p>
<p dir=3D"ltr">My additional concern, of course, is: Are other targets expo=
sed to performance degradation, and why? </p>
<p dir=3D"ltr">Thanks,<br>
Aleksandar<br><br></p>
<p dir=3D"ltr">&gt;<br>
&gt; r~<br>
&gt;<br>
&gt;<br>
&gt; Richard Henderson (4):<br>
&gt; =C2=A0 target/ppc: Use probe_access for LSW, STSW<br>
&gt; =C2=A0 target/ppc: Use probe_access for LMW, STMW<br>
&gt; =C2=A0 target/ppc: Remove redundant mask in DCBZ<br>
&gt; =C2=A0 target/ppc: Use probe_write for DCBZ<br>
&gt;<br>
&gt; =C2=A0target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++-=
------<br>
&gt; =C2=A01 file changed, 162 insertions(+), 35 deletions(-)<br>
&gt;<br>
&gt; -- <br>
&gt; 2.20.1<br>
&gt;<br>
&gt;<br>
</p>

--0000000000009826b6059d517979--

