Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A70C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B11322445
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B11322445
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMQp-0006bA-Gr
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXMOu-00050c-8e
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXMOs-0003uB-J1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:35:51 -0500
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:51995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXMOs-0003sr-Cm
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:35:50 -0500
Received: from player762.ha.ovh.net (unknown [10.108.57.72])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id CCB05213A86
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 10:35:46 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 041A1C532A1D;
 Wed, 20 Nov 2019 09:35:41 +0000 (UTC)
Date: Wed, 20 Nov 2019 10:35:38 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 08/23] ppc/xive: Introduce a XivePresenter
 interface
Message-ID: <20191120103538.25308564@bahia.lan>
In-Reply-To: <20191115162436.30548-9-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-9-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 644577699389020555
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqfedtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeivddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.253.54
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

On Fri, 15 Nov 2019 17:24:21 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When the XIVE IVRE sub-engine (XiveRouter) looks for a Notification
> Virtual Target (NVT) to notify, it broadcasts a message on the
> PowerBUS to find an XIVE IVPE sub-engine (Presenter) with the NVT
> dispatched on one of its HW threads, and then forwards the
> notification if any response was received.
>=20
> The current XIVE presenter model is sufficient for the pseries machine
> because it has a single interrupt controller device, but the PowerNV
> machine can have multiple chips each having its own interrupt
> controller. In this case, the XIVE presenter model is too simple and
> the CAM line matching should scan all chips of the system.
>=20
> To start fixing this issue, we first extend the XIVE Router model with
> a new XivePresenter QOM interface representing the XIVE IVPE
> sub-engine. This interface exposes a 'match_nvt' handler which the
> sPAPR and PowerNV XIVE Router models will need to implement to perform
> the CAM line matching.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h | 32 ++++++++++++++++++++++++++++++++
>  hw/intc/xive.c        | 26 +++++++++++++++++---------
>  2 files changed, 49 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index fa7adf87feb2..f9aa0fa0dac3 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -367,6 +367,38 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_t =
nvt_blk, uint32_t nvt_idx,
>  XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
>  void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
> =20
> +/*
> + * XIVE Presenter
> + */
> +
> +typedef struct XiveTCTXMatch {
> +    XiveTCTX *tctx;
> +    uint8_t ring;
> +} XiveTCTXMatch;
> +

We recently decided to follow a strict CamelCase naming scheme in spapr.
We should probably do the same in other areas. Can you please make this
XiveTctxMatch ? I can send follow-up patches to convert the existing code
later on, ie. after this series is merged at last :)

The patch looks good anyway so:

Reviewed-by: Greg Kurz <groug@kaod.org>

> +typedef struct XivePresenter XivePresenter;
> +
> +#define TYPE_XIVE_PRESENTER "xive-presenter"
> +#define XIVE_PRESENTER(obj)                                     \
> +    INTERFACE_CHECK(XivePresenter, (obj), TYPE_XIVE_PRESENTER)
> +#define XIVE_PRESENTER_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(XivePresenterClass, (klass), TYPE_XIVE_PRESENTER)
> +#define XIVE_PRESENTER_GET_CLASS(obj)                                   \
> +    OBJECT_GET_CLASS(XivePresenterClass, (obj), TYPE_XIVE_PRESENTER)
> +
> +typedef struct XivePresenterClass {
> +    InterfaceClass parent;
> +    int (*match_nvt)(XivePresenter *xptr, uint8_t format,
> +                     uint8_t nvt_blk, uint32_t nvt_idx,
> +                     bool cam_ignore, uint8_t priority,
> +                     uint32_t logic_serv, XiveTCTXMatch *match);
> +} XivePresenterClass;
> +
> +int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> +                              uint8_t format,
> +                              uint8_t nvt_blk, uint32_t nvt_idx,
> +                              bool cam_ignore, uint32_t logic_serv);
> +
>  /*
>   * XIVE END ESBs
>   */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 511e1a936347..344bb3f3bc4b 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1363,9 +1363,10 @@ static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tc=
tx)
>  /*
>   * The thread context register words are in big-endian format.
>   */
> -static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
> -                                     uint8_t nvt_blk, uint32_t nvt_idx,
> -                                     bool cam_ignore, uint32_t logic_ser=
v)
> +int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> +                              uint8_t format,
> +                              uint8_t nvt_blk, uint32_t nvt_idx,
> +                              bool cam_ignore, uint32_t logic_serv)
>  {
>      uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
>      uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
> @@ -1422,11 +1423,6 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
x, uint8_t format,
>      return -1;
>  }
> =20
> -typedef struct XiveTCTXMatch {
> -    XiveTCTX *tctx;
> -    uint8_t ring;
> -} XiveTCTXMatch;
> -
>  static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
>                                   uint8_t nvt_blk, uint32_t nvt_idx,
>                                   bool cam_ignore, uint8_t priority,
> @@ -1460,7 +1456,8 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
>           * Check the thread context CAM lines and record matches. We
>           * will handle CPU exception delivery later
>           */
> -        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_id=
x,
> +        ring =3D xive_presenter_tctx_match(XIVE_PRESENTER(xrtr), tctx, f=
ormat,
> +                                         nvt_blk, nvt_idx,
>                                           cam_ignore, logic_serv);
>          /*
>           * Save the context and follow on to catch duplicates, that we
> @@ -1754,6 +1751,7 @@ static const TypeInfo xive_router_info =3D {
>      .class_init    =3D xive_router_class_init,
>      .interfaces    =3D (InterfaceInfo[]) {
>          { TYPE_XIVE_NOTIFIER },
> +        { TYPE_XIVE_PRESENTER },
>          { }
>      }
>  };
> @@ -1923,10 +1921,20 @@ static const TypeInfo xive_notifier_info =3D {
>      .class_size =3D sizeof(XiveNotifierClass),
>  };
> =20
> +/*
> + * XIVE Presenter
> + */
> +static const TypeInfo xive_presenter_info =3D {
> +    .name =3D TYPE_XIVE_PRESENTER,
> +    .parent =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(XivePresenterClass),
> +};
> +
>  static void xive_register_types(void)
>  {
>      type_register_static(&xive_source_info);
>      type_register_static(&xive_notifier_info);
> +    type_register_static(&xive_presenter_info);
>      type_register_static(&xive_router_info);
>      type_register_static(&xive_end_source_info);
>      type_register_static(&xive_tctx_info);


