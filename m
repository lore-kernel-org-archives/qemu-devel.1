Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C95C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6353B2087F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us/u1YWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6353B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlGjc-0000u1-NH
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 13:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlGhk-0000Gb-0f
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlGhi-0004f8-RH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:48:31 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlGhh-0004VP-1l
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:48:30 -0400
Received: by mail-yb1-xb44.google.com with SMTP id j133so1035059ybj.12
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=YWRAGJScygCIkEFIDEFOG0ZDjtmjcDuccM93rza0Ng0=;
 b=Us/u1YWFyDTFP9algnQq+43C1q4t1Yz1D4eF+kjzk2MEptJTZ/kyCe0SU3zh6gdEM2
 pNvtvyWF5Kz0nYytuXhG4+U8xyYEsl0DNZEta+u4wj7lV6eWZlfGeTXkW+8KjH4KFxFv
 N4/MUB0m8Nh0fZ3UjEpkVhoCWuTFCYcSbyPe/u4DUI9LM8ymIA/6Nziw0qtD9RNGaASR
 +WWn7FB7pw06B/S/znzy31cw7gZ/9HdDuV6eULehMx5cTIZix6Kujeb8NFDfOe3dBH7u
 ABUXa2ImHsVbWGlfEJ7DB1+6QzRlZN3OQR3b6rS7y6lLdOgtMQbXRZMaPJTG4MLJKrl+
 Os1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=YWRAGJScygCIkEFIDEFOG0ZDjtmjcDuccM93rza0Ng0=;
 b=DP/IUuD+Ej+SVZwTQmcDU/nFV6pYj6XNOgm1oO2P0aUK5tosMowkt7AcONpwhcoC0T
 BP36qfjw9JEf7RVN7EJjbdNoDf1BA1bgVP+h9vhCnCC60ahZjUNhVmFbJ/MZdwAqnMcy
 NxGLnelggTLc9pBXHcoaKx/InT57TRuscj5kd1VI6XCwi685X0JhQW8ylqUzkcpSMvWD
 ++6p4g09yUujuWAMCDPJuCHQBnUIaqGcfaBt6UhzJNyDXu/KLBrNxjOSjqZHjWYm9FpQ
 f+FE1oj0nY0hRj6GYpcJsdWU8sNs9XCFZMBVxihxcj7MIkM6TADLKnAJLyJ7iPOZzPbY
 7UsQ==
X-Gm-Message-State: APjAAAXrymHOonguXT0y2JNBTC61Y10Mn2AB0krMFzODorB9Z3kaQ56n
 Y/6yz1jjCcmYuy24mYQiiOA=
X-Google-Smtp-Source: APXvYqzU9IzuBFKsV1ksuPjNhPHW076Aaqei3CAiGn/pcZ83Gt/Eto+3JbzFjHf2hVagj74XsBlwnw==
X-Received: by 2002:a25:e08:: with SMTP id 8mr19207733ybo.177.1562780905534;
 Wed, 10 Jul 2019 10:48:25 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id 202sm681168ywv.94.2019.07.10.10.48.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 10:48:24 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-2-jan.bobek@gmail.com>
 <8e5e96dd-ed35-895c-1fd3-d6b60ccba44b@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b8cdadb2-58a1-052f-e7ce-3d021784f9b7@gmail.com>
Date: Wed, 10 Jul 2019 13:48:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8e5e96dd-ed35-895c-1fd3-d6b60ccba44b@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ziOhKepHiTom7PVYQtAhtTwl8YUdawZwk"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 01/14] risugen_common: add
 insnv, randint_constr, rand_fill
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
--ziOhKepHiTom7PVYQtAhtTwl8YUdawZwk
Content-Type: multipart/mixed; boundary="crtaBYjYQuCD1wcBFOsB7jizh3Frsy8cC";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <b8cdadb2-58a1-052f-e7ce-3d021784f9b7@gmail.com>
Subject: Re: [RISU RFC PATCH v2 01/14] risugen_common: add insnv,
 randint_constr, rand_fill
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-2-jan.bobek@gmail.com>
 <8e5e96dd-ed35-895c-1fd3-d6b60ccba44b@linaro.org>
In-Reply-To: <8e5e96dd-ed35-895c-1fd3-d6b60ccba44b@linaro.org>

--crtaBYjYQuCD1wcBFOsB7jizh3Frsy8cC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Richard,

sorry for replying so late. I read your comments last week; as I
mentioned in our weekly update email, I ended up adding/removing quite
a lot since v2, so I wasn't 100% sure how much of it will remain
relevant.

Anyways,

On 7/3/19 11:22 AM, Richard Henderson wrote:
> On 7/1/19 6:35 AM, Jan Bobek wrote:
>> +    while ($bitcur < $bitend) {
>> +        my $format;
>> +        my $bitlen;
>> +
>> +        if ($bitcur + 64 <=3D $bitend) {
>> +            $format =3D "Q";
>> +            $bitlen =3D 64;
>> +        } elsif ($bitcur + 32 <=3D $bitend) {
>> +            $format =3D "L";
>> +            $bitlen =3D 32;
>> +        } elsif ($bitcur + 16 <=3D $bitend) {
>> +            $format =3D "S";
>> +            $bitlen =3D 16;
>> +        } else {
>> +            $format =3D "C";
>> +            $bitlen =3D 8;
>> +        }
>> +
>> +        $format .=3D ($args{bigendian} ? ">" : "<") if $bitlen > 8;
>=20
> It now occurs to me to wonder if it's worth simplifying this function t=
o always
> emit bytes, and thus take care of all of the endianness ourselves, sinc=
e we're
> doing it anyway for larger/odd-sized hunks.

Good point. *facepalm*

I will include this change in v3.

-Jan


--crtaBYjYQuCD1wcBFOsB7jizh3Frsy8cC--

--ziOhKepHiTom7PVYQtAhtTwl8YUdawZwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0mJOMACgkQZeg2ldrj
Ns9efA/+JOXaaMRE3zHxUcEWXk8fTcBo5W8Ii0nNAlMckt7fku6CNb4sBpmo43wu
gxwSO3YbEvf0fXXSZvCE8Syb5brTDJKX5V6anrQKDl8w/eW+LLhUnX1XrNI93csb
9IRmA5Y+Iw3NNPuwDTAA1eU00VN9gINtN5qXfnq4S4OHl57xDCpp+qnH7/TPncaN
udezaOJzkHGZm+HQCLGiJoeWIvYBQUED3WPoDVcTmlBTRureLu2IhiZAV+kTVdoB
nDk1jPbceH0XGOcMocYNJxt4+La9TJE1znzjfiLrZl+KceA9V39QYul9TOCwr5yY
J8BddvI9t8WaKBSixYRqF8goKmCEZkzU2ww7NZKUDrVRxAcFzNuTGQRnSF6bi8Xo
hKLxK9JHBDX27UB8ZzAF4yvEuSEkTW7KQ5Key1QF/lKtC78eP5QWsIF6RcM1AXpi
zX7X3OMiGZ14yp7WOzDe3N/HCGXVnrniNB07ZYzyLF6qbL8UTaB9AhWbTS7rfW6/
71SGzflu2ue3UhbHh/fOdqO0nkjlxNCguRF9Hszt5sF2dOu+y5i+5hHW4wP6GhIi
SWMD0S/SpHPlI1XBpfqzxfsfqhj3DbAk4gGhDhOI5T5IchXXVmjt6qahDC//+FIb
++9+3ph3Udyf6se/oUE9+ALdGRAP/4NRNlfhRNcKbTL7qd8y6UM=
=KqRr
-----END PGP SIGNATURE-----

--ziOhKepHiTom7PVYQtAhtTwl8YUdawZwk--

