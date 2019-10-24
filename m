Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B86CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3122075C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PaU2fbDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3122075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTil-0004Kb-DJ
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTP-0006ea-1g
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTL-0002vO-Mr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:35597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTK-0002sZ-Vf; Wed, 23 Oct 2019 23:07:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS5MSwz9sPp; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=eoF7wOoZ/DiiTp8zTx8hzJV+Nw+HaJzqGXR7TOkzano=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PaU2fbDdMaT9LqpbklX51spzNgIgDjeucERptALIZFxiHqyW7rwnKPM2X9BsRnBDa
 j0M/HFGzwUGF4Ylr5y2mVpe83uH2iEM8B+m5MDOmNervuEwv0cNFGanr+9hPH3VEIC
 eEBOzSSOSWqjaOjgb1ucPi2idvxm1QET7gHQRYnk=
Date: Thu, 24 Oct 2019 13:50:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/6] ppc: Add intc_destroy() handlers to
 SpaprInterruptController/PnvChip
Message-ID: <20191024025025.GR6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184231937.3053790.14496504009511167948.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cYG5ZC/RuVsIq1ir"
Content-Disposition: inline
In-Reply-To: <157184231937.3053790.14496504009511167948.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cYG5ZC/RuVsIq1ir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 04:51:59PM +0200, Greg Kurz wrote:
> SpaprInterruptControllerClass and PnvChipClass have an intc_create() meth=
od
> that calls the appropriate routine, ie. icp_create() or xive_tctx_create(=
),
> to establish the link between the VCPU and the presenter component of the
> interrupt controller during realize.
>=20
> There aren't any symmetrical call to be called when the VCPU gets unreali=
zed
> though. It is assumed that object_unparent() is the only thing to do.
>=20
> This is questionable because the parenting logic around the CPU and
> presenter objects is really an implementation detail of the interrupt
> controller. It shouldn't be open-coded in the machine code.
>=20
> Fix this by adding an intc_destroy() method that undoes what was done in
> intc_create().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I think it would be good to set the pointers in spapr_cpu_state() to
NULL at the point of destroy.  It probably won't matter, since this
happens in a path where the cpu's about to go away.  But still,
leaving a stale pointer around a moment more than necessary makes me
anxious.

> ---
>  hw/intc/spapr_xive.c       |    7 +++++++
>  hw/intc/xics.c             |    5 +++++
>  hw/intc/xics_spapr.c       |    7 +++++++
>  hw/intc/xive.c             |    5 +++++
>  hw/ppc/pnv.c               |   15 +++++++++++++++
>  hw/ppc/pnv_core.c          |    7 ++++---
>  hw/ppc/spapr_cpu_core.c    |    7 +------
>  hw/ppc/spapr_irq.c         |   14 ++++++++++++++
>  include/hw/ppc/pnv.h       |    1 +
>  include/hw/ppc/spapr_irq.h |    2 ++
>  include/hw/ppc/xics.h      |    1 +
>  include/hw/ppc/xive.h      |    1 +
>  12 files changed, 63 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index d8e1291905c3..b09cc48bcb61 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -555,6 +555,12 @@ static void spapr_xive_cpu_intc_reset(SpaprInterrupt=
Controller *intc,
>      xive_tctx_set_os_cam(tctx, xive_nvt_cam_line(nvt_blk, nvt_idx));
>  }
> =20
> +static void spapr_xive_cpu_intc_destroy(SpaprInterruptController *intc,
> +                                        PowerPCCPU *cpu)
> +{
> +    xive_tctx_destroy(spapr_cpu_state(cpu)->tctx);
> +}
> +
>  static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
> @@ -692,6 +698,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
>      sicc->deactivate =3D spapr_xive_deactivate;
>      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
>      sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset;
> +    sicc->cpu_intc_destroy =3D spapr_xive_cpu_intc_destroy;
>      sicc->claim_irq =3D spapr_xive_claim_irq;
>      sicc->free_irq =3D spapr_xive_free_irq;
>      sicc->set_irq =3D spapr_xive_set_irq;
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 6da05763f9db..935f325749cb 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -401,6 +401,11 @@ Object *icp_create(Object *cpu, const char *type, XI=
CSFabric *xi, Error **errp)
>      return obj;
>  }
> =20
> +void icp_destroy(ICPState *icp)
> +{
> +    object_unparent(OBJECT(icp));
> +}
> +
>  /*
>   * ICS: Source layer
>   */
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 7418fb9f370c..5977d1bdb73f 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -352,6 +352,12 @@ static void xics_spapr_cpu_intc_reset(SpaprInterrupt=
Controller *intc,
>      icp_reset(spapr_cpu_state(cpu)->icp);
>  }
> =20
> +static void xics_spapr_cpu_intc_destroy(SpaprInterruptController *intc,
> +                                        PowerPCCPU *cpu)
> +{
> +    icp_destroy(spapr_cpu_state(cpu)->icp);
> +}
> +
>  static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
>                                  bool lsi, Error **errp)
>  {
> @@ -440,6 +446,7 @@ static void ics_spapr_class_init(ObjectClass *klass, =
void *data)
>      sicc->deactivate =3D xics_spapr_deactivate;
>      sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
>      sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset;
> +    sicc->cpu_intc_destroy =3D xics_spapr_cpu_intc_destroy;
>      sicc->claim_irq =3D xics_spapr_claim_irq;
>      sicc->free_irq =3D xics_spapr_free_irq;
>      sicc->set_irq =3D xics_spapr_set_irq;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f066be5eb5e3..38257aa02083 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -696,6 +696,11 @@ error:
>      return NULL;
>  }
> =20
> +void xive_tctx_destroy(XiveTCTX *tctx)
> +{
> +    object_unparent(OBJECT(tctx));
> +}
> +
>  /*
>   * XIVE ESB helpers
>   */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 4a51fb65a834..bd17c3536dd5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -778,6 +778,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
>      pnv_cpu->intc =3D obj;
>  }
> =20
> +
>  static void pnv_chip_power8_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
>  {
>      PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> @@ -785,6 +786,11 @@ static void pnv_chip_power8_intc_reset(PnvChip *chip=
, PowerPCCPU *cpu)
>      icp_reset(ICP(pnv_cpu->intc));
>  }
> =20
> +static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    icp_destroy(ICP(pnv_cpu_state(cpu)->intc));
> +}
> +
>  /*
>   *    0:48  Reserved - Read as zeroes
>   *   49:52  Node ID
> @@ -829,6 +835,11 @@ static void pnv_chip_power9_intc_reset(PnvChip *chip=
, PowerPCCPU *cpu)
>      xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
>  }
> =20
> +static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
> +{
> +    xive_tctx_destroy(XIVE_TCTX(pnv_cpu_state(cpu)->intc));
> +}
> +
>  /*
>   * Allowed core identifiers on a POWER8 Processor Chip :
>   *
> @@ -999,6 +1010,7 @@ static void pnv_chip_power8e_class_init(ObjectClass =
*klass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->intc_reset =3D pnv_chip_power8_intc_reset;
> +    k->intc_destroy =3D pnv_chip_power8_intc_destroy;
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1019,6 +1031,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->intc_reset =3D pnv_chip_power8_intc_reset;
> +    k->intc_destroy =3D pnv_chip_power8_intc_destroy;
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1039,6 +1052,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->intc_reset =3D pnv_chip_power8_intc_reset;
> +    k->intc_destroy =3D pnv_chip_power8_intc_destroy;
>      k->isa_create =3D pnv_chip_power8nvl_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->pic_print_info =3D pnv_chip_power8_pic_print_info;
> @@ -1209,6 +1223,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p9;
>      k->intc_create =3D pnv_chip_power9_intc_create;
>      k->intc_reset =3D pnv_chip_power9_intc_reset;
> +    k->intc_destroy =3D pnv_chip_power9_intc_destroy;
>      k->isa_create =3D pnv_chip_power9_isa_create;
>      k->dt_populate =3D pnv_chip_power9_dt_populate;
>      k->pic_print_info =3D pnv_chip_power9_pic_print_info;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 328ad07c8d06..a66c4b471407 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -270,11 +270,12 @@ err:
>      error_propagate(errp, local_err);
>  }
> =20
> -static void pnv_core_cpu_unrealize(PowerPCCPU *cpu)
> +static void pnv_core_cpu_unrealize(PowerPCCPU *cpu, PnvChip *chip)
>  {
>      PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> =20
> -    object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
> +    pcc->intc_destroy(chip, cpu);
>      cpu_remove_sync(CPU(cpu));
>      cpu->machine_data =3D NULL;
>      g_free(pnv_cpu);
> @@ -290,7 +291,7 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
>      qemu_unregister_reset(pnv_core_reset, pc);
> =20
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        pnv_core_cpu_unrealize(pc->threads[i]);
> +        pnv_core_cpu_unrealize(pc->threads[i], pc->chip);
>      }
>      g_free(pc->threads);
>  }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ef7b27a66d56..8339c4c0f86b 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -195,12 +195,7 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, Sp=
aprCpuCore *sc)
>      if (!sc->pre_3_0_migration) {
>          vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_=
data);
>      }
> -    if (spapr_cpu_state(cpu)->icp) {
> -        object_unparent(OBJECT(spapr_cpu_state(cpu)->icp));
> -    }
> -    if (spapr_cpu_state(cpu)->tctx) {
> -        object_unparent(OBJECT(spapr_cpu_state(cpu)->tctx));
> -    }
> +    spapr_irq_cpu_intc_destroy(SPAPR_MACHINE(qdev_get_machine()), cpu);
>      cpu_remove_sync(CPU(cpu));
>      object_unparent(OBJECT(cpu));
>  }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b941608b69ba..168044be853a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -234,6 +234,20 @@ void spapr_irq_cpu_intc_reset(SpaprMachineState *spa=
pr, PowerPCCPU *cpu)
>      }
>  }
> =20
> +void spapr_irq_cpu_intc_destroy(SpaprMachineState *spapr, PowerPCCPU *cp=
u)
> +{
> +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
> +        SpaprInterruptController *intc =3D intcs[i];
> +        if (intc) {
> +            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS=
(intc);
> +            sicc->cpu_intc_destroy(intc, cpu);
> +        }
> +    }
> +}
> +
>  static void spapr_set_irq(void *opaque, int irq, int level)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 2a780e633f23..0b4c722e6b48 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -112,6 +112,7 @@ typedef struct PnvChipClass {
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>      void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
>      void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
> +    void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
>      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>      void (*dt_populate)(PnvChip *chip, void *fdt);
>      void (*pic_print_info)(PnvChip *chip, Monitor *mon);
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 09232999b07e..ff814d13de37 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -53,6 +53,7 @@ typedef struct SpaprInterruptControllerClass {
>      int (*cpu_intc_create)(SpaprInterruptController *intc,
>                              PowerPCCPU *cpu, Error **errp);
>      void (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU *c=
pu);
> +    void (*cpu_intc_destroy)(SpaprInterruptController *intc, PowerPCCPU =
*cpu);
>      int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
>                       Error **errp);
>      void (*free_irq)(SpaprInterruptController *intc, int irq);
> @@ -70,6 +71,7 @@ void spapr_irq_update_active_intc(SpaprMachineState *sp=
apr);
>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>                                PowerPCCPU *cpu, Error **errp);
>  void spapr_irq_cpu_intc_reset(SpaprMachineState *spapr, PowerPCCPU *cpu);
> +void spapr_irq_cpu_intc_destroy(SpaprMachineState *spapr, PowerPCCPU *cp=
u);
>  void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
>  void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>                    void *fdt, uint32_t phandle);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 602173c12250..48a75aa4ab75 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -181,6 +181,7 @@ void icp_resend(ICPState *ss);
> =20
>  Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
>                     Error **errp);
> +void icp_destroy(ICPState *icp);
> =20
>  /* KVM */
>  void icp_get_kvm_state(ICPState *icp);
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 99381639f50c..8fd439ec9bba 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -416,6 +416,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr off=
set, unsigned size);
>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
>  void xive_tctx_reset(XiveTCTX *tctx);
> +void xive_tctx_destroy(XiveTCTX *tctx);
> =20
>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
>  {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cYG5ZC/RuVsIq1ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xEXAACgkQbDjKyiDZ
s5KUzBAAzoWKHFH6PSsLCedxotYsWcSy3oVDTcRTSgmMDySgdaH31zO6nOHFE7Ip
7UECx1BLE+fbiiqgrgLKABKTSOmltXQfopFlwl5O/LRY6MN539e5Hqll3vMFikVt
w8GiwCUQ/fi0MBrq/oaI9lvTJSQLrxdpjv9IALaKvQaleyYH6dvGxwTo1/IOHjf6
1o+Fp77RR55trY1JHPjE5R1kZ9Au6QHMMph/c4RlwfSVSfPHTJgAPbO6ks33NtyS
ZlLif6t6R9jPC45vfNYpmVSXwPHXri2qDQZ0JRJWxeswREiWgTrYxC7vOwDRbdzz
iDpnj0N7tJb0pKp658x/rHNETcq/L5VBRfSU70jxMvlG2YmgTXRHWTIhH6d2mA0z
fXx1Se0KfVgjcgWQo4RHJtCl66gtmrvLGmEn6IgFaSiT3GMx1EvqW8fPxIO8TDNl
b9UaGUeo/8QGcmPvwskoiY6vRIG5y3Qn0zv+rYCGFjsAuZ/MCdUjbrywd4AFeMB+
ugtxnunH9qiWL3OffSPxvkVPPYMl6kGPIKW542aiV0QbpXtpXzikD1E2LBppjZBI
n/HSF0Mtt8UVKoNETCg5VqcJSkFbfLorz5oMjBKvL9T7xXSCQEWkm/KiMNunDsAM
cHYUhoTOvRznzBXMPmw6IMDQiHu53VCk7/TWW8sV0Y3fB7BnlEQ=
=IheX
-----END PGP SIGNATURE-----

--cYG5ZC/RuVsIq1ir--

