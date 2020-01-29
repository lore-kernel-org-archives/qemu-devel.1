Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51328C33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7DA206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 22:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W/18ripn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7DA206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwvou-00035a-B4
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 17:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iwvns-0001xt-LW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iwvnq-0002sF-Vr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 17:27:20 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38911 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iwvnp-0002my-Fq; Wed, 29 Jan 2020 17:27:18 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 487J4v6kQtz9sP6; Thu, 30 Jan 2020 09:27:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580336831;
 bh=oc22GZkS5CxQkD+w1PrD6nOoE5OZECmE6DZRtAK+0DY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W/18ripnqtNe6Z4iWIAefl2iDaPNNS1anHJCNvXqU9s+voZ8srJYcZ7uaAI/C542j
 ss1vLfvQtD2Y6F8WhfrmUBxeSaqk9wkpGWaVGe37M92FndXrD+sUv4oNflqupD9fdY
 gg2jOvUZdkX3UWpy+iyykARbOX1nEo+wjY87Z79s=
Date: Thu, 30 Jan 2020 09:14:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 0/2] ppc/pnv: Add models for PHB4 and PHB3 PCIe Host
 bridges
Message-ID: <20200129221444.GA2640@umbus.fritz.box>
References: <20200127144506.11132-1-clg@kaod.org>
 <20200129063103.GB42099@umbus.fritz.box>
 <ad66cad0-98ff-7ab1-9be9-8bc234279ff6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <ad66cad0-98ff-7ab1-9be9-8bc234279ff6@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Oliver O'Halloran <oohall@gmail.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 02:15:35PM +0100, C=E9dric Le Goater wrote:
> On 1/29/20 7:31 AM, David Gibson wrote:
> > On Mon, Jan 27, 2020 at 03:45:04PM +0100, C=E9dric Le Goater wrote:
> >> Hello,
> >>
> >> These are models for the PCIe Host Bridges, PHB3 and PHB4, as found on
> >> POWER8 and POWER9 processors. It includes the PowerBus logic interface
> >> (PBCQ), IOMMU support, a single PCIe Gen.3/4 Root Complex, and support
> >> for MSI and LSI interrupt sources as found on each system depending on
> >> the interrupt controller: XICS or XIVE.
> >>
> >> No default device layout is provided and PCI devices can be added on
> >> any of the available PCIe Root Port (pcie.0 .. 2) with address 0x0 as
> >> the firwware (skiboot) only accepts a single device per root port. To
> >> run a simple system with a network and a storage adapters, use a
> >> command line options such as :
> >>
> >>   -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,ad=
dr=3D0x0
> >>   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=
=3Dvirbr0,id=3Dhostnet0
> >>
> >>   -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
> >>   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,=
cache=3Dnone
> >>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
> >>
> >> If more are needed, include a bridge.
> >>
> >> Multi chip is supported, each chip adding its set of PHB controllers
> >> and its PCI busses. The model doesn't emulate the EEH error handling
> >> and cold plugging PHB devices still needs some work.
> >>
> >> XICS requires some adjustment to support the PHB3 MSI. The changes are
> >> provided in the PHB3 model but they could be decoupled in prereq
> >> patches.
> >=20
> > Applied to ppc-for-5.0, thanks.
>=20
> Should we add a default set of devices on PHB1 like found on OpenPOWER=20
> system ? On a P8 we have  :

I think that's kind of up to you.

>=20
>  +-[0001:00]---00.0-[01-07]----00.0-[02-07]--+-01.0-[03-04]----00.0-[04]-=
---00.0  ASPEED Technology, Inc. ASPEED Graphics Family
>  |                                           +-02.0-[05]----00.0  Texas I=
nstruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller
>  |                                           +-03.0-[06]--+-00.0  Broadco=
m Inc. and subsidiaries NetXtreme BCM5718 Gigabit Ethernet PCIe
>  |                                           |            \-00.1  Broadco=
m Inc. and subsidiaries NetXtreme BCM5718 Gigabit Ethernet PCIe
>  |                                           \-04.0-[07]----00.0  Marvell=
 Technology Group Ltd. 88SE9235 PCIe 2.0 x2 4-port SATA 6 Gb/s Controller
>=20
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4yA9IACgkQbDjKyiDZ
s5LrABAA05+f5KfQAP3FnYkhSVcu8WBKPRsn6l5C0xd0Zh7I89kXUPaRTcCbVSaP
Q5y9ODZcsg2y47sl4Gz/oWqJ88/lil9mnurybWQcF8iDuT3UTfSFd9Js/QBTmuuh
2UL02n5vvWp/XD+krS1SETLQR5YW+ju2lA/gX1Umm+HlOZfHzuWEu67vctIlDAWX
fuz9Bv/+36Wln0oYxiHM8xa2gXkJ6YNHnDElb5HbafBRkwZqiRMYzKSbZ6BHugE1
xknFI6drp4ONMrtr5mRlbxA8bz5yBY+wwUOQ28ZBuI/x/lped1DJ6ynCbS+qXsS/
uEUGtYlBhnXUtzT9WNC7yOrrwDc1IvKmpXr4dAyo8WdIwsTS3XXY8T3RHBa3GhAr
a++6MHFlRguhXbgZ+pMTDj/n9OUfGA3NF82GGpIK2CruFvXTo7fIpfNxjUp40y9l
olJYyNIrSVEnEMYBm9okJboooP9rcLCGft6gsJv2VVb6fCgd4FedqgGJ35Qpjhqs
I6kLjQhgrpVIJzg3vxw/5DSh48JoI7io7ZRMs0+a2rbe01TM1bLPU/wLXMvbQLiG
n3Kl2sgOBgfJsZm7taObxSXE/w9vuBtC/vnUAqwWD5B1204+Tbkzg+ln9DYl7aZk
W6wgRRZUF5ifecK2roMX+atQ/LBv4kyFSegIQHdp0MjvezWCS0w=
=N/B6
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

