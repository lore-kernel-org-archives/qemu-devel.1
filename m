Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F54ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEE420854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEE420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQrs-0001nf-HR
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iKQqt-0001KM-R0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iKQqs-0007vm-8n
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:43:19 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:47149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iKQqs-0007rZ-2W
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:43:18 -0400
Received: from player691.ha.ovh.net (unknown [10.109.159.159])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id DF67D208ED3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 19:43:08 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id C9E47B19587A;
 Tue, 15 Oct 2019 17:43:03 +0000 (UTC)
Subject: Re: [PULL 59/68] aspeed: Add an AST2600 eval board
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
 <20191014160404.19553-60-peter.maydell@linaro.org>
 <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a888142d-7c9e-bc15-84d3-80bd01df1d11@kaod.org>
Date: Tue, 15 Oct 2019 19:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-2EZnnrYViQUQK-mR0=JqR9mXNzfVNa_WR5HoCTJ+tag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 372672870308350931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeefgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.8
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
Cc: Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/2019 19:03, Peter Maydell wrote:
> On Mon, 14 Oct 2019 at 17:05, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Message-id: 20190925143248.10000-21-clg@kaod.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/hw/arm/aspeed.h |  1 +
>>  hw/arm/aspeed.c         | 23 +++++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>=20
>> @@ -455,6 +467,17 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>          .num_cs    =3D 2,
>>          .i2c_init  =3D witherspoon_bmc_i2c_init,
>>          .ram       =3D 512 * MiB,
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
>=20
> I'm going to drop this patch from my queue and redo
> the pullreq.

ok. We do have such a board.=20

What do you suggest ? We can lower the RAM to 1G for QEMU.=20

Thanks,

C. =20



U-Boot 2019.04-00299-g7eb9da617d8e (Aug 21 2019 - 17:46:13 +0930)

SOC : AST2600-A0=20
RST : WDT1 SOC=20
PCI RST : #1 #2=20
eSPI Mode : SIO:Enable : SuperIO-2e
Eth :    MAC0: RGMII ,MAC1: RGMII ,MAC2: RGMII ,MAC3: RGMII=20
Model: Aspeed BMC
DRAM:  2 GiB
WARNING: Caches not enabled
MMC:   emmc_slot0@100: 0
Loading Environment from SPI Flash... SF: Detected w25q512jv with page si=
ze 256 Bytes, erase size 4 KiB, total 64 MiB
OK
In:    serial@1e784000
Out:   serial@1e784000
Err:   serial@1e784000
Model: Aspeed BMC
Net:   eth1: ftgmac@1e680000, eth2: ftgmac@1e670000
Warning: ftgmac@1e690000 (eth3) using random MAC address - 96:5c:26:8e:5e=
:0a
, eth3: ftgmac@1e690000
Hit any key to stop autoboot:  0=20





