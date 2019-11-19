Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EE9C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6C2222A4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i9gW5XKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6C2222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWuDR-0002Xs-8Y
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWuCK-0001Hw-RE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWuCJ-0005Va-Bi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:29:00 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:46973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWuCI-0005UC-AM; Mon, 18 Nov 2019 22:28:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HBBH23d6z9sRC; Tue, 19 Nov 2019 14:28:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574134135;
 bh=ExL+zkuQGRpFasaTZR9E/klbr+TUkdxxGbZwmlAOmhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i9gW5XKX3PL7FO5HXSYRmyejJVpCvjM8/gcbTl0fEvKu1MQnUaXGePIqAJ0+plOyh
 DirrErNuusx4um4zj0ypKmImY1bdcmH8mzldx6nfUKIJksnOWj4wUjlrWrt5gb2hhQ
 oHNDTkvEC5OQ0+y+lQ8Hu6daEb9rHeRKTmTPjBdI=
Date: Tue, 19 Nov 2019 14:19:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 02/23] ppc/xive: Introduce helpers for the NVT
 id
Message-ID: <20191119031952.GR5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f4HxWLVbzokH9yio"
Content-Disposition: inline
In-Reply-To: <20191115162436.30548-3-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f4HxWLVbzokH9yio
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:24:15PM +0100, C=E9dric Le Goater wrote:
> Each vCPU in the system is identified with an NVT identifier which is
> pushed in the OS CAM line (QW1W2) of the HW thread interrupt context
> register when the vCPU is dispatched on a HW thread. This identifier
> is used by the presenter subengine to find a matching target to notify
> of an event. It is also used to fetch the associate NVT structure
> which may contain pending interrupts that need a resend.
>=20
> Add a couple of helpers for the NVT ids. The NVT space is 19 bits
> wide, giving a maximum of 512K per chip.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  include/hw/ppc/xive.h      |  5 -----
>  include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 8fd439ec9bba..fa7adf87feb2 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -418,11 +418,6 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xr=
tr, Error **errp);
>  void xive_tctx_reset(XiveTCTX *tctx);
>  void xive_tctx_destroy(XiveTCTX *tctx);
> =20
> -static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
> -{
> -    return (nvt_blk << 19) | nvt_idx;
> -}
> -
>  /*
>   * KVM XIVE device helpers
>   */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 530f232b04f8..1a5622f8ded8 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -272,4 +272,25 @@ typedef struct XiveNVT {
> =20
>  #define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VALID)
> =20
> +/*
> + * The VP number space in a block is defined by the END_W6_NVT_INDEX
> + * field of the XIVE END
> + */
> +#define XIVE_NVT_SHIFT                19
> +
> +static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
> +{
> +    return (nvt_blk << XIVE_NVT_SHIFT) | nvt_idx;
> +}
> +
> +static inline uint32_t xive_nvt_idx(uint32_t cam_line)
> +{
> +    return cam_line & ((1 << XIVE_NVT_SHIFT) - 1);
> +}
> +
> +static inline uint32_t xive_nvt_blk(uint32_t cam_line)
> +{
> +    return (cam_line >> XIVE_NVT_SHIFT) & 0xf;
> +}
> +
>  #endif /* PPC_XIVE_REGS_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f4HxWLVbzokH9yio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TX1gACgkQbDjKyiDZ
s5LsmBAAnAZPno/gjDe6uFNw89N2YE7qyhMpq8AI9NSX4A6juUvrXHcTYyQp0dZJ
s0ALKweBLSbOJG1wU2GQI2yMjPCeBNFUfcNopmI7xCwb4R9mrd9C7FjYudhuVNsi
uTUZT7bmZgxiSwL9KTUGO3Ix6LOsl3B7fx+k1mmiKgercHNEgrqXW3lRwN2sFwqA
PekjgZIoSj19jiRtrxCyg4QMSzQY+C08qnK4onWC9jqSB8eFLRLn4lOIMJQZv+lu
z3CiKejmaT1lGx1vXBEgGA+JTPktliodidVh4BK4uMFUH8PNQaUhTPFszDLfM1kP
Cxz/uZal5PsmubryPjIYBRZWxAPs0oIOtTTvOk61gDULEPxQggE/hQGRFBGHkdmu
y3F7OwUYZ+yfqY6HEA9+Yu9ocCgiFZFJAjEZY9wqOi+v7fQflHn1W6ca38T9Zwe3
qlsaYYq6VV7oFafAookKiwioJed1qZwMAabCHkAc8ZcyD19cpv3aawgIBX0+7P9D
RpxXctslai7Nto91WOnIDVHJp9oEz8dw220vQLs3bORDjCvuFd0A0VITwg3pDFKM
dgRZQXQxM61hVEOikNtlLqUuSjUHa7AKjpgHhuuVH/yx7IkDGjfzb0uymD3g2zMe
MGDmk6UVXEqidJL58VrlyEPScFNPxqcRai1xgEMavAvt42B5eUU=
=T1UE
-----END PGP SIGNATURE-----

--f4HxWLVbzokH9yio--

