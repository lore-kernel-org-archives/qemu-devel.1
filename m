Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76906C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493062133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493062133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbkyI-0000hb-QN
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hbkik-0006EL-Ar
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hbkii-00020R-TF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:50:14 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:59988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hbkii-0001jZ-GA
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 07:50:12 -0400
Received: from player731.ha.ovh.net (unknown [10.109.146.32])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 115C11F7944
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 13:49:59 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 405C36BC95FB;
 Fri, 14 Jun 2019 11:49:53 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-14-clg@kaod.org>
 <777b7a86-ce5e-d218-5848-c8f4b37a0bf4@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ce552c20-7dfa-7085-b90d-e3c2d33f5bda@kaod.org>
Date: Fri, 14 Jun 2019 13:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <777b7a86-ce5e-d218-5848-c8f4b37a0bf4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9936911105575259091
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.112
Subject: Re: [Qemu-devel] [PATCH 13/19] aspeed/smc: add a 'sdram_base'
 propertie
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

On 13/06/2019 16:32, Philippe Mathieu-Daud=C3=A9 wrote:
> On 5/25/19 5:12 PM, C=C3=A9dric Le Goater wrote:
>> The DRAM address of a DMA transaction depends on the DRAM base address
>> of the SoC. Inform the SMC controller model of this value.
>=20
> I'd reorder this one previous patch #16 "aspeed/smc: add support for
> DMAs" where you start to use sdram_base.
>=20
> Regardless,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


done.

Thanks,

C.=20

>=20
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ssi/aspeed_smc.h | 3 +++
>>  hw/arm/aspeed_soc.c         | 6 ++++++
>>  hw/ssi/aspeed_smc.c         | 1 +
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
>> index 3b1e7fce6c86..591279ba1f43 100644
>> --- a/include/hw/ssi/aspeed_smc.h
>> +++ b/include/hw/ssi/aspeed_smc.h
>> @@ -97,6 +97,9 @@ typedef struct AspeedSMCState {
>>      uint8_t r_timings;
>>      uint8_t conf_enable_w0;
>> =20
>> +    /* for DMA support */
>> +    uint64_t sdram_base;
>> +
>>      AspeedSMCFlash *flashes;
>> =20
>>      uint8_t snoop_index;
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index 8cfe9e9515ed..65fbac896c85 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -326,6 +326,12 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
>>                         aspeed_soc_get_irq(s, ASPEED_I2C));
>> =20
>>      /* FMC, The number of CS is set at the board level */
>> +    object_property_set_int(OBJECT(&s->fmc), sc->info->memmap[ASPEED_=
SDRAM],
>> +                            "sdram-base", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>>      object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err)=
;
>>      if (err) {
>>          error_propagate(errp, err);
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index f1e66870d71f..4ff12f7b27fc 100644
>> --- a/hw/ssi/aspeed_smc.c
>> +++ b/hw/ssi/aspeed_smc.c
>> @@ -912,6 +912,7 @@ static const VMStateDescription vmstate_aspeed_smc=
 =3D {
>> =20
>>  static Property aspeed_smc_properties[] =3D {
>>      DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
>> +    DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>> =20
>>


