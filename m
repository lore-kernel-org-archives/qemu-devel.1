Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F2C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC5720643
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC5720643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXp6M-0003Sm-WC
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXp5T-0002lk-66
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXp5R-0002r6-HW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:13:42 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:58315)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXp5R-0002pY-Ag
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:13:41 -0500
Received: from player688.ha.ovh.net (unknown [10.108.54.217])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 902411148CC
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 17:13:38 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id E3797C4FC20B;
 Thu, 21 Nov 2019 16:13:32 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Create BMC devices at machine init
To: cminyard@mvista.com
References: <20191118092222.15691-1-clg@kaod.org>
 <20191121153649.GG3556@minyard.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <47950b1d-0755-1ef6-7301-f8152d7ee404@kaod.org>
Date: Thu, 21 Nov 2019 17:13:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121153649.GG3556@minyard.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13236642258092788563
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.37.72
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
Cc: qemu-ppc@nongnu.org, Oliver O'Halloran <oohall@gmail.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/2019 16:36, Corey Minyard wrote:
> On Mon, Nov 18, 2019 at 10:22:22AM +0100, C=C3=A9dric Le Goater wrote:
>> The BMC of the OpenPOWER systems monitors the machine state using
>> sensors, controls the power and controls the access to the PNOR flash
>> device containing the firmware image required to boot the host.
>>
>> QEMU models the power cycle process, access to the sensors and access
>> to the PNOR device. But, for these features to be available, the QEMU
>> PowerNV machine needs two extras devices on the command line, an IPMI
>> BT device for communication and a BMC backend device:
>>
>>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D=
10
>=20
> With these changes, the above line will no longer be necessary, right?

Yes.=20

I would have liked to find a way to introduce some kind of lazy binding
between the two devices and still be able to change the IPMI backend on=20
the command line but it seemed too complex.

> Minor nit inline ...
>=20
>>
>> The BMC properties are then defined accordingly in the device tree and
>> OPAL self adapts. If a BMC device and an IPMI BT device are not
>> available, OPAL does not try to communicate with the BMC in any
>> manner. This is not how real systems behave.
>>
>> To be closer to the default behavior, create an IPMI BMC simulator
>> device and an IPMI BT device at machine initialization time. We loose
>> the ability to define an external BMC device but there are benefits:
>>
>>   - a better match with real systems,
>>   - a better test coverage of the OPAL code,
>>   - system powerdown and reset commands that work,
>>   - a QEMU device tree compliant with the specifications (*).
>>
>> (*) Still needs a MBOX device.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/pnv.h |  2 +-
>>  hw/ppc/pnv.c         | 33 ++++++++++++++++-----------------
>>  hw/ppc/pnv_bmc.c     | 20 +++++++++++++++++---
>>  3 files changed, 34 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index 07c56c05ad30..90f1343ed07c 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -198,7 +198,7 @@ static inline bool pnv_is_power9(PnvMachineState *=
pnv)
>>   */
>>  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>>  void pnv_bmc_powerdown(IPMIBmc *bmc);
>> -int pnv_bmc_hiomap(IPMIBmc *bmc);
>> +IPMIBmc *pnv_bmc_create(void);
>> =20
>>  /*
>>   * POWER8 MMIO base addresses
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index c3ac0d6d5b4a..2117d879895c 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -551,27 +551,10 @@ static void pnv_powerdown_notify(Notifier *n, vo=
id *opaque)
>> =20
>>  static void pnv_reset(MachineState *machine)
>>  {
>> -    PnvMachineState *pnv =3D PNV_MACHINE(machine);
>>      void *fdt;
>> -    Object *obj;
>> =20
>>      qemu_devices_reset();
>> =20
>> -    /*
>> -     * OpenPOWER systems have a BMC, which can be defined on the
>> -     * command line with:
>> -     *
>> -     *   -device ipmi-bmc-sim,id=3Dbmc0
>> -     *
>> -     * This is the internal simulator but it could also be an externa=
l
>> -     * BMC.
>> -     */
>> -    obj =3D object_resolve_path_type("", "ipmi-bmc-sim", NULL);
>> -    if (obj) {
>> -        pnv->bmc =3D IPMI_BMC(obj);
>> -        pnv_bmc_hiomap(pnv->bmc);
>> -    }
>> -
>>      fdt =3D pnv_dt_create(machine);
>> =20
>>      /* Pack resulting tree */
>> @@ -629,6 +612,16 @@ static bool pnv_match_cpu(const char *default_typ=
e, const char *cpu_type)
>>      return ppc_default->pvr_match(ppc_default, ppc->pvr);
>>  }
>> =20
>> +static void ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
>=20
> All the other names have pnv_ in front of them, could you add that to
> this, too?

Sure. I will resend a v2 with this change and your acked-by.

C.=20


>=20
> -corey
>=20
>> +{
>> +    Object *obj;
>> +
>> +    obj =3D OBJECT(isa_create(bus, "isa-ipmi-bt"));
>> +    object_property_set_link(obj, OBJECT(bmc), "bmc", &error_fatal);
>> +    object_property_set_int(obj, irq, "irq", &error_fatal);
>> +    object_property_set_bool(obj, true, "realized", &error_fatal);
>> +}
>> +
>>  static void pnv_init(MachineState *machine)
>>  {
>>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
>> @@ -751,6 +744,9 @@ static void pnv_init(MachineState *machine)
>>      }
>>      g_free(chip_typename);
>> =20
>> +    /* Create the machine BMC simulator */
>> +    pnv->bmc =3D pnv_bmc_create();
>> +
>>      /* Instantiate ISA bus on chip 0 */
>>      pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
>> =20
>> @@ -760,6 +756,9 @@ static void pnv_init(MachineState *machine)
>>      /* Create an RTC ISA device too */
>>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
>> =20
>> +    /* Create the IPMI BT device for communication with the BMC */
>> +    ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
>> +
>>      /*
>>       * OpenPOWER systems use a IPMI SEL Event message to notify the
>>       * host to powerdown
>> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
>> index aa5c89586c63..07fa1e1c7e45 100644
>> --- a/hw/ppc/pnv_bmc.c
>> +++ b/hw/ppc/pnv_bmc.c
>> @@ -17,6 +17,8 @@
>>   */
>> =20
>>  #include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "qapi/error.h"
>>  #include "target/ppc/cpu.h"
>>  #include "qemu/log.h"
>>  #include "hw/ipmi/ipmi.h"
>> @@ -211,8 +213,20 @@ static const IPMINetfn hiomap_netfn =3D {
>>      .cmd_handlers =3D hiomap_cmds
>>  };
>> =20
>> -int pnv_bmc_hiomap(IPMIBmc *bmc)
>> +/*
>> + * Instantiate the machine BMC. PowerNV uses the QEMU internal
>> + * simulator but it could also be external.
>> + */
>> +IPMIBmc *pnv_bmc_create(void)
>>  {
>> -    return ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc),
>> -                                   IPMI_NETFN_OEM, &hiomap_netfn);
>> +    Object *obj;
>> +
>> +    obj =3D object_new(TYPE_IPMI_BMC_SIMULATOR);
>> +    object_property_set_bool(obj, true, "realized", &error_fatal);
>> +
>> +    /* Install the HIOMAP protocol handlers to access the PNOR */
>> +    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(obj), IPMI_NETFN_OEM,
>> +                            &hiomap_netfn);
>> +
>> +    return IPMI_BMC(obj);
>>  }
>> --=20
>> 2.21.0
>>


