Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFB8C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3702245D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iFJRMgVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3702245D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXGtM-0007C0-Nn
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 22:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXGsG-00063A-0d
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXGsE-00020f-Iv
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:41:47 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53165 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXGsD-0001vL-Su; Tue, 19 Nov 2019 22:41:46 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HpQV25SNz9sPV; Wed, 20 Nov 2019 14:41:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574221298;
 bh=WmIMY2kyFRbwIJoaOQRQ/x7hA6B+1zmuq5C7zFZiTGk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iFJRMgVUzZt6Q6GYyEpg5f8fEQaPh2WJeQMTvzFGfuFmhZTIHXUAXsa0fDck7ylRH
 CETM3GkAbPCZu/r8yCeEdAaXOtBxCwYCi/kKrT/+PYkr/JckldHwmI03aBrbLcJALU
 D5SZkaXA6EzOG4YhJZ643O24vjvev6BEgdQcmkTI=
Date: Wed, 20 Nov 2019 14:25:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 07/23] ppc/xive: Check V bit in TM_PULL_POOL_CTX
Message-ID: <20191120032525.GB5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TuBLotoxjxNtqonL"
Content-Disposition: inline
In-Reply-To: <20191115162436.30548-8-clg@kaod.org>
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


--TuBLotoxjxNtqonL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:24:20PM +0100, C=E9dric Le Goater wrote:
> A context should be 'valid' when pulled from the thread interrupt
> context registers.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/xive.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 42e9a11ef731..511e1a936347 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -377,6 +377,11 @@ static uint64_t xive_tm_pull_os_ctx(XiveTCTX *tctx, =
hwaddr offset,
> =20
>      qw1w2 =3D xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
> =20
> +    if (!vo) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVT %x/%x =
!?\n",
> +                      nvt_blk, nvt_idx);
> +    }
> +
>      /* Invalidate CAM line */
>      qw1w2_new =3D xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
>      xive_tctx_set_os_cam(tctx, qw1w2_new);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TuBLotoxjxNtqonL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UsiUACgkQbDjKyiDZ
s5Lk4g/+JYwacO1kCMZxvUvCXS6ZcXo6QWpNHZ7AkN0734gjIK2bD3ffNsFLor9f
vgKHVBuW0gbNd2A+nDKtnc8IrMSpJnr/IlAiB+/QU2P0mY3x3QmN/G5mNUIMsVUM
woR3fFmE84Rp9GnpaBBg4MpYlaBrBqeXfZYo+uLBNxnuRbIgXr7FbT1qzLG80vKU
EH60zb0rJ/Kd3zyddKKXstkCJPOo4ygn1WtAu8PJtWFYPJA+92Mh8jW4GMi3/JxE
ZCt4NYK/KeipBQzan9htbU33bGbPqXhbNd7m7WEQv4jTWDZxup3HvVAECS5YwTuZ
UuiqsedcweOhbqAWsqsIB5yAq/L0oMtPQHYiZV/wFFQi17y6IUb5E+7lO6Mp2j9Z
JPRuaJfE+/4nSPKpKtZclj4rCtv0CMTZnUB+lMsy1126dLs9rIpiRuh5lv69XZTf
gLcGYQF/MItuig/gxsdjtQHbpBjSwvEAJOai3fNN6qE7I6xTeH7up3a8Bx/gK9oL
Hb6D9A8hlYTMM9W+otC1HNXIQZF9Ig1qUbGx2+r2TEsQlxbjztpR4VMZ8ieAWj0D
NaxouVhV8vOJIFFDzY002QQgtNHEdwjXoXeGqp8qB+SX59X1gosfkGqEdZZ6zGaW
96LtC0FfBEAs3mc5FGLDQxnPaBMVljgrdUejuqb2jFsqo2dobJg=
=4N6+
-----END PGP SIGNATURE-----

--TuBLotoxjxNtqonL--

