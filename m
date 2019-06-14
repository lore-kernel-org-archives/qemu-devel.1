Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E7FC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F216C208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F216C208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbl1V-0001T9-0s
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hbkuP-0007Wf-Tb
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hbkuO-0004XT-Mn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:02:17 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:55630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hbkuM-0004TL-TE
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:02:15 -0400
Received: from player756.ha.ovh.net (unknown [10.109.146.86])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 18335136678
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 14:02:10 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id E3CD3606A805;
 Fri, 14 Jun 2019 12:02:04 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-19-clg@kaod.org>
 <f3b3948f-8d24-fb8c-0b65-8fe08019a077@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b4401eaf-9898-8c3e-3beb-f550edb83228@kaod.org>
Date: Fri, 14 Jun 2019 14:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f3b3948f-8d24-fb8c-0b65-8fe08019a077@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10142669311310400467
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.148
Subject: Re: [Qemu-devel] [PATCH 18/19] aspeed/smc: inject errors in DMA
 checksum
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/06/2019 16:31, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 5/25/19 5:12 PM, C=C3=A9dric Le Goater wrote:
>> Emulate read errors in the DMA Checksum Register for high frequencies
>> and optimistic settings of the Read Timing Compensation Register. This
>> will help in tuning the SPI timing calibration algorithm.
>>
>> The values below are those to expect from the first flash device of
>> the FMC controller of a palmetto-bmc machine.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ssi/aspeed_smc.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index 406c30c60b3f..4c162912cf62 100644
>> --- a/hw/ssi/aspeed_smc.c
>> +++ b/hw/ssi/aspeed_smc.c
>> @@ -866,6 +866,30 @@ static void aspeed_smc_dma_calibration(AspeedSMCS=
tate *s)
>>      s->regs[s->r_ctrl0 + cs] |=3D CE_CTRL_CLOCK_FREQ(hclk_div);
>>  }
>> =20
>=20
> Can you add a comment (like the patch description) here?

yes. done.
=20
>> +static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
>> +{
>> +    uint8_t delay =3D
>> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELA=
Y_MASK;
>> +    uint8_t hclk_mask =3D
>> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_=
MASK;
>> +
>> +    /*
>> +     * Typical values of a palmetto-bmc machine.
>> +     */
>> +    switch (aspeed_smc_hclk_divisor(hclk_mask)) {
>> +    case 4 ... 16:
>> +        return false;
>> +    case 3: /* at least one HCLK cycle delay */
>> +        return (delay & 0x7) < 1;
>> +    case 2: /* at least two HCLK cycle delay */
>> +        return (delay & 0x7) < 2;
>> +    case 1: /* (> 100MHz) is above the max freq of the controller */
>> +        return true;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>>  /*
>>   * Accumulate the result of the reads to provide a checksum that will
>>   * be used to validate the read timing settings.
>> @@ -903,6 +927,11 @@ static void aspeed_smc_dma_checksum(AspeedSMCStat=
e *s)
>>          s->regs[R_DMA_FLASH_ADDR] +=3D 4;
>>          s->regs[R_DMA_LEN] -=3D 4;
>>      }
>> +
>> +    if (aspeed_smc_inject_read_failure(s)) {
>=20
> So this model real world where noise eventually triggers errors. Don't
> we want this to be enable by the user (or a QMP command)?

I can add a property at the device model level to trigger this behavior.
Such as :

   -global driver=3Daspeed.smc,property=3Dtiming,value=3Dtrue

timing if defined would provide the maximum clock and delay settings.

Are there any other examples in QEMU ?=20

Thanks,

C.

>=20
>> +        s->regs[R_DMA_CHECKSUM] =3D 0xbadc0de;
>> +    }
>> +
>>  }
>> =20
>>  static void aspeed_smc_dma_rw(AspeedSMCState *s)
>>


