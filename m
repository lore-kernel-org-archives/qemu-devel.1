Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D5CC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 08:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF532173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF532173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4i3E-0004M2-W2
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 04:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i4i2B-0003d2-L6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 04:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i4i2A-00073S-5w
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 04:49:59 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:48442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i4i29-00071s-VM
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 04:49:58 -0400
Received: from player795.ha.ovh.net (unknown [10.109.160.217])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id ADB31764B2
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 10:49:55 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 50A7E942567A;
 Mon,  2 Sep 2019 08:49:50 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190731141233.1340-1-clg@kaod.org>
 <20190731141233.1340-17-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <283a343a-2346-790b-42a9-1ce8e700170b@kaod.org>
Date: Mon, 2 Sep 2019 10:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731141233.1340-17-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 15542766743265512275
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejtddgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.53.132
Subject: Re: [Qemu-devel] [PATCH v3 16/18] ppc/pnv: Extend XivePresenter
 with a get_block_id() handler
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello David,

On 31/07/2019 16:12, C=C3=A9dric Le Goater wrote:
> When doing CAM line compares, fetch the block id from the interrupt
> controller which can have set the PC_TCTXT_CHIPID field.

I don't know if you had time to review the rest of this patchset.=20

I would prefer to move the get_block_id() in XiveRouter, we could get
rid of the 'block_id' field in the XiveEndSource.

Thanks,

C.


>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h | 1 +
>  hw/intc/pnv_xive.c    | 6 ++++++
>  hw/intc/spapr_xive.c  | 6 ++++++
>  hw/intc/xive.c        | 8 +++++---
>  4 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index e16c3b63fc44..d68fb6eea46e 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -391,6 +391,7 @@ typedef struct XivePresenterClass {
>                       uint8_t nvt_blk, uint32_t nvt_idx,
>                       bool cam_ignore, uint8_t priority,
>                       uint32_t logic_serv, XiveTCTXMatch *match);
> +    uint8_t (*get_block_id)(XivePresenter *xptr);
>  } XivePresenterClass;
> =20
>  int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 6b7078aa4fde..8e3ba23788f7 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -460,6 +460,11 @@ static int pnv_xive_match_nvt(XivePresenter *xptr,=
 uint8_t format,
>      return count;
>  }
> =20
> +static uint8_t pnv_xive_get_block_id(XivePresenter *xptr)
> +{
> +    return pnv_xive_block_id(PNV_XIVE(xptr));
> +}
> +
>  /*
>   * The TIMA MMIO space is shared among the chips and to identify the
>   * chip from which the access is being done, we extract the chip id
> @@ -1918,6 +1923,7 @@ static void pnv_xive_class_init(ObjectClass *klas=
s, void *data)
> =20
>      xnc->notify =3D pnv_xive_notify;
>      xpc->match_nvt  =3D pnv_xive_match_nvt;
> +    xpc->get_block_id =3D pnv_xive_get_block_id;
>  };
> =20
>  static const TypeInfo pnv_xive_info =3D {
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 4abb099d341c..26fc815d3931 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -479,6 +479,11 @@ static int spapr_xive_match_nvt(XivePresenter *xpt=
r, uint8_t format,
>      return count;
>  }
> =20
> +static uint8_t spapr_xive_get_block_id(XivePresenter *xrtr)
> +{
> +    return SPAPR_XIVE_BLOCK_ID;
> +}
> +
>  static const VMStateDescription vmstate_spapr_xive_end =3D {
>      .name =3D TYPE_SPAPR_XIVE "/end",
>      .version_id =3D 1,
> @@ -570,6 +575,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
>      xrc->write_nvt =3D spapr_xive_write_nvt;
> =20
>      xpc->match_nvt  =3D spapr_xive_match_nvt;
> +    xpc->get_block_id =3D spapr_xive_get_block_id;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9b02ce423d66..e79439f6b940 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1305,12 +1305,14 @@ int xive_router_write_nvt(XiveRouter *xrtr, uin=
t8_t nvt_blk, uint32_t nvt_idx,
>   *
>   *   chip << 19 | 0000000 0 0001 thread (7Bit)
>   */
> -static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx)
> +static uint32_t xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *t=
ctx)
>  {
>      CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
>      uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
> +    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
> +    uint8_t blk =3D xpc->get_block_id(xptr);
> =20
> -    return xive_nvt_cam_line((pir >> 8) & 0xf, 1 << 7 | (pir & 0x7f));
> +    return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
>  }
> =20
>  /*
> @@ -1347,7 +1349,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr=
, XiveTCTX *tctx,
> =20
>          /* PHYS ring */
>          if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
> -            cam =3D=3D xive_tctx_hw_cam_line(tctx)) {
> +            cam =3D=3D xive_tctx_hw_cam_line(xptr, tctx)) {
>              return TM_QW3_HV_PHYS;
>          }
> =20
>=20


