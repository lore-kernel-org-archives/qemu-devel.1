Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B63FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAD8205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epcVagc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAD8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiIZ-0001Oi-Nd
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKiHs-0000vH-QR
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKiHr-00040e-L3
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:20:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39973
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKiHr-00040B-D0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571228418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gHFD217dcO65tiUuIUg3e87g4ojwa9Ge6fz/0+n/HAM=;
 b=epcVagc+3mLH8EXYH7ZW4FnOJDTeZTw89k3o1OYI2OWNpIA4jK5Am4s4EOYAKrIISPrQcN
 m/PIXaRbVmzdXo7Wt8Zo6fUnwdlrqM9sRvVZPj9FU0SVBGbN1TyDYM5Ink8KXhrLvsQRLJ
 uqRf12NSuTOg8gGQqXCaCzBwC3HNb44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-5GUa3P8vO3y6V-aw5Ye5Lg-1; Wed, 16 Oct 2019 08:20:15 -0400
Received: by mail-wm1-f70.google.com with SMTP id n3so1133457wmf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Txgl9dk6JaDGRA+qRaaDtMFeiybFPhOcD1t2h81Xpc0=;
 b=bHInZFXfcplfz3NORWpuUErTnEuMPnaLzIIMwwXJRbT5nKMKSoFrJXUIp/lfKK8xZ5
 zwzd+F5BHFMve3YJHshRLSjTk62e/j1tY5GAlVqMZkllvO0mFewsK5SjxrmEu+JqoxvL
 Fw8F2aMozoIOAekephwCRkFPUW2q1pVQkmVV0r83VDlL0xP2bqMpRYI+x9F1SCXKYDDt
 g951n0Jr2O/ziyORZz0IMY60XZlqfPRtN36jsWdWdlWItWTnxqKRcxahBd05yGwJfqqj
 04g2Q5k/7F2xZS2bg/JkbZhy/Dc/nDfbroKoCksq8kS/iyzLLuO8LQjPJhVaS9HIgtXA
 HHGw==
X-Gm-Message-State: APjAAAUjHqMSu4QBCREtMUJJRfq0H5IoM1I8v76foD/1e9TTWk4OMpBe
 B5WYjuyG8iK2O+6AyCe1hb1LsXz4T1qIukqj8iygSyhKzwZdea7Y0ex7fkui+1Ebyx7wF9EIXk4
 TbgddXhruCuhqrxM=
X-Received: by 2002:a5d:5542:: with SMTP id g2mr2522968wrw.115.1571228413831; 
 Wed, 16 Oct 2019 05:20:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNZc/OOzXk3uhDfn3WAe8UgwDSUjedt5mI953h10clp2egtffEV7opC+DopvjMdbaWyUJf0A==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr2522948wrw.115.1571228413582; 
 Wed, 16 Oct 2019 05:20:13 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id a13sm60718090wrf.73.2019.10.16.05.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 05:20:13 -0700 (PDT)
Subject: Re: [PULL 59/68] aspeed: Add an AST2600 eval board
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Joel Stanley <joel@jms.id.au>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
 <20191014160404.19553-60-peter.maydell@linaro.org>
 <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f6dd2bc-27e7-91a2-e673-18b9715a9628@redhat.com>
Date: Wed, 16 Oct 2019 14:20:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 5GUa3P8vO3y6V-aw5Ye5Lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/15/19 7:03 PM, Peter Maydell wrote:
> On Mon, 14 Oct 2019 at 17:05, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Message-id: 20190925143248.10000-21-clg@kaod.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   include/hw/arm/aspeed.h |  1 +
>>   hw/arm/aspeed.c         | 23 +++++++++++++++++++++++
>>   2 files changed, 24 insertions(+)
>=20
>> @@ -455,6 +467,17 @@ static const AspeedBoardConfig aspeed_boards[] =3D =
{
>>           .num_cs    =3D 2,
>>           .i2c_init  =3D witherspoon_bmc_i2c_init,
>>           .ram       =3D 512 * MiB,
>> +    }, {
>> +        .name      =3D MACHINE_TYPE_NAME("ast2600-evb"),
>> +        .desc      =3D "Aspeed AST2600 EVB (Cortex A7)",
>> +        .soc_name  =3D "ast2600-a0",
>> +        .hw_strap1 =3D AST2600_EVB_HW_STRAP1,
>> +        .hw_strap2 =3D AST2600_EVB_HW_STRAP2,
>> +        .fmc_model =3D "w25q512jv",
>> +        .spi_model =3D "mx66u51235f",
>> +        .num_cs    =3D 1,
>> +        .i2c_init  =3D ast2600_evb_i2c_init,
>> +        .ram       =3D 2 * GiB,
>=20
> Hi. I just discovered that this makes 'make check' fail on
> 32-bit systems, because you can't default to 2GB of RAM
> for a board:
>=20
> (armhf)pmaydell@mustang-maydell:~/qemu$
> ./build/all-a32/arm-softmmu/qemu-system-arm -M ast2600-evb
> qemu-system-arm: at most 2047 MB RAM can be simulated
>=20
> It's also a pretty rudely large amount of RAM to allocate
> by default: it caused 'make check' to fail on my OSX
> box, which is 64-bits but doesn't have huge swathes
> of free RAM.

It is unlikely you use this board on a 32-bit system...

You usually prefer to have modeled hardware matching real-life,
what about making this board not available on 32-bit systems
(we will soon have more boards like this):

   #if HOST_LONG_BITS > 32
       {
           .name      =3D MACHINE_TYPE_NAME("ast2600-evb"),
           .desc      =3D "Aspeed AST2600 EVB (Cortex A7)",
           ...
       },
   #endif /* HOST_LONG_BITS > 32 */

Regards,

Phil.


