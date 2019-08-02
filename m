Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89B0C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D9E2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tn7xk/If"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D9E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXi9-000087-Mk
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1htXhY-0007cw-LK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1htXhX-0006bR-51
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:34:32 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:40645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1htXhW-0006bB-UB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:34:31 -0400
Received: by mail-yb1-xb44.google.com with SMTP id j6so4694755ybm.7
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=DqWcs6ASHKa/+nhKoO+BaqHLruBVwyT2sWHTEdZOLec=;
 b=tn7xk/IfPFHS3w22gg+p5th50y7lPKbqvG72g7JsEM2h7Ow99L4rb8GRiyusKo08DF
 V9hjMAX04280Lw00I/p1tNNVzAa+TL24Ie1Vzdn/By5GNBYQOqyZr4tWcHiWJzibikmY
 MtjWqD8CT5Lm9rJnYzADzAA5Pk3ngpDFXNhqKBSkhOv+UD7bJZzBKVvE7EpXBG/kX17+
 2mcAcn8Aqjwj+GOOWXiKEs1pgs81Ixox2J6Buy8/KAa6YTSYD4aNORe/GEXnSYi71GZ4
 weIaJtUS3j4qzeu0pEj1fuWbJ9uykODcWP5BulDhzA2prCIklq9QggpU5kzz5eJ4e4kf
 eR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=DqWcs6ASHKa/+nhKoO+BaqHLruBVwyT2sWHTEdZOLec=;
 b=AWiwGN2i41h08GE3tRRru9SwLX4medvUDxG3vLR14To+2GIMHaP6wgzeLqzWzggW5y
 LGZrbhwl5hLZbfC9RfXcAmAq58Bz/dXlwUWRpaIg8DL981JQx4ZFYtOxtVUG7cAgyqbD
 iOWkzKREFcNd2LH+qmLfO1mLLaGMc8wnz9JsNaRyxLCRm/W1F1VQDMIgBeSJKw5K+EOg
 dABlKBXXmSbK3GamcXwugrjfPSqXk7ibWRGPgOlL2xFUAZeXCXDLn+xjUVMkIviz3kP0
 274FIlNUJAxwAlUBdW/2ew94Yk8RO9jbYLlztwGzHC9DkoZsUxC9SvKpwy2XkhZ7aWhH
 PL/Q==
X-Gm-Message-State: APjAAAXUKjiLjZzLedblVWAjdT0biixed8QcO6qk1y9+QD/Zysv0HN+k
 RXet6xWlWNp4ZkajK+sTsUA=
X-Google-Smtp-Source: APXvYqy4tkXarrukoT5y5I88oMd5qRv4Cx+zDzMeN7KDe2yYPeFfq+Ykf3glZaWSJmF0SQr2A3NVCA==
X-Received: by 2002:a25:d252:: with SMTP id j79mr90009266ybg.236.1564752870187; 
 Fri, 02 Aug 2019 06:34:30 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id 143sm18198960ywi.81.2019.08.02.06.34.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 06:34:29 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-7-jan.bobek@gmail.com>
 <0e38a01b-6a1b-cd18-1fd0-29faea840e69@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <73a5354a-f4d0-9e94-418a-13b19bb1d9b1@gmail.com>
Date: Fri, 2 Aug 2019 09:34:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0e38a01b-6a1b-cd18-1fd0-29faea840e69@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kAz5Npqpbz1dW5GhFUQAN25QM7ZZPd7Jj"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: Re: [Qemu-devel] [RFC PATCH v1 06/22] target/i386: introduce
 gen_gvec_ld_modrm_* helpers
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kAz5Npqpbz1dW5GhFUQAN25QM7ZZPd7Jj
Content-Type: multipart/mixed; boundary="IdhoJoIn0BsvzYnI7fUTBDQHTdNfbuTZx";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <73a5354a-f4d0-9e94-418a-13b19bb1d9b1@gmail.com>
Subject: Re: [RFC PATCH v1 06/22] target/i386: introduce gen_gvec_ld_modrm_*
 helpers
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-7-jan.bobek@gmail.com>
 <0e38a01b-6a1b-cd18-1fd0-29faea840e69@linaro.org>
In-Reply-To: <0e38a01b-6a1b-cd18-1fd0-29faea840e69@linaro.org>

--IdhoJoIn0BsvzYnI7fUTBDQHTdNfbuTZx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/31/19 6:47 PM, Richard Henderson wrote:
> I suppose there aren't so many different combinations, but did you cons=
ider
> separate callbacks per operand?  If you have
>=20
> typedef unsigned (*gen_offset)(CPUX86State *, DisasContext *, int);
>=20
> static unsigned offset_Pq(CPUX86State *env, DisasContext *s, int modrm)=

> {
>     int reg =3D (modrm >> 3) & 7; /* Ignore REX_R */
>     return offsetof(CPUX86State, fpregs[reg].mmx);
> }
>=20
> static unsigned offset_Qq(CPUX86State *env, DisasContext *s, int modrm)=

> {
>     int mod =3D (modrm >> 6) & 3;
>     unsigned ret;
>=20
>     if (mod =3D=3D 3) {
>         int rm =3D modrm & 7; /* Ignore REX_B */
>         ret =3D offsetof(CPUX86State, fpregs[rm].mmx);
>     } else {
>         ret =3D offsetof(CPUX86State, mmx_t0);
>         gen_lea_modrm(env, s, modrm);
>         gen_ldq_env_A0(s, ret);
>     }
>     return ret;
> }
>=20
> static unsigned offset_Vx(CPUX86State *env, DisasContext *s, int modrm)=

> {
>     int reg =3D ((modrm >> 3) & 7) | REX_R(s);
>     return offsetof(CPUX86State, xmm_regs[reg]);
> }
>=20
> static unsigned offset_Wx(CPUX86State *env, DisasContext *s, int modrm)=

> {
>     int mod =3D (modrm >> 6) & 3;
>     unsigned ret;
>=20
>     if (mod =3D=3D 3) {
>         int rm =3D (modrm & 7) | REX_B(s);
>         ret =3D offsetof(CPUX86State, xmm_regs[rm]);
>     } else {
>         ret =3D offsetof(CPUX86State, xmm_t0);
>         gen_lea_modrm(env, s, modrm);
>         gen_ldo_env_A0(s, ret);
>     }
>     return ret;
> }
>=20
> static unsigned offset_Hx(CPUX86State *env, DisasContext *s, int modrm)=

> {
>     return offsetof(CPUX86State, xmm_regs[s->vex_v]);
> }
>=20
> Then you can have
>=20
> #define GEN_GVEC_3(OP0, OP1, OP2, OPRSZ, MAXSZ)
> static void gen_gvec_ld_modrm_##OP0##OP1##OP2(CPUX86State *env,      \
>     DisasContext *s, int modrm, unsigned vece,  gen_gvec_2_fp_t gen) \
> {                                               \
>     int ofd =3D offset_##OP0(env, s, modrm);      \
>     int of1 =3D offset_##OP1(env, s, modrm);      \
>     int of2 =3D offset_##OP2(env, s, modrm);      \
>     gen(vece, opd, opa, opb, OPRSZ, MAXSZ);     \
> }
>=20
> GEN_GVEC_3(Pq, Pq, Qq, sizeof(MMXReg), sizeof(MMXReg))
> GEN_GVEC_3(Vx, Vx, Wx, sizeof(XMMReg), max_vec_size(s))
> GEN_GVEC_3(Vx, Hx, Wx, sizeof(XMMReg), max_vec_size(s))
>=20
> The PqPqQq and VxVxWx sub-strings aren't quite canonical, but imo a bet=
ter fit
> to the actual format of the instruction, with 2 inputs and 1 output.

Funny, I had a similar idea and converged to almost identical
solution. This will be part of v2.

> You can also do
>=20
> GEN_GVEC_3(Pq, Qq, Pq, sizeof(MMXReg), sizeof(MMXReg))
>=20
> for those rare "reversed" operations like PANDN.  Now you don't need to=
 carry
> around the OPCTL argument, which I initially found non-obvious.

Yup, solves the problem nicely and more clearly.

> I initially thought you'd be able to infer maxsz from the set of argume=
nts, but
> since there are vex encoded operations that do not use vex.vvvv that is=
 not
> always the case.  Thus I suggest
>=20
> static size_t max_vec_size(DisasContext *s)
> {
>     if (s->prefixes & PREFIX_VEX) {
>         /*
>          * TODO: When avx512 is supported and enabled, sizeof(ZMMReg).
>          * In the meantime don't waste time zeroing data that is not
>          * architecturally present.
>          */
>         return sizeof(YMMReg);
>     } else {
>         /* Without vex encoding, only the low 128 bits are modified. */=

>         return sizeof(XMMReg);
>     }
> }

Looks good.

-Jan


--IdhoJoIn0BsvzYnI7fUTBDQHTdNfbuTZx--

--kAz5Npqpbz1dW5GhFUQAN25QM7ZZPd7Jj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1EO+QACgkQZeg2ldrj
Ns+YOg//W4ezUOb8QHcaBAv3c5fDBwoH8vatn6AMdOt+Zg6pQ5I4aN1iSUI70IGO
DZ9p2MY6mBDvJaNNUBkQW0M1vSukGRa7g004TGBoeATvGu/F4SYIlUN/GiN/zYXy
sloHS6DfsteJWGhQmFqAaQpBCgXIHcZhSowQkWbuXdP9e+pILuiCagr6tFMchHuA
KljnV+L64rFZzY27rZKCHPhpa6srgytbritF7OupErvXh80rDwONoken9p1ClpST
JT8wS2fpXMg0lKCqDN07Su5GEDApBcmqQeatFyUbN/B+Q7euD9aC/gyRNelgmT+L
6ctXsV1058v5yb+pRLnHgunO5XJEGXQEayfnGcbt62Yx8bBOwmrdK9fp07Ea9U+A
qPiaZSyA227l7/vGJ2kIhu/LO5LObQfHlX/S353ZLdPTGXWReuSadUxP0ZfBqUEY
eRHYNM+NQnzQrpZH9AmzQYhRuEkCNanbStW4/EKtuxCD2cbjZriVxvyv57ROtGGJ
Qq62GGIVEClO7veb5PCYok1F54m8vySKq1YqdWLMXua6V/UzNoLVyJrYg4lzwZBo
HadVD1dMWUfrpwW2HkVmkfCqJvrqiPmfbM3QyGGP5Ka8ZKE2RwiXCRzRjxD0s6u1
8BHUN8Cp6wmcpYm9OvfpBUZMTtVhp8B453RYF8F6x3DeFQnURDY=
=HaHl
-----END PGP SIGNATURE-----

--kAz5Npqpbz1dW5GhFUQAN25QM7ZZPd7Jj--

