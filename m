Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20ADC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A392230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A392230F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXN5K-0005Qa-10
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXN4g-0004tG-IA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXN4e-00035w-ON
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:19:02 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:55836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXN4e-00034L-Fo
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:19:00 -0500
Received: from player737.ha.ovh.net (unknown [10.108.57.245])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3AEE11B5E34
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 11:18:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 017882E1DB67;
 Wed, 20 Nov 2019 10:18:53 +0000 (UTC)
Date: Wed, 20 Nov 2019 11:18:52 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 09/23] ppc/xive: Implement the XivePresenter
 interface
Message-ID: <20191120111852.6bd519c2@bahia.lan>
In-Reply-To: <20191115162436.30548-10-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-10-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 1373879364749990283
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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

On Fri, 15 Nov 2019 17:24:22 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Each XIVE Router model, sPAPR and PowerNV, now implements the 'match_nvt'
> handler of the XivePresenter QOM interface. This is simply moving code
> and taking into account the new API.
>=20
> To be noted that the xive_router_get_tctx() helper is not used anymore
> when doing CAM matching and will be removed later on after other changes.
>=20
> The XIVE presenter model is still too simple for the PowerNV machine
> and the CAM matching algo is not correct on multichip system. Subsequent
> patches will introduce more changes to scan all chips of the system.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/pnv_xive.c   | 41 +++++++++++++++++++++++++++++++++++
>  hw/intc/spapr_xive.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>  hw/intc/xive.c       | 51 ++++++--------------------------------------
>  3 files changed, 97 insertions(+), 44 deletions(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index a394331ddd6a..087cbfbaad48 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -372,6 +372,45 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>  }
> =20
> +static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
> +                              uint8_t nvt_blk, uint32_t nvt_idx,
> +                              bool cam_ignore, uint8_t priority,
> +                              uint32_t logic_serv, XiveTCTXMatch *match)
> +{
> +    CPUState *cs;
> +    int count =3D 0;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> +        int ring;
> +

I guess it's ok not to check tctx here because the powernv machine type
doesn't support cpu hotplug.

LGTM despite the non-strict CamelCase type :)

Reviewed-by: Greg Kurz <groug@kaod.org>

> +        /*
> +         * Check the thread context CAM lines and record matches.
> +         */
> +        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
> +                                         cam_ignore, logic_serv);
> +        /*
> +         * Save the context and follow on to catch duplicates, that we
> +         * don't support yet.
> +         */
> +        if (ring !=3D -1) {
> +            if (match->tctx) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
> +                              "thread context NVT %x/%x\n",
> +                              nvt_blk, nvt_idx);
> +                return -1;
> +            }
> +
> +            match->ring =3D ring;
> +            match->tctx =3D tctx;
> +            count++;
> +        }
> +    }
> +
> +    return count;
> +}
> +
>  static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> @@ -1810,6 +1849,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
>      PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
>      XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
>      XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
> =20
>      xdc->dt_xscom =3D pnv_xive_dt_xscom;
> =20
> @@ -1825,6 +1865,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
>      xrc->get_tctx =3D pnv_xive_get_tctx;
> =20
>      xnc->notify =3D pnv_xive_notify;
> +    xpc->match_nvt  =3D pnv_xive_match_nvt;
>  };
> =20
>  static const TypeInfo pnv_xive_info =3D {
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 729246e906c9..bb3b2dfdb77f 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -405,6 +405,52 @@ static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrt=
r, CPUState *cs)
>      return spapr_cpu_state(cpu)->tctx;
>  }
> =20
> +static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool cam_ignore, uint8_t priority,
> +                                uint32_t logic_serv, XiveTCTXMatch *matc=
h)
> +{
> +    CPUState *cs;
> +    int count =3D 0;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
> +        int ring;
> +
> +        /*
> +         * Skip partially initialized vCPUs. This can happen when
> +         * vCPUs are hotplugged.
> +         */
> +        if (!tctx) {
> +            continue;
> +        }
> +
> +        /*
> +         * Check the thread context CAM lines and record matches.
> +         */
> +        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
> +                                         cam_ignore, logic_serv);
> +        /*
> +         * Save the matching thread interrupt context and follow on to
> +         * check for duplicates which are invalid.
> +         */
> +        if (ring !=3D -1) {
> +            if (match->tctx) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
> +                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
> +                return -1;
> +            }
> +
> +            match->ring =3D ring;
> +            match->tctx =3D tctx;
> +            count++;
> +        }
> +    }
> +
> +    return count;
> +}
> +
>  static const VMStateDescription vmstate_spapr_xive_end =3D {
>      .name =3D TYPE_SPAPR_XIVE "/end",
>      .version_id =3D 1,
> @@ -684,6 +730,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
>      SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
> =20
>      dc->desc    =3D "sPAPR XIVE Interrupt Controller";
>      dc->props   =3D spapr_xive_properties;
> @@ -708,6 +755,8 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
>      sicc->print_info =3D spapr_xive_print_info;
>      sicc->dt =3D spapr_xive_dt;
>      sicc->post_load =3D spapr_xive_post_load;
> +
> +    xpc->match_nvt  =3D spapr_xive_match_nvt;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 344bb3f3bc4b..da6196ca958f 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1428,51 +1428,14 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
>                                   bool cam_ignore, uint8_t priority,
>                                   uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
>  {
> -    CPUState *cs;
> +    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> +    int count;
> =20
> -    /*
> -     * TODO (PowerNV): handle chip_id overwrite of block field for
> -     * hardwired CAM compares
> -     */
> -
> -    CPU_FOREACH(cs) {
> -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> -        int ring;
> -
> -        /*
> -         * Skip partially initialized vCPUs. This can happen when
> -         * vCPUs are hotplugged.
> -         */
> -        if (!tctx) {
> -            continue;
> -        }
> -
> -        /*
> -         * HW checks that the CPU is enabled in the Physical Thread
> -         * Enable Register (PTER).
> -         */
> -
> -        /*
> -         * Check the thread context CAM lines and record matches. We
> -         * will handle CPU exception delivery later
> -         */
> -        ring =3D xive_presenter_tctx_match(XIVE_PRESENTER(xrtr), tctx, f=
ormat,
> -                                         nvt_blk, nvt_idx,
> -                                         cam_ignore, logic_serv);
> -        /*
> -         * Save the context and follow on to catch duplicates, that we
> -         * don't support yet.
> -         */
> -        if (ring !=3D -1) {
> -            if (match->tctx) {
> -                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
> -                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
> -                return false;
> -            }
> -
> -            match->ring =3D ring;
> -            match->tctx =3D tctx;
> -        }
> +    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
> +                           priority, logic_serv, match);
> +    if (count < 0) {
> +        return false;
>      }
> =20
>      if (!match->tctx) {


