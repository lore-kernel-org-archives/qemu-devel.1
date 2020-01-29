Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D654AC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 06:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2163206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 06:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eFqXYN+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2163206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwgtL-0003in-OS
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 01:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iwgsf-0002qS-Kg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iwgsd-0000PH-JP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 01:31:17 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:56015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iwgsd-0000K1-50; Wed, 29 Jan 2020 01:31:15 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 486tsp2pzbz9sPW; Wed, 29 Jan 2020 17:31:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580279470;
 bh=yDainVpzdoTJdPGNe6B6H/0am7Tjpl23tQqxPa0lDAk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eFqXYN+RJieawvM8Zb3uPz2sdcqzxWzcF+zseH80dYC18m+18T6HfOlzS1m3UgguJ
 dBUo629I5251fhi8ocwGFpXnjc3uqxd1/sDUcbZXSiWcGSwmo0iTS6prYhxjJ3RVNt
 YmYEXv1PlGQ3ZwuhgEZDRXaSeTB52JtE/eN5BvxQ=
Date: Wed, 29 Jan 2020 17:31:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 0/2] ppc/pnv: Add models for PHB4 and PHB3 PCIe Host
 bridges
Message-ID: <20200129063103.GB42099@umbus.fritz.box>
References: <20200127144506.11132-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/0ZNML3L+nUf91nU"
Content-Disposition: inline
In-Reply-To: <20200127144506.11132-1-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Oliver O'Halloran <oohall@gmail.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/0ZNML3L+nUf91nU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2020 at 03:45:04PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> These are models for the PCIe Host Bridges, PHB3 and PHB4, as found on
> POWER8 and POWER9 processors. It includes the PowerBus logic interface
> (PBCQ), IOMMU support, a single PCIe Gen.3/4 Root Complex, and support
> for MSI and LSI interrupt sources as found on each system depending on
> the interrupt controller: XICS or XIVE.
>=20
> No default device layout is provided and PCI devices can be added on
> any of the available PCIe Root Port (pcie.0 .. 2) with address 0x0 as
> the firwware (skiboot) only accepts a single device per root port. To
> run a simple system with a network and a storage adapters, use a
> command line options such as :
>=20
>   -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,addr=
=3D0x0
>   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3D=
virbr0,id=3Dhostnet0
>=20
>   -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
>   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,cac=
he=3Dnone
>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Dd=
rive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
>=20
> If more are needed, include a bridge.
>=20
> Multi chip is supported, each chip adding its set of PHB controllers
> and its PCI busses. The model doesn't emulate the EEH error handling
> and cold plugging PHB devices still needs some work.
>=20
> XICS requires some adjustment to support the PHB3 MSI. The changes are
> provided in the PHB3 model but they could be decoupled in prereq
> patches.

Applied to ppc-for-5.0, thanks.

>=20
> Thanks,
>=20
> C.
>=20
> Benjamin Herrenschmidt (1):
>   ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge
>=20
> C=E9dric Le Goater (1):
>   ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge
>=20
>  include/hw/pci-host/pnv_phb3.h      |  164 +++
>  include/hw/pci-host/pnv_phb3_regs.h |  450 +++++++++
>  include/hw/pci-host/pnv_phb4.h      |  230 +++++
>  include/hw/pci-host/pnv_phb4_regs.h |  553 ++++++++++
>  include/hw/pci/pcie_port.h          |    1 +
>  include/hw/ppc/pnv.h                |   11 +
>  include/hw/ppc/pnv_xscom.h          |   20 +
>  include/hw/ppc/xics.h               |    5 +
>  hw/intc/xics.c                      |   14 +-
>  hw/pci-host/pnv_phb3.c              | 1195 ++++++++++++++++++++++
>  hw/pci-host/pnv_phb3_msi.c          |  349 +++++++
>  hw/pci-host/pnv_phb3_pbcq.c         |  357 +++++++
>  hw/pci-host/pnv_phb4.c              | 1438 +++++++++++++++++++++++++++
>  hw/pci-host/pnv_phb4_pec.c          |  593 +++++++++++
>  hw/ppc/pnv.c                        |  176 +++-
>  hw/pci-host/Makefile.objs           |    2 +
>  hw/ppc/Kconfig                      |    2 +
>  17 files changed, 5557 insertions(+), 3 deletions(-)
>  create mode 100644 include/hw/pci-host/pnv_phb3.h
>  create mode 100644 include/hw/pci-host/pnv_phb3_regs.h
>  create mode 100644 include/hw/pci-host/pnv_phb4.h
>  create mode 100644 include/hw/pci-host/pnv_phb4_regs.h
>  create mode 100644 hw/pci-host/pnv_phb3.c
>  create mode 100644 hw/pci-host/pnv_phb3_msi.c
>  create mode 100644 hw/pci-host/pnv_phb3_pbcq.c
>  create mode 100644 hw/pci-host/pnv_phb4.c
>  create mode 100644 hw/pci-host/pnv_phb4_pec.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/0ZNML3L+nUf91nU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4xJqUACgkQbDjKyiDZ
s5KCfg//dGYUL7Ute6lfI1m1/TlLqV2Mskc5ouCB+r0GEuU1v9LhXpIGFIHFOUwR
yfNkS7M1+kERFzr7XV8W5INWC2g3Pl3knD6mcNZ3HgcS/xW61m0Tb07PLNEkb7Sl
/4SQA1CLU4ncNRJyF/feP5aDA+nF4v9/6Rm0vfEkyvCR3/+nWUEkZZSfGH4TtkPw
vqn2O1v4RB6jZ+NY2hxTNOtRouUBHZ3rl0sx+QNZh+n3snE9X/fwtr96Mw39JLMy
XF2sQdJhXJ9v/wSkyol4oaakQkewdfIk2TzYJuzi+xZna9iRjfIVuE2CfvwAPeG7
MGkZmU44I1RDYRV1nR4vcSfX+w0z/P8jG98Xk03SQUYIQ7yS2uTyf4c5b+zjTrrU
MPlhDunt4hL+2LDaqD10uIunzoxqvY+A3h5kpNLy9mkktEKRtq81OZx3gUrhtYKk
0ueMt2CO5mnhP1goi18BBrx2mbNAExZ0a5cLqNwVoEveA00I1UGbk5UVbBv4XaEF
XdGwqtni1SRiJSkDHO6sJY7tdpvSH/RiVonfAFRJndNy/RYvXs0yoa4VgMZzvR4Q
wVJIl8xuSgMmRE7o5PSQNSXJiKDNne+UtG8MYpJGwCcVzey8JO6+GHrqJ+n5vTt2
MrygrLfp/mswN9l5wpfAOn6yeT7Ay9BYH8oWAHz5JHpINrWJCHQ=
=S9kl
-----END PGP SIGNATURE-----

--/0ZNML3L+nUf91nU--

