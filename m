Received: from eggs.gnu.org ([2001:4830:134:3::10]:35435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqrWR-0000Iu-1i
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 21:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqrWQ-0002O7-0o
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 21:58:55 -0400
Date: Sun, 10 Sep 2017 11:40:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910014015.GV2735@umbus.fritz.box>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uOZhbHG+Ruum37TI"
Content-Disposition: inline
In-Reply-To: <150496954641.9654.1998704077006846521.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH 0/5] spapr_pci: various cleanups and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--uOZhbHG+Ruum37TI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2017 at 05:05:46PM +0200, Greg Kurz wrote:
> Before resuming the huge work on PHB hotplug, here are some patches
> that maybe worth to apply.
>=20
> Patches 1 to 3 are basic improvements.

I've applied these to ppc-for-2.11.

> Patch 4 and 5 may be a bit controversial. Everywhere in the spapr
> code where we build an FDT portion, libfdt failures cause QEMU to
> exit, even on hotplug paths. Only spapr_pci doesn't do that and
> propagates the error instead. My understanding is that a failure
> when building the FDT is likely to happen because of a bug in QEMU.

Still looking at these.

>=20
> Hence the choice to convert spapr_pci to do like the others. We may
> even consider changing _FDT() to abort() instead of exit().
>=20
> Alternatively, if libfdt failures shouldn't be necessarily fatal,
> especially on post-realize paths, then we should probably introduce
> an _FDT_ERR() helper to propagate errors. And use it in may places
> where we currently terminate QEMU: memory hotplug, CPU hotplug, CAS,
> machine reset...
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uOZhbHG+Ruum37TI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0l/sACgkQbDjKyiDZ
s5Ki/Q/4kR9XyLcaiN5/0H6QHlk2QEBvpUSPpMiT79h5hqQFVm/PXfB4xLUYxz8e
MLAdFwxoJ4gK8W3/hFHmpHuHBBCLqj/iKsbGkJo3sLIRgwIzbGmpMXT3ITTVWqCF
hSneZ/DRUETot1DtXSalIlkJZHcJw5/ZxOBfJI+p+teoUcvUPdpJltyM6KkQaTN2
f4FpfHl2Vqnv6uVz07eEYXVx1QQuxEGCJN9rhSz+lPOt0XmadafGdL0NreOWFUjf
mzzqUWYbxGXA+qmd8D0bMqrRN0mqG/B0Rn9zOEGrA/PglE41sLl+6zVOP8a/TCPz
rVoNpXTRRoEHgkKr6wA/Mu1yj7NCDADDyT0lyWpYNu8sXclnPf+856wf/asjF7yy
XSailkY90l/12bDH0cR1lXhF6ckhIqdrSe29Tlq+5ChtJLZf/T4kbm3/VKAYIh6p
kC/s6GoQdbp4gSxCcLzufpQZBj1rfMI7joQWZEBY5RYgzNAhnLvlb8Yy4gDP9hgu
TumUjCcKI7eAYizMpZ/kg967egyQMxR6Tpwwt9D4j/rXDfCFsC+ptiHBO43+7djg
bFUOaoKbaQjZgGjmwROyLt7ieKeZYqIXrq3lApk6c3p2Zk5A2s0JiFOfCboE10kg
1ZVjnwyScmwQ/AwkSxRE0dv57WKoL2Wc4Itmwfw2KUOw8afeaw==
=UZzK
-----END PGP SIGNATURE-----

--uOZhbHG+Ruum37TI--
