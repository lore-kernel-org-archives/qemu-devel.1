Received: from eggs.gnu.org ([2001:4830:134:3::10]:48962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edweh-0000iz-8i
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edwed-0008R2-A5
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:22:19 -0500
Received: from ozlabs.org ([103.22.144.67]:36809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1edwec-0008Q7-Ta
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:22:15 -0500
Date: Tue, 23 Jan 2018 22:20:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180123112025.GI11419@umbus>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
	<1516372482.3278.29.camel@redhat.com>
	<1516702111.31897.2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <1516702111.31897.2.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 11:08:31AM +0100, Andrea Bolognani wrote:
> On Fri, 2018-01-19 at 15:34 +0100, Andrea Bolognani wrote:
> > > > This won't solve the libvirt problem we were discussing, because it
> > > > needs an existing instance of the object.  libvirt wants to know the
> > > > machine properties *without* instantiating an instance.
> > >=20
> > > My patch works with types, it creates an instance for a short time it=
self,
> > > this is why it does not do a thing for "pseries" as it is not a type =
and
> > > prints properties for the "pseries-2.12-machine" type.
> >=20
> > Yeah, I took this for a spin and can confirm that it's pretty much
> > exactly what I was thinking about. The fact that the QMP command
> > instantiates objects behind the scenes is not an issue, at least
> > from libvirt's point of view: device-list-properties does the same
> > thing and we already use it quite happily; what matters is that we
> > can call this, along with all the other capabilities-collecting
> > QMP commands, in one go and on a single QEMU instance.
>=20
> David, I know you're busy with linux.conf.au, but it would be
> really helpful if you could carve out five minutes to look over
> Alexey's proposal again, with my reply above in mind, and let us
> know whether it looks a reasonable design. Doesn't have to be a
> review, just a quick feedback on the high-level idea.

It looks ok, I think, but I don't think I'm really the right person to
ask.  I do wonder if creating a throwaway instance could cause
trouble, especially for something like machine that might well have
gotten away with having global side-effects in the past.  I think we
need to talk with someone who knows more about qom and qapi - Markus
seems the obvious choice.

> I'm moving forward with the libvirt implementation of pSeries
> capabilities and I would have to start implementing support for
> this new QMP command, well, pretty much... Right now :) But I'd
> rather not start at all if I'm just going to have to scrap
> everything later.

Yeah, unfortunately because its part of the core infrastructure, not
power specific, this isn't something I can make call on.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpnGnkACgkQbDjKyiDZ
s5KkbxAAs6rvA0juI/ZA3dOer6t9HiLmdj6nZc2tgs7AKe232BtOPBiexT6FhSN3
3r0qkKG0KN1AvINZeJ94y5KdRT3WNkcY+rzDvMu7Zrll62j51Ljv9TzxeLQys/Gw
W/LC5wvUyLEKpVEbqoxQ2VNTBv560H2b3cZsYROqFltArOvWyI6WP1LXmjMhCCOs
wABZe4sUJh10GTXKHmxvnbg2sPkqORkz9E8EQ7Q+GkaGelPHq85yYKFRIRFhA/ea
z5qY8yWftFwFb5vBnKpOLUL3CkA7VAXxyl3GKQwKWNyW2ab51zZ+0pIGP69596uT
jSLVr5DGt4LYOoa11sMk7HnnBZjdVY5Lww+5qs0NHKUvdHO+uiIwrt5KO8E47yU6
Bb3YcUjBvbVKd5a//VrwDYjC0aw7MpVLTyla2rsxMiBv6zOEmS1/u95sesxV3Ahb
lyQPN8a8MsIWEBOEo97Q0o77yeR19ne1q3bTlrEFwrzhawoIOyH0XgOucnaZK745
UrPz+qnSVeEvu3+hJUUkQLYA7++gz87eHMU9qNqZP9d7hNYKsJ1qMwCSNaU+IYhv
Cr3hhANiiNSkCi+XIFYXVBgTjCzio4e0e+8VkXIrLZe+IDxrWGz2wuTZyk6/KLtk
vz6QrLy2acqRqyG5I5WHvLek5a2DO0aFiFSY5+BcZS75mhM2nGI=
=NHl8
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
