Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C000C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0947206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0947206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJxSn-00029s-2x
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jJxSA-0001aF-Ob
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jJxS8-0005xT-PJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:52:06 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:33025)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jJxS8-0005wD-Il
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:52:04 -0400
Received: from player746.ha.ovh.net (unknown [10.108.57.49])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5491B983E6
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 12:52:02 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id 78A13111E5D64;
 Thu,  2 Apr 2020 10:51:57 +0000 (UTC)
Date: Thu, 2 Apr 2020 12:51:55 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 2/2] ppc/xive: Add support for PQ state bits offload
Message-ID: <20200402125155.3485c78c@bahia.lan>
In-Reply-To: <20200401164653.28231-3-clg@kaod.org>
References: <20200401164653.28231-1-clg@kaod.org>
 <20200401164653.28231-3-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14110059111052843403
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeggddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeegiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.58.91
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

On Wed,  1 Apr 2020 18:46:53 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The trigger message coming from a HW source contains a special bit
> informing the XIVE interrupt controller that the PQ bits have been
> checked at the source or not. Depending on the value, the IC can
> perform the check and the state transition locally using its own PQ
> state bits.
>=20
> The following changes add new accessors to the XiveRouter required to
> query and update the PQ state bits. This is only applies to the
> PowerNV machine, sPAPR is not concerned by such complex configuration.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h  |  8 +++++--
>  hw/intc/pnv_xive.c     | 37 +++++++++++++++++++++++++++++---
>  hw/intc/xive.c         | 48 ++++++++++++++++++++++++++++++++++++------
>  hw/pci-host/pnv_phb4.c |  9 ++++++--
>  hw/ppc/pnv_psi.c       |  8 +++++--
>  5 files changed, 94 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 112fb6fb6dbe..050e49c14fd9 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -160,7 +160,7 @@ typedef struct XiveNotifier XiveNotifier;
> =20
>  typedef struct XiveNotifierClass {
>      InterfaceClass parent;
> -    void (*notify)(XiveNotifier *xn, uint32_t lisn);
> +    void (*notify)(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
>  } XiveNotifierClass;
> =20
>  /*
> @@ -354,6 +354,10 @@ typedef struct XiveRouterClass {
>      /* XIVE table accessors */
>      int (*get_eas)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>                     XiveEAS *eas);
> +    int (*get_pq)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
> +                  uint8_t *pq);
> +    int (*set_pq)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
> +                  uint8_t *pq);
>      int (*get_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
>                     XiveEND *end);
>      int (*write_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
> @@ -375,7 +379,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
>                          XiveNVT *nvt);
>  int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
>                            XiveNVT *nvt, uint8_t word_number);
> -void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
> +void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked=
);
> =20
>  /*
>   * XIVE Presenter
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 77cacdd6c623..bcfe9dc54e3b 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -373,6 +373,34 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>  }
> =20
> +static int pnv_xive_get_pq(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
> +                           uint8_t *pq)
> +{
> +    PnvXive *xive =3D PNV_XIVE(xrtr);
> +
> +    if (pnv_xive_block_id(xive) !=3D blk) {
> +        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx));
> +        return -1;
> +    }
> +
> +    *pq =3D xive_source_esb_get(&xive->ipi_source, idx);
> +    return 0;
> +}
> +
> +static int pnv_xive_set_pq(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
> +                           uint8_t *pq)
> +{
> +    PnvXive *xive =3D PNV_XIVE(xrtr);
> +
> +    if (pnv_xive_block_id(xive) !=3D blk) {
> +        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx));
> +        return -1;
> +    }
> +
> +    *pq =3D xive_source_esb_set(&xive->ipi_source, idx, *pq);
> +    return 0;
> +}
> +
>  /*
>   * One bit per thread id. The first register PC_THREAD_EN_REG0 covers
>   * the first cores 0-15 (normal) of the chip or 0-7 (fused). The
> @@ -469,12 +497,12 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cp=
u)
>   * event notification to the Router. This is required on a multichip
>   * system.
>   */
> -static void pnv_xive_notify(XiveNotifier *xn, uint32_t srcno)
> +static void pnv_xive_notify(XiveNotifier *xn, uint32_t srcno, bool pq_ch=
ecked)
>  {
>      PnvXive *xive =3D PNV_XIVE(xn);
>      uint8_t blk =3D pnv_xive_block_id(xive);
> =20
> -    xive_router_notify(xn, XIVE_EAS(blk, srcno));
> +    xive_router_notify(xn, XIVE_EAS(blk, srcno), pq_checked);
>  }
> =20
>  /*
> @@ -1316,7 +1344,8 @@ static void pnv_xive_ic_hw_trigger(PnvXive *xive, h=
waddr addr, uint64_t val)
>      blk =3D XIVE_EAS_BLOCK(val);
>      idx =3D XIVE_EAS_INDEX(val);
> =20
> -    xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
> +    xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx),
> +                       !!(val & XIVE_TRIGGER_PQ));
>  }
> =20
>  static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t=
 val,
> @@ -1944,6 +1973,8 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
>      device_class_set_props(dc, pnv_xive_properties);
> =20
>      xrc->get_eas =3D pnv_xive_get_eas;
> +    xrc->get_pq =3D pnv_xive_get_pq;
> +    xrc->set_pq =3D pnv_xive_set_pq;
>      xrc->get_end =3D pnv_xive_get_end;
>      xrc->write_end =3D pnv_xive_write_end;
>      xrc->get_nvt =3D pnv_xive_get_nvt;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index b8825577f719..894be4b49ba4 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -927,7 +927,7 @@ static void xive_source_notify(XiveSource *xsrc, int =
srcno)
>      XiveNotifierClass *xnc =3D XIVE_NOTIFIER_GET_CLASS(xsrc->xive);
> =20
>      if (xnc->notify) {
> -        xnc->notify(xsrc->xive, srcno);
> +        xnc->notify(xsrc->xive, srcno, true);
>      }
>  }
> =20
> @@ -1343,6 +1343,24 @@ int xive_router_get_eas(XiveRouter *xrtr, uint8_t =
eas_blk, uint32_t eas_idx,
>      return xrc->get_eas(xrtr, eas_blk, eas_idx, eas);
>  }
> =20
> +static
> +int xive_router_get_pq(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_i=
dx,
> +                       uint8_t *pq)
> +{
> +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +    return xrc->get_pq(xrtr, eas_blk, eas_idx, pq);
> +}
> +
> +static
> +int xive_router_set_pq(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_i=
dx,
> +                       uint8_t *pq)
> +{
> +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +    return xrc->set_pq(xrtr, eas_blk, eas_idx, pq);
> +}
> +

Only the powernv machine implements the PQ bits hooks. I understand
that pseries doesn't need them because it cannot execute the helpers
above in practice, since xive_router_notify() is always called with
pq_checked =3D=3D true :

spapr_xive_set_irq()
 xive_source_set_irq()
  xive_source_notify()
  {
     xnc->notify(xsrc->xive, srcno, true);
  }

IMHO the XIVE code is complex enough that we should maybe make
this really explicit with a comment and assert(xrc->[sg]et_pq)
in the PQ bits helpers.

>  int xive_router_get_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_=
idx,
>                          XiveEND *end)
>  {
> @@ -1686,7 +1704,7 @@ do_escalation:
>                             xive_get_field32(END_W5_ESC_END_DATA,  end.w5=
));
>  }
> =20
> -void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
> +void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
>  {
>      XiveRouter *xrtr =3D XIVE_ROUTER(xn);
>      uint8_t eas_blk =3D XIVE_EAS_BLOCK(lisn);
> @@ -1699,11 +1717,27 @@ void xive_router_notify(XiveNotifier *xn, uint32_=
t lisn)
>          return;
>      }
> =20
> -    /*
> -     * The IVRE checks the State Bit Cache at this point. We skip the
> -     * SBC lookup because the state bits of the sources are modeled
> -     * internally in QEMU.
> -     */
> +    if (!pq_checked) {
> +        bool notify;
> +        uint8_t pq;
> +
> +        /* PQ cache lookup */
> +        if (xive_router_get_pq(xrtr, eas_blk, eas_idx, &pq)) {
> +            /* Set FIR */
> +            g_assert_not_reached();

I'm not sure about the intent of this assert... Actual QEMU
bug that should never happen ever or guest misuse of XIVE
that we might try to handle one day ?

In the former case, I'd rather assert() in the PQ bits
machine hooks when the error condition is first detected.

Apart from that, rest looks good.

> +        }
> +
> +        notify =3D xive_esb_trigger(&pq);
> +
> +        if (xive_router_set_pq(xrtr, eas_blk, eas_idx, &pq)) {
> +            /* Set FIR */
> +            g_assert_not_reached();
> +        }
> +
> +        if (!notify) {
> +            return;
> +        }
> +    }
> =20
>      if (!xive_eas_is_valid(&eas)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index ac824f877cf1..c451819bfd52 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1241,14 +1241,19 @@ static const char *pnv_phb4_root_bus_path(PCIHost=
State *host_bridge,
>      return phb->bus_path;
>  }
> =20
> -static void pnv_phb4_xive_notify(XiveNotifier *xf, uint32_t srcno)
> +static void pnv_phb4_xive_notify(XiveNotifier *xf, uint32_t srcno,
> +                                 bool pq_checked)
>  {
>      PnvPHB4 *phb =3D PNV_PHB4(xf);
>      uint64_t notif_port =3D phb->regs[PHB_INT_NOTIFY_ADDR >> 3];
>      uint32_t offset =3D phb->regs[PHB_INT_NOTIFY_INDEX >> 3];
> -    uint64_t data =3D XIVE_TRIGGER_PQ | offset | srcno;
> +    uint64_t data =3D offset | srcno;
>      MemTxResult result;
> =20
> +    if (pq_checked) {
> +        data |=3D XIVE_TRIGGER_PQ;
> +    }
> +
>      address_space_stq_be(&address_space_memory, notif_port, data,
>                           MEMTXATTRS_UNSPECIFIED, &result);
>      if (result !=3D MEMTX_OK) {
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index c34a49b000f2..63804f28f45e 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -652,7 +652,7 @@ static const TypeInfo pnv_psi_power8_info =3D {
>  #define   PSIHB9_IRQ_STAT_DIO           PPC_BIT(12)
>  #define   PSIHB9_IRQ_STAT_PSU           PPC_BIT(13)
> =20
> -static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno)
> +static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno, bool pq_che=
cked)
>  {
>      PnvPsi *psi =3D PNV_PSI(xf);
>      uint64_t notif_port =3D psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADDR)];
> @@ -661,9 +661,13 @@ static void pnv_psi_notify(XiveNotifier *xf, uint32_=
t srcno)
> =20
>      uint32_t offset =3D
>          (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_SHIFT=
);
> -    uint64_t data =3D XIVE_TRIGGER_PQ | offset | srcno;
> +    uint64_t data =3D offset | srcno;
>      MemTxResult result;
> =20
> +    if (pq_checked) {
> +        data |=3D XIVE_TRIGGER_PQ;
> +    }
> +
>      if (!valid) {
>          return;
>      }


