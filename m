Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5AC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 11:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BB020659
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 11:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZkaywfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BB020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhYJS-0005W7-4V
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 07:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhYHX-000523-Cm
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 07:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhYHQ-0000Mk-7J
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 07:46:03 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhYHM-0000GA-GU
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 07:45:57 -0400
Received: by mail-ot1-x344.google.com with SMTP id e8so10582310otl.7
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=J989QPnTFPA4HOMLHLnU3ooHNh4CW/yEHg/IzF7pzpo=;
 b=mZkaywfvzRfB7UVg3NYuFbQ3IWockvB9dYvgCpUGcmv3/IP0s/Tua4yP3TUUOK5ed3
 T1nuvf6BWOIthEopicYgEUFac2kP3CvqqMw9AxUQ7se2A2pI1/MtHPggQxrqENU8HHh4
 u5YzutV48WJ4td4mQpjtaECSkhv8oizjMEqxx+jVDhDabNmDWCNgjWDdHJz3Q8lhZmt3
 Pxdh+JVbT5hGjJYdvl6PMNASsy30+VxGd0XLnYPDrJlEso7ZxgY981aTfpCr9+InEsp3
 Gwq+Sp1jpVeAHl9Zx7JFwiW+B2TXexrvVP2qSmIflEP9SkEgcC9JIGTQkM840zwf0b0/
 nUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=J989QPnTFPA4HOMLHLnU3ooHNh4CW/yEHg/IzF7pzpo=;
 b=rwxmq2A+cPDXQowN2FOxB2tBmUcmCrBT2iJWGquKQ1Y9jdeJaK4lmT6RsFi3mHGTGm
 d47xk9DZRHqGHVdA5LxTD40r7cOqonfsnMOg58mLO93kSrn2fzGw1MhbjF3w62grWcCA
 8cp4/6cvo9+Lokwgd8O3fqqy7uKpw8LqJcUKAH55SMqx3yoiSS4WuVRA0yFk6m4KYBKC
 29NN4kzkWrFOfUM06OYghILasQ7Yu97lNj83QRQ/o1p3PSxyz5nWdpxstUYFQLWzLuW3
 016danv4C8glkcyppPYfwYLO0EOOKhwcB2cO+Ru8Wrd8geTu0mDdaxJfQCvHAmG2o3ue
 2+TQ==
X-Gm-Message-State: APjAAAWHAnvrO2qwGIfs3Vnzsbq0yWGI87MncIG8xhPaQH/A8SZX5F9N
 xm5KSnI0DmBvyNig19mQzzZAeS5ZXXiQOErij00=
X-Google-Smtp-Source: APXvYqxAELdNKypxUy04ILq8Kxf25K1Xx5e/WpcJcBcDn3TNWMFI2NCBV1HoG3oy3u5l2uMQQ3nQ5s8wxts2XB2pJoI=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr15411181otq.306.1561895153564; 
 Sun, 30 Jun 2019 04:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 04:45:53
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 04:45:53
 -0700 (PDT)
In-Reply-To: <1896cde6-ce3a-3aa9-d4ee-c97944374338@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-5-richard.henderson@linaro.org>
 <CAL1e-=i266juep8-7N1=At680eY3AE-_vyNL_5GO=VRAnH_tig@mail.gmail.com>
 <1896cde6-ce3a-3aa9-d4ee-c97944374338@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 30 Jun 2019 13:45:53 +0200
Message-ID: <CAL1e-=jx7jpJMgWL5u=uckdNo+4O-XqaCOJSp17yO1Vsb4SSEQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 04/16] tcg/ppc: Enable tcg backend
 vector compilation
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
Cc: mark.cave-ayland@ilande.co.uk,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 30, 2019 12:48 PM, "Richard Henderson" <richard.henderson@linaro.org=
>
wrote:
>
> On 6/30/19 11:46 AM, Aleksandar Markovic wrote:
> >
> >
> > On Saturday, June 29, 2019, Richard Henderson <
richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >
> >     Introduce all of the flags required to enable tcg backend vector
support,
> >     and a runtime flag to indicate the host supports Altivec
instructions.
> >
> >
> > If two flags have different purpose and usage, it is better that they
> > have different names. (perhaps one of them should have the suffix
=E2=80=9C_runtime=E2=80=9C)
>
> Huh?  They do have different names.  Very different names.
>

They do. If you leave the same name, you would make any search for that
name during future debugging/development more difficult.

> > Also, I am not sure if Altiveec can be reffered as isa, it is a
part/extension
> > of an isa, so =E2=80=9Cisa=E2=80=9D seems  superfluous here.
>
> It also matches the other existing names, so I'll leave it as is.
>

If something is wrong in the old code, it does not mean one should continue
the same practice.

> > checkpatch warning should also be honored.
>
> It's bogus.

I don't think it is bogus. The comment should be converted to a regular
one-line ot perhaps multiline comment before if-statement. Althoug it may
be correct in the sense of C-syntax, noone expects coment to be inlined
into if-condition, and it makes the code feel obfuscated, rather than clear=
.

> > WARNING: Block comments use a leading /* on a separate line
> > #155: FILE: tcg/ppc/tcg-target.inc.c:2842:
> > +    if (hwcap & /* PPC_FEATURE_HAS_ALTIVEC -- NOT YET */ 0) {
>
> It's not a block comment; the whole thing is on one line.
> I have no idea why it doesn't notice.
>
> In any case, this goes away in patch 13.
>
>
> r~
