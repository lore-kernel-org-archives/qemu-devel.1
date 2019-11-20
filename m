Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D50F20878
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D50F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUDu-0007W3-5W
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXUAa-0005fs-Gu
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXUAZ-000397-0v
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:53:36 -0500
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:56550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXUAY-00037V-R4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:53:34 -0500
Received: from player758.ha.ovh.net (unknown [10.108.42.174])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6F7181ED579
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 18:53:32 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id E1A41C611612;
 Wed, 20 Nov 2019 17:53:25 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:53:24 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 14/23] ppc/spapr: Implement the XiveFabric
 interface
Message-ID: <20191120185324.7f859d39@bahia.lan>
In-Reply-To: <20191115162436.30548-15-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-15-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 9051109355180300683
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.124.17
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 17:24:27 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The CAM line matching sequence in the pseries machine does not change
> much apart from the use of the new QOM interfaces. There is an extra
> indirection because of the sPAPR IRQ backend of the machine. Only the
> XIVE backend implements the new 'match_nvt' handler.
>=20

The changelog needs an update since you dropped the indirection you had
in v4.

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 94f9d27096af..a8f5850f65bb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4270,6 +4270,39 @@ static void spapr_pic_print_info(InterruptStatsPro=
vider *obj,
>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
>  }
> =20
> +static int spapr_xive_match_nvt(XiveFabric *xfb, uint8_t format,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool cam_ignore, uint8_t priority,
> +                                uint32_t logic_serv, XiveTCTXMatch *matc=
h)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
> +    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> +    int count;
> +

As suggested by David, you should probably assert() that XIVE is in use
for extra paran^Wsafety.

With these fixed,

Reviewed-by: Greg Kurz <groug@kaod.org>

> +    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
> +                           priority, logic_serv, match);
> +    if (count < 0) {
> +        return count;
> +    }
> +
> +    /*
> +     * When we implement the save and restore of the thread interrupt
> +     * contexts in the enter/exit CPU handlers of the machine and the
> +     * escalations in QEMU, we should be able to handle non dispatched
> +     * vCPUs.
> +     *
> +     * Until this is done, the sPAPR machine should find at least one
> +     * matching context always.
> +     */
> +    if (count =3D=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispatche=
d\n",
> +                      nvt_blk, nvt_idx);
> +    }
> +
> +    return count;
> +}
> +
>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
>  {
>      return cpu->vcpu_id;
> @@ -4366,6 +4399,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
> =20
>      mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
>      mc->ignore_boot_device_suffixes =3D true;
> @@ -4442,6 +4476,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->linux_pci_probe =3D true;
>      smc->smp_threads_vsmt =3D true;
>      smc->nr_xirqs =3D SPAPR_NR_XIRQS;
> +    xfc->match_nvt =3D spapr_xive_match_nvt;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -4460,6 +4495,7 @@ static const TypeInfo spapr_machine_info =3D {
>          { TYPE_PPC_VIRTUAL_HYPERVISOR },
>          { TYPE_XICS_FABRIC },
>          { TYPE_INTERRUPT_STATS_PROVIDER },
> +        { TYPE_XIVE_FABRIC },
>          { }
>      },
>  };


