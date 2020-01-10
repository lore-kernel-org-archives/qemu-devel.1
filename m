Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FF4C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50742051A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50742051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprKd-0004Ux-Qf
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iprJf-0003rC-M0
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iprJe-0001Ly-5M
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:14:55 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:38880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iprJd-0001EK-Qp
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:14:54 -0500
Received: from player750.ha.ovh.net (unknown [10.109.146.32])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 94E58117F3A
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:14:51 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id DDCC6E07DDD6;
 Fri, 10 Jan 2020 10:14:44 +0000 (UTC)
Subject: Re: [PATCH 4/5] hw/arm/aspeed: add a 'execute-in-place' property to
 boot directly from CE0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200107073423.30043-1-clg@kaod.org>
 <20200107073423.30043-5-clg@kaod.org>
 <949c0ad0-40b5-9c7d-4d5a-58e519166142@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ec6d268c-6fcc-4c28-26ee-6003a2a12b7f@kaod.org>
Date: Fri, 10 Jan 2020 11:14:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <949c0ad0-40b5-9c7d-4d5a-58e519166142@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5663839482681133888
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeifedgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.1
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
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 9:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/7/20 8:34 AM, C=C3=A9dric Le Goater wrote:
>> The overhead for the OpenBMC firmware images using the a custom U-Boot
>> is around 2 seconds, which is fine, but with a U-Boot from mainline,
>> it takes an extra 50 seconds or so to reach Linux. A quick survey on
>> the number of reads performed on the flash memory region gives the
>> following figures :
>>
>> =C2=A0=C2=A0 OpenBMC U-Boot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 922478 (~ 3.=
5 MBytes)
>> =C2=A0=C2=A0 Mainline U-Boot=C2=A0=C2=A0 20569977 (~ 80=C2=A0 MBytes)
>>
>> QEMU must be trashing the TCG TBs and reloading text very often. Some
>> addresses are read more than 250.000 times. Until we find a solution
>> to improve boot time, execution from MMIO is not activated by default.
>>
>> Setting this option also breaks migration compatibility.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> =C2=A0 include/hw/arm/aspeed.h |=C2=A0 2 ++
>> =C2=A0 hw/arm/aspeed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 44 ++++++++++++++++++++++++++++++++++++-----
>> =C2=A0 2 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
>> index 4423cd0cda71..18521484b90e 100644
>> --- a/include/hw/arm/aspeed.h
>> +++ b/include/hw/arm/aspeed.h
>> @@ -19,6 +19,8 @@ typedef struct AspeedBoardState AspeedBoardState;
>> =C2=A0 =C2=A0 typedef struct AspeedMachine {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MachineState parent_obj;
>> +
>> +=C2=A0=C2=A0=C2=A0 bool mmio_exec;
>> =C2=A0 } AspeedMachine;
>> =C2=A0 =C2=A0 #define ASPEED_MACHINE_CLASS(klass) \
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 0a7dfd29868b..bf23579fa53d 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -260,11 +260,18 @@ static void aspeed_machine_init(MachineState *ma=
chine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * SoC and=
 128MB for the AST2500 SoC, which is twice as big as
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * needed =
by the flash modules of the Aspeed machines.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_init_rom(boo=
t_rom, OBJECT(bmc), "aspeed.boot_rom",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fl->size, &error_abort);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_region_add_subregio=
n(get_system_memory(), FIRMWARE_ADDR,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boot_r=
om);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_boot_rom(drive0, FIR=
MWARE_ADDR, fl->size, &error_abort);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ASPEED_MACHINE(machine=
)->mmio_exec) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
mory_region_init_alias(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
&fl->mmio, 0, fl->size);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
mory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 boot_rom);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
mory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fl->size, &e=
rror_abort);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
mory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 boot_rom);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wr=
ite_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Nitpick: I'd use rom_add_file_mr() in write_boot_rom(), and keep the me=
mory_region_add_subregion() call after the if/else statement.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I would rather address changes in follow-up  patches.

Thanks for the hint.=20

C.=20

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_board_binfo.ram_size =3D =
ram_size;
>> @@ -398,6 +405,30 @@ static void witherspoon_bmc_i2c_init(AspeedBoardS=
tate *bmc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Bus 11: TODO ucd90160@64 */
>> =C2=A0 }
>> =C2=A0 +static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return ASPEED_MACHINE(obj)->mmio_exec;
>> +}
>> +
>> +static void aspeed_set_mmio_exec(Object *obj, bool value, Error **err=
p)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ASPEED_MACHINE(obj)->mmio_exec =3D value;
>> +}
>> +
>> +static void aspeed_machine_instance_init(Object *obj)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ASPEED_MACHINE(obj)->mmio_exec =3D false;
>> +}
>> +
>> +static void aspeed_machine_class_props_init(ObjectClass *oc)
>> +{
>> +=C2=A0=C2=A0=C2=A0 object_class_property_add_bool(oc, "execute-in-pla=
ce",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_get_m=
mio_exec,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_set_m=
mio_exec, &error_abort);
>> +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(oc, "execute=
-in-place",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "boot directly from CE0 flash device", &error_abort);
>> +}
>> +
>> =C2=A0 static void aspeed_machine_class_init(ObjectClass *oc, void *da=
ta)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);
>> @@ -407,6 +438,8 @@ static void aspeed_machine_class_init(ObjectClass =
*oc, void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_floppy =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_cdrom =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_parallel =3D 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 aspeed_machine_class_props_init(oc);
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void aspeed_machine_palmetto_class_init(ObjectCla=
ss *oc, void *data)
>> @@ -549,6 +582,7 @@ static const TypeInfo aspeed_machine_types[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D TYPE_ASPEED_MACHINE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D TYPE_MACHINE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =
=3D sizeof(AspeedMachine),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_init =3D aspeed_=
machine_instance_init,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_size=C2=A0=
=C2=A0=C2=A0 =3D sizeof(AspeedMachineClass),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=
=C2=A0=C2=A0 =3D aspeed_machine_class_init,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abstract=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D true,
>>
>=20


