Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BBDECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046ED20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 06:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HCRVyoEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046ED20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJtPN-0001ZG-PB
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 02:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJtNx-0000DM-NK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 01:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJtNw-0004Lu-4G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 01:59:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iJtNv-0004KV-D1; Mon, 14 Oct 2019 01:59:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46s7D91WDtz9sPj; Mon, 14 Oct 2019 16:59:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571032745;
 bh=HUAs6aYPFkPXXaELSWXeYts1zvY8/A+6TTwc8zNBhOk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HCRVyoEhw8t1Ir3U/vU9vOd+LhXqvCw8Yx1Gj8+HLBf0gbEKCdJo38RMoiQKUjJJ4
 7gbfTpf+pkOxk256Ka62D/xqD4I90pEHIFWRXVg7ASBSk7oSHdYECvBQuk5dD0Br/h
 aYNBYH++waII3k7CXhqUdBiGXTpUqXzFWR5pmZks=
Date: Mon, 14 Oct 2019 16:32:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 3/9] ppc/xive: Record the IPB in the associated NVT
Message-ID: <20191014053257.GU4080@umbus.fritz.box>
References: <20191007084102.29776-1-clg@kaod.org>
 <20191007084102.29776-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EyuBRJR0MsVMWKTf"
Content-Disposition: inline
In-Reply-To: <20191007084102.29776-4-clg@kaod.org>
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


--EyuBRJR0MsVMWKTf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 10:40:56AM +0200, C=E9dric Le Goater wrote:
> When an interrupt can not be presented to a vCPU, the XIVE presenter
> updates the Interrupt Pending Buffer of the XIVE NVT if backlog is
> activated in the END.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This commit message doesn't really make it clear what was happening
before, which certainly looks like an update to the IPB field in the
NVT, via a different method.

Is this just a cleanup, or a fix?

> ---
>  include/hw/ppc/xive_regs.h |  1 +
>  hw/intc/xive.c             | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 55307cd1533c..530f232b04f8 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -255,6 +255,7 @@ typedef struct XiveNVT {
>          uint32_t        w2;
>          uint32_t        w3;
>          uint32_t        w4;
> +#define NVT_W4_IPB               PPC_BITMASK32(16, 23)
>          uint32_t        w5;
>          uint32_t        w6;
>          uint32_t        w7;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index cbe4ae6c294d..2bf7b4ad7006 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1600,14 +1600,21 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
>       * - logical server : forward request to IVPE (not supported)
>       */
>      if (xive_end_is_backlog(&end)) {
> +        uint8_t ipb;
> +
>          if (format =3D=3D 1) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "XIVE: END %x/%x invalid config: F1 & backlog\=
n",
>                            end_blk, end_idx);
>              return;
>          }
> -        /* Record the IPB in the associated NVT structure */
> -        ipb_update((uint8_t *) &nvt.w4, priority);
> +        /*
> +         * Record the IPB in the associated NVT structure for later
> +         * use. The presenter will resend the interrupt when the vCPU
> +         * is dispatched again on a HW thread.
> +         */
> +        ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4) | priority_to_ipb(p=
riority);
> +        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
>          xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
> =20
>          /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EyuBRJR0MsVMWKTf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2kCIkACgkQbDjKyiDZ
s5LV0A/9FBVGcLG19/8Dyy5/SAJuywLGHEzBEoLHMu2wbhAiLVUpcqs1t317nWXT
Byh98VhOyyT+wOL0L3VpUGHQZBaPwmnV9VJ1qrIDk/hPK4hvZFRMYA6AvnRxJvam
yEnX1/M95qTegjOP/BV95Ux9DP4Kl3ZNunJPckMRpRX5F5C0hV0bES4zEs6d5bOM
fJ5PD/NJuzarOk5B+Xl8jb4e9DrfDXzUTWKKdRIKFXI/OmuviXyHDvAddn7kxfYh
gaqGcwBjpE+xQJCjirNgKc/zXk3IbYS+il+CzrIYWQ00V8ZM5T+MOCsSx+N3JG91
rUA0Df7qzypVLMeJg8jwL7goTN1Ma/Cwjdw9ztp/kJ7s0EUzbwOh5KY8GIwreojf
Vb8K8ipcpHv81eIXKG8K07eqldjRcIDTyPS2ZYfOpz5jQK6JX2M5HB9YLhc6lOyD
D5B6IRhGtWY7YoUWCfVxPo4OjlzQ1xpjfqztB106UF+CYZzBWr1tHHLQkiPzGH3t
/cAZrd+QX9BawmvB9qbeJgxLtz0OpeijHN17vZm6YUCXZ2UABrjtSsN3xDw/VX7c
QO3kdhNuc5os1vVPpGyhZfPcPwwz2419U5IdF1kQocveuJyvXy1GPw9kccTpGIHP
f+pEc3/MbMomkLNBQx+KZ9Otk/3xyDBFChh8nDEDRCFxAPHJwtw=
=NzKT
-----END PGP SIGNATURE-----

--EyuBRJR0MsVMWKTf--

