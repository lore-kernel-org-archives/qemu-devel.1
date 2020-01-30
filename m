Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD0AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76955214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZDxgQrsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76955214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJc7-0002du-ID
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixJb8-0001Kl-UZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixJb7-0000BT-6V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:51:46 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46965 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixJb6-00006Q-8i; Thu, 30 Jan 2020 18:51:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 487xvw5vhFz9sPW; Fri, 31 Jan 2020 10:51:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580428300;
 bh=V5H4XMQoUqe+XDP5P4Tl83JigQAeZX4iXaO1VkHJa/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZDxgQrsPoJ5C5XNDbRL5rbgbepoFeXxbIjfdQRbkX8aZA1vFBtL9q5CXm/hYVeRUS
 Q6og5Q5VxN9lmyb1UEPO8Jp7aqNGFgFKkjacEHnGMwtfq+bIHC3H0JwMpqXCNeWwi/
 dyKEjmdby1g0PIDYvyahcToQcg+z6krE69eORN5w=
Date: Fri, 31 Jan 2020 10:39:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v21 0/7]target-ppc/spapr: Add FWNMI support in QEMU for
 PowerKVM guests
Message-ID: <20200130233906.GA15210@umbus.fritz.box>
References: <20200130184423.20519-1-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20200130184423.20519-1-ganeshgr@linux.ibm.com>
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2020 at 12:14:16AM +0530, Ganesh Goudar wrote:
> This patch set adds support for FWNMI in PowerKVM guests.
>=20
> System errors such as SLB multihit and memory errors
> that cannot be corrected by hardware is passed on to
> the kernel for handling by raising machine check
> exception (an NMI). Upon such machine check exceptions,
> if the address in error belongs to guest then KVM
> invokes guests' 0x200 interrupt vector if the guest
> is not FWNMI capable. For FWNMI capable guest
> KVM passes the control to QEMU by exiting the guest.
>=20
> This patch series adds functionality to QEMU to pass
> on such machine check exceptions to the FWNMI capable
> guest kernel by building an error log and invoking
> the guest registered machine check handling routine.
>=20
> The KVM changes are now part of the upstream kernel
> (commit e20bbd3d). This series contain QEMU changes.

Applied to ppc-for-5.0.

>=20
> Change Log v21:
>   - Use error_setg() for failure handling in apply hook.
>   - Report warning if FWNMI enabled for TCG.
>   - Enable FWNMI by default for machine type 5.0.
>=20
> Change Log v20:
>   - Remove code left over from previous version.
>=20
> Change Log v19:
>   - Create error object for migration blocker in machine_init().
>   - Remove the check to see fwnmi calls are already registered,
>     which is no longer needed.
>   - Register fwnmi RTAS calls in core_rtas_register_types() where
>     other RTAS calls are registered.
>   - Bail out from interlock call if the cap is not set.
>   - Reorder and add missing S-O-Bs.
>=20
> Change Log v18:
>   - Dynamically create the Error object before adding it as blocker
>   - In apply hook check if the fwnmi calls are already registered and
>     if kvm supports fwnmi before registering the fwnmi calls.
>   - In rtas_ibm_nmi_register() test the feature flag before attempting
>     to get the RTAS address
>   - Introduce a bool member "fwnmi_calls_registered" to check if the
>     fwnmi calls are registered and use the same in needed hook to save
>     the state during migration.=20
>=20
> Change Log v17:
>   - Add fwnmi cap to migration state
>   - Reprhase the commit message in patch 2/7
>=20
> Change Log v16:
>   - Fixed coding style problems
>=20
> Change Log v15:
>   - Removed cap_ppc_fwnmi
>   - Moved fwnmi registeration to .apply hook
>   - Assume SLOF has allocated enough room for rtas error log
>   - Using ARRAY_SIZE to end the loop
>   - Do not set FWNMI cap in post_load, now its done in .apply hook
>=20
> Change Log v14:
>   - Feature activation moved to a separate patch
>   - Fixed issues with migration blocker
>=20
> Change Log v13:
>   - Minor fixes (mostly nits)
>   - Moved FWNMI guest registration check from patch 4 to 3.
>=20
> Change Log v12:
>   - Rebased to latest ppc-for-4.2 (SHA b1e8156743)
>=20
> Change Log v11:
>   - Moved FWNMI SPAPR cap defaults to 4.2 class option
>   - Fixed issues with handling fwnmi KVM capability
>=20
> ---
>=20
> Aravinda Prasad (7):
>   Wrapper function to wait on condition for the main loop mutex
>   ppc: spapr: Introduce FWNMI capability
>   target/ppc: Handle NMI guest exit
>   target/ppc: Build rtas error log upon an MCE
>   ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS
>     calls
>   migration: Include migration support for machine check handling
>   ppc: spapr: Activate the FWNMI functionality
>=20
>  cpus.c                   |   5 +
>  hw/ppc/spapr.c           |  60 +++++++++
>  hw/ppc/spapr_caps.c      |  28 ++++
>  hw/ppc/spapr_events.c    | 269 +++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_rtas.c      |  87 +++++++++++++
>  include/hw/ppc/spapr.h   |  25 +++-
>  include/qemu/main-loop.h |   8 ++
>  target/ppc/kvm.c         |  24 ++++
>  target/ppc/kvm_ppc.h     |   8 ++
>  target/ppc/trace-events  |   1 +
>  10 files changed, 513 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4zaRUACgkQbDjKyiDZ
s5KDfhAAhwQF7Kdx95uWFF5sStrjcluD08f0X1bs/i4Ib1VcKwUCFVEmNcWSMYHH
oxamdP0fgO/Ct/iCT9cUon2x9nAdfh/pB35qSv7qjLVeObfrpo48ToVX7VfeRTui
ZGAxFUb1rR0rjRZK4s061oC88loAVg87v1AchruHP2+XwSIUMgaEdfDylKuWXiLT
zCp7eJrBQ1UHipGV+GMjBYDYpdxgUzQfVlZ0bE5ynErh/tq6U/UpivXsLTETWcuT
Utbc7ruZKTaBONsPSfVTYolXzQ1p5AainyTl5f8XmWsz3Ria9zsfnbSDdTC98dml
85uLPkWLOPnkKUAMipA57tQAFTOS9qhrRzwtUVEISgscPd0FloOVDCf/4Cm70et1
/I+YIXQ+G0XyzuAYhrL1wPcaN9vaLBR0tQuNcRFszZN70dfQXqcXFEuJSj8kZAQB
0Ty9HIHtPfLOx8glniEc4Cs8M+xkcqXy4yEpK557uqmAUzzX1bFh96XQ8+mQmSN9
+OEumRUFaIEcZiPGA7Sqm3IchjEtyRhOBFtX1EB7VVNI4owXqgGlxup+/Z73U0Iu
ZG7i/yQerhWI72Ncp9XquJmivb7XamAOJTDcjw47yjoSYehXZVyETn3lK3llGgGa
0rtoN87olmD2gfjBUQ45p8Df03CEUU3UBosYTIYMp9B5bD3Du9s=
=sYJV
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

