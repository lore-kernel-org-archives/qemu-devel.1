Received: from eggs.gnu.org ([2001:4830:134:3::10]:43030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fED67-0002KK-1f
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fED63-0007Rp-T4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:12:31 -0400
Date: Thu, 3 May 2018 21:59:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503115909.GA13229@umbus.fritz.box>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-9-david@gibson.dropbear.id.au>
	<0d815d7c-42de-c89e-4481-21b32e04ed7c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLk8PSyqxe/ugcCT"
Content-Disposition: inline
In-Reply-To: <0d815d7c-42de-c89e-4481-21b32e04ed7c@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 8/8] spapr: Clean up handling of LPCR
 power-saving exit bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com


--SLk8PSyqxe/ugcCT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 09:47:18AM +0200, C=E9dric Le Goater wrote:
> On 05/03/2018 08:21 AM, David Gibson wrote:
> > To prevent spurious wakeups on cpus that are supposed to be disabled, we
> > need to clear the LPCR bits which control certain wakeup events.
> > spapr_cpu_reset() has separate cases here for boot and non-boot (initia=
lly
> > inactive) cpus.  rtas_start_cpu() then turns the LPCR bits on when the
> > non-boot cpus are activated.
> >=20
> > But explicit checks against first_cpu are not how we usually do things:
> > instead spapr_cpu_reset() generally sets things up for non-boot (inacti=
ve)
> > cpus, then spapr_machine_reset() and/or rtas_start_cpu() override as
> > necessary.
> >=20
> > So, do that instead.  Because the LPCR activation is identical for boot
> > cpus and non-boot cpus just activated with rtas_start_cpu() we can put =
the
> > code common in spapr_cpu_set_entry_state().
>=20
> This is much nicer.
>=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> and for the patchset :
>=20
> Tested-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> under KVM & TCG with cpu hotplug and unplug.

Thanks.  I've folded the series into ppc-for-2.13.

> There is still a spapr_cpu_reset() call under spapr_cpu_init().
> Is that on purpose ?

Sort of.  I'd still like to remove it, but figuring out how to do so
safely is going to take a bit longer.  Well, probably quite a lot
longer, since I doubt I'll get it done before I go away.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SLk8PSyqxe/ugcCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrq+YoACgkQbDjKyiDZ
s5JnPQ/9HienOKF4i36vCFEGiX48mObk2JGGwXQ4yryd4oJ8go40tGqMm8K3jJ4K
nzUT5gldjNjEjs9ZOYpN059pv78unkooWfvKY1UIyAGNvtx/8TOwvD2MNWEmi7uc
JrlnVX9mfjGoJwlUg1iKuLwwTQxUzcUt9qEqoepFCLRrDwnK1U5nmOTXOrsnAN3o
xYe7eaftaa6bl57dHBOK7FYhDVK8Q/LGrX13RGhcgKMCw9AwVjVl3WxIROlwQQ69
3AWgJRDx8Lfnvi4NL91WAT6ED4S4rf1g2KU0YbQzGUsXrgIRRCdPTo0qt7TmYsRQ
Lixz4KCBqPeTry+gDlqAQ7iQvWS3dDTYqzaEpuI+cTtNHUFdJTGdIKXtXi0lgF+2
L5v7ZrZWQ7rjdal5xvwxU1ZCymDKUQAAL6bKwd2efNY8VJtQY6t+qA2g1bNyYZOX
eLip/M2hB4/A8YnNSfGDsYDw269EsNTbF3i/tomlqxYBpZG648480Q1y+IaDt2LP
SBLxE3Pjep2pdLRdrBpCD5C+59xkWjpbzPVctQjlUC4UyXrrLB/bIVLRiap6R8Bx
dzawbbMqlW9jBfqUrUDtJBt8appezttX9xT+2C1FMmUjm/rb/BhsO6jrrVSlLk4/
05oOt2IzRKVrgBOjE62gXze8Gge/Oq8JqqATXvKstqBG+IJmuuc=
=+/yl
-----END PGP SIGNATURE-----

--SLk8PSyqxe/ugcCT--
