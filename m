Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D04C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5783920706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5783920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9c9-0002Xp-IP
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iY9ah-0000qM-As
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iY9af-000084-UJ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:07:19 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:47092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iY9af-00005n-NV
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:07:17 -0500
Received: from player696.ha.ovh.net (unknown [10.109.159.157])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 124F0807E5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 15:07:14 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 9CE43C7DD11D;
 Fri, 22 Nov 2019 14:07:09 +0000 (UTC)
Date: Fri, 22 Nov 2019 15:07:08 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 19/23] ppc/xive: Remove the get_tctx()
 XiveRouter handler
Message-ID: <20191122150708.2f21714f@bahia.lan>
In-Reply-To: <20191115162436.30548-20-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-20-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16974629946903271819
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.227
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

On Fri, 15 Nov 2019 17:24:32 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> It is now unused.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h |  2 --
>  hw/intc/pnv_xive.c    | 13 -------------
>  hw/intc/spapr_xive.c  |  8 --------
>  hw/intc/xive.c        |  7 -------
>  4 files changed, 30 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index dcf897451589..24315480e7c2 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -351,7 +351,6 @@ typedef struct XiveRouterClass {
>                     XiveNVT *nvt);
>      int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>                       XiveNVT *nvt, uint8_t word_number);
> -    XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
>  } XiveRouterClass;
> =20
>  int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
> @@ -364,7 +363,6 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt=
_blk, uint32_t nvt_idx,
>                          XiveNVT *nvt);
>  int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nv=
t_idx,
>                            XiveNVT *nvt, uint8_t word_number);
> -XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
>  void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
> =20
>  /*
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 4501c671d8df..2e568721b44e 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -467,18 +467,6 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
>      return xive;
>  }
> =20
> -static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
> -{
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> -
> -    if (!xive) {
> -        return NULL;
> -    }
> -
> -    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> -}
> -
>  /*
>   * The internal sources (IPIs) of the interrupt controller have no
>   * knowledge of the XIVE chip on which they reside. Encode the block
> @@ -1936,7 +1924,6 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
>      xrc->write_end =3D pnv_xive_write_end;
>      xrc->get_nvt =3D pnv_xive_get_nvt;
>      xrc->write_nvt =3D pnv_xive_write_nvt;
> -    xrc->get_tctx =3D pnv_xive_get_tctx;
> =20
>      xnc->notify =3D pnv_xive_notify;
>      xpc->match_nvt  =3D pnv_xive_match_nvt;
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 6292da58f62c..1542cef91878 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -427,13 +427,6 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, ui=
nt8_t nvt_blk,
>      g_assert_not_reached();
>  }
> =20
> -static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
> -{
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -    return spapr_cpu_state(cpu)->tctx;
> -}
> -
>  static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>                                  uint8_t nvt_blk, uint32_t nvt_idx,
>                                  bool cam_ignore, uint8_t priority,
> @@ -771,7 +764,6 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
>      xrc->write_end =3D spapr_xive_write_end;
>      xrc->get_nvt =3D spapr_xive_get_nvt;
>      xrc->write_nvt =3D spapr_xive_write_nvt;
> -    xrc->get_tctx =3D spapr_xive_get_tctx;
> =20
>      sicc->activate =3D spapr_xive_activate;
>      sicc->deactivate =3D spapr_xive_deactivate;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index ab779c4c2a0f..e576a1e4ba9c 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1317,13 +1317,6 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_=
t nvt_blk, uint32_t nvt_idx,
>     return xrc->write_nvt(xrtr, nvt_blk, nvt_idx, nvt, word_number);
>  }
> =20
> -XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs)
> -{
> -    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> -
> -    return xrc->get_tctx(xrtr, cs);
> -}
> -
>  /*
>   * Encode the HW CAM line in the block group mode format :
>   *


