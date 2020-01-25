Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 10:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E472070A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6B9+854"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E472070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivIbQ-0000sN-00
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 05:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivIak-0000K8-R6
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 05:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivIaj-0004Fd-6H
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 05:23:02 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivIaj-0004Eq-0y
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 05:23:01 -0500
Received: by mail-oi1-x242.google.com with SMTP id a142so494219oii.7
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=RPtfx6gYlteJwLXwgiSTj5CsprkMA0W45htVBLJ9B44=;
 b=p6B9+854XJyO2YsraMPAbvsQcIVIbjcWCjjsPlDkPvVUGZZo+TVBiPGsHz4Ct8emZ9
 T8ecXIhCRgwzQvbRwl19nUNYaSQguTGMX4Mv5uZ6qRPRTDlmt+hbd30UH7W2TFoMICxT
 xUmgNDoWSi24mp7kss5PYWbpxOnsRsiHFBeEGA+3x2ypsgZrlfCNUl1Nq6ZPzuTSzZrK
 EWDW0/x4lKGGgBINd9O/iT4R3QoZEzhAawA7O4YWjB55mbjCud4CaO2dvj5Ci252nw3N
 FlhpdbMceYHWTbkRBHBPB9TXr+1ryu9st1AbCGWSlLYnr1Zmqxgxh4VQ4mvYCBWcYCuf
 RSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=RPtfx6gYlteJwLXwgiSTj5CsprkMA0W45htVBLJ9B44=;
 b=RUV7lrQeHfvkvOsZH94M6FOOLG5uX3qraQJRnRWcC3nWlUoTcbfUQtbLoMM7azB99L
 dF/FQDx/BFvlw1uMDj5S5qYOdbVvPhZehVk1Q0gH42IZidrZB+tHn4LZqpyxZ8kmxmzJ
 dsV2A9q8vaMIDoUM5QANLNXumro6ULbjVK47XAqb3+N8lS4blQ0yj8ZfPdxniwCNH5iA
 10bhChWODO1YyhZ3w50TSpeUbgomI9/4k037neLOqQWunJU79VNecmfUPplmsjTjHa37
 LDjKFCpmnu5ySzHWgAFUXZlODOiAOMv8tGJSzphdoZv6bU3WTd1dun4Miuyqq0/B/hSO
 05zA==
X-Gm-Message-State: APjAAAWrru4wVmbiKErQAUsW8fxE4BK+eSk6q1sSOoCoRnm8hZvBQawF
 wRw/FqaGTZEPMy9U1pI1RGMgNWFOaMVV0YfhZsQ=
X-Google-Smtp-Source: APXvYqycgCHMEdG3DL6Ic9pmrHvfXB8YFQWyf9gCb101aZVC10slPvndmQCgIcDUvgkcVBr2ir3LHQz1IyDa+aLTN3I=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr1929292oih.106.1579947780189; 
 Sat, 25 Jan 2020 02:23:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 25 Jan 2020 02:22:59 -0800 (PST)
In-Reply-To: <0d2d0fff-302b-b8e6-cbc6-5c2bb66f1f8e@linaro.org>
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <779b7b35-16a8-0538-ad87-fac218c93e82@linaro.org>
 <CAL1e-=hqgWesfm9f8fsSQ8JS54LybNMMGygbCNi0O+VyfSAJvg@mail.gmail.com>
 <c3c80f0a-e348-4c7c-e8c4-579b16ec22a4@linaro.org>
 <CAL1e-=g89vC8gw6xNiGcNAhDixX2xZgnDjKgvDsChkvHHpduQA@mail.gmail.com>
 <0d2d0fff-302b-b8e6-cbc6-5c2bb66f1f8e@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 25 Jan 2020 11:22:59 +0100
Message-ID: <CAL1e-=gsX+_G28i3MbFn3qLW7YKyQapaAdEhpkCKtvwS6juHHQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] disas: mips: Add micromips R6 disassembler -
 infrastructure and 16-bit instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000033b108059cf442bc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000033b108059cf442bc
Content-Type: text/plain; charset="UTF-8"

On Saturday, January 25, 2020, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 1/24/20 1:38 PM, Aleksandar Markovic wrote:
> > On Friday, January 24, 2020, Richard Henderson <
> richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >     The thing I'm concerned about here is any future maintenance of this
> file.  One
> >     would surely prefer to edit the original decodetree input than this
> output.
> >
> >
> > Here is the deal: This dissasembler is meant to reflect the
>  documentation of a
> > particular ISA, and as the documentation largely stays constant (except
> adding
> > some insignificant errata), the disassembler will stay virtually
> constant, we
> > wouldn't like even to touch it, and we like it this way.
>
> No, this is neither right nor proper.
>
> To review the code in this form is significantly harder than in its
> decodetree
> form.  That is in fact the whole point of the decodetree form: otherwise
> we'd
> still be writing these sorts of parsers by hand.
>
> While there's no license on this new file (another problem), if as assumed
> this
> is GPL 2+, then you are in violation of the GPL.  From section 3:
>
>   # The source code for a work means the preferred form of
>   # the work for making modifications to it.
>
> You cannot with a straight face claim that the generated c is the preferred
> form for making modifications.
>
> Finally, suppose we improve decodetree.py, so that it produces code with
> which
> the compiler produces better code, for some metric of better.  We would
> want
> this disassembler to benefit as well.
>
>
I think you got some things upside-down. A tool developent and usage should
be driven by the needs of users of a tool, and not dictated by the author.
Users should be free to use the tool in any way they seem suitable,
including its modification.



> r~
>

--00000000000033b108059cf442bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, January 25, 2020, Richard Henderson &lt;<a href=3D"mai=
lto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On 1/24/20 1:38 PM, Aleksandar Markovi=
c wrote:<br>
&gt; On Friday, January 24, 2020, Richard Henderson &lt;<a href=3D"mailto:r=
ichard.henderson@linaro.org">richard.henderson@linaro.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0The thing I&#39;m concerned about here is any futur=
e maintenance of this file.=C2=A0 One<br>
&gt;=C2=A0 =C2=A0 =C2=A0would surely prefer to edit the original decodetree=
 input than this output.<br>
&gt; <br>
&gt; <br>
&gt; Here is the deal: This dissasembler is meant to reflect the =C2=A0docu=
mentation of a<br>
&gt; particular ISA, and as the documentation largely stays constant (excep=
t adding<br>
&gt; some insignificant errata), the disassembler will stay virtually const=
ant, we<br>
&gt; wouldn&#39;t like even to touch it, and we like it this way.<br>
<br>
No, this is neither right nor proper.<br>
<br>
To review the code in this form is significantly harder than in its decodet=
ree<br>
form.=C2=A0 That is in fact the whole point of the decodetree form: otherwi=
se we&#39;d<br>
still be writing these sorts of parsers by hand.<br>
<br>
While there&#39;s no license on this new file (another problem), if as assu=
med this<br>
is GPL 2+, then you are in violation of the GPL.=C2=A0 From section 3:<br>
<br>
=C2=A0 # The source code for a work means the preferred form of<br>
=C2=A0 # the work for making modifications to it.<br>
<br>
You cannot with a straight face claim that the generated c is the preferred=
<br>
form for making modifications.<br>
<br>
Finally, suppose we improve decodetree.py, so that it produces code with wh=
ich<br>
the compiler produces better code, for some metric of better.=C2=A0 We woul=
d want<br>
this disassembler to benefit as well.<br>
<br></blockquote><div><br></div><div>I think you got some things upside-dow=
n. A tool developent and usage should be driven by the needs of users of a =
tool, and not dictated by the author. Users should be free to use the tool =
in any way they seem suitable, including its modification.</div><div><br></=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
r~<br>
</blockquote>

--00000000000033b108059cf442bc--

