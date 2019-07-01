Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA73BC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20E22089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k9ID7lLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20E22089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpEq-0005k6-Uz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAf-0000dq-39
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAd-0005oY-K3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:09 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54215 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAc-0005mQ-VY; Mon, 01 Jul 2019 01:48:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxs60wgz9sPF; Mon,  1 Jul 2019 15:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960081;
 bh=+D3DQbY9JdLaTwovq3kHy1Bw+Ug4vw9WR1eucUafKKM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k9ID7lLgWdTL/Povr/s9O53HzQynAAmH/aAS0YnEAbNHBbiwAD89KW5Q9VrteCTk8
 j7fw/eZGlEGQSxN3UnIqeMeOEDy8aSbJZG3u1oHLXh5YfLfGF/kxmOrcPVxFNLbPtn
 S2NMpYGu38di03M/ZNrlSJGZ6f4Qj0ChWQu02WFo=
Date: Mon, 1 Jul 2019 15:27:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701052725.GN2138@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K4LMwn8CgX2KMboP"
Content-Disposition: inline
In-Reply-To: <20190630204601.30574-3-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 02/10] ppc/xive: Make the PIPR register
 readonly
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


--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 10:45:53PM +0200, C=E9dric Le Goater wrote:
> When the hypervisor (KVM) dispatches a vCPU on a HW thread, it restores
> its thread interrupt context. The Pending Interrupt Priority Register
> (PIPR) is computed from the Interrupt Pending Buffer (IPB) and stores
> should not be allowed to change its value.
>=20
> Fixes: 207d9fe98510 ("ppc/xive: introduce the XIVE interrupt thread conte=
xt")
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.1.

> ---
>  hw/intc/xive.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 3b1f9520ae9f..534f56f86bd5 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -182,31 +182,31 @@ static uint64_t xive_tm_vt_poll(XiveTCTX *tctx, hwa=
ddr offset, unsigned size)
>   */
> =20
>  static const uint8_t xive_tm_hw_view[] =3D {
> -    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
> -    /* QW-1 OS   */   3, 3, 3, 3,   3, 3, 0, 3,   3, 3, 3, 3,   0, 0, 0,=
 0,
> -    /* QW-2 POOL */   0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
> -    /* QW-3 PHYS */   3, 3, 3, 3,   0, 3, 0, 3,   3, 0, 0, 3,   3, 3, 3,=
 0,
> +    3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
> +    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
> +    0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
> +    3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS */
>  };
> =20
>  static const uint8_t xive_tm_hv_view[] =3D {
> -    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
> -    /* QW-1 OS   */   3, 3, 3, 3,   3, 3, 0, 3,   3, 3, 3, 3,   0, 0, 0,=
 0,
> -    /* QW-2 POOL */   0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0,=
 0,
> -    /* QW-3 PHYS */   3, 3, 3, 3,   0, 3, 0, 3,   3, 0, 0, 3,   0, 0, 0,=
 0,
> +    3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
> +    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
> +    0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
> +    3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS */
>  };
> =20
>  static const uint8_t xive_tm_os_view[] =3D {
> -    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0,=
 0,
> -    /* QW-1 OS   */   2, 3, 2, 2,   2, 2, 0, 2,   0, 0, 0, 0,   0, 0, 0,=
 0,
> -    /* QW-2 POOL */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
> -    /* QW-3 PHYS */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
> +    3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
> +    2, 3, 2, 2,   2, 2, 0, 2,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-1 OS   */
> +    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-2 POOL */
> +    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-3 PHYS */
>  };
> =20
>  static const uint8_t xive_tm_user_view[] =3D {
> -    /* QW-0 User */   3, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
> -    /* QW-1 OS   */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
> -    /* QW-2 POOL */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
> -    /* QW-3 PHYS */   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0,=
 0,
> +    3, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-0 User */
> +    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-1 OS   */
> +    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-2 POOL */
> +    0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0,   0, 0, 0, 0, /* QW-3 PHYS */
>  };
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZmbwACgkQbDjKyiDZ
s5KtBQ/+Npay9CaxC3kkZbFphazhyxL0NJbBC6WvoLlBa7f5zYhJKZkZgO+3k30L
QlxVNST4BMTtveHlpBhMdQk4q+FmrpSOkh3QfJKm4tpwP5h//WoONbtNI6bMw3Ef
MSvGXEjoTQHF7JtDCf6xCpO4om/yxSvoz++looXIzavt5d6a96+BSwjVcekIYH5D
yUVAuNqXAX4h2gERDOSzmSpwZtKmpVRH6smqfqGoEdFqBfgQx/ruOicloq15IAH+
b84ZBSJugCWQMJ8WJEp+1kJJy701zluiVYzneUgskF/BFiTBD4SdFcfd/bQm9tOq
R7nsjGbKWzPEJHKcegZxaqmNZZGHbDFcX+GzzpFG3D+Vhf/n2Zcv9FErqDwTH2rH
Z4wuOXdNSETnvIsAAS010MtQskfok9ZDQNtqvHmP8kQjEWZiJ661Gr4x8qNpuvOd
DyhDHMghOfv58ZQfZ98QnRmA2IThT3jf2J67aJRTiW45kese70UJ8ziI89EvFs//
IaOKBqGOXrqlGIEPNUGJJ5LftpxLIMkRTQeVkpzbAWPZFV8OcifwTylMZPfu4iPj
hYG5lj5U7QHX1JMPcjAwrjiETJ4zvRh9nHpZWcXFMfKeU0MkAiXoSKaafrqnFY8q
yVqhqF6tRgkIxAcvU/OxzrIRfw+e+iwGclKiQoGf3+ojl5GdZLc=
=Z+MP
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--

