Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC4C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A0924125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A0924125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkL1-0002QQ-K6
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkJY-0001EA-CS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkJX-0004vB-5c
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:45:00 -0500
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:54620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkJW-0004sS-VK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:44:59 -0500
Received: from player699.ha.ovh.net (unknown [10.109.143.3])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3B4A078FC2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:44:57 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 9E6FFD3F658F;
 Fri, 13 Dec 2019 12:44:51 +0000 (UTC)
Subject: Re: [PATCH 05/13] ppc/pnv: Introduce PnvMachineClass::dt_power_mgt()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623839642.360005.9243510140436689941.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <861cd13c-9237-59be-dad6-5f3d4031a1e1@kaod.org>
Date: Fri, 13 Dec 2019 13:44:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623839642.360005.9243510140436689941.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9784070194249501523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.50.32
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
> We add an extra node to advertise power management on some machines,
> namely powernv9 and powernv10. This is achieved by using the
> pnv_is_power9() and pnv_is_power10() helpers.
>=20
> This can be achieved with QOM. Add a method to the base class for
> powernv machines and have it implemented by machine types that
> support power management instead.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/pnv.c         |   10 ++++++----
>  include/hw/ppc/pnv.h |    8 ++++++--
>  2 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 5ac149b149d8..efc00f4cb67a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -472,7 +472,7 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *=
fdt)
>                         &args);
>  }
> =20
> -static void pnv_dt_power_mgt(void *fdt)
> +static void pnv_dt_power_mgt(PnvMachineState *pnv, void *fdt)
>  {
>      int off;
> =20
> @@ -540,9 +540,9 @@ static void *pnv_dt_create(MachineState *machine)
>          pnv_dt_bmc_sensors(pnv->bmc, fdt);
>      }
> =20
> -    /* Create an extra node for power management on Power9 and Power10=
 */
> -    if (pnv_is_power9(pnv) || pnv_is_power10(pnv)) {
> -        pnv_dt_power_mgt(fdt);
> +    /* Create an extra node for power management on machines that supp=
ort it */
> +    if (pmc->dt_power_mgt) {
> +        pmc->dt_power_mgt(pnv, fdt);
>      }
> =20
>      return fdt;
> @@ -1710,6 +1710,7 @@ static void pnv_machine_power9_class_init(ObjectC=
lass *oc, void *data)
> =20
>      pmc->compat =3D compat;
>      pmc->compat_size =3D sizeof(compat);
> +    pmc->dt_power_mgt =3D pnv_dt_power_mgt;
>  }
> =20
>  static void pnv_machine_power10_class_init(ObjectClass *oc, void *data=
)
> @@ -1723,6 +1724,7 @@ static void pnv_machine_power10_class_init(Object=
Class *oc, void *data)
> =20
>      pmc->compat =3D compat;
>      pmc->compat_size =3D sizeof(compat);
> +    pmc->dt_power_mgt =3D pnv_dt_power_mgt;
>  }
> =20
>  static void pnv_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index d534746bd493..8a42c199b65c 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -190,6 +190,8 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32=
_t pir);
>  #define PNV_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(PnvMachineClass, klass, TYPE_PNV_MACHINE)
> =20
> +typedef struct PnvMachineState PnvMachineState;
> +
>  typedef struct PnvMachineClass {
>      /*< private >*/
>      MachineClass parent_class;
> @@ -197,9 +199,11 @@ typedef struct PnvMachineClass {
>      /*< public >*/
>      const char *compat;
>      int compat_size;
> +
> +    void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
>  } PnvMachineClass;
> =20
> -typedef struct PnvMachineState {
> +struct PnvMachineState {
>      /*< private >*/
>      MachineState parent_obj;
> =20
> @@ -216,7 +220,7 @@ typedef struct PnvMachineState {
>      Notifier     powerdown_notifier;
> =20
>      PnvPnor      *pnor;
> -} PnvMachineState;
> +};
> =20
>  static inline bool pnv_chip_is_power9(const PnvChip *chip)
>  {
>=20


