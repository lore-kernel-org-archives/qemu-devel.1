Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834AAC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D65A207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65A207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayK8-0006SD-Kj
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50087)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hayHj-0004JM-HX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hayEZ-0002UN-7e
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:03:52 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:34855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hayEY-0002PD-Ug
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:03:51 -0400
Received: from player770.ha.ovh.net (unknown [10.108.42.228])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 9C42910D753
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 10:03:42 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id E00B56BE40C8;
 Wed, 12 Jun 2019 08:03:36 +0000 (UTC)
To: Joel Stanley <joel@jms.id.au>
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-7-clg@kaod.org>
 <CACPK8Xet-EQFKbjykuE774pCo4aSNoy=SNpSRW16pJjXW=4J5w@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e3a86c7f-86f8-55b8-6825-311885ab742f@kaod.org>
Date: Wed, 12 Jun 2019 10:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xet-EQFKbjykuE774pCo4aSNoy=SNpSRW16pJjXW=4J5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12816681590398094251
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehiedguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.159
Subject: Re: [Qemu-devel] [PATCH 06/19] aspeed: introduce a configurable
 number of CPU per machine
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/2019 03:32, Joel Stanley wrote:
> On Sat, 25 May 2019 at 15:13, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> The current models of the Aspeed SoCs only have one CPU but future
>> ones will support SMP. Introduce a way to configure the maximum number
>> of CPU per machine. SMP support will be activated when models for such
>> SoCs are implemented.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/arm/aspeed.h     |  1 +
>>  include/hw/arm/aspeed_soc.h |  3 ++-
>>  hw/arm/aspeed.c             |  8 ++++++--
>>  hw/arm/aspeed_soc.c         | 17 +++++++++++------
>>  4 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
>> index 02073a6b4d61..f2f238ea83cc 100644
>> --- a/include/hw/arm/aspeed.h
>> +++ b/include/hw/arm/aspeed.h
>> @@ -23,6 +23,7 @@ typedef struct AspeedBoardConfig {
>>      uint32_t num_cs;
>>      void (*i2c_init)(AspeedBoardState *bmc);
>>      uint32_t ram;
>> +    uint32_t num_cpus;
>>  } AspeedBoardConfig;
>>
>>  #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index fa0ba957a611..7247f6da2505 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -24,13 +24,14 @@
>>
>>  #define ASPEED_SPIS_NUM  2
>>  #define ASPEED_WDTS_NUM  3
>> +#define ASPEED_CPUS_NUM  2
>>
>>  typedef struct AspeedSoCState {
>>      /*< private >*/
>>      DeviceState parent;
>>
>>      /*< public >*/
>> -    ARMCPU cpu;
>> +    ARMCPU cpu[ASPEED_CPUS_NUM];
>>      MemoryRegion sram;
>>      AspeedVICState vic;
>>      AspeedRtcState rtc;
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 10ba3f50481a..004b0c318951 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -29,7 +29,6 @@
>>
>>  static struct arm_boot_info aspeed_board_binfo =3D {
>>      .board_id =3D -1, /* device-tree-only board */
>> -    .nb_cpus =3D 1,
>>  };
>>
>>  struct AspeedBoardState {
>> @@ -231,6 +230,7 @@ static void aspeed_board_init(MachineState *machin=
e,
>>      aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
>>      aspeed_board_binfo.ram_size =3D ram_size;
>>      aspeed_board_binfo.loader_start =3D sc->info->memmap[ASPEED_SDRAM=
];
>> +    aspeed_board_binfo.nb_cpus =3D cfg->num_cpus;
>>
>>      if (cfg->i2c_init) {
>>          cfg->i2c_init(bmc);
>> @@ -327,7 +327,7 @@ static void aspeed_machine_class_init(ObjectClass =
*oc, void *data)
>>
>>      mc->desc =3D board->desc;
>>      mc->init =3D aspeed_machine_init;
>> -    mc->max_cpus =3D 1;
>> +    mc->max_cpus =3D ASPEED_CPUS_NUM;
>>      mc->no_sdcard =3D 1;
>>      mc->no_floppy =3D 1;
>>      mc->no_cdrom =3D 1;
>> @@ -357,6 +357,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>          .num_cs    =3D 1,
>>          .i2c_init  =3D palmetto_bmc_i2c_init,
>>          .ram       =3D 256 * MiB,
>> +        .num_cpus  =3D 1,
>>      }, {
>>          .name      =3D MACHINE_TYPE_NAME("ast2500-evb"),
>>          .desc      =3D "Aspeed AST2500 EVB (ARM1176)",
>> @@ -367,6 +368,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>          .num_cs    =3D 1,
>>          .i2c_init  =3D ast2500_evb_i2c_init,
>>          .ram       =3D 512 * MiB,
>> +        .num_cpus  =3D 1,
>>      }, {
>>          .name      =3D MACHINE_TYPE_NAME("romulus-bmc"),
>>          .desc      =3D "OpenPOWER Romulus BMC (ARM1176)",
>> @@ -377,6 +379,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>          .num_cs    =3D 2,
>>          .i2c_init  =3D romulus_bmc_i2c_init,
>>          .ram       =3D 512 * MiB,
>> +        .num_cpus  =3D 1,
>>      }, {
>>          .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
>>          .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
>> @@ -387,6 +390,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>          .num_cs    =3D 2,
>>          .i2c_init  =3D witherspoon_bmc_i2c_init,
>>          .ram       =3D 512 * MiB,
>> +        .num_cpus  =3D 1,
>>      },
>>  };
>>
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index d1dc8f03f35c..b983d5efc5d1 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -172,8 +172,11 @@ static void aspeed_soc_init(Object *obj)
>>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>>      int i;
>>
>> -    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cp=
u),
>> -                            sc->info->cpu_type, &error_abort, NULL);
>> +    for (i =3D 0; i < MIN(smp_cpus, ASPEED_CPUS_NUM); i++) {
>=20
> What's the intent of this test?
>=20
> If we're checking that the user hasn't requested more CPUs that the
> SoC supports, shoudln't it be testing against ->num_cpus instead of
> ASPEED_CPUS_NUM?

yes but we are in the SoC and ->num_cpus is currently a board level=20
information. As we are in the _init routine I can't use a SoC property.=20

This can be improved. I will send a v2.

Thanks,

C.

>=20
>> +        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
>> +                                sizeof(s->cpu[i]), sc->info->cpu_type=
,
>> +                                &error_abort, NULL);
>> +    }
>>
>>      sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu)=
,
>>                            TYPE_ASPEED_SCU);
>> @@ -242,10 +245,12 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
>>                                  ASPEED_SOC_IOMEM_SIZE);
>>
>>      /* CPU */
>> -    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err)=
;
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -        return;
>> +    for (i =3D 0; i < smp_cpus; i++) {
>=20
> Can you explain why we use smp_cpus instead of ->num_cpus?
>=20
>> +        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized"=
, &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>>      }
>>
>>      /* SRAM */
>> --
>> 2.20.1
>>


