Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BC4C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EF4208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cPHTx+WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EF4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaB1S-0007mw-UD
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 23:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaB02-0006JO-Am
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaAzy-0001Tj-AF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:48 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37511 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaAzs-0001Jo-Ft; Wed, 27 Nov 2019 23:01:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47NkTr1kPXz9sPZ; Thu, 28 Nov 2019 15:01:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574913696;
 bh=JNWdlQ0cUc0HXy/Wm2vQcAcLe8JbepOiaNl5eFQstPg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cPHTx+WLv1l5Hv7RO4RmESyczdjw6ByEcAuZu/34Bl/qzQuKFSx2+CeCGw88Pil0D
 UvLoqa6FiugrbJyQVL8zVGYZjTQjGFs8lGA9RssJp+NLnl1qVis/dEEvWNbBnu5zDt
 R/A10VAkqiB6POMUYG+uz+9Celn0wgnXPOvpdrps=
Date: Thu, 28 Nov 2019 12:32:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 15/20] ppc/xive: Remove the get_tctx() XiveRouter
 handler
Message-ID: <20191128013240.GB4765@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20191125065820.927-16-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 07:58:15AM +0100, C=E9dric Le Goater wrote:
> It is now unused.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

14..15 applied to ppc-for-5.0.

> ---
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
> index c14a2d186960..216ebc150a41 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -460,18 +460,6 @@ static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
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
> @@ -1900,7 +1888,6 @@ static void pnv_xive_class_init(ObjectClass *klass,=
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
> index 0ca7099f4e55..4bff3abdc3eb 100644
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3fI7gACgkQbDjKyiDZ
s5Js8RAAiLOUWHYsU5vV+O83udEO4WKXiq2cJF8z0OyzbdtWSI9aenxSP/vSrp2y
C4phB6quZO/7Vnuzg/VmDvfFtQ+JjBPD0eTCqElQyyV8SPelk+3n+Cv7hxOgEYrx
R+YNOW17HckjvFZqXhzyQu5/UmHOrPw3DLp59oYyL5HPcxXOoc+cdb/t9WaYZ9CR
2uJLZHBksZsUy9sr0QAm27t7w4EWZ7y//NtHIJl0EdZRCHyc9so6XSFZc7Dq8kBe
w05OcHPu8f7xthekEkVLTtM5M3nbsd0OoVfvQDNMZDIEsSTCWxg6ievju0ZSgGzf
zKWYtnJ2pU+p8X/rNO0CeoRe1/6Ta7Q/Oc8/UIEQnx7/SLhrZcKVwMAUjdaedQPq
weYiCMod9/FVQ4hoQoELhbDBdYHNjlX42mbRQI12VSdFBRVxABDyPx+HpW+1kVfF
NgTJvdhhios2TPfIltRclhceWo7b95tDI3z1iCrChOMfSgIFA84JFMhE9Giy9EYM
P0tU2I4AWKBgIwRd6H8rvF9lz1W7hywefHNdhGGUxZ39ocgFN8AngDkgDIm69qya
PQNVYVDhk2JqXODjsYEGncpcllivXfK6+8YwSfiorhjeRZm9Ms0I19d6uEu4TFo0
LS6r7pWuahAQ19tMKJdCCGacb6kolwnvIbMuhVED/a/P8WjMkC4=
=9DS9
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--

