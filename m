Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EFC04AB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D93320840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VjxFZdPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D93320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ2xm-0003ih-L0
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 20:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2uu-0001zG-Bd
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2ut-0003m6-3T
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:39:36 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hZ2ur-0003eR-Lu; Thu, 06 Jun 2019 20:39:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45KkDt1RvXz9s9y; Fri,  7 Jun 2019 10:39:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1559867966;
 bh=OditJNTHbMeC3PlNwYr9CXp7VPDlxTmGXH7n1UdQZP8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VjxFZdPeK09J0RaoOyK+cdkKVlSSLe0Uc/nG++S7a3wvNySiawLU4C8f5dCNKIHTZ
 PGgdrb6OTmFrVusPkRQVj7YmWQtCC50zhbA/EDHkSsR1Ww4XkHPlrsPS35aj2Nz5Ap
 UV/JlxNG83SUzkBxp7Emv38+ei5mvomA5YcwgIPU=
Date: Fri, 7 Jun 2019 10:22:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190607002240.GD3760@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
 <155910845769.13149.8097972239187020170.stgit@aravinda>
 <20190606030614.GK10319@umbus.fritz.box>
 <20190606080609.28b4dd15@bahia.lab.toulouse-stg.fr.ibm.com>
 <9a4291d3-2ae6-92f3-6922-e8924398cdb7@linux.vnet.ibm.com>
 <20190606141048.01e7d6be@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20190606141048.01e7d6be@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v9 6/6] migration: Include migration
 support for machine check handling
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 02:10:48PM +0200, Greg Kurz wrote:
> On Thu, 6 Jun 2019 16:45:30 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>=20
> > On Thursday 06 June 2019 11:36 AM, Greg Kurz wrote:
> > > On Thu, 6 Jun 2019 13:06:14 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > >> On Wed, May 29, 2019 at 11:10:57AM +0530, Aravinda Prasad wrote: =20
> > >>> This patch includes migration support for machine check
> > >>> handling. Especially this patch blocks VM migration
> > >>> requests until the machine check error handling is
> > >>> complete as (i) these errors are specific to the source
> > >>> hardware and is irrelevant on the target hardware,
> > >>> (ii) these errors cause data corruption and should
> > >>> be handled before migration.
> > >>>
> > >>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> > >>> ---
> > >>>  hw/ppc/spapr.c         |   20 ++++++++++++++++++++
> > >>>  hw/ppc/spapr_events.c  |   17 +++++++++++++++++
> > >>>  hw/ppc/spapr_rtas.c    |    4 ++++
> > >>>  include/hw/ppc/spapr.h |    2 ++
> > >>>  4 files changed, 43 insertions(+)
> > >>>
> > >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >>> index e8a77636..31c4850 100644
> > >>> --- a/hw/ppc/spapr.c
> > >>> +++ b/hw/ppc/spapr.c
> > >>> @@ -2104,6 +2104,25 @@ static const VMStateDescription vmstate_spap=
r_dtb =3D {
> > >>>      },
> > >>>  };
> > >>> =20
> > >>> +static bool spapr_fwnmi_needed(void *opaque)
> > >>> +{
> > >>> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> > >>> +
> > >>> +    return (spapr->guest_machine_check_addr =3D=3D -1) ? 0 : 1;   =
=20
> > >>
> > >> Since we're introducing a PAPR capability to enable this, it would
> > >> actually be better to check that here, rather than the runtime state.
> > >> That leads to less cases and easier to understand semantics for the
> > >> migration stream.
> > >> =20
> > >=20
> > > Hmmm... the purpose of needed() VMState callbacks is precisely about
> > > runtime state: the subsection should only be migrated if an MCE is
> > > pending, ie. spapr->guest_machine_check_addr !=3D -1. =20
> >=20
> > spapr->guest_machine_check_addr is set when fwnmi is registered. Hence
> > an MCE might not be pending if it is set.
> >=20
>=20
> Oops sorry, got confused... should have written "if the guest has
> registered FWNMI", but the idea is the same. We only need to migrate
> the subsection if the state is different from reset. This is the way
> needed() callbacks are generally implemented.

Yes, but usually that's because we need to omit the section if it's
not actively in use in order to maintain backwards compatiblity with
old migration streams.  If the cap is enabled we already need
something that implements it at both ends to have a sane migration.

> > I am fine with both the approaches (checking for
> > guest_machine_check_addr or for SPAPR_CAP_FWNMI_MCE).
> >=20
>=20
> I would find ackward to migrate this always for new machine types,
> even if the guest doesn't register FWNMI...

How so?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz5rlAACgkQbDjKyiDZ
s5LUfg//WX1X9vVmYD9A4mabdZGHJTYjKh9+yEss2WqPoVAOfMg7KZYsdaxrBBK9
OHbHam5SGi8lIhhi73NVq2bgf82/ul1a6eFQUMTMPh+EcVXEr4K46u1EcUwuMyJj
HJKMmqiR/Tc1V6zJ2Ry1EiV5GjvnZR4l6WjxP2UPL2nIeMI4K5YbkCVJfFltgMBV
dOm7enJ9PCc92abAwQNmDWarrKeic2R+S5oGeHPlYKTRLWj2V/ymbTw0FkNqfOyG
P4duwNemrtLZNE9a+cC4ZBNWBs4J3HAf7xvEx0CL9DpudnGfa1w1bKyWskL/Dswa
tDkHG7jzrN+jInxXXSsvmzjnyOe5cE5uDaKw9EYVHKOyh88ZkMJhgMCFNNjLuEFW
Y0ivzXXbi2sb8Wydu0Q3f4wsS9FDTzdk6L2e0bDXv+vdeuZABLV4e37ANZgER/Zd
4hNseeX4XYpcg5jbva67pzpyTKY7E5wbhXD0pP1oQY8iSPIJraW9CJlJWCRUfOKM
kmYqfZkGRng5HXq7pfgGEGmhqdv8Cbqm6uhpUWV7veh6lzEMvR2aRqHL4e4fT3no
7hGUwP171Xo7phEEgSV0sZhm0NSV4c7L88vMpoXnBb54OdqMhnqgVUGPNkMv+d+0
gA3vnbqVTkOsJJcmtLI3Z6Mkz6NdtfR3ahHxCfamNwVnpMY/zK8=
=is3W
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--

