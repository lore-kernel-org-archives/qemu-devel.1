Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0DCC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 06:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491022238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 06:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491022238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnr0-0003om-IS
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 02:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hpnqm-0003HI-LO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 02:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hpnql-0002dX-B5
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 02:00:36 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:41185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hpnql-0002au-32
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 02:00:35 -0400
Received: from player696.ha.ovh.net (unknown [10.108.57.49])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id D8D8E13D92C
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:00:32 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id BBFD68485F67;
 Tue, 23 Jul 2019 06:00:27 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190722182347.25075-1-clg@kaod.org>
 <20190723013808.GJ25073@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <177076c3-b418-fb52-74c9-ee98f5fe4694@kaod.org>
Date: Tue, 23 Jul 2019 08:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723013808.GJ25073@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 11709359032353065811
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrjeejgddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.59.63
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Introduce PowerNV machines with
 fixed CPU models
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/2019 03:38, David Gibson wrote:
> On Mon, Jul 22, 2019 at 08:23:47PM +0200, C=E9dric Le Goater wrote:
>> Make the current "powernv" machine an abstract type and derive from it
>> new machines with specific CPU models: power8, power8e, power8nvl,
>> power9.
>>
>> The "powernv" machine is now an alias on the "powernv9" machine.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Ah, sorry, I wasn't clear here.  I don't think we need a different
> machine type for every cpu model, I just think we should have powernv8
> and powernv9.  POWER8E and POWER8NVL don't significantly change the
> system design (IIUC) so they can still be done with "-machine powernv8
> -cpu POWER8E" or whatever.  I expect the same will be true for POWER9'
> when that comes along

I understand but I am afraid we will to have one machine per CPU family=20
because POWER8E and POWER8NVL already have their own PnvChip :=20

    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_ini=
t),
    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_i=
nit),
    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
                          pnv_chip_power8nvl_class_init),

C.

>> ---
>>  hw/ppc/pnv.c | 97 +++++++++++++++++++++++++++++++++++++++++++++------=
-
>>  1 file changed, 85 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 8cef6d17f111..36f57479a1f5 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -600,6 +600,7 @@ static void pnv_chip_power9_pic_print_info(PnvChip=
 *chip, Monitor *mon)
>>  static void pnv_init(MachineState *machine)
>>  {
>>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>>      MemoryRegion *ram;
>>      char *fw_filename;
>>      long fw_size;
>> @@ -659,16 +660,25 @@ static void pnv_init(MachineState *machine)
>>          }
>>      }
>> =20
>> -    /* Create the processor chips */
>> -    i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX)=
;
>> -    chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
>> -                                    i, machine->cpu_type);
>> -    if (!object_class_by_name(chip_typename)) {
>> -        error_report("invalid CPU model '%.*s' for %s machine",
>> -                     i, machine->cpu_type, MACHINE_GET_CLASS(machine)=
->name);
>> +    /*
>> +     * Do a sanity check on the specified CPU to check compatibility
>> +     * with the machine default. In the future, we might want to
>> +     * create the PnvChip with a compatible CPU model but for now, we
>> +     * use the machine default.
>> +     */
>> +    if (object_class_by_name(mc->default_cpu_type) !=3D
>> +        object_class_by_name(machine->cpu_type)) {
>> +        error_report("invalid CPU model '%s' for %s machine",
>> +                     machine->cpu_type, mc->name);
>>          exit(1);
>>      }
>> =20
>> +    /* Create the processor chips */
>> +    i =3D strlen(mc->default_cpu_type) - strlen(POWERPC_CPU_TYPE_SUFF=
IX);
>> +    chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
>> +                                    i, mc->default_cpu_type);
>> +    assert(object_class_by_name(chip_typename));
>> +
>>      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
>>      for (i =3D 0; i < pnv->num_chips; i++) {
>>          char chip_name[32];
>> @@ -1343,25 +1353,69 @@ static void pnv_machine_class_props_init(Objec=
tClass *oc)
>>                                NULL);
>>  }
>> =20
>> -static void pnv_machine_class_init(ObjectClass *oc, void *data)
>> +static void pnv_machine_power8e_class_init(ObjectClass *oc, void *dat=
a)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>> +
>> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8E";
>> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8e_v2.1");
>> +
>> +    xic->icp_get =3D pnv_icp_get;
>> +    xic->ics_get =3D pnv_ics_get;
>> +    xic->ics_resend =3D pnv_ics_resend;
>> +}
>> +
>> +static void pnv_machine_power8_class_init(ObjectClass *oc, void *data=
)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>> +
>> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8";
>> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>> +
>> +    xic->icp_get =3D pnv_icp_get;
>> +    xic->ics_get =3D pnv_ics_get;
>> +    xic->ics_resend =3D pnv_ics_resend;
>> +}
>> +
>> +static void pnv_machine_power8nvl_class_init(ObjectClass *oc, void *d=
ata)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>> +
>> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8NVL";
>> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8nvl_v1.0");
>> +
>> +    xic->icp_get =3D pnv_icp_get;
>> +    xic->ics_get =3D pnv_ics_get;
>> +    xic->ics_resend =3D pnv_ics_resend;
>> +}
>> +
>> +static void pnv_machine_power9_class_init(ObjectClass *oc, void *data=
)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>> +
>> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
>> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>> +
>> +    mc->alias =3D "powernv";
>> +}
>> +
>> +static void pnv_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CL=
ASS(oc);
>> =20
>>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>>      mc->init =3D pnv_init;
>>      mc->reset =3D pnv_reset;
>>      mc->max_cpus =3D MAX_CPUS;
>> -    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>      mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device =
for
>>                                        * storage */
>>      mc->no_parallel =3D 1;
>>      mc->default_boot_order =3D NULL;
>>      mc->default_ram_size =3D 2 * GiB;
>> -    xic->icp_get =3D pnv_icp_get;
>> -    xic->ics_get =3D pnv_ics_get;
>> -    xic->ics_resend =3D pnv_ics_resend;
>>      ispc->print_info =3D pnv_pic_print_info;
>> =20
>>      pnv_machine_class_props_init(oc);
>> @@ -1381,10 +1435,29 @@ static void pnv_machine_class_init(ObjectClass=
 *oc, void *data)
>>          .parent        =3D TYPE_PNV9_CHIP,          \
>>      }
>> =20
>> +#define DEFINE_PNV_MACHINE_TYPE(cpu, class_initfn)      \
>> +    {                                                   \
>> +        .name          =3D MACHINE_TYPE_NAME(cpu),        \
>> +        .parent        =3D TYPE_PNV_MACHINE,              \
>> +        .instance_size =3D sizeof(PnvMachineState),       \
>> +        .instance_init =3D pnv_machine_instance_init,     \
>> +        .class_init    =3D class_initfn,                  \
>> +        .interfaces =3D (InterfaceInfo[]) {               \
>> +            { TYPE_XICS_FABRIC },                       \
>> +            { TYPE_INTERRUPT_STATS_PROVIDER },          \
>> +            { },                                        \
>> +        },                                              \
>> +    }
>> +
>>  static const TypeInfo types[] =3D {
>> +    DEFINE_PNV_MACHINE_TYPE("powernv8e", pnv_machine_power8e_class_in=
it),
>> +    DEFINE_PNV_MACHINE_TYPE("powernv8", pnv_machine_power8_class_init=
),
>> +    DEFINE_PNV_MACHINE_TYPE("powernv8nvl", pnv_machine_power8nvl_clas=
s_init),
>> +    DEFINE_PNV_MACHINE_TYPE("powernv9", pnv_machine_power9_class_init=
),
>>      {
>>          .name          =3D TYPE_PNV_MACHINE,
>>          .parent        =3D TYPE_MACHINE,
>> +        .abstract       =3D true,
>>          .instance_size =3D sizeof(PnvMachineState),
>>          .instance_init =3D pnv_machine_instance_init,
>>          .class_init    =3D pnv_machine_class_init,
>=20


