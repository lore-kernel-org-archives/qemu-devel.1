Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B8C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D09F20650
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AIfE6FJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D09F20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJtSR-0004Oh-PX
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 02:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJtNx-0000Dc-Nb
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 01:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJtNw-0004Lj-3s
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 01:59:13 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59023 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iJtNv-0004KY-9x; Mon, 14 Oct 2019 01:59:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46s7D85k3Vz9sPh; Mon, 14 Oct 2019 16:59:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571032744;
 bh=vX0AubCGIwk3bW9+Qwp20WoFFx7C4/mznICav8Fa1ic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AIfE6FJtEt5qJZUWraPZONhdWwckhUStKzuGCY4BaAh7Tk5T3sr4ev93rSusKZElJ
 R5Qc+RynGdCH1oCka5zYc0r0oQBN72FD22PqMJs3IqHbgKD8NwDtik5Zv8YQZxIoGc
 bSOayG9ET8JIvYauPNlumM8CdE2tFjpNm82nHjDE=
Date: Mon, 14 Oct 2019 16:28:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/9] ppc/pnv: Improve trigger data definition
Message-ID: <20191014052824.GS4080@umbus.fritz.box>
References: <20191007084102.29776-1-clg@kaod.org>
 <20191007084102.29776-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cjNiBkmi8s9yAE0W"
Content-Disposition: inline
In-Reply-To: <20191007084102.29776-2-clg@kaod.org>
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


--cjNiBkmi8s9yAE0W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 10:40:54AM +0200, C=C3=A9dric Le Goater wrote:
> The trigger data is used for both triggers of a HW source interrupts,
> PHB, PSI, and triggers for rerouting interrupts between interrupt
> controllers.
>=20
> When an interrupt is rerouted, the trigger data follows an "END
> trigger" format. In that case, the remote IC needs EAS containing an
> END index to perform a lookup of an END.
>=20
> An END trigger, bit0 of word0 set to '1', is defined as :
>=20
>              |0123|4567|0123|4567|0123|4567|0123|4567|
>     W0 E=3D1   |1P--|BLOC|          END IDX            |
>     W1 E=3D1   |M   |           END DATA               |
>=20
> An EAS is defined as :
>=20
>              |0123|4567|0123|4567|0123|4567|0123|4567|
>     W0       |V---|BLOC|          END IDX            |
>     W1       |M   |          END DATA                |
>=20
> The END trigger adds an extra 'PQ' bit, bit1 of word0 set to '1',
> signaling that the PQ bits have been checked. That bit is unused in
> the initial EAS definition.
>=20
> When a HW device performs the trigger, the trigger data follows an
> "EAS trigger" format because the trigger data in that case contains an
> EAS index which the IC needs to look for.
>=20
> An EAS trigger, bit0 of word0 set to '0', is defined as :
>=20
>              |0123|4567|0123|4567|0123|4567|0123|4567|
>     W0 E=3D0   |0P--|---- ---- ---- ---- ---- ---- ----|
>     W1 E=3D0   |BLOC|            EAS INDEX             |
>=20
> There is also a 'PQ' bit, bit1 of word0 to '1', signaling that the
> PQ bits have been checked.
>=20
> Introduce these new trigger bits and rename the XIVE_SRCNO macros in
> XIVE_EAS to reflect better the nature of the data.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.2, thanks.

> ---
>  include/hw/ppc/xive_regs.h | 26 +++++++++++++++++++++++---
>  hw/intc/pnv_xive.c         | 20 ++++++++++++++++----
>  hw/intc/xive.c             |  4 ++--
>  3 files changed, 41 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 08c8bf7172e2..55307cd1533c 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -22,9 +22,29 @@
>  /*
>   * Interrupt source number encoding on PowerBUS
>   */
> -#define XIVE_SRCNO_BLOCK(srcno) (((srcno) >> 28) & 0xf)
> -#define XIVE_SRCNO_INDEX(srcno) ((srcno) & 0x0fffffff)
> -#define XIVE_SRCNO(blk, idx)    ((uint32_t)(blk) << 28 | (idx))
> +/*
> + * Trigger data definition
> + *
> + * The trigger definition is used for triggers both for HW source
> + * interrupts (PHB, PSI), as well as for rerouting interrupts between
> + * Interrupt Controller.
> + *
> + * HW source controllers set bit0 of word0 to =E2=80=980=E2=80=99 as the=
y provide EAS
> + * information (EAS block + EAS index) in the 8 byte data and not END
> + * information, which is use for rerouting interrupts.
> + *
> + * bit1 of word0 to =E2=80=981=E2=80=99 signals that the state bit check=
 has been
> + * performed.
> + */
> +#define XIVE_TRIGGER_END        PPC_BIT(0)
> +#define XIVE_TRIGGER_PQ         PPC_BIT(1)
> +
> +/*
> + * QEMU macros to manipulate the trigger payload in native endian
> + */
> +#define XIVE_EAS_BLOCK(n)       (((n) >> 28) & 0xf)
> +#define XIVE_EAS_INDEX(n)       ((n) & 0x0fffffff)
> +#define XIVE_EAS(blk, idx)      ((uint32_t)(blk) << 28 | (idx))
> =20
>  #define TM_SHIFT                16
> =20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index ed6e9d71bbfa..348f2fdd263d 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -385,7 +385,7 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t=
 blk, uint32_t idx,
>      PnvXive *xive =3D PNV_XIVE(xrtr);
> =20
>      if (pnv_xive_get_ic(blk) !=3D xive) {
> -        xive_error(xive, "VST: EAS %x is remote !?", XIVE_SRCNO(blk, idx=
));
> +        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx));
>          return -1;
>      }
> =20
> @@ -431,7 +431,7 @@ static void pnv_xive_notify(XiveNotifier *xn, uint32_=
t srcno)
>      PnvXive *xive =3D PNV_XIVE(xn);
>      uint8_t blk =3D xive->chip->chip_id;
> =20
> -    xive_router_notify(xn, XIVE_SRCNO(blk, srcno));
> +    xive_router_notify(xn, XIVE_EAS(blk, srcno));
>  }
> =20
>  /*
> @@ -1225,12 +1225,24 @@ static const MemoryRegionOps pnv_xive_ic_reg_ops =
=3D {
> =20
>  static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t =
val)
>  {
> +    uint8_t blk;
> +    uint32_t idx;
> +
> +    if (val & XIVE_TRIGGER_END) {
> +        xive_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0x%"=
PRIx64,
> +                   addr, val);
> +        return;
> +    }
> +
>      /*
>       * Forward the source event notification directly to the Router.
>       * The source interrupt number should already be correctly encoded
>       * with the chip block id by the sending device (PHB, PSI).
>       */
> -    xive_router_notify(XIVE_NOTIFIER(xive), val);
> +    blk =3D XIVE_EAS_BLOCK(val);
> +    idx =3D XIVE_EAS_INDEX(val);
> +
> +    xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
>  }
> =20
>  static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t=
 val,
> @@ -1566,7 +1578,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
>  {
>      XiveRouter *xrtr =3D XIVE_ROUTER(xive);
>      uint8_t blk =3D xive->chip->chip_id;
> -    uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
> +    uint32_t srcno0 =3D XIVE_EAS(blk, 0);
>      uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive);
>      uint32_t nr_ends =3D pnv_xive_nr_ends(xive);
>      XiveEAS eas;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 29df06df1136..cbe4ae6c294d 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1648,8 +1648,8 @@ do_escalation:
>  void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
>  {
>      XiveRouter *xrtr =3D XIVE_ROUTER(xn);
> -    uint8_t eas_blk =3D XIVE_SRCNO_BLOCK(lisn);
> -    uint32_t eas_idx =3D XIVE_SRCNO_INDEX(lisn);
> +    uint8_t eas_blk =3D XIVE_EAS_BLOCK(lisn);
> +    uint32_t eas_idx =3D XIVE_EAS_INDEX(lisn);
>      XiveEAS eas;
> =20
>      /* EAS cache lookup */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cjNiBkmi8s9yAE0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2kB3gACgkQbDjKyiDZ
s5LyqBAAlf+/rTwuRZs0IAPuBHNbJ6wPZt6ZvabPddvumLILGloLUJ49Lx5ujD/H
DTx2C3SZKhRxxboy8+6xAyzrHJ7JN0FxGD/u7ogdO4eP8Z9Md50DA65NjYMHDHCX
LUhwXp2zMUbgvbI7G9BaHMrzmF9FXj5l2TauiQh26SJmlCgGWPUESnY17gMG+CHC
ge4VnzHj16k1tvs80nHiMZsepDeKy9ESrHRJx5SwfiaxmRs15HUHlYLM5C+LesAr
qn1AizwKjpVvuTsKHbUccRvPWf4HWfIJVKNweji+AkdgZU3b/wrAj0HUB11edRYt
B9of7mVXgPilMKZumTfvrr9626OEOqpyi6j+xtC6K75u2zqlhzNGWuKnmODF0Twf
PXt77sdNkW0kDI+zdGmkjtl6ZU22stE7qQC//9RFntGXKX1ODd6reBXR3jQPFhTz
PI6/rkSvE+YBUywuZwmjZFsKc9igHkB4qWdYfIK6Lv9Bg2LRYYzjOEvgkn0k0pyS
QP+WsnjTWkbNI+YNQxGp1N8xDUJ7oOnsyOhH7DbEfYj/b3iKQleR6PsKFb5JIuR5
efB8mBsqUXhkdLbgODfdtAxTprc54TwOhEDm/Hb8/sGd2ABs1d8UA0zSEi8GRLpI
dRK+2QlP6EAt/kaGn5g3CfrvsH0I3p4kXHz9xGC4fka+X7d1esk=
=M5lc
-----END PGP SIGNATURE-----

--cjNiBkmi8s9yAE0W--

