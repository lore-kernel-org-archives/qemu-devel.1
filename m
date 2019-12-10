Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E226C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685B4206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mSgrLzkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685B4206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieqDa-0005yv-9g
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 19:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC9-0004TH-Lp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC8-0002I7-5W
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:37 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44911 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieqC7-0002FV-5o; Tue, 10 Dec 2019 19:49:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47XdcC4C7Pz9sRK; Wed, 11 Dec 2019 11:49:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576025371;
 bh=J+4Ti1seh8o4hZ0PtDNfNBInaQXg244TvzUqdOPGitM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mSgrLzkheLJU0IA18RuvVyUJBOtnCb1vGltlepMjL+DN6eB5cqIkfrh6zkQOZIo8B
 L3Iz8u4p0ElsWCG4L6Qw/c+tFx+fDdtUW6JUFaPfXVIKat1VPW1TBP6iDS3ELfFuoT
 cC/2buhx+XAzfDjb99rl7TqIptHHOWWutzUKnMlc=
Date: Wed, 11 Dec 2019 10:46:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 0/2] ppc/pnv: minor XSCOM fixes
Message-ID: <20191210234636.GO207300@umbus.fritz.box>
References: <20191210135845.19773-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline
In-Reply-To: <20191210135845.19773-1-clg@kaod.org>
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


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 02:58:43PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here are a couple of fixes/cleanups for the PowerNV XSCOM bus.

Applied to ppc-for-5.0, thanks.

>=20
> Thanks,
>=20
> C.=20
>=20
> C=E9dric Le Goater (2):
>   ppc/pnv: Loop on the whole hierarchy to populate the DT with the XSCOM
>     nodes
>   ppc/pnv: populate the DT with realized XSCOM devices
>=20
>  hw/ppc/pnv_xscom.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3wLlwACgkQbDjKyiDZ
s5KqcQ/9GQQjbYCxfIT8NeI52ttcz+PcvfCtv2J6IwUiaMUhW/Hgj7dM9O+n/Xwx
9/AL5GD2YMK6uQZ4l6+FdQ/yvCD8saRRirGT/OMziJQPlExHTLeg23kRA/v4ss7B
OKZx+LFMSUglxxrZSQAgq0W093cBvqj1eDXElk5LrLztkXx3G33xhBww5LfXsocv
XA2JmyS4jBjC1vjJ6xd9voY0ouPnBkHSO1RwDdqfg9XB2kgfgD+42v/UbDfvj4gm
xMbEsMwK6ikcnNyyAM5uU2uYRki0/6wAs9TF9kBWBi9+ki9unE+TVzbKxqGo+82V
cXOc50Pvb8WSPva8yJMVThVfF3x0jC3Sh8f2nInz2DJDAjZjvSOC4WGemqvI3YWT
+muk5tXdNtHALnsG5LhFnpHJizruQyJ3AUdyDRfgHCHoIRxxhoeaKdf5y/0a1cRh
ns8iqVUFAydcMxD8vaqlxcoV+nRWRtBu4ysIdwKdOHAUlRdsem9uY7jh/atDl07R
TNiTnYv6QX7MoxiqBj0mCeNHy5qT3GJc6EjZ7C6ua3ttijw10Eqws/UY+6CkEdr7
IcubSrgIUnwNKsVwPzoasts0/j/vmXUpFhOm7uSpvLoKncE4EAOugmUndYOS4xl2
4KVs75F2hPZDUsb5I84EZapckpOlOuy7AQSKc8lz0Cty4TTD8q4=
=gMk8
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--

