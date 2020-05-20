Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9011C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B379C2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B379C2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbSPC-0006Kz-SZ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbSOY-0005VR-GQ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:20:42 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:40344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbSOW-0002jZ-JG
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:20:42 -0400
Received: from player795.ha.ovh.net (unknown [10.110.208.144])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 057558F3E9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 19:20:37 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 6187A1270C66B;
 Wed, 20 May 2020 17:20:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002972eb8eb-0826-4aed-be51-3e9f52acacb3,D4AE9CB3A4750E3488E7135F1D4D455A9A9A4933)
 smtp.auth=groug@kaod.org
Date: Wed, 20 May 2020 19:20:33 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 4/9] ppc/xive2: Introduce a presenter matching routine
Message-ID: <20200520192033.4c2ab878@bahia.lan>
In-Reply-To: <20200513151109.453530-5-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
 <20200513151109.453530-5-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 7414332364619028875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtledguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeukeejkeeiffeftdevueekvdetjeegieevhffgjefgtdeluddvgfefleekueevueenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.50.107; envelope-from=groug@kaod.org;
 helo=6.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 13:20:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On Wed, 13 May 2020 17:11:04 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The VP space is larger in XIVE2 (P10), 24 bits instead of 19bits on
> XIVE (P9), and the CAM line can use a 7bits or 8bits thread id.
>=20
> For now, we only use 7bits thread ids, same as P9, but because of the
> change of the size of the VP space, the CAM matching routine is
> different between P9 and P10. It is easier to duplicate the whole
> routine than to add extra handlers in xive_presenter_tctx_match() used
> for P9.
>=20
> We might come with a better solution later on, after we have added
> some more support for the XIVE2 controller.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive2.h |  9 +++++
>  hw/intc/xive2.c        | 87 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index cb15487efdb6..4aefca4d96f1 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -60,6 +60,15 @@ int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t =
nvt_blk, uint32_t nvt_idx,
> =20
>  void xive2_router_notify(XiveNotifier *xn, uint32_t lisn);
> =20
> +/*
> + * XIVE2 Presenter (POWER10)
> + */
> +
> +int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> +                                uint8_t format,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool cam_ignore, uint32_t logic_serv);
> +

Indent.

>  /*
>   * XIVE2 END ESBs  (POWER10)
>   */
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 15ea04cf1822..1ce9d995e990 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -20,6 +20,11 @@
>  #include "hw/ppc/xive2.h"
>  #include "hw/ppc/xive2_regs.h"
> =20
> +static inline uint32_t xive_tctx_word2(uint8_t *ring)
> +{
> +    return *((uint32_t *) &ring[TM_WORD2]);
> +}
> +
>  static uint8_t priority_to_ipb(uint8_t priority)
>  {
>      return priority > XIVE_PRIORITY_MAX ?
> @@ -212,6 +217,88 @@ static int xive2_router_get_block_id(Xive2Router *xr=
tr)
>     return xrc->get_block_id(xrtr);
>  }
> =20
> +/*
> + * Encode the HW CAM line with 7bit or 8bit thread id. The thread id
> + * width and block id width is configurable at the IC level.
> + *
> + *    chipid << 19 | 0000000 0 0001 threadid (7Bit)
> + *    chipid << 24 | 0000 0000 0000 0001 threadid (8Bit)
> + */
> +static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tc=
tx)
> +{
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(xptr);
> +    CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
> +    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
> +    uint8_t blk =3D xive2_router_get_block_id(xrtr);
> +    uint8_t tid_shift =3D 7;
> +    uint8_t tid_mask =3D (1 << tid_shift) - 1;
> +
> +    return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
> +}
> +
> +/*
> + * The thread context register words are in big-endian format.
> + */
> +int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> +                                uint8_t format,
> +                                uint8_t nvt_blk, uint32_t nvt_idx,
> +                                bool cam_ignore, uint32_t logic_serv)
> +{
> +    uint32_t cam =3D   xive2_nvp_cam_line(nvt_blk, nvt_idx);
> +    uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
> +    uint32_t qw2w2 =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
> +    uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
> +    uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
> +
> +    /*
> +     * TODO (PowerNV): ignore mode. The low order bits of the NVT
> +     * identifier are ignored in the "CAM" match.
> +     */
> +
> +    if (format =3D=3D 0) {
> +        if (cam_ignore =3D=3D true) {
> +            /*
> +             * F=3D0 & i=3D1: Logical server notification (bits ignored =
at
> +             * the end of the NVT identifier)
> +             */
> +            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT %x/%x\=
n",
> +                          nvt_blk, nvt_idx);
> +             return -1;
> +        }
> +
> +        /* F=3D0 & i=3D0: Specific NVT notification */
> +
> +        /* PHYS ring */
> +        if ((be32_to_cpu(qw3w2) & TM2_QW3W2_VT) &&
> +            cam =3D=3D xive2_tctx_hw_cam_line(xptr, tctx)) {
> +            return TM_QW3_HV_PHYS;
> +        }
> +
> +        /* HV POOL ring */
> +        if ((be32_to_cpu(qw2w2) & TM2_QW2W2_VP) &&
> +            cam =3D=3D xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2)) {
> +            return TM_QW2_HV_POOL;
> +        }
> +
> +        /* OS ring */
> +        if ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
> +            cam =3D=3D xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) {
> +            return TM_QW1_OS;
> +        }
> +    } else {
> +        /* F=3D1 : User level Event-Based Branch (EBB) notification */
> +
> +        /* USER ring */
> +        if  ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
> +             (cam =3D=3D xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) &&
> +             (be32_to_cpu(qw0w2) & TM2_QW0W2_VU) &&
> +             (logic_serv =3D=3D xive_get_field32(TM2_QW0W2_LOGIC_SERV, q=
w0w2))) {
> +            return TM_QW0_USER;
> +        }
> +    }
> +    return -1;
> +}
> +
>  static void xive2_router_realize(DeviceState *dev, Error **errp)
>  {
>      Xive2Router *xrtr =3D XIVE2_ROUTER(dev);


