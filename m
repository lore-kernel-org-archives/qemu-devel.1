Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED354C5B57D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 03:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA7021721
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 03:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iasvOnpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA7021721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiVYD-0000Q8-Qy
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 23:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiVXA-0007tU-EN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 23:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiVX0-0007Dp-5V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 23:02:06 -0400
Received: from ozlabs.org ([203.11.71.1]:57019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiVWy-0006xG-Fw; Tue, 02 Jul 2019 23:02:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dm913vBsz9s3Z; Wed,  3 Jul 2019 13:01:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562122901;
 bh=Fx2R7NcSe3z3v0P0Ad3dCgk/h/dim4kRBsqubuerPeM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iasvOnpUuMO3bBd/91XFvXONLnL76ZHUqQJR3wbykMML6Cwn/p9RH/v547vncXp4D
 q/0MSJopD0v7hP54gsLPuLMIIroBBRRTZnyor0ytUHYonCDnaLFSsbeuSFuBvBeQPT
 G7zPSMX0zwGsydb5YSsDIw7jTsZh2i57SrQTyhho=
Date: Wed, 3 Jul 2019 12:10:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190703021009.GE9442@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <20190630204601.30574-1-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 00/10] ppc/pnv: add XIVE support for KVM
 guests
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


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 10:45:51PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
> acts as an hypervisor (L0). Supporting emulation of KVM to run guests
> (L1) requires a few more extensions, among which support for the XIVE
> interrupt controller on POWER9 processor.=20
>=20
> The following changes fix some parts of the XIVE model and provide
> support for escalations and resend. This mechanism is used by KVM to
> kick a vCPU when it is not dispatched on a HW thread.
>=20
> A series from Suraj adding guest support in the Radix MMU model of the
> QEMU PowerNV machine is still required and will be send later. The
> whole patchset can be found under :
>=20
>   https://github.com/legoater/qemu/tree/powernv-4.1

The rest of this series is essentially a new feature, and so will have
to wait until 4.2 now we're in soft freeze.

>=20
> Thanks,
>=20
> C.
>=20
> C=E9dric Le Goater (10):
>   ppc/xive: Force the Physical CAM line value to group mode
>   ppc/xive: Make the PIPR register readonly
>   ppc/pnv: Rework cache watch model of PnvXIVE
>   ppc/xive: Fix TM_PULL_POOL_CTX special operation
>   ppc/xive: Implement TM_PULL_OS_CTX special command
>   ppc/xive: Provide escalation support
>   ppc/xive: Improve 'info pic' support
>   ppc/xive: Extend XiveTCTX with an router object pointer
>   ppc/xive: Synthesize interrupt from the saved IPB in the NVT
>   ppc/pnv: Dump the XIVE NVT table
>=20
>  include/hw/ppc/xive.h      |  23 ++-
>  include/hw/ppc/xive_regs.h |  13 ++
>  hw/intc/pnv_xive.c         | 211 +++++++++++++++++++----
>  hw/intc/spapr_xive.c       |   1 -
>  hw/intc/xive.c             | 341 +++++++++++++++++++++++++++++--------
>  hw/ppc/pnv.c               |   2 +-
>  hw/ppc/spapr_irq.c         |   2 +-
>  7 files changed, 479 insertions(+), 114 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cDoEACgkQbDjKyiDZ
s5IL3g//VeDXELpUfQU46pxPzAKS6dbNhBqY2f1GzUnraRBw2aTZ7BGZIVyUXKkl
pznQjsjKfP0vL+OSExYasJwuyAHnMKKaClfE4Wqsm9Aw5Fgp8grb6gXizIe7bLpX
2xDjyAiJakHHurw0TG5vOn9G1AsKmdzZgd5EcaDNx2cFCJxrac5SsGKspiG6ZyTF
5YYE9Bj6PJ3oy4gEW5gWy2yx+OOQWTlcvSo5M8ahMWdmFWxXzZiqZCIqZAwGfoMI
sDOMCLl5dO2PpQsBntdrHcuvorPb3PQpWsFAv9eH1x0XBvhgZUG6vikT4S5XwnfK
FFpc5CD69xk3+jYA1xI9PchGWquwjZzDPXUxiXA+fqKTBCSh58ICO+5Bf/iC7iAD
1OYyIIzhjMulqVjsDp0vFc7mDgOuxEow/o9daWN63WqSKt1QUl9G2tjjEVbHUu62
lu0rEpf1/Rs3j7G1zJnbhOVnrf5tH+DlUSLTZ+aJXIgXnmea7IfFa52JQEjFDmtR
jss4XY/Y39mu0eAejwiq5S18ojQmsWEnTzGrNCtuBggGkY7bSKN1kQ0CE0w3Wx0O
9TiZdXbtvP9+UsODZW6149V/enDAJzJ4qhN9FeASYNAp7eE/fgXedlYLn924B23K
P51+83/H5E6xVe1a6+xaBEiWpxyTlzj+006788qCbUTK0PT5wiA=
=BFlT
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

