Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBE5C41514
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1025C217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWbmXTVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1025C217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXUz-0008Fa-8d
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1htXTx-0007eO-HM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1htXTv-0001RS-Ie
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:20:29 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:34392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1htXTu-0001Mu-Ei
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:20:27 -0400
Received: by mail-yw1-xc44.google.com with SMTP id q128so27265423ywc.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=1iA+4V7D0eYBeOU7PrtMX2Ty8yR99s1ogXniCeXFg8k=;
 b=uWbmXTVw9ZDoMbyw4WWKxaxBaX0f5vtyvO801AVY8RPnDdePpmtmLu33g6G+OOU3wc
 RRcHc9AQa4PO6xB2E7XCIXw3t4PhHNM5H5eqPFztVbODLT0QAsF0r+l9Y+QkqHwxQVfn
 jzBEqF8oSPL9OfImUHJYDWfKUH4wKjMhnFknkdLI87CnlTpihFO2h2yY+OlCs47L/5Ia
 nxIEGkItg3lqWJVzoGaKSm51I0uSMOI3IwGgSD9K/cI9I9Se9JtMAATGghdE0fL7aa3M
 OoiQW3P15u9grXvJAunTZ3mrjkELBZ/mBKG6tD6xW6DeA1oLw7cDTeFTu8hJkdjLgYf/
 KhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=1iA+4V7D0eYBeOU7PrtMX2Ty8yR99s1ogXniCeXFg8k=;
 b=D+dq1wKZVNMl/WyYhqPFrfu3TjfPUOUiEptvqBlFAsQ+ejFw/pv/2t8hwmoK3Nmlyt
 8kreiPBlmMA9Lml1kNc1BxvwIoPbgkXIgfjrvAcmR9K/UaoFmpe/mHqZX+tK9EGM/m8/
 N6wFSKBH0zjTtkUN7Wx0im+nCeXVXUzslQuVhwXwvsP+kXRlrsymWNFV50quOqxH3Zor
 wOFCa7ko/mDRcAYcYw/Jl0VPbgIQQBVq9P1lG46/TcmfsTg2bWV7hlqRADBXbY4eSGRP
 ojxDlwxEF2W4cS6t036oj/yIVMAVSnzErVvOPcsHRFCxLyvfAcL+G0sHsA1irWsbudHu
 qGcQ==
X-Gm-Message-State: APjAAAU1uo2G6Ev0rcF/JpARLhi127Z/Aw/LdFPR0iGwq8fPx2btEPTU
 y5dzM3YXAL2Yd7/x+HFVYyA=
X-Google-Smtp-Source: APXvYqwrMdP8NUXjN5p0MfPN634HK1YUMIAEtN+6/nozMePhQb9c+JoN0xQZYllqHSic8OU4nA7Djw==
X-Received: by 2002:a81:a682:: with SMTP id
 d124mr85712776ywh.302.1564752023138; 
 Fri, 02 Aug 2019 06:20:23 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165]) by smtp.googlemail.com with ESMTPSA id
 u123sm18266030ywu.75.2019.08.02.06.20.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 06:20:22 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-4-jan.bobek@gmail.com>
 <CAL1e-=g+F3snN+JQ0CPsdfDQB7cXcGO+frcKxZNdr5T6UpTgAA@mail.gmail.com>
 <CAL1e-=giiT80NvijLPYCk929K5PvewqVjAim5tRwfu+q8biLaA@mail.gmail.com>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e4482a24-48d0-5a79-da0d-dad6e6d3b939@gmail.com>
Date: Fri, 2 Aug 2019 09:20:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=giiT80NvijLPYCk929K5PvewqVjAim5tRwfu+q8biLaA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tqpoyOUy7vn7bvj4VeicfIBRlJJMauMak"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: Re: [Qemu-devel] [RFC PATCH v1 03/22] target/i386: Use prefix,
 aflag and dflag from DisasContext
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tqpoyOUy7vn7bvj4VeicfIBRlJJMauMak
Content-Type: multipart/mixed; boundary="cqgsqvWGdFWd1Q7fUjlHusQFcu7y3oloB";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4482a24-48d0-5a79-da0d-dad6e6d3b939@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 03/22] target/i386: Use prefix, aflag
 and dflag from DisasContext
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-4-jan.bobek@gmail.com>
 <CAL1e-=g+F3snN+JQ0CPsdfDQB7cXcGO+frcKxZNdr5T6UpTgAA@mail.gmail.com>
 <CAL1e-=giiT80NvijLPYCk929K5PvewqVjAim5tRwfu+q8biLaA@mail.gmail.com>
In-Reply-To: <CAL1e-=giiT80NvijLPYCk929K5PvewqVjAim5tRwfu+q8biLaA@mail.gmail.com>

--cqgsqvWGdFWd1Q7fUjlHusQFcu7y3oloB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Aleksandar,

thanks a lot for your feedback! I have to admit that I paid little
attention to this particular patch, because it was authored by
Richard; I simply included it verbatim. I agree that it would be
clearer if it were split into three patches, and the description could
be made less confusing.  I will make sure to include your suggestions
in v2.

Thanks a lot for looking over my code!

Best,
-Jan

On 7/31/19 4:04 PM, Aleksandar Markovic wrote:
>=20
>=20
> On Wed, Jul 31, 2019 at 9:41 PM Aleksandar Markovic <aleksandar.m.mail@=
gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
>=20
>=20
>=20
>     On Wed, Jul 31, 2019 at 7:59 PM Jan Bobek <jan.bobek@gmail.com <mai=
lto:jan.bobek@gmail.com>> wrote:
>=20
>         From: Richard Henderson <rth@twiddle.net <mailto:rth@twiddle.ne=
t>>
>=20
>         The variables are already there, we just have to hide the ones
>         in disas_insn so that we are forced to use them.
>=20
>         Signed-off-by: Richard Henderson <rth@twiddle.net <mailto:rth@t=
widdle.net>>
>         ---
>         =C2=A0target/i386/translate.c | 299 ++++++++++++++++++++-------=
-------------
>         =C2=A01 file changed, 152 insertions(+), 147 deletions(-)
>=20
>=20
>     Hi, Jan.
>=20
>     The series overall looks great, and hopefully you will refine rough=

>     around the edges parts soon. Thanks for this valuable contribution!=

>=20
>     About this patch, I noticed that it mentions "aflag" in the title, =
but
>     the patch actually does not change any code related to the variable=

>     "aflag" in the described sense - it looks to me it just reduces the=

>     scope of the local variable "aflag", which is certainly different t=
han
>     "use aflag from DisasContext" as it could be implied from the
>     patch title. You definitely should not confuse the readers with
>     such inaccuracies.
>=20
>=20
> Also, Jan, you need to correct the code alignment (indentation), if
> you enclose a part of a function to form a new code block. I guess
> you just left these cosmetic things for v2 or later.
>=20
> Sincerely,
> Aleksandar
> =C2=A0
>=20
>=20
>     Actually, I think the patch would look much better if split into th=
ree
>     patches (easier for reviewing, and also clearer for future develope=
rs),
>     wouldn't it?
>=20
>     Yours,
>     Aleksandar
>=20


--cqgsqvWGdFWd1Q7fUjlHusQFcu7y3oloB--

--tqpoyOUy7vn7bvj4VeicfIBRlJJMauMak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1EOJAACgkQZeg2ldrj
Ns/dNxAAlC3Xpcd7JpdSe50txa0h1Fr+uV2vwnlJ2VvrrBItDNVg3xlWy/HiywlD
fdj1itrdiB73Ox1WE9pOqipw26H0p2m+CB2jPEF8C+sGtfEupHVggzQIWD7csmp4
al63qHFrwLS4b9BpfJis1Al6qO97KUdl5Q0JX5ia5b6jjo1fGo2EYsqhNbrA0U4U
rnaFsX+Z7B8cBmIk4fEzMdbX5KdGINxxgSRCw7n3KXeTY+URUW/93BW3QMMRr2HR
WTbZnASftu3WaGgzmqWDJ16sgEapujnfsHSptRpbPcB0yeoMi9GC4rRAd3bfqJAd
oSUTVwxPV8EA19/vdZQ174mGJvLHHvrFPYDaeNQkH6Ofwl8vK5IA+k7pPBLyayNu
zQt4+dpPU3eBBXffqynpuxt9L0S6IDBxxhT8Fc5Kj8T1OMZLJ96cXcUrUdcwoHU4
VEZ6Jwb7hxOBlKZvT4EjmwjbHNwOS9OuzTVZkPVwqG2zGxNtNSPKnC6A9TMCm6to
VjTHXKCLS/SIs1eOEEpRpY1EUdKsgXzGOhmHQPJXzhDFMJUzaFmkXuAxKBx+VF6k
pjAAV15WB3tG+2z4kIR4xSRhNTvRKjRw6IIrbfmlAvWYVVFw6Vd+Sanh1bteaDSb
6Gmd0LFwPIjhGRF92gorDxdx2sa/IjPL2MjUp1JGyKpclrAUwFM=
=fU4H
-----END PGP SIGNATURE-----

--tqpoyOUy7vn7bvj4VeicfIBRlJJMauMak--

