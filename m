Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8A024125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8A024125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkL1-0002P6-3D
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkJX-0001E6-8O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkJV-0004sq-U7
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:44:59 -0500
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:42939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkJV-0004q8-LM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:44:57 -0500
Received: from player791.ha.ovh.net (unknown [10.109.143.189])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 878B61A4A8C
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:44:55 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id C7EFAD232940;
 Fri, 13 Dec 2019 12:44:49 +0000 (UTC)
Subject: Re: [PATCH 04/13] ppc/pnv: Introduce PnvMachineClass and
 PnvMachineClass::compat
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623839085.360005.4046508784077843216.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5bf40b1e-48cb-5a20-82b2-7cd037003c27@kaod.org>
Date: Fri, 13 Dec 2019 13:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623839085.360005.4046508784077843216.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9783788717117442899
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.104.224
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/2019 12:59, Greg Kurz wrote:
> The pnv_dt_create() function generates different contents for the
> "compatible" property of the root node in the DT, depending on the
> CPU type. This is open coded with multiple ifs using pnv_is_powerXX()
> helpers.
>=20
> It seems cleaner to achieve with QOM. Introduce a base class for the
> powernv machine and a compat attribute that each child class can use
> to provide the value for the "compatible" property.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/ppc/pnv.c         |   33 +++++++++++++++++++--------------
>  include/hw/ppc/pnv.h |   13 +++++++++++++
>  2 files changed, 32 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0be0b6b411c3..5ac149b149d8 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -484,9 +484,7 @@ static void pnv_dt_power_mgt(void *fdt)
> =20
>  static void *pnv_dt_create(MachineState *machine)
>  {
> -    const char plat_compat8[] =3D "qemu,powernv8\0qemu,powernv\0ibm,po=
wernv";
> -    const char plat_compat9[] =3D "qemu,powernv9\0ibm,powernv";
> -    const char plat_compat10[] =3D "qemu,powernv10\0ibm,powernv";
> +    PnvMachineClass *pmc =3D PNV_MACHINE_GET_CLASS(machine);
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      void *fdt;
>      char *buf;
> @@ -504,17 +502,8 @@ static void *pnv_dt_create(MachineState *machine)
>      _FDT((fdt_setprop_cell(fdt, 0, "#size-cells", 0x2)));
>      _FDT((fdt_setprop_string(fdt, 0, "model",
>                               "IBM PowerNV (emulated by qemu)")));
> -    if (pnv_is_power10(pnv)) {
> -        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat10,
> -                          sizeof(plat_compat10))));
> -    } else if (pnv_is_power9(pnv)) {
> -        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat9,
> -                          sizeof(plat_compat9))));
> -    } else {
> -        _FDT((fdt_setprop(fdt, 0, "compatible", plat_compat8,
> -                          sizeof(plat_compat8))));
> -    }
> -
> +    _FDT((fdt_setprop(fdt, 0, "compatible", pmc->compat,
> +                      sizeof(pmc->compat))));
> =20
>      buf =3D  qemu_uuid_unparse_strdup(&qemu_uuid);
>      _FDT((fdt_setprop_string(fdt, 0, "vm,uuid", buf)));
> @@ -1692,6 +1681,8 @@ static void pnv_machine_power8_class_init(ObjectC=
lass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> +    PnvMachineClass *pmc =3D PNV_MACHINE_CLASS(oc);
> +    static const char compat[] =3D "qemu,powernv8\0qemu,powernv\0ibm,p=
owernv";
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> @@ -1699,26 +1690,39 @@ static void pnv_machine_power8_class_init(Objec=
tClass *oc, void *data)
>      xic->icp_get =3D pnv_icp_get;
>      xic->ics_get =3D pnv_ics_get;
>      xic->ics_resend =3D pnv_ics_resend;
> +
> +    pmc->compat =3D compat;
> +    pmc->compat_size =3D sizeof(compat);
>  }
> =20
>  static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
> +    PnvMachineClass *pmc =3D PNV_MACHINE_CLASS(oc);
> +    static const char compat[] =3D "qemu,powernv9\0ibm,powernv";
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>      xfc->match_nvt =3D pnv_match_nvt;
> =20
>      mc->alias =3D "powernv";
> +
> +    pmc->compat =3D compat;
> +    pmc->compat_size =3D sizeof(compat);
>  }
> =20
>  static void pnv_machine_power10_class_init(ObjectClass *oc, void *data=
)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    PnvMachineClass *pmc =3D PNV_MACHINE_CLASS(oc);
> +    static const char compat[] =3D "qemu,powernv10\0ibm,powernv";
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER10";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power10_v1.0");
> +
> +    pmc->compat =3D compat;
> +    pmc->compat_size =3D sizeof(compat);
>  }
> =20
>  static void pnv_machine_class_init(ObjectClass *oc, void *data)
> @@ -1796,6 +1800,7 @@ static const TypeInfo types[] =3D {
>          .instance_size =3D sizeof(PnvMachineState),
>          .instance_init =3D pnv_machine_instance_init,
>          .class_init    =3D pnv_machine_class_init,
> +        .class_size    =3D sizeof(PnvMachineClass),
>          .interfaces =3D (InterfaceInfo[]) {
>              { TYPE_INTERRUPT_STATS_PROVIDER },
>              { },
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 92f80b1ccead..d534746bd493 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -185,6 +185,19 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint3=
2_t pir);
>  #define TYPE_PNV_MACHINE       MACHINE_TYPE_NAME("powernv")
>  #define PNV_MACHINE(obj) \
>      OBJECT_CHECK(PnvMachineState, (obj), TYPE_PNV_MACHINE)
> +#define PNV_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(PnvMachineClass, obj, TYPE_PNV_MACHINE)
> +#define PNV_MACHINE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(PnvMachineClass, klass, TYPE_PNV_MACHINE)
> +
> +typedef struct PnvMachineClass {
> +    /*< private >*/
> +    MachineClass parent_class;
> +
> +    /*< public >*/
> +    const char *compat;
> +    int compat_size;
> +} PnvMachineClass;
> =20
>  typedef struct PnvMachineState {
>      /*< private >*/
>=20


