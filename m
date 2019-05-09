Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B1C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34E52053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="K5n4c27O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34E52053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hObrM-0005SB-Va
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:44:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObof-0003Pj-3T
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObod-0001eg-Qe
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hObod-0001ZF-E7; Thu, 09 May 2019 01:41:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4502KB54TRz9sBp; Thu,  9 May 2019 15:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557380510;
	bh=xgfnGfX6+FeTELrd78HNe0kwwdXcmDk9nZ1+L26y//s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K5n4c27OxR6ivslFSts0YgIAEJlW33qkExVJuW7akKCuiyqqpAkW0dUGfZg1JMkDw
	wbxRPr1QVZ48SSC0KRyT7fHqA+pq6yDuTEBV3ZRE2v7rwpjHuN7yk8qbz0J+NW58ee
	PYIu1tm+lDkmW0/joYXASJiDsO/B/BwQkSz25YEc=
Date: Thu, 9 May 2019 15:37:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190509053700.GS7073@umbus.fritz.box>
References: <20190508171946.657-1-clg@kaod.org>
	<20190508171946.657-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bk6L21jbBNK7V1Rv"
Content-Disposition: inline
In-Reply-To: <20190508171946.657-2-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr/xive: EQ page should be
 naturally aligned
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bk6L21jbBNK7V1Rv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 07:19:44PM +0200, C=E9dric Le Goater wrote:
> When the OS configures the EQ page in which to receive event
> notifications from the XIVE interrupt controller, the page should be
> naturally aligned. Add this check.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/spapr_xive.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 097f88d4608d..666e24e9b447 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -993,6 +993,12 @@ static target_ulong h_int_set_queue_config(PowerPCCP=
U *cpu,
>      case 16:
>      case 21:
>      case 24:
> +        if (!QEMU_IS_ALIGNED(qpage, 1ul << qsize)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: EQ @0x%" HWADDR_PRIx
> +                          " is not naturally aligned with %" HWADDR_PRIx=
 "\n",
> +                          qpage, 1ul << qsize);
> +            return H_P4;
> +        }
>          end.w2 =3D cpu_to_be32((qpage >> 32) & 0x0fffffff);
>          end.w3 =3D cpu_to_be32(qpage & 0xffffffff);
>          end.w0 |=3D cpu_to_be32(END_W0_ENQUEUE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bk6L21jbBNK7V1Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzTvHsACgkQbDjKyiDZ
s5J1FRAAy6CRUF6dRmSk+B/Q3dqHxmUWNMoMjWzacK9ENt7NUOnnYSirCRIqrsjd
jyFeiVLBavnHLGofPLzHmeUp7t/H3BB2UwQBtz9jXGccBdGtyWgJRG0Jf4zDQjn7
UfqDJV/dcohYNIs1Dy4i8UDQOlXwiJlEyP/hgBq2ZF2zn0eeDQXGNVFcUGfTCcEX
Ry0UU0h6MyChORSUolr4bMAueCKP3gPUuLvDnsc8+qzJaRaXv/0hy/KAmKl3q/0k
drV7QDc3bM0taXweWf7PGCDwDi+BbMSePqG7Pz/E1i6Gmdxzmrw7p+qbHxUiqcWR
rgq1AK7S4M5w+Rjm4nsn4pjiSqfIkL45Hl3q/raN/5CJfrR1V5UbySFmBgiJSXHs
8jjgPTmfmi5JKDaKrstw+YRVoa80NI15epO4PdED/u8H6wE9VEoEUds5wjsaOsUC
zBw1xSlbOs16hiQ87rTpoTI/zQ/2mLGCJJGGyhvTQq1yg4Zvi+FHfohQpIN1LzPU
TwZeZmO7LbIrsgeB4v703Bk4gzncKinq3CB/MKrQz3YJl9bL2mf0CUoeGx60XApK
zAPcoMKdBRkkmQd4aMdPNQYu9EOlcZMh0E3sACiPcIMN0lnW322bsktD7U8i0QK2
v6jySR2tzdSd/QTcv4WfapLncLhgvI8Ghqz9DV7IPdlhYbyaQwE=
=s4l+
-----END PGP SIGNATURE-----

--Bk6L21jbBNK7V1Rv--

