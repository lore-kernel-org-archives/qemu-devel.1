Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93449C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 21:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F14020C01
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 21:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV51AhID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F14020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmmTK-00040g-W8
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 17:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hmmT8-0003cP-Jx
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 17:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hmmT7-0001aF-Iu
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 17:55:42 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:39989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hmmT7-0001Wb-CR
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 17:55:41 -0400
Received: by mail-yw1-xc41.google.com with SMTP id b143so6750908ywb.7
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=iJVKPUOLNlMi5ZFqEj3Q1HaxuX9bNJuJJFxRPhlzoIY=;
 b=MV51AhIDkTdG/38CnLMTsW/DXQE0m0bAMUNkNmqKBMcgpjTyqyxaO/2MjzlqhQHvTS
 RBxrT2BXK8b46DylpIhpzY+HzYub0Tb1ub1sF2TSwTMnHl2cS01lNRysP+ktZ1OAZz2m
 owxsVW7huHHkaOABzGwanOVSwTZh/G6tYafqcdFuuFh9iL6Dt5OHQwCpFFiHFjzT7d90
 xad6LELDWwmh16h/dfl+i6A8Eg1rXUh1VTDr7U6O1cIx0TglETI2+6VyIMmlTHF6lZZu
 wqTvHfpsCxlJE4ZAQ269ngHnNzqyi3u+EnBeGYM0RoILCoKspsqky6VDPZex+NxdmLP6
 FZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=iJVKPUOLNlMi5ZFqEj3Q1HaxuX9bNJuJJFxRPhlzoIY=;
 b=uhUETiXuc3j69fuAHBKs7j5lQMuhedtQ9kxgC0d/xBhAne4CyZunPT7sxubPRnahWs
 g9FpHeJb0A6NOXuq4KNfCeP9QJRxJjxY6Uv3oR0WQkNDSOlsO6Sp1YyLh9FbPhxLFndt
 YqRRSjXeyIjeXHsbK2V5uX8ouGCpZcJ5Vqvvabr4Cm4PwOgegWhbaFm6q8IBWNF7yGNm
 /Ru1cJH1RSLqGF6Zlw5yO9iWgm7zIKbWn99oNq3GuntAC7V4bSg9/t0FXr5O2tFeKLSo
 n/SJ5DM67GIFRSIJvIqDoNiqPDQz0bbU5smwPH5wtytiWZGhAuYm0t6CL6OxHAsWIcgQ
 O0Kg==
X-Gm-Message-State: APjAAAV5Qb7evxOfmS13ongbMtqO1gzzC9tAwivRmUKPmDe97Gbor5jo
 Zh7sERztk1KocUoTbDq2Qsg=
X-Google-Smtp-Source: APXvYqx3MIr+cjsNeroanrJkq9IWZ8ErdpIXwf7RDj7DoyQihusSS6sMAkw9COkh4JnHKD8E1do+BA==
X-Received: by 2002:a81:9152:: with SMTP id i79mr10997270ywg.286.1563141339991; 
 Sun, 14 Jul 2019 14:55:39 -0700 (PDT)
Received: from [192.168.1.96] (69-222-133-165.lightspeed.tukrga.sbcglobal.net.
 [69.222.133.165])
 by smtp.googlemail.com with ESMTPSA id d7sm4031970ywh.14.2019.07.14.14.55.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 14:55:38 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-2-jan.bobek@gmail.com>
 <bc5b92ff-cc62-103c-7216-ced33bf72114@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fed9e984-49e8-9b91-9797-b182713389f3@gmail.com>
Date: Sun, 14 Jul 2019 17:55:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bc5b92ff-cc62-103c-7216-ced33bf72114@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7xnqnmUIXPXAUI9S6QdyNTsLv6SnORUZX"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: Re: [Qemu-devel] [RISU PATCH v3 01/18] risugen_common: add helper
 functions insnv, randint
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
--7xnqnmUIXPXAUI9S6QdyNTsLv6SnORUZX
Content-Type: multipart/mixed; boundary="x4f13gn8QjEhGnaFZhUClGZfGIskSL04m";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <fed9e984-49e8-9b91-9797-b182713389f3@gmail.com>
Subject: Re: [RISU PATCH v3 01/18] risugen_common: add helper functions insnv,
 randint
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-2-jan.bobek@gmail.com>
 <bc5b92ff-cc62-103c-7216-ced33bf72114@linaro.org>
In-Reply-To: <bc5b92ff-cc62-103c-7216-ced33bf72114@linaro.org>

--x4f13gn8QjEhGnaFZhUClGZfGIskSL04m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/12/19 1:48 AM, Richard Henderson wrote:
> On 7/12/19 12:32 AM, Jan Bobek wrote:
>> insnv allows emitting variable-length instructions in little-endian or=

>> big-endian byte order; it subsumes functionality of former insn16()
>> and insn32() functions.
>>
>> randint can reliably generate signed or unsigned integers of arbitrary=

>> width.
>>
>> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
>> ---
>>  risugen_common.pm | 55 +++++++++++++++++++++++++++++++++++++++++-----=
-
>>  1 file changed, 48 insertions(+), 7 deletions(-)
>>
>> diff --git a/risugen_common.pm b/risugen_common.pm
>> index 71ee996..d63250a 100644
>> --- a/risugen_common.pm
>> +++ b/risugen_common.pm
>> @@ -23,8 +23,9 @@ BEGIN {
>>      require Exporter;
>> =20
>>      our @ISA =3D qw(Exporter);
>> -    our @EXPORT =3D qw(open_bin close_bin set_endian insn32 insn16 $b=
ytecount
>> -                   progress_start progress_update progress_end
>> +    our @EXPORT =3D qw(open_bin close_bin set_endian insn32 insn16
>> +                   $bytecount insnv randint progress_start
>> +                   progress_update progress_end
>>                     eval_with_fields is_pow_of_2 sextract ctz
>>                     dump_insn_details);
>>  }
>> @@ -37,7 +38,7 @@ my $bigendian =3D 0;
>>  # (default is little endian, 0).
>>  sub set_endian
>>  {
>> -    $bigendian =3D @_;
>> +    ($bigendian) =3D @_;
>>  }
>> =20
>>  sub open_bin
>> @@ -52,18 +53,58 @@ sub close_bin
>>      close(BIN) or die "can't close output file: $!";
>>  }
>> =20
>> +sub insnv(%)
>> +{
>> +    my (%args) =3D @_;
>> +
>> +    # Default to big-endian order, so that the instruction bytes are
>> +    # emitted in the same order as they are written in the
>> +    # configuration file.
>> +    $args{bigendian} =3D 1 unless defined $args{bigendian};
>> +
>> +    for (my $bitcur =3D 0; $bitcur < $args{width}; $bitcur +=3D 8) {
>> +        my $value =3D $args{value} >> ($args{bigendian}
>> +                                     ? $args{width} - $bitcur - 8
>> +                                     : $bitcur);
>> +
>> +        print BIN pack("C", $value & 0xff);
>> +        $bytecount +=3D 1;
>> +    }
>=20
> Looks like bytecount is no longer used?

bytecount is an exported variable, a quick git grep shows that
it's being used in risugen_arm.pm (sub thumb_align4).

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~
>=20


--x4f13gn8QjEhGnaFZhUClGZfGIskSL04m--

--7xnqnmUIXPXAUI9S6QdyNTsLv6SnORUZX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl0rpNMACgkQZeg2ldrj
Ns835hAAmxSSuEra4I3KXmyiP2uCIXKB45cYTyC8+mr13hhRrh+Q0OxT0HvEop5f
U4MLgkTFw4Lw7/wHmIxdf5Uvn518bX1mXY8UKM+zFQYQwoFc5Wnm6I7gLcsT9eJv
ws9WSh0HnhdoeGo7ZUWNCS8a1KRyczt3TUBJOPeWHIkzkZ7dOwRVwO6wczjNCpsj
62z2s/5GLd3CmLCUNzgRNUp88KqMQK3tS9Ck8l270UtK6hzuEWLjw0/DiqdI3FMR
PxUc3KlXVeNXiF1JnT3cqd6h4mf1drUQmbqrmPTLT+SE3vNEPZ74SuDpPSOoCHb8
+5zzeg/6eB9WwrQmHZs00M1vgMz9cnXPqHZzVczZr4uUxuqLMVjOSWuOJRfep5v2
nC25Hvgkrve/q8Zbm7vjo5pA0E65xB3REvnE6SwRF4LY/55YY/9Bnq7j+rp8voVW
I59KlYwC0guLDkGGxV+2oh7ADyUbGQ/U9kGvj3NrwL/caxnAHw45kKhliRHXmwaw
BcT56V+0aMee3y7qoAWG6MpQSTAb0z7ikyjcQVQcYyY+XiCXSfKHaT2d91cX1Bz4
fq3dQRQthDj78Lt7NWSEyDe3OXwpyZqs5H/rXqVL/a8mbCtZCbjA7Q0DT82yFlG9
KHp5kvVOycRE2ID5O8wASb3egeJOL69qhjULrE4HVDVKgXF9LgQ=
=t59L
-----END PGP SIGNATURE-----

--7xnqnmUIXPXAUI9S6QdyNTsLv6SnORUZX--

