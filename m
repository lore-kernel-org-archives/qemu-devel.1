Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E11C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CF020663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 20:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKjyj37N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CF020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGTV8-0000JN-Pp
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 16:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1jGTU2-0007Jg-5W
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1jGTU1-0001gf-0V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:15:38 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:37364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1jGTU0-0001g8-SU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 16:15:36 -0400
Received: by mail-qt1-x82e.google.com with SMTP id d12so10507404qtj.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pPrFW5MtY2SdPtXFp5xU52/c3vvTvnKrFxmuf3FxVlU=;
 b=lKjyj37N4ZXmTkZMnbV39R40knAZAo7JBrPgDeUFACcg0a8wH93ThYmjfAdsbPXKhH
 dMHETwLyn6A4/nz8cTSdgSDdGeETkhxyoKYPwvINUJYlnjqCLI4uMK8scIB4ZUKZbZ1t
 5C8QNwf9B6J3yBwNfaLpsOkIxynVOGidlkadNuJ5qR3dzbDebf2/JIhB+fajsK7emMLg
 O75RRMWPB1vAfNInfSMlWKlyrucEobpJG5qfvWMYPapYyo/Tr92+4ziBsTpKCbnOdET7
 TmXTDmCGlx3v6D10M0Fz4cdAtc8+IR7PcqhaHJ3x2o/stEKc6D0z+fZlwN0rNDqxadb6
 C9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pPrFW5MtY2SdPtXFp5xU52/c3vvTvnKrFxmuf3FxVlU=;
 b=RejDQ1SvbvA9jZEVPd5WPf47zOt7T/0kFgVLyqObaE3ey2mP958PLyLY0h7M6otauP
 cvMFtqJfvmNjjOd9r8Uf7nHf1ZuuIxXrV3kUS26Oyba+RO0bbs/aBhxZpyQCgdt8PwuB
 wfkZZysVw38TuLMVh/pm18Y19tCURpDwaF5dgbIZJ46dfLBE9O5VJPZ3X8JSHgU1YE/x
 1LDIga0T7oatqoywSKI8ithgYP76n41P/iVpHbX5ZsZEapNZmWA5siq671jgm7IG1AE3
 oVo9natVuqKEkZeShvu9Xn8S+MadwFOQpT8ogJVw0Kogp4z537Su22N0LvkVauAGOm4j
 DtjA==
X-Gm-Message-State: ANhLgQ2xWKWgcLxZEHNzvLhrgfor5oX8kBy9PEEA+5WdEiakQ4H/cU2f
 sLDdefRPKkN/S30G3785k1mhEh6khNueVIAEL28=
X-Google-Smtp-Source: ADFU+vuEbyMZ74v4F7ARxg4Ue75d0kVrlwLo85OhmdKnTYjdP8iRCSh/Dm6xJnLmwNsfrWTCodtrfG1js5lBzdmSyZs=
X-Received: by 2002:ac8:6f36:: with SMTP id i22mr23425047qtv.122.1584994536068; 
 Mon, 23 Mar 2020 13:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200118191416.19934-1-mrolnik@gmail.com>
 <20200118191416.19934-2-mrolnik@gmail.com>
 <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
 <CAK4993ie33Awp=sqUOcubqCLFqTd5mTPAkWQfhh3zvorMwnSig@mail.gmail.com>
 <8ac9a03a-a02f-1b48-c75d-77e4b8aea9ef@linaro.org>
 <45d68295-416b-b6d2-a512-86f6120432f0@redhat.com>
In-Reply-To: <45d68295-416b-b6d2-a512-86f6120432f0@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 23 Mar 2020 22:14:51 +0200
Message-ID: <CAK4993iVT358BOU9gQKcNEDLw_smTfvzm0ePDO1WLubtGx_Mvw@mail.gmail.com>
Subject: Re: [PATCH v41 01/21] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004b1a7705a18b4c0f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82e
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004b1a7705a18b4c0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks Philippe.

On Mon, Mar 23, 2020 at 9:20 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 3/23/20 7:03 PM, Richard Henderson wrote:
> > On 3/23/20 10:03 AM, Michael Rolnik wrote:
> >> Hi Philippe.
> >>
> >> It's been a while. let me think about it and get back to you. what is
> your
> >> concern ?
>
> We are using this series with Joaquin for a Google Summit of Code
> project, so we are noticing some bugs and fixing them.
> As it has not been merged, we work in a fork.
> Since it was posted on the list, I prefer to ask on the list than
> directly to you.
>
> >
> > It shouldn't be there.  See commit 1f5c00cfdb81.
>
> Ah it has been moved to cpu_common_reset, thanks :)
> I suppose it is because this port is based on some quite old work.
>
> >
> >>      > +    memset(env->r, 0, sizeof(env->r));
> >>      > +
> >>      > +    tlb_flush(cs);
> >>
> >>      Why are you calling tlb_flush() here?
> >
> >
> > r~
> >
>
>

--=20
Best Regards,
Michael Rolnik

--0000000000004b1a7705a18b4c0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thanks Philippe.</div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23, 2020 at 9:20 PM Philippe M=
athieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 3/23/20 7:03 PM, Richard Henderson wrote:<br>
&gt; On 3/23/20 10:03 AM, Michael Rolnik wrote:<br>
&gt;&gt; Hi Philippe.<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s been a while. let me think about it=C2=A0and get back to =
you. what is your<br>
&gt;&gt; concern ?<br>
<br>
We are using this series with Joaquin for a Google Summit of Code <br>
project, so we are noticing some bugs and fixing them.<br>
As it has not been merged, we work in a fork.<br>
Since it was posted on the list, I prefer to ask on the list than <br>
directly to you.<br>
<br>
&gt; <br>
&gt; It shouldn&#39;t be there.=C2=A0 See commit 1f5c00cfdb81.<br>
<br>
Ah it has been moved to cpu_common_reset, thanks :)<br>
I suppose it is because this port is based on some quite old work.<br>
<br>
&gt; <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memset(env-&gt;r, 0, sizeo=
f(env-&gt;r));<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 tlb_flush(cs);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Why are you calling tlb_flush() here?<br>
&gt; <br>
&gt; <br>
&gt; r~<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000004b1a7705a18b4c0f--

