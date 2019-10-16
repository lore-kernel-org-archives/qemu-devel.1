Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB7FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04C82168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDPGedAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04C82168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKih9-0006C1-S3
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKifl-0005CK-4k
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKifi-0005RL-Fb
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:44:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKifi-0005Qu-2e
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571229897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBdfY/1i7TbYf0JgScF/YSZX5J4wrGZzD7wCV2O5FqY=;
 b=SDPGedAcy20isja4T3r73fdmUbUfTv+jAQ5BKorw9yRxZ3tK+4NB4PwghQw32vMO4zPlTU
 VFH7PftQ2qJRQBOnY5VvHD6xewqfuT6pEAvGlpuvoSTFhk2BG+//pJMaxZ5Oq3sk0gpMD2
 hYVwcLfLSPas94prJdi27AwI00dtZB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-Ax_RvExDObytHLVcZYcEDA-1; Wed, 16 Oct 2019 08:44:55 -0400
Received: by mail-wm1-f71.google.com with SMTP id o188so1159473wmo.5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IUF8uus1tt/CbKNov4kwWjotnaqRaJYeSCPtFu4fjT4=;
 b=UnSVHmJ0+f3KNxbx5+f4VnRrWiddX+al8YOsEqX/cqNMdLsHx3PeG2oHrM8mstHA+o
 J8SQ6w9xsAOVzfHNtHM07DVND07XuvXqtV9vG8AIDUysY/1rwl3qg3vzj6jZStF08HKq
 UKNg3Eh2Aff6y8qBTbSnrdJ2EMi8CwroFMjVZ5er2JSpyieGOiYm3ZO0VbvCyRq4e+Cb
 QCnlZiOu/yEBldqJXL7hOL9sfh3ZbbZuk/dsVQq4J6XzI15lcNBxkLE7SthyINdV3/v9
 YXHS8BeHpDiaTIy4V5mWmFDm/Hyd2blNqDzy7QdGQMAURHgYZW4EF8B8E/qQf5P89YjA
 lWFw==
X-Gm-Message-State: APjAAAUWNHQ9tTkWBnS88Ttf9s9lLsl59HDik0YTMc3cs+bWsMezRgHN
 Fkgxvgg6vqMIuPaITOoVRyhjCaskchzT8BcaIqrH8ev0rPh2WtwQY7GzurMcMR4eALx7WQHp2oq
 D8HzvC5Pj+ib5pdc=
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr996412wrr.252.1571229894616;
 Wed, 16 Oct 2019 05:44:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyqleRj/Tb2EuODic8NQWEJwDLnRw5WGNsKwFbnHQ50I7Xh6cj2vYiH19Dp9S7hYv28H9jTRQ==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr996392wrr.252.1571229894363;
 Wed, 16 Oct 2019 05:44:54 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id x2sm31109104wrn.81.2019.10.16.05.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 05:44:53 -0700 (PDT)
Subject: Re: [PULL 59/68] aspeed: Add an AST2600 eval board
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
 <20191014160404.19553-60-peter.maydell@linaro.org>
 <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
 <2f6dd2bc-27e7-91a2-e673-18b9715a9628@redhat.com>
 <81879465-e235-e146-46d9-b8e1441b30cf@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <53a6663a-bfbc-b90c-a982-46aeee838f19@redhat.com>
Date: Wed, 16 Oct 2019 14:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <81879465-e235-e146-46d9-b8e1441b30cf@kaod.org>
Content-Language: en-US
X-MC-Unique: Ax_RvExDObytHLVcZYcEDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 10/16/19 2:41 PM, C=C3=A9dric Le Goater wrote:
> On 16/10/2019 14:20, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Peter,
>>
>> On 10/15/19 7:03 PM, Peter Maydell wrote:
>>> On Mon, 14 Oct 2019 at 17:05, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>>
>>>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>> Message-id: 20190925143248.10000-21-clg@kaod.org
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>  =C2=A0 include/hw/arm/aspeed.h |=C2=A0 1 +
>>>>  =C2=A0 hw/arm/aspeed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 23 +++++++++++++++++++++++
>>>>  =C2=A0 2 files changed, 24 insertions(+)
>>>
>>>> @@ -455,6 +467,17 @@ static const AspeedBoardConfig aspeed_boards[] =
=3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_cs=C2=A0=
=C2=A0=C2=A0 =3D 2,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .i2c_init=C2=
=A0 =3D witherspoon_bmc_i2c_init,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ram=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 512 * MiB,
>>>> +=C2=A0=C2=A0=C2=A0 }, {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D MACHINE_TYPE_NAME("ast2600-evb"),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .desc=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D "Aspeed AST2600 EVB (Cortex A7)",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .soc_name=C2=A0 =3D "ast26=
00-a0",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_strap1 =3D AST2600_EVB=
_HW_STRAP1,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_strap2 =3D AST2600_EVB=
_HW_STRAP2,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fmc_model =3D "w25q512jv"=
,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .spi_model =3D "mx66u51235=
f",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_cs=C2=A0=C2=A0=C2=A0 =
=3D 1,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .i2c_init=C2=A0 =3D ast260=
0_evb_i2c_init,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ram=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D 2 * GiB,
>>>
>>> Hi. I just discovered that this makes 'make check' fail on
>>> 32-bit systems, because you can't default to 2GB of RAM
>>> for a board:
>>>
>>> (armhf)pmaydell@mustang-maydell:~/qemu$
>>> ./build/all-a32/arm-softmmu/qemu-system-arm -M ast2600-evb
>>> qemu-system-arm: at most 2047 MB RAM can be simulated
>>>
>>> It's also a pretty rudely large amount of RAM to allocate
>>> by default: it caused 'make check' to fail on my OSX
>>> box, which is 64-bits but doesn't have huge swathes
>>> of free RAM.
>>
>> It is unlikely you use this board on a 32-bit system...
>>
>> You usually prefer to have modeled hardware matching real-life,
>> what about making this board not available on 32-bit systems
>> (we will soon have more boards like this):
>>
>>  =C2=A0 #if HOST_LONG_BITS > 32
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D MACHINE_TYPE_NAME("ast2600-evb"),
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .desc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D "Aspeed AST2600 EVB (Cortex A7)",
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>  =C2=A0 #endif /* HOST_LONG_BITS > 32 */
>=20
> I sent a patch to lower the default RAM size to 1G but you can always
> increase it on the command line.
>=20
> Making the machine available seems a better choice but that's fine with
> me if we prefer to restrict its use to 64bits hosts. As you wish.

I'd rather keep models consistent with real hardware and not cripple=20
them to test them on unlikely setups.


