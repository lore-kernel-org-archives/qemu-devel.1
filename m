Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1DBFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DB7205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DB7205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKicy-0004Gq-MO
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iKic6-0003nC-5d
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iKic3-0004DP-QE
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:41:13 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:37954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iKic2-00049w-7m
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:41:11 -0400
Received: from player793.ha.ovh.net (unknown [10.109.143.216])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 82C2111C96B
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 14:41:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 36728B055416;
 Wed, 16 Oct 2019 12:41:01 +0000 (UTC)
Subject: Re: [PULL 59/68] aspeed: Add an AST2600 eval board
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
 <20191014160404.19553-60-peter.maydell@linaro.org>
 <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
 <2f6dd2bc-27e7-91a2-e673-18b9715a9628@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <81879465-e235-e146-46d9-b8e1441b30cf@kaod.org>
Date: Wed, 16 Oct 2019 14:41:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <2f6dd2bc-27e7-91a2-e673-18b9715a9628@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1144195782812732371
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeehgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.44
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

On 16/10/2019 14:20, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Peter,
>=20
> On 10/15/19 7:03 PM, Peter Maydell wrote:
>> On Mon, 14 Oct 2019 at 17:05, Peter Maydell <peter.maydell@linaro.org>=
 wrote:
>>>
>>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>> Message-id: 20190925143248.10000-21-clg@kaod.org
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> =C2=A0 include/hw/arm/aspeed.h |=C2=A0 1 +
>>> =C2=A0 hw/arm/aspeed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 23 +++++++++++++++++++++++
>>> =C2=A0 2 files changed, 24 insertions(+)
>>
>>> @@ -455,6 +467,17 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_cs=C2=A0=C2=
=A0=C2=A0 =3D 2,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .i2c_init=C2=A0=
 =3D witherspoon_bmc_i2c_init,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ram=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D 512 * MiB,
>>> +=C2=A0=C2=A0=C2=A0 }, {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D MACHINE_TYPE_NAME("ast2600-evb"),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .desc=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D "Aspeed AST2600 EVB (Cortex A7)",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .soc_name=C2=A0 =3D "ast2=
600-a0",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_strap1 =3D AST2600_EV=
B_HW_STRAP1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_strap2 =3D AST2600_EV=
B_HW_STRAP2,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fmc_model =3D "w25q512jv=
",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .spi_model =3D "mx66u5123=
5f",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_cs=C2=A0=C2=A0=C2=A0=
 =3D 1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .i2c_init=C2=A0 =3D ast26=
00_evb_i2c_init,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ram=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D 2 * GiB,
>>
>> Hi. I just discovered that this makes 'make check' fail on
>> 32-bit systems, because you can't default to 2GB of RAM
>> for a board:
>>
>> (armhf)pmaydell@mustang-maydell:~/qemu$
>> ./build/all-a32/arm-softmmu/qemu-system-arm -M ast2600-evb
>> qemu-system-arm: at most 2047 MB RAM can be simulated
>>
>> It's also a pretty rudely large amount of RAM to allocate
>> by default: it caused 'make check' to fail on my OSX
>> box, which is 64-bits but doesn't have huge swathes
>> of free RAM.
>=20
> It is unlikely you use this board on a 32-bit system...
>=20
> You usually prefer to have modeled hardware matching real-life,
> what about making this board not available on 32-bit systems
> (we will soon have more boards like this):
>=20
> =C2=A0 #if HOST_LONG_BITS > 32
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D MACHINE_TYPE_NAME("ast2600-evb"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .desc=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D "Aspeed AST2600 EVB (Cortex A7)",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0 #endif /* HOST_LONG_BITS > 32 */

I sent a patch to lower the default RAM size to 1G but you can always=20
increase it on the command line.=20

Making the machine available seems a better choice but that's fine with
me if we prefer to restrict its use to 64bits hosts. As you wish.

C.

