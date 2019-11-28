Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D92C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD9A2086A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CGzuwZW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD9A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaB58-0002YH-Ap
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 23:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaB02-0006JN-Ap
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaAzy-0001U9-DX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:48 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48399 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaAzs-0001Jq-F1; Wed, 27 Nov 2019 23:01:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47NkTr4t5zz9sPn; Thu, 28 Nov 2019 15:01:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574913696;
 bh=Y+/02JTzPvbbw1ggOJnrRFkmPn976KXYtiOcF89bOx4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CGzuwZW8x+gL9F5yPQEsUZWbNYGelfxwcHhoqanYxYZuui3fAYpwD9WZrpOdQ7GHV
 nyKvTByaWrXkLOMJ5m94AmpwEjvoH4CjQdC625BJxHrHPgXL7VK2SSF+qt+jgb+E0p
 BLCl0pr++JzcOvgv2I5ud1bLBoWrcazhrxotpHoA=
Date: Thu, 28 Nov 2019 13:18:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 00/20] ppc/pnv: add XIVE support for KVM guests
Message-ID: <20191128021855.GD4765@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <20191125065820.927-1-clg@kaod.org>
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


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 07:58:00AM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
> acts as an hypervisor (L0). Supporting emulation of KVM to run guests
> (L1) requires a few more extensions, among which guest support for the
> XIVE interrupt controller on POWER9 processor.
>=20
> The following changes extend the XIVE models with the new XiveFabric
> and XivePresenter interfaces to provide support for XIVE escalations
> and interrupt resend. This mechanism is used by XIVE to notify the
> hypervisor that a vCPU is not dispatched on a HW thread. Tested on a
> QEMU PowerNV machine and a simple QEMU pseries guest doing network on
> a local bridge.
>=20
> The XIVE interrupt controller offers a way to increase the XIVE
> resources per chip by configuring multiple XIVE blocks on a chip. This
> is not currently supported by the model. However, some configurations,
> such as OPAL/skiboot, use one block-per-chip configuration with some
> optimizations. One of them is to override the hardwired chip ID by the
> block id in the PowerBUS operations and for CAM line compares. This
> patchset improves the support for this setup. Tested with 4 chips.
>=20
> A series from Suraj adding guest support in the Radix MMU model of the
> QEMU PowerNV machine is still required and will be send later. The
> whole patchset can be found under :
>=20
>   https://github.com/legoater/qemu/tree/powernv-4.2

I now have all of this applied to the ppc-for-5.0 branch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3fLowACgkQbDjKyiDZ
s5KXEw/+KrLooINAcXe1jtXdrOR2un8IP4+jjEEWd647LgkpawMhS3cm30hbzyGh
EcX/Z7Fx8UWuq6BkOYinlnoXyuYmxnEsUP4Id+t9XwZhylIp5NrSZybhWC0zwsvc
bkX7NZ5XEXhEdgNRLWe7Q847Quwewwetud9hf5O0p1CWQ+qGP8snOOLLm8W6Pz9a
/ZUxO60oqsFo3lndCeb0F4yNgaNZnYbCudVRRQSu2HnUEocDRDQr7BEPY2JklUq8
mrq+EphqJqpQRS3dqJ+oBWVDBbmq5Y3ihoSiKy3LMhpgNsPx5db6RhOnRhaqIXED
nx8un7WrVAwb3M6lwX8KNMLe0kYXu5B0lcbwBdGFBCZzEDk2/MZAc+LunHMs3Tin
4jAexB1gkebAHqcnau7EXXqwwthW+zP/cvsJHJhEAg9LRFWDNBcFr4aPCSWugaTw
ZwhW0FQGEou9U8suzYngjKJTTyUndktSKe+hodVnO2NCPkZR1WLgxvDGkazCbaNR
ZGCNBohqIRY2hxxrMgfuH7PCcnyI3IpnK0HQYQeh2LyxXLW+EGmJ2vazxPpzDiLQ
RvrozOvzOJBFIVHxzoxarOkgBHQB1O/l3Hu8Apgf+r0UGyYw59hscWDkIv7u/vvM
IQm/WgiTF/9FvloLHH8wEhWEQJERmroO/+QQK/Qhl27Nprp3uxE=
=2QoT
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--

