Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA34C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06F32089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ElTWjJTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06F32089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpEt-0005op-Ts
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAh-0000eG-OA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAg-0005r5-CU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33643 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAf-0005p5-Na; Mon, 01 Jul 2019 01:48:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxt01vGz9sPQ; Mon,  1 Jul 2019 15:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960082;
 bh=vguJ93WFktdv05krgifyxoFZP0baSNzdAZIzqTT10Jc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ElTWjJTefR9eGtYRLS6Gi9PFR7nL1itfO0F9b/P6gQBM7iBgZH0qSBX/8FD+x1ykj
 b2jVFBByXOgAVKkdSYkRvf92fkj2ikgEPphLdeMohHWD73FMl4SB8Zex6uyg2EX4QX
 vtot9+Pk6X3tMIhiyGHRrV4RDfvBJVdPZLiX8Um0=
Date: Mon, 1 Jul 2019 15:26:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701052616.GM2138@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline
In-Reply-To: <20190630204601.30574-2-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 01/10] ppc/xive: Force the Physical CAM
 line value to group mode
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 10:45:52PM +0200, C=E9dric Le Goater wrote:
> When an interrupt needs to be delivered, the XIVE interrupt controller
> presenter scans the CAM lines of the thread interrupt contexts of the
> HW threads of the chip to find a matching vCPU. The interrupt context
> is composed of 4 different sets of registers: Physical, HV, OS and
> User.
>=20
> The encoding of the Physical CAM line depends on the mode in which the
> interrupt controller is operating: CAM mode or block group mode.
> Block group mode being the default configuration today on POWER9 and
> the only one available on the next POWER10 generation, enforce this
> encoding in the Physical CAM line :
>=20
>     chip << 19 | 0000000 0 0001 thread (7Bit)
>=20
> It fits the overall encoding of the NVT ids and simplifies the matching
> algorithm in the presenter.
>=20
> Fixes: d514c48d41fb ("ppc/xive: hardwire the Physical CAM line of the thr=
ead context")
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Since this appears to be a fix, applied to ppc-for-4.1.

> ---
>  hw/intc/xive.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 6250c0414de8..3b1f9520ae9f 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1229,27 +1229,16 @@ XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, =
CPUState *cs)
>  }
> =20
>  /*
> - * By default on P9, the HW CAM line (23bits) is hardwired to :
> + * Encode the HW CAM line in the block group mode format :
>   *
> - *   0x000||0b1||4Bit chip number||7Bit Thread number.
> - *
> - * When the block grouping is enabled, the CAM line is changed to :
> - *
> - *   4Bit chip number||0x001||7Bit Thread number.
> + *   chip << 19 | 0000000 0 0001 thread (7Bit)
>   */
> -static uint32_t hw_cam_line(uint8_t chip_id, uint8_t tid)
> -{
> -    return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
> -}
> -
> -static bool xive_presenter_tctx_match_hw(XiveTCTX *tctx,
> -                                         uint8_t nvt_blk, uint32_t nvt_i=
dx)
> +static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx)
>  {
>      CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
>      uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
> =20
> -    return hw_cam_line((pir >> 8) & 0xf, pir & 0x7f) =3D=3D
> -        hw_cam_line(nvt_blk, nvt_idx);
> +    return xive_nvt_cam_line((pir >> 8) & 0xf, 1 << 7 | (pir & 0x7f));
>  }
> =20
>  /*
> @@ -1285,7 +1274,7 @@ static int xive_presenter_tctx_match(XiveTCTX *tctx=
, uint8_t format,
> =20
>          /* PHYS ring */
>          if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
> -            xive_presenter_tctx_match_hw(tctx, nvt_blk, nvt_idx)) {
> +            cam =3D=3D xive_tctx_hw_cam_line(tctx)) {
>              return TM_QW3_HV_PHYS;
>          }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZmXYACgkQbDjKyiDZ
s5JN7w//UKqYCmhO/PLPU4scrsw5Nv7rODNlsn3pWWhhGM4H80HenZtqqGa8+/bV
dKlF2e6UmhdmEMPxtmbVIg8GUP6HBwagYJTQwQGE/kcAk7SxY/OqfoKtm/FWAvKS
35q8MDHnbWrWLqc8eKKgmyVYPkXJa7j4kd7+HHFDLXvGxlvVjGYgdyqPavZm3+uX
XpRwhruPO0a6X3JrPqJQP65biGKmYmnQLYiu/97tJ4lGws7afOrX/9FlCCC8oP7Z
/OPPw45Ru9nMGE0N9Hh/JxhdQrgBmBlQoTO2NTC8SyUqe6Zk7n1CfGc0QVsxv7RH
fahZOiQiaAsQ+SjcYR7LR2xx2xkX3EkdiNSdbFP+DXcEpNkVF+UmqBqWAxoACR4P
SgjeND+pkZCCebJ1b9QhxvT7GxJ/SKNrLpeo9O/JO/HPGt+qkxG74Fr/3JbHswno
kLdeipg9GwlVL0izQTYnGhUjTmbmR8veat5W8UC8wAOjWLUyLZp8flA/YbRbCjLs
G7F90cvOFgjeZwJPLr1RxPm1IOO3DHwhGDXkbZhNKpZWBpW5GXZQCXV+YMLmpSdK
Hu03BfSoTGtzDEuRCqZ26OpEKyB4miBdRVqXZUnsVGlQOKzcHfvw/v8woOmxSb/E
ExIndSnwXZNTjycIklddIO2xN+R6feiKslfbYvVDAZa5j0LlGIQ=
=m/S+
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--

