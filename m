Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C9C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48852082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSzCpTfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48852082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTizh-0005HA-Lw
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTiz1-0004ks-8k
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTiyz-0004H7-Ml
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:26:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTiyz-0004Gk-0b
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:26:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id u16so1223134wmc.5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sgXXg4ceZKsTQ6nV86CvYTkHxSQK0zyjxQd2Fe7sS04=;
 b=CSzCpTfVA1zjOobnTKAu4ECvgBvxVeLIkxtbrFoBaWRXySuX9UV1mmlGJ0NXT02SLa
 H/n/yixfEyQ7OMNbEvEQEN9AGCDzi6fjvBLa0F2BV98zZG/nthAfu94i2IL9+g+1FIWV
 zsSQ1N9nSD7ylXFFxQFfh2FielIIUQhMMxSBT4iZJDVRZvdKwqNJOPyemB11AqhgKY8k
 2zS+41AuxcZxrR6kM/2pREK1VO8TgtUlWuPSk57dpy5bcLh9HjXzjfwogmpBJcjWr/wf
 K41UuiBonaawRqfLvs6QhYBkdRanr6g59k0DHivNRYTFHvQ2kaOUjywgVkJcoTiub5Hd
 h7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=sgXXg4ceZKsTQ6nV86CvYTkHxSQK0zyjxQd2Fe7sS04=;
 b=c/N1/Cpky0NfrwkeHWCcfTx03kBmPss6GWgZl7vXRrCF6WcM5TkjwNveXS+dmVIZqe
 o514hI8LnLWertK2u7Q5DGZXy83UNojIjE4yXMCP7sBmKrBbcucEH3HrI4UIDyDtmCI8
 tVRUlUer7XQahth7R5h6Hf13rARBNzmrzzCDsL0TNiLaMuu6YIZw5StTbEcj2wkGPx7L
 Y5pf116vXrJDiDFWgTMKXw2CpfzyXhczisW9+EoJYr02BMCrSCcKC375SS6lw78/6kLe
 r7/Il/Sv8TAdOPGlhAjbSIKFRnROPbX5Ws3PGoJQa2jIXcD9u7ukcTAeMVbkKj87hKT0
 XAig==
X-Gm-Message-State: AGi0PuZA89ZfyCC7z56W6nBmHj0ox9RLFC70UK7VYwwU0mHra97IQSMC
 pV3oGhxINLaZBJzJEd2JEAAPcQ==
X-Google-Smtp-Source: APiQypI6BeJ1oTcI+4UBBdN+vYA48LR8VXDdjnDCrNy0kPBwyNgRTyVcUMwk/hP8m/Vx78uQVANvOQ==
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr2113349wmi.2.1588152379418;
 Wed, 29 Apr 2020 02:26:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b4sm29294207wrv.42.2020.04.29.02.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 02:26:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 26F5B1FF7E;
 Wed, 29 Apr 2020 10:26:17 +0100 (BST)
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
 <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
 <87d07rlac5.fsf@linaro.org>
 <9f6c1efc-a195-0f5d-8c34-4dfb45d910f8@vivier.eu>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
In-reply-to: <9f6c1efc-a195-0f5d-8c34-4dfb45d910f8@vivier.eu>
Date: Wed, 29 Apr 2020 10:26:16 +0100
Message-ID: <87a72ulk1z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, philmd@redhat.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 28/04/2020 =C3=A0 20:43, Alex Benn=C3=A9e a =C3=A9crit :
>>=20
>> KONRAD Frederic <frederic.konrad@adacore.com> writes:
>>=20
>>> The MC68881 say about infinities (3.2.4):
>>>
>>> "*For the extended precision format, the most significant bit of the
>>> mantissa (the integer bit) is a don't care."
>>>
>>> https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf
>>>
>>> The m68k extended format is implemented with the floatx80 and
>>> floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
>>> an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
>>> accepts that the most significant bit of the mantissa can be 0.
>>>
>>> This bug can be revealed with the following code which pushes extended
>>> infinity on the stack as a double and then reloads it as a double.  It
>>> should normally be converted and read back as infinity and is currently
>>> read back as nan:
>>=20
>> Do you have any real HW on which you could record some .ref files for
>> the various multiarch float tests we have (float_convs/float_madds)?
>> Does this different of invalid encoding show up when you add them?
>
> On my side, in the past when I started to implement m68k FPU, I used
> TestFloat and SoftFloat I have ported to m68k and I compare the result
> in QEMU and in a Quadra 800.

Surely TestFloat and SoftFloat is all emulation though?

Anyway if you have a Quadra 800 running Linux could you generate some
.ref files for the float_convs and float_madds test cases. The binaries
are static so you should just be able to copy them and run.

> https://github.com/vivier/m68k-testfloat
> https://github.com/vivier/m68k-softfloat

Ahh I see you have sys_float functions to compare to TestFloat.=20

> I also used the gcc and libc testsuite to detect problems but this was a
> very slow process...
>
> I have also ported RISU to m68k, but I didn't add FPU test in it (does
> it support FPU test?).

There is no reason why it couldn't. The FPU support would basically be
ensuring the appropriate registers are saved out of the context. I did
similar when we expanded the aarch64 RISU to support SVE. In fact
looking at the code:

    for (i =3D 0; i < 8; i++) {
        if (m->fpregs.f_fpregs[i][0] !=3D a->fpregs.f_fpregs[i][0] ||
            m->fpregs.f_fpregs[i][1] !=3D a->fpregs.f_fpregs[i][1] ||
            m->fpregs.f_fpregs[i][2] !=3D a->fpregs.f_fpregs[i][2]) {
            return 0;
        }
    }

it seems the fpregs are included and tested so it should be good.

That said RISU's random instruction approach means most floating point
numbers very quickly become tend to NaNs which is part of the reason I
wrote the float_convs/float_madds tests which try to be more systematic
in exercising the range of float types (normals, denormals, min and max
etc). Maybe we could improve risugen's seeding of floating point values
to better exercise FP ops rather than just dumping random stuff there.

>
> Thanks,
> Laurent


--=20
Alex Benn=C3=A9e

