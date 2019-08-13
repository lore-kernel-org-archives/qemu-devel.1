Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F7C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B83206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5zCzIFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B83206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxX0w-0003ND-GO
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxX0O-0002x7-5S
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxX0N-0007to-7G
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:38:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxX0M-0007tU-Rh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:38:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id q12so17524180wrj.12
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dX0CFnC/QUmeFVowKVTbhwyDEWyWuKxnVCNy2DEQ3Q8=;
 b=k5zCzIFFKLS50K9kAPNk4/RgIVEuaKgdE/6U5g+5Hqg4SJtrdY3f/wGbOI+4nQdXda
 FYKtiTrmzwfkWfxj0DJaMrFUGzu3dIGY6hkyMf1XiFfxyXVx8Zs5N5mMJhINshMJKE3S
 9NR0AyFmMWyjeSnaMxAh2UF8ak7IaCJWHvDNt7QxfTWr7LQ55wrHJrEFpViuQnOqb3i2
 yy7SGSZvlm87dDaMeVX1yawCj0FEcU4OQy1eHENHmqMutXGuUc9ru3hgGTDdJxL3kkw8
 vAdenfQeYnIOuENUVhfWSwo5ng1TbsM8ldhRiTWDk9EtTnDPqvrbZW3AdJfJvZojXjJQ
 JKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dX0CFnC/QUmeFVowKVTbhwyDEWyWuKxnVCNy2DEQ3Q8=;
 b=csXL8vGKstiSRAES2xVW6oywJ1O1vnidMGAc5RLGhS2Q7dIkoTWiBH7PUf++GzxhYi
 DgOAQ/74QGjIbx8tOnP1rkIgy2QDLtHIncUjDeJTKyRsCbggR5YjuR91xZd1jUFOMl9f
 eLtJH8Y2AQsTcvHbAoOFJXUZP69sezd4oFEPQeFuGt2xaumzmJ4rD1OqcAeFQ4cAxYd9
 jre8HVnKcdU43yrvDiEF6WGtjGnotoD0PNcbrBOyvm5eQhPvUTqySb5CXwqwMkh3Myzn
 CaaXPibJXfRxTeXOWxaN6hGujNjL2O5R+rcqRnh81Lz+RAB1pIJ3MVLdiaWIUgeNtMuU
 myyQ==
X-Gm-Message-State: APjAAAUV5iAnppyrXG4y2anh4k3qz/rFf3Y4+4Sik4W2PcNBS9Y8HT6c
 6vNmCFrjJ2XshvqYDCZ9r4jDbg==
X-Google-Smtp-Source: APXvYqxC4ITVVcswA2Sqw/46y7gmK5WAEtb3Clidnyi3xXNnY68yl3IzMVVAscXtyoeYjFxboi/lOw==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr48570170wrl.281.1565703505594; 
 Tue, 13 Aug 2019 06:38:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f10sm95454858wrs.22.2019.08.13.06.38.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 06:38:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 845CB1FF87;
 Tue, 13 Aug 2019 14:38:24 +0100 (BST)
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-3-alex.bennee@linaro.org>
 <02e9e013-da2d-38cd-6d92-035023f0d963@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <02e9e013-da2d-38cd-6d92-035023f0d963@linaro.org>
Date: Tue, 13 Aug 2019 14:38:24 +0100
Message-ID: <871rxpnq27.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 02/13] fpu: convert
 float[16/32/64]_squash_denormal to new modern style
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/13/19 1:49 PM, Alex Benn=C3=A9e wrote:
>> +static FloatParts parts_squash_denormal(FloatParts p, float_status *sta=
tus)
>> +{
>> +    if (p.exp =3D=3D 0 && p.frac !=3D 0) {
>> +        float_raise(float_flag_input_denormal, status);
>> +        p.frac =3D 0;
>> +        p.cls =3D float_class_zero;
>> +    }
>> +
>> +    return p;
>> +}
>> +
>> +float16 float16_squash_input_denormal(float16 a, float_status *status)
>> +{
>> +    if (status->flush_inputs_to_zero) {
>> +        FloatParts p =3D float16_unpack_raw(a);
>> +        p =3D parts_squash_denormal(p, status);
>> +        return float16_pack_raw(p);
>> +    }
>> +    return a;
>> +}
>
> Hmm.  Maybe avoid the re-pack in the likely chance that we can?
>
> static bool parts_squash_denormal(FloatParts p, float_status *status)
> {
>     if (p.exp =3D=3D 0 && p.frac !=3D 0) {
>         float_raise(float_flag_input_denormal, status);
>         return true;
>     }
>     return false;
> }
>
> float16 float16_squash_input_denormal(float16 a, float_status *status)
> {
>     if (status->flush_inputs_to_zero) {
>         FloatParts p =3D float16_unpack_raw(a);
>         if (parts_squash_denormal(p, status)) {
>             return float16_set_sign(float16_zero, p.sign);
>         }

I'll squash with the next patch and use the set_sign rather than
make_float and see if it's the same.

>     }
>     return a;
> }


--
Alex Benn=C3=A9e

