Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ADDC4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6455621D81
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RpvDNni7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6455621D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrF7-000096-8t
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5M-00007f-Bk
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5K-0000xT-9L
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5I-0000wE-9I; Wed, 02 Oct 2019 22:43:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHP95nvyz9sPL; Thu,  3 Oct 2019 12:43:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070589;
 bh=mTN9VjpZMT1HLOs/HSsbjzc7k9UfSwliXhrPLdqw+5g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RpvDNni7IFRCIR4sGrawsKXX+74ANsfgrBd98rM7wxlp/dC7pPriICKHKwmukEktP
 eGXaGh0n1kSHtHxPU6lzwv0DBNqcAELlx3bnC4+efF683xIGkKQH/eetgzFYYpA/4c
 Fhy4qV0OGjzL6ZGXS1fslGd64YERy33QqNjTy1NY=
Date: Thu, 3 Oct 2019 12:08:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 11/25] ppc/xive: Move the TIMA operations to the
 controller model
Message-ID: <20191003020859.GJ11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dYuLH7fbMjVsPkFl"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-12-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dYuLH7fbMjVsPkFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:31PM +0200, C=E9dric Le Goater wrote:
> This also removes the need of the get_tctx() XiveRouter handler in the
> core XIVE framework.

In general these commit messages could really do with more context.
What exactly is the "controller model"?  Where were the TIMA
operations before now.  Why is having them in the controller model
better?

I could probably answer those with some investigation, but the point
is that the commit message is supposed to make it easy to find that
information.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h |  1 -
>  hw/intc/pnv_xive.c    | 35 ++++++++++++++++++++++++++++++++++-
>  hw/intc/spapr_xive.c  | 33 +++++++++++++++++++++++++++++++--
>  hw/intc/xive.c        | 29 -----------------------------
>  4 files changed, 65 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 536deea8c622..9d9cd88dd17e 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -462,7 +462,6 @@ typedef struct XiveENDSource {
>  #define XIVE_TM_OS_PAGE         0x2
>  #define XIVE_TM_USER_PAGE       0x3
> =20
> -extern const MemoryRegionOps xive_tm_ops;
>  void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offs=
et,
>                          uint64_t value, unsigned size);
>  uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr o=
ffset,
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 3d6fcf9ac139..40e18fb44811 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1475,6 +1475,39 @@ static const MemoryRegionOps xive_tm_indirect_ops =
=3D {
>      },
>  };
> =20
> +static void pnv_xive_tm_write(void *opaque, hwaddr offset,
> +                              uint64_t value, unsigned size)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> +    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> +
> +    xive_tctx_tm_write(XIVE_PRESENTER(xive), tctx, offset, value, size);
> +}
> +
> +static uint64_t pnv_xive_tm_read(void *opaque, hwaddr offset, unsigned s=
ize)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> +    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> +
> +    return xive_tctx_tm_read(XIVE_PRESENTER(xive), tctx, offset, size);

You're not using the opaque pointer in either of these cases.  So
couldn't you make it point to the presenter for pnv as well, then...

> +}
> +
> +const MemoryRegionOps pnv_xive_tm_ops =3D {
> +    .read =3D pnv_xive_tm_read,
> +    .write =3D pnv_xive_tm_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
>  /*
>   * Interrupt controller XSCOM region.
>   */
> @@ -1832,7 +1865,7 @@ static void pnv_xive_realize(DeviceState *dev, Erro=
r **errp)
>                            "xive-pc", PNV9_XIVE_PC_SIZE);
> =20
>      /* Thread Interrupt Management Area (Direct) */
> -    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,
> +    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &pnv_xive_tm_ops,
>                            xive, "xive-tima", PNV9_XIVE_TM_SIZE);
> =20
>      qemu_register_reset(pnv_xive_reset, dev);
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index eefc0d4c36b9..e00a9bdd901b 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -222,6 +222,35 @@ void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
>      memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
>  }
> =20
> +static void spapr_xive_tm_write(void *opaque, hwaddr offset,
> +                          uint64_t value, unsigned size)
> +{
> +    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
> +
> +    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value,
> size);

=2E.. there would be no difference from the spapr versions, AFAICT.

> +}
> +
> +static uint64_t spapr_xive_tm_read(void *opaque, hwaddr offset, unsigned=
 size)
> +{
> +    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
> +
> +    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size);
> +}
> +
> +const MemoryRegionOps spapr_xive_tm_ops =3D {
> +    .read =3D spapr_xive_tm_read,
> +    .write =3D spapr_xive_tm_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
>  static void spapr_xive_end_reset(XiveEND *end)
>  {
>      memset(end, 0, sizeof(*end));
> @@ -331,8 +360,8 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
>      qemu_register_reset(spapr_xive_reset, dev);
> =20
>      /* TIMA initialization */
> -    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
> -                          "xive.tima", 4ull << TM_SHIFT);
> +    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &spapr_xive_tm_o=
ps,
> +                          xive, "xive.tima", 4ull << TM_SHIFT);
>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
> =20
>      /*
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9bb09ed6ee7b..11432f04f5c3 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -483,35 +483,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, Xive=
TCTX *tctx, hwaddr offset,
>      return xive_tm_raw_read(tctx, offset, size);
>  }
> =20
> -static void xive_tm_write(void *opaque, hwaddr offset,
> -                          uint64_t value, unsigned size)
> -{
> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> -
> -    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
> -}
> -
> -static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
> -{
> -    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
> -
> -    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size);
> -}
> -
> -const MemoryRegionOps xive_tm_ops =3D {
> -    .read =3D xive_tm_read,
> -    .write =3D xive_tm_write,
> -    .endianness =3D DEVICE_BIG_ENDIAN,
> -    .valid =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -    },
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -    },
> -};
> -
>  static char *xive_tctx_ring_print(uint8_t *ring)
>  {
>      uint32_t w2 =3D xive_tctx_word2(ring);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dYuLH7fbMjVsPkFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VWDgACgkQbDjKyiDZ
s5Jrdw/+Lb1jwCGIY3sJoTMQdUtELEGbpSXYdcPx4hhVL1qsZKuCVCgdxnuoOApt
hfl10A/DwvoFxaOkUUbV/ZnT4Twjr8uMJUrL+VGRMfpRjmJgXMaahccmxD1eq7/6
dbkUN+UZcGOtBcDDIhX0S7HIN3/K7dq9HOut2X8d0h5X1JEdhGKN0IctJPAxkCuO
EOGHfVRFDpDnM190mpfHhqOkkqM6VXvUGkqarZwT4JWSe7hXyl6BSnYMlc/KHAjh
NKzFOcKNLpTXAfICrgGvNH0khG6xu81+GlK5NfK9oLivw8F9Z1X9TliC3IbBYX4E
uO6IrNB+RdBLGwNkFmxNEVGtLcApGXej3GWmF28xORRJ6ZSuVE1irxVq2arp+asg
Ammsbqft4SJ52IkedEsUdl1GwLszUV8A/HKyTHlk3OR/Jqc44Sh4Stgo3TDjBPuu
xW/E5SEx94tusw6QDVQImgr9ct1MrTCFA7IItGAay3f0Xt85pqrl3XafVfPKycjc
azqycOT7h2gJAfDHNj0R86vn3573BtvIAsnuWV2cTVOR3Zwsmip3UFgJmdxeE9i/
OUJff9svPv7Hml9tE+jKOxZcwA8sF07uo/pLrTvJY+5iH4yxc5toAIhUv3BpVEyl
4VWw7/5/NbA4LHBNcUkvsFa74SApB/Qs0qgTNPl029urkjlkofg=
=V8tV
-----END PGP SIGNATURE-----

--dYuLH7fbMjVsPkFl--

