Received: from eggs.gnu.org ([209.51.188.92]:52813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggt4a-0008Ip-83
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggt4Y-0001o6-46
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:13:44 -0500
Date: Tue, 8 Jan 2019 16:13:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108151309.GE11492@linux.fritz.box>
References: <20190103094728.31747-1-rjones@redhat.com>
	<20190103094728.31747-2-rjones@redhat.com>
	<cb7b80d8-e54f-5422-7029-47ee286dd25f@redhat.com>
	<741a5843-a47a-6a02-c378-b778f7ffe172@redhat.com>
	<f5aa2057-509b-28fa-d803-b18ca525ae73@redhat.com>
	<20190107184058.GN27120@redhat.com>
	<20190108121625.GA11492@linux.fritz.box>
	<b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <b6df06a8-4a68-e4ed-2101-d0e30759c8e0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: Reinitialize optind to 1 (not
 0) before parsing inner command.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.01.2019 um 15:51 hat Eric Blake geschrieben:
> On 1/8/19 6:16 AM, Kevin Wolf wrote:
> > Unconditionally setting optind =3D 1 looks fine. I would, however, quot=
e a
> > different part of the glibc man page (in addition or instead of the
> > paragraph you already quoted):
> >=20
> >     The  variable  optind is the index of the next element to be
> >     processed in argv.  The system initializes this value to 1.  The
> >     caller can reset it to 1 to restart scanning of the same argv, or
> >     when scanning a new argument vector.
> >=20
> > This makes it pretty clear that optind =3D 1 is fine for our case with
> > glibc. The FreeBSD man page still suggests that we need optreset =3D 1,=
 so
> > I suppose we'd end up with something like:
> >=20
> > ...
> > optind =3D 1;
> > #ifdef __FreeBSD__
> > optreset =3D 1;
> > #endif
>=20
> If you really want to set optreset for BSD systems, I'd do a configure
> probe for whether optreset exists, and if so set it for ALL platforms
> that have optreset, not just for __FreeBSD__.  (That, and checkpatch.pl
> will gripe if you don't do it that way).
>=20
> But I'm leaning towards not bothering with optreset UNLESS someone
> proves they have a case where it actually matters.

I don't mind either way as long as it works. Using optreset would be
following the spec by the letter.

In fact, I had already applied this patch because it's correct even if
possibly incomplete, depending on your interpretation, but I decided to
reply instead because the commit message didn't really describe that
optreset =3D 1 is correct for glibc, but that optreset =3D 0 is necessary in
some other case (which is irrelevant here). So the commit message was my
main point.

Kevin

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNL4FAAoJEH8JsnLIjy/W7lkQAL6qlVGr6lb9EINANrAZp4iR
uTBWk2BTiJfFBLDzBqnt/qDuJ/94YJqiSJVz8HqHeRYmFni5s+E+GO41ottaCCZB
vVQuIma3JLA/mVt0JOKL/6sgxm66HRyBy1ZamJA7eOrH7DXD27bpdvVBQYp6XO2S
Vhp90sFL31MOWi4MWGrsRY+JfSwio1+NUf9dA1TbqLEGSXsiQjdqjG0HmKuQ7YGq
X2wtAsAkFv+p3Dbdi0lIhWA3r3NvGRP96yxwmtHZ+C2v6SWgKQpwVSjDxcgYrNQF
H1bIVGGZT5OLk1P9wPaF/5XFXBjqm9uDqfTeIzJF4uajyG0mtSvcI4I7UzBRMwgd
q0q6nMmgeLU1e/aBSim6Ce25ddhz8am+h1Xc6Rwmk1DajKEdt89QbE9FyX1P/CGQ
ia6RJ2NQCidrHBME1gDjWZuJaqI62q1Vnl09NJ9QJRwfC0x+Xh7jiZgxAy6X2Li/
1ZJkxStIA2Hc+wR6gaeVGCb3ugYy3FgDAb+DA7byx31RFv0SRdfgtvtVdOWNNyYU
ex57GmfmghWmwLP5LL/WH6p0X8K1OKQDd4R8pbPKsNz/5b+LVbOoV+t8cA+pCj0L
DjH49mHBfiO6oP2ew+Ug6vYyeICw238O2eHdEvaDp1cGhAlQFC7uH+GF7r7f4DOf
GfnoheFNnNX3GAOBo+Mi
=kcaH
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
