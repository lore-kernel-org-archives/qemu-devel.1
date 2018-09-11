Received: from eggs.gnu.org ([2001:4830:134:3::10]:51010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzeh5-0006DS-4s
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fzeh1-00079T-MF
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:10:46 -0400
Date: Tue, 11 Sep 2018 11:10:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180911091005.GA3994@localhost.localdomain>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180910151848.GJ4901@dhcp-200-186.str.redhat.com>
	<a043566e-f794-5be0-b0dd-29490f735486@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <a043566e-f794-5be0-b0dd-29490f735486@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.09.2018 um 18:51 hat Max Reitz geschrieben:
> On 10.09.18 17:18, Kevin Wolf wrote:
> > Am 09.08.2018 um 23:34 hat Max Reitz geschrieben:
> >> Once more, I=E2=80=99ll spare both me and you another iteration of the=
 cover
> >> letter, so see here:
> >>
> >> http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html
> >>
> >> (Although this series no longer includes a @base-directory option.)
> >>
> >> In regards to the last version, the biggest change is that I dropped
> >> backing_overridden and instead try to compare the filename from the
> >> image header with the filename of the actual backing BDS to find out
> >> whether the backing file has been overridden.
> >>
> >> In order that this doesn=E2=80=99t break whenever the header contains =
a slightly
> >> unusual (=E2=80=9Cnon-canonical=E2=80=9D) backing filename (e.g. =E2=
=80=9Cfile:foo.qcow2=E2=80=9D or
> >> =E2=80=9Cnbd:localhost:10809=E2=80=9D instead of =E2=80=9Cnbd://localh=
ost:10809=E2=80=9D, i.e. something
> >> different from what bdrv_refresh_filename() would generate), when the
> >> reference filename in the BDS (auto_backing_file) is used to open the
> >> backing file, it is updated from the backing BDS's resulting filename.
> >=20
> > This doesn't seem to apply cleanly any more.
>=20
> I know, but is that a "Please send your current v11 to the list"?

Depends on how urgently you want me to review this. I don't like
reviewing patches directly from emails, without being able to apply
them.

Or maybe if you just can give me the commit ID this is based on? I
wouldn't mind applying it to an old tree as long as I can apply it
somewhere.

Kevin

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbl4ZtAAoJEH8JsnLIjy/WFMIP/0PyehY4HTH/jt/pvHJK4WjO
h1BQIg+Tr3GMg+8C22uy4XDZsmYwOQooxbDpj0kXhXwjAJvV1WyYK4PFtypHiQnt
3v71/ax25JnVHFolRomO/j20iCbrPNkahGyJVzv6yKB690EIxsk/Adr+xNrSNZnd
W5DPs2UqA6PWSbP7FABFzMsHLJnXqfXZ4Fe6/Cm9hst1RQwrZ9O8ufP3z2mzx7aG
LBP1qOdNjuZvWbk4R3oq+unxlPSSNY0K3bXFJ95TTMC4+pydQuPzaIWUmLyTBtyf
TO1mLB2/4Ixn3yjjvxvSm3RBzxCV0o7csHNduxMU+Loy+8o5gW7EfzF6TzFZciP4
rAzwE9mFaVooEJ1ugB8nMifvVypHo1Mfa6slwOxl3nqJ9AjwlIFmEIfZ8ss3XZMD
zudeAMZNsWzfCegeZjnCybYGWhU+7ABeb4uddlkl0vPkVABZzUPOuFen/YQwJ3UU
/VZQszXFOhL4ZHmyz+FAPHopDCnawO2hbUbHw9SWQYGRV/FySO+bGdjzXh9U8ALF
QR4gnurYZ23bW2+DdVo8SgRhHgFGWGW71H2V6UeDt/wyHzx9gQuHbU+vn0xjZWFX
+6TLzZe4CrG7SwJrKYX1Ntccy3ues/NjyCPI0x/vgzRTd5R89K+dsH4b/tH9Zy6e
JYaf94QvZZeNqTtmBz6C
=nPrX
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
