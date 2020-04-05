Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F68AC2D0E8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFDA206F5
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFDA206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKzNb-0005aG-1F
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 03:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jKzMi-0004qU-My
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jKzMg-0005s0-7g
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:06:43 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:42438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jKzMg-0005q5-05
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:06:42 -0400
Received: from player739.ha.ovh.net (unknown [10.110.171.250])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8D3CE135E06
 for <qemu-devel@nongnu.org>; Sun,  5 Apr 2020 09:06:40 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id 6B5B2D1966A5;
 Sun,  5 Apr 2020 07:06:30 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Create BMC devices only when defaults are enabled
To: Nathan Chancellor <natechancellor@gmail.com>
References: <20200404153655.166834-1-clg@kaod.org>
 <20200404214447.GA34626@ubuntu-m2-xlarge-x86>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c813318e-0538-99ac-cf79-41faa103389f@kaod.org>
Date: Sun, 5 Apr 2020 09:06:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200404214447.GA34626@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9475573617545481024
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.159
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/4/20 11:44 PM, Nathan Chancellor wrote:
> Hi C=C3=A9dric,
>=20
> On Sat, Apr 04, 2020 at 05:36:55PM +0200, C=C3=A9dric Le Goater wrote:
>> Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
>> introduced default BMC devices which can be a problem when the same
>> devices are defined on the command line with :
>>
>>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D=
10
>>
>> QEMU fails with :
>>
>>   qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS
>>
>> Use defaults_enabled() when creating the default BMC devices to let
>> the user provide its own BMC devices using '-nodefaults'. If no BMC
>> device are provided, output a warning but let QEMU run as this is a
>> supported configuration. However, when multiple BMC devices are
>> defined, stop QEMU with a clear error as the results are unexpected.
>>
>> Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> This fixes my issue when -nodefaults is passed and that does not regres=
s
> QEMU 3.1.0 or 4.2.0. Thank you for the quick fix!
>=20
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>=20
> A few comments inline.
>=20
>> ---
>>  include/hw/ppc/pnv.h |  2 ++
>>  hw/ppc/pnv.c         | 32 ++++++++++++++++++++++++++-----
>>  hw/ppc/pnv_bmc.c     | 45 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 74 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index fb4d0c0234b3..d4b0b0e2ff71 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -241,6 +241,8 @@ struct PnvMachineState {
>>  void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>>  void pnv_bmc_powerdown(IPMIBmc *bmc);
>>  IPMIBmc *pnv_bmc_create(PnvPnor *pnor);
>> +IPMIBmc *pnv_bmc_find(Error **errp);
>> +void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>> =20
>>  /*
>>   * POWER8 MMIO base addresses
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index ac83b8698b8e..a3b7a8d0ff32 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -573,10 +573,29 @@ static void pnv_powerdown_notify(Notifier *n, vo=
id *opaque)
>> =20
>>  static void pnv_reset(MachineState *machine)
>>  {
>> +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
>> +    IPMIBmc *bmc;
>>      void *fdt;
>> =20
>>      qemu_devices_reset();
>> =20
>> +    /*
>> +     * The machine should provide by default an internal BMC simulato=
r.
>> +     * If not, try to use the BMC device that was provided on the com=
mand
>> +     * line.
>> +     */
>> +    bmc =3D pnv_bmc_find(&error_fatal);
>> +    if (!pnv->bmc) {
>> +        if (!bmc) {
>> +            warn_report("machine has no BMC device. Use '-device "
>> +                        "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,b=
mc=3Dbmc0,irq=3D10' "
>> +                        "to define one");
>=20
> If I pass no -device flags + -nodefaults, I don't see this message. Is
> that expected?

yes. Because the machine instantiates the default BMC devices.

>=20
>> +        } else {
>> +            pnv_bmc_set_pnor(bmc, pnv->pnor);
>> +            pnv->bmc =3D bmc;
>> +        }
>> +    }
>> +
>>      fdt =3D pnv_dt_create(machine);
>> =20
>>      /* Pack resulting tree */
>> @@ -835,9 +854,6 @@ static void pnv_init(MachineState *machine)
>>      }
>>      g_free(chip_typename);
>> =20
>> -    /* Create the machine BMC simulator */
>> -    pnv->bmc =3D pnv_bmc_create(pnv->pnor);
>> -
>>      /* Instantiate ISA bus on chip 0 */
>>      pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
>> =20
>> @@ -847,8 +863,14 @@ static void pnv_init(MachineState *machine)
>>      /* Create an RTC ISA device too */
>>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
>> =20
>> -    /* Create the IPMI BT device for communication with the BMC */
>> -    pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
>> +    /*
>> +     * Create the machine BMC simulator and the IPMI BT device for
>> +     * communication with the BMC
>> +     */
>> +    if (defaults_enabled()) {
>> +        pnv->bmc =3D pnv_bmc_create(pnv->pnor);
>> +        pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
>> +    }
>> =20
>>      /*
>>       * OpenPOWER systems use a IPMI SEL Event message to notify the
>> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
>> index 8863354c1c08..4e018b8b70e4 100644
>> --- a/hw/ppc/pnv_bmc.c
>> +++ b/hw/ppc/pnv_bmc.c
>> @@ -213,6 +213,18 @@ static const IPMINetfn hiomap_netfn =3D {
>>      .cmd_handlers =3D hiomap_cmds
>>  };
>> =20
>> +
>> +void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
>> +{
>> +    object_ref(OBJECT(pnor));
>> +    object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor),
>> +                                   &error_abort);
>> +
>> +    /* Install the HIOMAP protocol handlers to access the PNOR */
>> +    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc), IPMI_NETFN_OEM,
>> +                            &hiomap_netfn);
>> +}
>> +
>>  /*
>>   * Instantiate the machine BMC. PowerNV uses the QEMU internal
>>   * simulator but it could also be external.
>> @@ -232,3 +244,36 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
>> =20
>>      return IPMI_BMC(obj);
>>  }
>> +
>> +typedef struct ForeachArgs {
>> +    const char *name;
>> +    Object *obj;
>> +} ForeachArgs;
>> +
>> +static int bmc_find(Object *child, void *opaque)
>> +{
>> +    ForeachArgs *args =3D opaque;
>> +
>> +    if (object_dynamic_cast(child, args->name)) {
>> +        if (args->obj) {
>> +            return 1;
>> +        }
>> +        args->obj =3D child;
>> +    }
>> +    return 0;
>> +}
>> +
>> +IPMIBmc *pnv_bmc_find(Error **errp)
>> +{
>> +    ForeachArgs args =3D { TYPE_IPMI_BMC_SIMULATOR, NULL };
>> +    int ret;
>> +
>> +    ret =3D object_child_foreach_recursive(object_get_root(), bmc_fin=
d, &args);
>> +    if (ret) {
>> +        error_setg(errp, "machine should have only one BMC device. "
>> +                   "Use '-nodefaults'");
>=20
> When passing the -device flags in the commit message as I did in my
> original command without -nodefaults, I still see the
>=20
> qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS
>=20
> message. Is that expected?
object_child_foreach_recursive() is broken. Here is the fix :

   http://patchwork.ozlabs.org/patch/1266419/

Sorry. I should have copied you.

But there are other ways to find multiple instances of the same type.=20
May be we will need to rework that part a bit.

Thanks,

C.

>=20
>> +        return NULL;
>> +    }
>> +
>> +    return args.obj ? IPMI_BMC(args.obj) : NULL;
>> +}
>> --=20
>> 2.25.1
>>


