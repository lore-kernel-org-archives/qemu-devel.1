Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B9AC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38BB2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38BB2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCdNi-0007Kt-R9
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 01:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCdLq-0006Fj-WC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCdLp-0000fX-3b
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:27:02 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:46888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCdLo-0000cv-Ol
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:27:00 -0400
Received: from player737.ha.ovh.net (unknown [10.108.35.95])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id CD7311444C0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 07:26:58 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 26AA5B5237C;
 Tue, 24 Sep 2019 05:26:55 +0000 (UTC)
Subject: Re: [PATCH 3/4] xics: Rename misleading ics_simple_*() functions
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2d14e467-6c49-72d3-c086-b0f39f52c859@kaod.org>
Date: Tue, 24 Sep 2019 07:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924045952.11412-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12187303543605070600
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.62.179
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/2019 06:59, David Gibson wrote:
> There are a number of ics_simple_*() functions that aren't actually
> specific to TYPE_XICS_SIMPLE at all, and are equally valid on
> TYPE_XICS_BASE.  Rename them to ics_*() accordingly.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/intc/trace-events  |  6 +++---
>  hw/intc/xics.c        | 29 ++++++++++++++---------------
>  hw/intc/xics_spapr.c  | 12 ++++++------
>  hw/ppc/pnv_psi.c      |  4 ++--
>  hw/ppc/spapr_irq.c    |  2 +-
>  include/hw/ppc/xics.h |  6 +++---
>  6 files changed, 29 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index fdc716c2cc..527c3f76ca 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -66,10 +66,10 @@ xics_icp_accept(uint32_t old_xirr, uint32_t new_xir=
r) "icp_accept: XIRR 0x%"PRIx
>  xics_icp_eoi(int server, uint32_t xirr, uint32_t new_xirr) "icp_eoi: s=
erver %d given XIRR 0x%"PRIx32" new XIRR 0x%"PRIx32
>  xics_icp_irq(int server, int nr, uint8_t priority) "cpu %d trying to d=
eliver irq 0x%"PRIx32" priority 0x%x"
>  xics_icp_raise(uint32_t xirr, uint8_t pending_priority) "raising IRQ n=
ew XIRR=3D0x%x new pending priority=3D0x%x"
> -xics_ics_simple_set_irq_msi(int srcno, int nr) "set_irq_msi: srcno %d =
[irq 0x%x]"
> +xics_ics_set_irq_msi(int srcno, int nr) "set_irq_msi: srcno %d [irq 0x=
%x]"
>  xics_masked_pending(void) "set_irq_msi: masked pending"
> -xics_ics_simple_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d =
[irq 0x%x]"
> -xics_ics_simple_write_xive(int nr, int srcno, int server, uint8_t prio=
rity) "ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
> +xics_ics_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d [irq 0x=
%x]"
> +xics_ics_write_xive(int nr, int srcno, int server, uint8_t priority) "=
ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
>  xics_ics_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
>  xics_ics_eoi(int nr) "ics_eoi: irq 0x%x"
> =20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index db0e532bd9..9ae51bbc76 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -428,11 +428,11 @@ static void ics_resend_lsi(ICSState *ics, int src=
no)
>      }
>  }
> =20
> -static void ics_simple_set_irq_msi(ICSState *ics, int srcno, int val)
> +static void ics_set_irq_msi(ICSState *ics, int srcno, int val)
>  {
>      ICSIRQState *irq =3D ics->irqs + srcno;
> =20
> -    trace_xics_ics_simple_set_irq_msi(srcno, srcno + ics->offset);
> +    trace_xics_ics_set_irq_msi(srcno, srcno + ics->offset);
> =20
>      if (val) {
>          if (irq->priority =3D=3D 0xff) {
> @@ -444,11 +444,11 @@ static void ics_simple_set_irq_msi(ICSState *ics,=
 int srcno, int val)
>      }
>  }
> =20
> -static void ics_simple_set_irq_lsi(ICSState *ics, int srcno, int val)
> +static void ics_set_irq_lsi(ICSState *ics, int srcno, int val)
>  {
>      ICSIRQState *irq =3D ics->irqs + srcno;
> =20
> -    trace_xics_ics_simple_set_irq_lsi(srcno, srcno + ics->offset);
> +    trace_xics_ics_set_irq_lsi(srcno, srcno + ics->offset);
>      if (val) {
>          irq->status |=3D XICS_STATUS_ASSERTED;
>      } else {
> @@ -457,7 +457,7 @@ static void ics_simple_set_irq_lsi(ICSState *ics, i=
nt srcno, int val)
>      ics_resend_lsi(ics, srcno);
>  }
> =20
> -void ics_simple_set_irq(void *opaque, int srcno, int val)
> +void ics_set_irq(void *opaque, int srcno, int val)
>  {
>      ICSState *ics =3D (ICSState *)opaque;
> =20
> @@ -467,13 +467,13 @@ void ics_simple_set_irq(void *opaque, int srcno, =
int val)
>      }
> =20
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> -        ics_simple_set_irq_lsi(ics, srcno, val);
> +        ics_set_irq_lsi(ics, srcno, val);
>      } else {
> -        ics_simple_set_irq_msi(ics, srcno, val);
> +        ics_set_irq_msi(ics, srcno, val);
>      }
>  }
> =20
> -static void ics_simple_write_xive_msi(ICSState *ics, int srcno)
> +static void ics_write_xive_msi(ICSState *ics, int srcno)
>  {
>      ICSIRQState *irq =3D ics->irqs + srcno;
> =20
> @@ -486,13 +486,13 @@ static void ics_simple_write_xive_msi(ICSState *i=
cs, int srcno)
>      icp_irq(ics, irq->server, srcno + ics->offset, irq->priority);
>  }
> =20
> -static void ics_simple_write_xive_lsi(ICSState *ics, int srcno)
> +static void ics_write_xive_lsi(ICSState *ics, int srcno)
>  {
>      ics_resend_lsi(ics, srcno);
>  }
> =20
> -void ics_simple_write_xive(ICSState *ics, int srcno, int server,
> -                           uint8_t priority, uint8_t saved_priority)
> +void ics_write_xive(ICSState *ics, int srcno, int server,
> +                    uint8_t priority, uint8_t saved_priority)
>  {
>      ICSIRQState *irq =3D ics->irqs + srcno;
> =20
> @@ -500,13 +500,12 @@ void ics_simple_write_xive(ICSState *ics, int src=
no, int server,
>      irq->priority =3D priority;
>      irq->saved_priority =3D saved_priority;
> =20
> -    trace_xics_ics_simple_write_xive(ics->offset + srcno, srcno, serve=
r,
> -                                     priority);
> +    trace_xics_ics_write_xive(ics->offset + srcno, srcno, server, prio=
rity);
> =20
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> -        ics_simple_write_xive_lsi(ics, srcno);
> +        ics_write_xive_lsi(ics, srcno);
>      } else {
> -        ics_simple_write_xive_msi(ics, srcno);
> +        ics_write_xive_msi(ics, srcno);
>      }
>  }
> =20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 6577be0d92..3e9444813a 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -179,7 +179,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
>      }
> =20
>      srcno =3D nr - ics->offset;
> -    ics_simple_write_xive(ics, srcno, server, priority, priority);
> +    ics_write_xive(ics, srcno, server, priority, priority);
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> @@ -243,8 +243,8 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>      }
> =20
>      srcno =3D nr - ics->offset;
> -    ics_simple_write_xive(ics, srcno, ics->irqs[srcno].server, 0xff,
> -                          ics->irqs[srcno].priority);
> +    ics_write_xive(ics, srcno, ics->irqs[srcno].server, 0xff,
> +                   ics->irqs[srcno].priority);
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> @@ -276,9 +276,9 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachi=
neState *spapr,
>      }
> =20
>      srcno =3D nr - ics->offset;
> -    ics_simple_write_xive(ics, srcno, ics->irqs[srcno].server,
> -                          ics->irqs[srcno].saved_priority,
> -                          ics->irqs[srcno].saved_priority);
> +    ics_write_xive(ics, srcno, ics->irqs[srcno].server,
> +                   ics->irqs[srcno].saved_priority,
> +                   ics->irqs[srcno].saved_priority);
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 88ba8e7b9b..8ea81e9d8e 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -311,7 +311,7 @@ static void pnv_psi_set_xivr(PnvPsi *psi, uint32_t =
reg, uint64_t val)
>       * do for now but a more accurate implementation would instead
>       * use a fixed server/prio and a remapper of the generated irq.
>       */
> -    ics_simple_write_xive(ics, src, server, prio, prio);
> +    ics_write_xive(ics, src, server, prio, prio);
>  }
> =20
>  static uint64_t pnv_psi_reg_read(PnvPsi *psi, uint32_t offset, bool mm=
io)
> @@ -514,7 +514,7 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
>          ics_set_irq_type(ics, i, true);
>      }
> =20
> -    psi->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr=
_irqs);
> +    psi->qirqs =3D qemu_allocate_irqs(ics_set_irq, ics, ics->nr_irqs);
> =20
>      /* XSCOM region for PSI registers */
>      pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xsco=
m_ops,
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d8f46b6797..ac189c5796 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -210,7 +210,7 @@ static void spapr_irq_set_irq_xics(void *opaque, in=
t srcno, int val)
>  {
>      SpaprMachineState *spapr =3D opaque;
> =20
> -    ics_simple_set_irq(spapr->ics, srcno, val);
> +    ics_set_irq(spapr->ics, srcno, val);
>  }
> =20
>  static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **err=
p)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 0eb39c2561..92628e7cab 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -168,9 +168,9 @@ uint32_t icp_accept(ICPState *ss);
>  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
>  void icp_eoi(ICPState *icp, uint32_t xirr);
> =20
> -void ics_simple_write_xive(ICSState *ics, int nr, int server,
> -                           uint8_t priority, uint8_t saved_priority);
> -void ics_simple_set_irq(void *opaque, int srcno, int val);
> +void ics_write_xive(ICSState *ics, int nr, int server,
> +                    uint8_t priority, uint8_t saved_priority);
> +void ics_set_irq(void *opaque, int srcno, int val);
> =20
>  static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
>  {
>=20


