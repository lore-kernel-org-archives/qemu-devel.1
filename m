Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD4CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D5A20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KHSe/QAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D5A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTVQ-0000XO-Ar
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTJ-0006Pz-QR
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTI-0002ry-Be
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:33 -0400
Received: from ozlabs.org ([203.11.71.1]:42729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTH-0002nF-7k; Wed, 23 Oct 2019 23:07:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS1hS9z9sNw; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=gSjtQwlQKxTQDrZCVgREHwp9Og1zNXyrSBBxMJ6cltA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KHSe/QAIfLNjPvirl0woJy9EGiqo5K4zLtYVSqqsQM0D0PuuMZ3dLcCQIj3MFvW3l
 b7unB+Tu4XKWB+e+LP2PKH3wsgEjF3xN7RU2JhmOGoZ/u66/INwRPjixCXEeUb6mnO
 b/etgVKadHw2wp+ltPmmbrTzK8uWYSaywM87mDrM=
Date: Thu, 24 Oct 2019 13:35:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 0/7] ppc: reset the interrupt presenter from the CPU
 reset handler
Message-ID: <20191024023502.GN6439@umbus.fritz.box>
References: <20191022163812.330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8CNmCRe8Sh4keFKJ"
Content-Disposition: inline
In-Reply-To: <20191022163812.330-1-clg@kaod.org>
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8CNmCRe8Sh4keFKJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 06:38:05PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> On the sPAPR machine and PowerNV machine, the interrupt presenters are
> created by a machine handler at the core level and are reseted
> independently. This is not consistent and it raises issues when it
> comes to handle hot-plugged CPUs. In that case, the presenters are not
> reseted. This is less of an issue in XICS, although a zero MFFR could
> be a concern, but in XIVE, the OS CAM line is not set and this breaks
> the presenting algorithm. The current code has workarounds which need
> a global cleanup.
>=20
> Extend the sPAPR IRQ backend and the PowerNV Chip class with a new
> cpu_intc_reset() handler called by the CPU reset handler and remove
> the XiveTCTX reset handler which is now redundant.
>=20
> Set the OS CAM line when the interrupt presenter of the sPAPR core is
> reseted. This will also cover the case of hot-plugged CPUs.

I'm not totally convinced whether every step here is done the best it
can be.  But it addresses real problems, so I've applied anyway.  I
will make some comments inline, which could be addressed in follow up
patches.

>=20
> Thanks,
>=20
> C.
>=20
> Changes in v5:
>=20
>  - Removed useless PNV_CHIP() cast
> =20
> Changes in v4:
>=20
>  - Introduce a PnvCore reset handler
>  - Add PnvChip pointer to PnvCore
>=20
> Changes in v3:
>=20
>  - Introduced a DeviceClass::reset for the CPU (Greg)
>  - add support for PowerNV
> =20
> Changes in v2:
>=20
>  - removed property
>  - simplified reset handlers
>=20
> C=E9dric Le Goater (6):
>   spapr: move CPU reset after presenter creation
>   ppc/pnv: Introduce a PnvCore reset handler
>   ppc/pnv: Add a PnvChip pointer to PnvCore
>   ppc: Reset the interrupt presenter from the CPU reset handler
>   ppc/pnv: Fix naming of routines realizing the CPUs
>   spapr/xive: Set the OS CAM line at reset
>=20
> Greg Kurz (1):
>   spapr_cpu_core: Implement DeviceClass::reset
>=20
>  include/hw/ppc/pnv.h        |  1 +
>  include/hw/ppc/pnv_core.h   |  3 +++
>  include/hw/ppc/spapr_irq.h  |  2 ++
>  include/hw/ppc/spapr_xive.h |  1 -
>  include/hw/ppc/xics.h       |  1 +
>  include/hw/ppc/xive.h       |  1 +
>  hw/intc/spapr_xive.c        | 53 +++++++++++++++++--------------------
>  hw/intc/xics.c              |  8 ++----
>  hw/intc/xics_spapr.c        |  7 +++++
>  hw/intc/xive.c              | 12 +--------
>  hw/ppc/pnv.c                | 18 +++++++++++++
>  hw/ppc/pnv_core.c           | 31 ++++++++++++++++------
>  hw/ppc/spapr_cpu_core.c     | 44 +++++++++++++++++++++++-------
>  hw/ppc/spapr_irq.c          | 14 ++++++++++
>  14 files changed, 131 insertions(+), 65 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8CNmCRe8Sh4keFKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xDdYACgkQbDjKyiDZ
s5LcDBAAjjPgZUMKAzlR+n564uUSo0pC0ZkN62hgP6mTkrVo/sk1Xs810AuGih/x
Oxpv9DQIz9UkMOgVgL+QGBcL4ohSjzQLL51aiNfkC5iLhv22ydIVsy1x/TeuvQnB
+XI3hfd2M67RnZY2Ul1Qc2nRG2MCkfRZ9wORoUEdw0mPkZV3+J+1p+3iN6ZPzH55
6iCTDP+HNHh5J3gAa6uIgtPUjOepVJro5Ri4wvsFoHzfY/EXr7g+PVOBFV9p7q6O
XF7JrViHKrpbVaLtFlHOkuDA5FOG35TZpSzjcCjnYIxrxWylKt8qmb8ph8vpBauC
PL2BWuik36FmYUtFYNUZJBqE/0T/yq45Os6mcbPT2ewTejue6aNWrQFzsvNg1KpF
N1eS6h/fr044TPmvJixCbKuFPTozIVEcGSQFiVeA6hmB4sOMo2gv4yMCIZvEvLQ7
5HmFtENAY0jFouwkfR7iEhffbgw8lp4bDfg/ty4yV7fAsW7+KCq4MLDhLIiKoCzh
trdjocdcfOu/nntmXQf/s0RaBGMARY0U5xs8ZlOHnW26ahdazZRVX2vcb18UhMmU
CpXBkbHxqW7JWjTEm+gkoIBDgXo5mJRhZrzY75SauIqSckPR+086Wx9/jTgqaE2A
18Yd8q8UQI0o1o7GqlYvo514VtPNxCNew3aNCWGuspAWHD5FL54=
=0EVm
-----END PGP SIGNATURE-----

--8CNmCRe8Sh4keFKJ--

