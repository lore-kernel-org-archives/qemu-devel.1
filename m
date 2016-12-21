Received: from eggs.gnu.org ([2001:4830:134:3::10]:43216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJZjR-0003mM-QW
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 00:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJZjO-0000Vm-OV
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 00:46:29 -0500
Date: Wed, 21 Dec 2016 15:52:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161221045245.GE13024@umbus.fritz.box>
References: <20161215061128.30792-1-david@gibson.dropbear.id.au>
	<1482160529.3732.2.camel@redhat.com>
	<20161219234717.GG23176@umbus.fritz.box>
	<1482225561.3732.12.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <1482225561.3732.12.camel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 for-2.9 0/6] HPT resizing for
 pseries guests (qemu part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2016 at 10:19:21AM +0100, Andrea Bolognani wrote:
> On Tue, 2016-12-20 at 10:47 +1100, David Gibson wrote:
> > > Do we want to expose a knob for controlling this
> > > to the user at the libvirt level, or should we just enable
> > > resize-hpt unconditionally whenever we detect that the QEMU
> > > binary supports it?
> >=A0
> > I'm not sure if we need a knob.=A0=A0I think in general enabling for
> > pseries-2.9 and later machine types is correct.=A0=A0The difficulty is
> > that for HV guests, we can only enable it if the host kernel also has
> > support.=A0=A0Explicitly setting "resize-hpt=3Denable" means qemu will =
not
> > start if the kernel doesn't support it.
>=20
> I thought that would be the case for resize-hpt=3Drequired,
> not resized-hpt=3Denabled.

resize-hpt=3Denabled requires the host to support resizing, but not the
guest.  resize-hpt=3Drequired requires both the host and the guest to
support resizing.

If you can think of a less ambiguous word for it, let me know.

> > My inclination would be to enable unconditionally for pseries-2.9 and
> > later machine types.
>=20
> So I guess the question is, will users want to enable this
> manually for older machine types, or is it reasonable to
> expect them to simply switch to pseries-2.9 if they want
> the feature?

I can't see any particular reason you'd enable it on an old machine
type.

> Moreover, do you foresee any situation in which users
> might reasonably want to turn the feature off even though
> the entire stack (host kernel, QEMU, guest kernel)
> understands it?

Nothing clearly compelling.  In the nearish term, being able to turn
it off to isolate possible bugs could be useful of course.  It's also
possible that you could have a VM where the latency of each resize
could be too much downtime - although in that case I doubt you'd want
to hotplug memory anyway.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYWgqYAAoJEGw4ysog2bOSbWIP/AisdTx4opP0yeu9qKy3gs/h
ZE8PnJ9pJHJJVF+Vrh6mIOqqFkFSPg/rhVKzhEKhgYARVVk6zUoM7wq9xAUm9MyE
hYER09x7ykEbbehvPZVI+GvM7vTkNiPAee8WgFE/HwczSHuXM1GNjeg2JS4Y9bNF
Qx/NJIJ4IrVADX2N6WQyYDu16943cuL37K+5sE9VrXcgnsUSzpLXjpyRudxuS+k2
ybtLTNRsrFX/USTKpZJpugh7AyrYLrwfhBJDV6sgAnwsV+rWwzIlfRXO/carJBS3
I1r0ta34ui8lQ6FVhHGef4GabHqRQz7JVuKkvCvMDtB2yBmy8jr9/pABTAzFenvR
mKPOIPaFMFGpZQrrMJ1pldWdnPpHDjUyGL3p4AYlNkDKIMv/kI70JapBWB/PDAzB
gkSPA/2U7k4UQojD2+EnhpVsSn9Gpu1csUGSh+UK7xnq0CDl/U5g9eMHVcNLB9W0
BSGI0Cgi/D3KU4dVigeTvOy3BvT22OXf3WKgmuO5uvAOk41luVSNI4rlGkJdkSXo
nxiNE6EGMfnSUjULfOWibsgEfkwuJQOz/lcm/NvQSOFp2yI2oRB2n2yZ5zcEZ+Ue
GCulnG4HNY8uGWxhL0wcD49y+undR4x4k0enKv78+16uZ/rPYk1nzsCNqsJ5DK1c
NFdeSo6/6Zg1iqszPnxJ
=gPJO
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
