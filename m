Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6066C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7593720844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsAa48+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7593720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlGyL-0000Ve-KK
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 14:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33441)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlGvp-0007gD-0F
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlGvn-0007QQ-N1
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:03:04 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:38454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlGvn-00070v-Ag
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:03:03 -0400
Received: by mail-yw1-xc42.google.com with SMTP id f187so1106894ywa.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=JRT4TwRQH49zsvlDzmtS1h2K5OHTaSOVzXXdYBbKYR4=;
 b=GsAa48+947iAam4FzpxYL00IHciYcwU4Xr6TGKDnXC33beUd5dVmq04oNohjvEth4D
 OP5PhqX46Ry5n5zoDQtjcV/MHsm+9rpb6VAIRSHRQr1tS8Phn+8k4ksUR05qMONhc3aY
 YoW35IJJ8IRpp2BbbZndMzFhqbYXfyPX/dX3Bx5KhQhzOvEcgOJInJBQ8KzEf7tbD26p
 ExbB8jg27hIzZWLPSsPj4a1k9shNvLtKjmeo50EXFvZ2TZUL3bRBbDHJ2bvBhv2K1E7r
 +8PvjTKSKFbeWdZi7KbK/PSjasaPqHoK2EVHcFZO6DdZxz1SnwcrS/mqToQGspxHoJlF
 2zWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=JRT4TwRQH49zsvlDzmtS1h2K5OHTaSOVzXXdYBbKYR4=;
 b=k6R7dPXiQPOCzXPjWy8BfAZKA+UOqRcjFud++J4EhoyknuN36AZ/3PpDYCCvASnID7
 TeK+kBl7aWmfW1hDIeecESDYRKBmNWQzlH6uDo9LTqJgbRtT9fqM46oSEGkK20efz2IA
 ZvKI9o3CjpemRNr+rx85hMuTXL5whNMhLDIIvujTugjvJ7XvEP4va41uB02Kb59zidLL
 bFywLN40qlSy/KTHw0kjLH5qtdqFPcM5McJyeUXXK46RsSVSMJFQygcDLCGUxQVKL8vo
 gl9mmWvdF+kwXRNT7P8lU9oUqku0fnxyMz+Odx8+jvEbPDU2I7H5tLQ1xqyCLA/qqOVQ
 Qn9g==
X-Gm-Message-State: APjAAAVAx0I7w0ni3790eZ8jiuHBllej6Jja/VfPjDxTYJfHjG2b7YX1
 TL1OpJ4QND6xdoVhTin/0yE=
X-Google-Smtp-Source: APXvYqyEBCk1PUuH3wEEvB4H3qsidRilukcEKkoreCT7xSHpyFMamfEiPfkpDmMqHE2JIqp3rMNmPw==
X-Received: by 2002:a81:a785:: with SMTP id
 e127mr10201850ywh.317.1562781775746; 
 Wed, 10 Jul 2019 11:02:55 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id q83sm771551ywq.88.2019.07.10.11.02.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 11:02:55 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-3-jan.bobek@gmail.com>
 <c98ee4eb-44ff-83ff-6fc6-5f97174b0044@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a64c7e5e-7fbf-a3a0-5af2-c3e45c699b16@gmail.com>
Date: Wed, 10 Jul 2019 14:02:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c98ee4eb-44ff-83ff-6fc6-5f97174b0044@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gNQ755gaGnwr6MEJtVZfuTQaSB6mc4bsG"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 02/14] risugen_x86_asm: add
 module
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
--gNQ755gaGnwr6MEJtVZfuTQaSB6mc4bsG
Content-Type: multipart/mixed; boundary="4fimAXTNtrNdzXubiILzCRuV72m23YXdu";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <a64c7e5e-7fbf-a3a0-5af2-c3e45c699b16@gmail.com>
Subject: Re: [RISU RFC PATCH v2 02/14] risugen_x86_asm: add module
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-3-jan.bobek@gmail.com>
 <c98ee4eb-44ff-83ff-6fc6-5f97174b0044@linaro.org>
In-Reply-To: <c98ee4eb-44ff-83ff-6fc6-5f97174b0044@linaro.org>

--4fimAXTNtrNdzXubiILzCRuV72m23YXdu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/3/19 11:37 AM, Richard Henderson wrote:
> On 7/1/19 6:35 AM, Jan Bobek wrote:
>> +    VEX_V_UNUSED =3D> 0b1111,
>=20
> I think perhaps this is a mistake.  Yes, that's what goes in the field,=
 but
> what goes in the field is ~(logical_value).
>=20
> While for general RISU-ish operation, ~(random_number) is just as rando=
m as
> +(random_number), the difference will be if we ever want to explicitly =
emit
> with this interface a specific vex instruction which also requires the =
v-register.

See below.

>> +sub rex_encode(%)
>> +{
>> +    my (%args) =3D @_;
>> +
>> +    $args{w} =3D 0 unless defined $args{w};
>> +    $args{r} =3D 0 unless defined $args{r};
>> +    $args{x} =3D 0 unless defined $args{x};
>> +    $args{b} =3D 0 unless defined $args{b};
>> +
>> +    return (value =3D> 0x40
>> +            | (($args{w} ? 1 : 0) << 3)
>> +            | (($args{r} ? 1 : 0) << 2)
>> +            | (($args{x} ? 1 : 0) << 1)
>> +            | ($args{b} ? 1 : 0),
>> +            len =3D> 1);
>> +}
>=20
> Does
>=20
> 	(defined $args{w} && $args{w}) << 3
>=20
> work?  That seems tidier to me than splitting these conditions.

It does, I will change it. Thanks!

>> +        return (value =3D> (0xC4 << 16)
>> +                | (($args{r} ? 1 : 0) << 15)
>> +                | (($args{x} ? 1 : 0) << 14)
>> +                | (($args{b} ? 1 : 0) << 13)
>=20
> Further down in vex_encode, and along the lines of VEX_V_UNUSED, this a=
ppears
> to be actively wrong, since these bits are encoded as inverses.  What t=
his
> *really* means is that because of that, rex_encode and vex_encode will =
not
> encode the same registers for a given instruction.  Which really does f=
eel
> bug-like, random inputs or no.

So, vex_encode, rex_encode and friends were meant to be really
low-level functions; they literally just encode the bits from what you
pass in, without any concern for what the fields even mean. In that
spirit, write_insn itself never did much of error-checking.

I have added quite a lot of code to risugen_x86_asm in v3; most
importantly, there are now asm_insn_* functions which are more
high-level, in that you pass in the logical values and they care of
error checks and encoding. I also removed write_insn and all the
encoding-related symbolic constants from the public interface of the
module.

-Jan


--4fimAXTNtrNdzXubiILzCRuV72m23YXdu--

--gNQ755gaGnwr6MEJtVZfuTQaSB6mc4bsG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0mKE4ACgkQZeg2ldrj
Ns8ffg/9ERKFqB0A7d36XNLc7CEQKoXoW5iwtUc0lOdot5Nn2baEut9aJEhqQrA9
s1wUF2NySLe19mfQVDDXm86+oaQMWIg5m0Bm/afkTZSWC5qS6xXTs+3zJ18jZzS2
OeyrAh9spaWwNzud7n2ABrpe7OQ3AiNGNoHooEjz4gtB76qxTxKJNLAofpvRpuS6
p/neBnz+4uuf+gHHDcFt3oGD/0dJ3ZVNs6ycE5YV9Zh0RvdIGIKIMuaxKs9rKiFH
Z/V283pwrAzDypujHv9msHTiX+JoFy9j++ftZpteJjUx16pDJyhQhSf32Ia+Ih4D
K4hzDZKbBvuPy0Hx8kTBgBRHW8Gbngvfd+VxeKWuR7vfbG47ePqECwR6yCAf6F40
qTisXTUjCGBUI7D2n2dCu+u/yPJnB+AAes7lzDK6YqoqhNtTY57hznaOedDzMVpv
9oOd3piyOIhFWzuQhE0VjyiyhgsxxBMj4yPt6HfcKcqLFafGPAlHkOZA5KhKDovZ
hvquNMKceP1OOu+w9PxV4oLItMkV4ubvkJMWEk/q7IXalNi/4QrSvx/3dA+KjpD/
dMRzHeYzFylWGR+vmCYELBhFTKmGEUyFandpVq6RHVJD1E+/vFma0ESPrIJAQ7xg
zG6+unbztbsquPfZsyEvEmQagKApoMal8DfadWLr+NBdPO/zqVg=
=H4Wd
-----END PGP SIGNATURE-----

--gNQ755gaGnwr6MEJtVZfuTQaSB6mc4bsG--

