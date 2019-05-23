Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B394C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6112075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ8tPp9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6112075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41473 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTs5r-0001fJ-62
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:05:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTs4P-0000yL-Uc
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTs4O-00013y-Ip
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:04:01 -0400
Received: from mail-yw1-xc33.google.com ([2607:f8b0:4864:20::c33]:38630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTs4O-00013E-BA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:04:00 -0400
Received: by mail-yw1-xc33.google.com with SMTP id b74so2609346ywe.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to;
	bh=ASp5972/qsXywbXWj0hvvS0etQkPWYWmbVGek+lwI8M=;
	b=AJ8tPp9cOjrtNl4tUp1Lqcv9MEXoUHDO+2eE1p29Dcym1sVogumSDB8y7x7zVqFdDT
	cBccNoZkmJH/p4AClTtPbk4UctJqAU+dtkwwc2eaTD7M2m7GvrwlFgxpvDy5DHv2VcmI
	x0cK7ng+aQPjU5UqL/Ll5lMPgQu90cTABVpzFp7IfM3V74jC8R0WlkxQF8VyFY2h1/hT
	yXybBx1qVj2M+YxwTfozJpm6opl0jdlmLM1tbKeh+4587dMs+RYPTGQNMQzuk3gSbrJV
	H7bAXpPVguVwo6B4QCLxAH/AagefP+6y3Mun+wBPmmcD5oDsEVhiSsbxT2/2f01UI4Wn
	8IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to;
	bh=ASp5972/qsXywbXWj0hvvS0etQkPWYWmbVGek+lwI8M=;
	b=bOJrR+vdd2P9toPca4Do+HebTTpoL3mfuperOf0ihB9LNLuVvz9LiafwCSZDMu8uQc
	xgvIN2DtoYjeCFL+ZwjAvONCtyPvnZeIaVGBnt9lX9ovDj5D5Fd4vxHzbx+gIQ012xKP
	+ZCdl6vEeAL3tfVD9/gzanNac/r/VEkyip8HWsTUHIdmhk/5NRQIMYfILruLisuiY12Y
	u6Fk/5QrokrivJLS+q/Vp3NC6Zlh1oTfWxjtmjynYnLZIsA2fVKwuuScEsH/YzICZhmK
	swVchtaVdln/j1Ew13SKCBAqzhtTuYp82a/oXbzccvPXGAh2BmBfb7EVNJoe97tNPXgf
	eeRw==
X-Gm-Message-State: APjAAAUP5YPbkki6e9qSgpZZxhXI8UhELbLBnvvVokF0fVV14/j01u11
	d3dFI8yR59rEOPNEvVBaLYN9/n9l
X-Google-Smtp-Source: APXvYqxX/XpNfP4H0JVs6awxiZ++N31wZj4WuvWq9GfnUkOqhx+6sCZCqxKQsKHdEzsP02yfQkdAIw==
X-Received: by 2002:a81:2ac6:: with SMTP id q189mr39104738ywq.97.1558634638762;
	Thu, 23 May 2019 11:03:58 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
	[69.222.133.165]) by smtp.googlemail.com with ESMTPSA id
	l131sm2825201ywc.0.2019.05.23.11.03.57
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 11:03:57 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<87v9y5gvfq.fsf@zen.linaroharston>
	<233da7c2-baed-face-16e8-af7a06d642c5@gmail.com>
	<0d863686-435b-e3f6-e358-926591bbd7d3@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
	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
Message-ID: <3e9ec904-62f4-1886-7d33-1903e795adf0@gmail.com>
Date: Thu, 23 May 2019 14:03:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0d863686-435b-e3f6-e358-926591bbd7d3@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="uStn0J5Uu8jbNXG08xXWHntSxVXxZtBHn"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c33
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RISU v2 00/11] Support for i386/x86_64 with
 vector extensions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uStn0J5Uu8jbNXG08xXWHntSxVXxZtBHn
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Message-ID: <3e9ec904-62f4-1886-7d33-1903e795adf0@gmail.com>
Subject: Re: [RISU v2 00/11] Support for i386/x86_64 with vector extensions
References: <20190517224450.15566-1-jan.bobek@gmail.com>
 <87v9y5gvfq.fsf@zen.linaroharston>
 <233da7c2-baed-face-16e8-af7a06d642c5@gmail.com>
 <0d863686-435b-e3f6-e358-926591bbd7d3@linaro.org>
In-Reply-To: <0d863686-435b-e3f6-e358-926591bbd7d3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/21/19 12:49 PM, Richard Henderson wrote:
> SSE2 is a mandatory part of the x86_64 ABI.
>=20
> I sincerely doubt we care about testing 32-bit that does not have SSE, =
but even
> then this patch set will not fail, as the kernel will not include the S=
SE
> registers into the signal frame.  It would be the actual test cases for=
 SSE
> instructions that would SIGILL when run on a 32-bit guest w/o SSE.

Fair enough. I had no idea that SSE2 is mandatory in x86_64, that's
good to know. Let's keep the SSE default then.

> No, the assert is really an assert, because we have also masked the --x=
features
> value against the set of features stored in the signal frame.  If the k=
ernel
> reports a feature in the signal frame for which there is no cpuid leaf,=
 then
> something is very confused somewhere.

Ah, I see. Makes complete sense.

> I am not sure that we can validate that the features in the signal fram=
e match
> the --xfeatures value, because I *think* that features are omitted from=
 the
> XSAVE data structure when they are in init state.  E.g. when we have no=
t yet
> exercised the feature.
>=20
> This caveat is definitely true of ARM SVE, and I found that if I assert=
ed that
> all of the SVE state was in the signal frame that the generated RISU te=
st which
> uses memory would fail the 1st checkpoint, because no SVE instructions =
had yet
> been executed.
>=20
> A careful reading of the XSAVE documentation, plus some experimentation=
, is
> definitely required.  Maybe hand-craft a test case using XRSTOR, giving=
 it a
> save area that specifies all features to be reset to init state.

tl;dr Richard is exactly right; a component may be missing from the
XSAVE region if it's in the "initial configuration." I'd just leave it
as it is now: it appears everything more advanced than the SSE state
is in the initial configuration when the test image starts
executing. It won't show up until there's instructions which actually
touch it, but by then we get a SIGILL if the HW doesn't support it.

Long story: The Intel manual definitely has a notion of "init
optimization," in addition to "modified optimization." Vol. 1, Section
13.6 "Processor Tracking of XSAVE Managed State" says:

  The XSAVEOPT, XSAVEC, and XSAVES instructions use two optimizations
  to reduce the amount of data that they write to memory. They avoid
  writing data for any state component known to be in its initial
  configuration (the init optimization). In addition, if either
  XSAVEOPT or XSAVES is using the same XSAVE area as that used by the
  most recent execution of XRSTOR or XRSTORS, it may avoid writing
  data for any state component whose configuration is known not to
  have been modified since then (the modified optimization). (XSAVE
  does not use these optimizations, and XSAVEC does not use the
  modified optimization.)

So, XSAVE does not use any optimizations, whereas all other XSAVE
variants use at least the init optimization. Furthermore,

  The following notation describes the state of the init and modified
  optimizations:

  * XINUSE denotes the state-component bitmap corresponding to the
    init optimization. If XINUSE[i] =3D 0, state component i is known to
    be in its initial configuration; otherwise XINUSE[i] =3D 1. It is
    possible for XINUSE[i] to be 1 even when state component i is in
    its initial configuration. On a processor that does not support
    the init optimization, XINUSE[i] is always 1 for every value of i.

  [...]

The processor does not need to detect "return" to the initial
configuration; this makes more sense once it's clear what the initial
configuration is:

  The following items specify the initial configuration each state
  component (for the purposes of defining the XINUSE bitmap):

  * SSE state. In 64-bit mode, SSE state is in its initial
    configuration if each of XMM0=E2=80=93XMM15 is 0. Outside 64-bit mode=
, SSE
    state is in its initial configuration if each of XMM0=E2=80=93XMM7 is=

    0. [...]

  * AVX state. In 64-bit mode, AVX state is in its initial
    configuration if each of YMM0_H=E2=80=93YMM15_H is 0. Outside 64-bit =
mode,
    AVX state is in its initial configuration if each of YMM0_H=E2=80=93Y=
MM7_H
    is 0. [...]

  [...]

No surprise here; the initial configuration is just all zeros.

I ran some experiments on my laptop's Intel(R) Core(TM) i5-4210U to
find out what actually happens. This CPU supports AVX (but not
AVX-512) and doesn't support XSAVEC, so I only looked at XSAVE and
XSAVEOPT (XSAVES is kernel-mode only). I found out that:

1. both XSAVE and XSAVEOPT do not include the AVX state if it is in
   the initial configuration (not only XSAVEOPT),
2. return to initial configuration is not detected, i.e. the AVX state
   is included even though it has been set to all zeros via vxorps,
3. the AVX state can be brought back to the initial configuration via
   XRSTOR with the AVX component removed.

Cheers,
-Jan


--uStn0J5Uu8jbNXG08xXWHntSxVXxZtBHn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAlzm4IcACgkQZeg2ldrj
Ns9L5xAAnW6Bc8Ni88E0R5J0AHsZX+2npp4g7L9j/QN4x3oWlook2qTF/XtmpAZl
P9Pd7Tvun+t1VGJ1esP2OhkIGO9A/wx5dGGw3YnkByz67B4MCMdd/7B/FwQ4UA4h
iLgZNwDwX97JWjzHA5vTT8+ElC0cmkerpzjkd3z/bzM+Lfhu2OAFY408w4WJkbqu
nJ8WUcHivncOVeFtyNldCrQzbLeLBlr8am5B6muo5SCpa8iI8LkW0NJIjHydG1rq
RueqqfOqNB04DdLj/WTZXdYtLwXndd4seAUm1KHC5dUWq/8u1Oj4kAZShXkDOStE
63EeclUip2xLGQzA+T4V5CLYFHqWjoKj0+XEcwsGx7UXPXOGZas/ST8cJ9HPhdFu
TbR+3c0a296d25rJS3rG1XyBmZj9JYDDP39VCle7tCtCx8Zw2ANjxKklLViUYYnq
DJOPIyqRW/SPf0rOZIfMzTmq7TcpcZ1XGxrAhI6I7oKiLLnLEMv0bPeC0y0oV4sr
6O1dQlOzPirT+PeFuvve7ll1lSSjFZMTFdU9OOQlnlx3ecQHBLgUO7yoSwMhyzvy
CSY0ohqhBPU0tNOIqSDnTibVbqqpb+gJ0vAaAqubn1KkrvWnRPyrtmLWvh/4c7tf
K75JDy5h81L1SGKT7FQje6B3gDnYtLlBS5HFO4PWa+ShVFJo7Jw=
=3e70
-----END PGP SIGNATURE-----

--uStn0J5Uu8jbNXG08xXWHntSxVXxZtBHn--

