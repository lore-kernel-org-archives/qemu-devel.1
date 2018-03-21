Received: from eggs.gnu.org ([2001:4830:134:3::10]:51620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eykb6-0000v9-PT
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eykb3-00081f-LV
	for Qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:44:36 -0400
Date: Wed, 21 Mar 2018 21:44:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321204420.GL3898@localhost.localdomain>
References: <20180321124417.29242-1-ptoscano@redhat.com>
	<20180321125105.GJ19514@redhat.com>
	<65a7365f-89d5-a66c-4e7a-ce8ae1bcf595@redhat.com>
	<2075074.dXtERdIzXi@thyrus.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <2075074.dXtERdIzXi@thyrus.usersys.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [Libguestfs] [PATCH] tests:
 regressions: make test-big-heap use a temporary empty file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pino Toscano <ptoscano@redhat.com>
Cc: libguestfs@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>, qemu block <qemu-block@nongnu.org>, mreitz@redhat.com, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.03.2018 um 14:48 hat Pino Toscano geschrieben:
> On Wednesday, 21 March 2018 14:45:38 CET Eric Blake wrote:
> > [adding qemu lists]
> >=20
> > On 03/21/2018 07:51 AM, Richard W.M. Jones wrote:
> > > On Wed, Mar 21, 2018 at 01:44:17PM +0100, Pino Toscano wrote:
> > >> Newer versions of qemu use file locking for the images by default, a=
nd
> > >> apparently that does not work with /dev/null.  Since this test just
> > >> calls qemu-img to get the format of an empty image, create a tempora=
ry
> > >> one instead.
> > >=20
> > > ACK, but feels like this is a bug in qemu-img to me.
> >=20
> > You're right that file locking on a character device like /dev/null is=
=20
> > not going to work as expected, but is it a case where fcntl() actually=
=20
> > fails, or is it worse where the fcntl() claiming the locks "succeeds"=
=20
> > but doesn't do what we want?  That is, what were the actual error=20
> > messages you ran into?
>=20
> $ qemu-img --version
> qemu-img version 2.10.1(qemu-2.10.1-2.fc27)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> $ qemu-img info /dev/null=20
> qemu-img: Could not open '/dev/null': Failed to get "consistent read" lock
> Is another process using the image?

Not sure where the difference is, but I can't reproduce this on
upstream, neither git master nor the v2.10.1 tag:

$ ./qemu-img --version
qemu-img version 2.10.1 (v2.10.1-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ ./qemu-img info /dev/null
image: /dev/null
file format: raw
virtual size: 0 (0 bytes)
disk size: 0

Also with strace:

open("/dev/null", O_RDONLY|O_CLOEXEC)   =3D 10
fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
=2E..

So my kernel (4.15.9-200.fc26.x86_64) seems to have no problems with
locking /dev/null.

Kevin

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJassQkAAoJEH8JsnLIjy/WqQ4P/RSqvnA/fNtVjPcpszdnMbNP
SS7ub/a3jq3m0l/8wXJewZs2pPTIE3qe7kysUv8Ej5jfFJZvF0nPTMb37gWxrbvG
4/hfk4RQFmuXUflIKJsZ/UoqWh2Z+xOTGQ2n53yqXYWDqnek2Ku4r32dMOFnGZGI
JLkyjo6MtbyJauiXuarHzUTmrPtlas0DhRm31U9ZLJ3uoGewc1cJevhKwy4J5hMn
Hk2R70Eni7+DzKgletrhGc3FgyFGHaslxzVgRZ7FNHkam63jY0/wEFPS+VriHFkV
R0YRM+zGDTS4a56J20+Dcqai+JMLDtCZkVZyz8D36BKqUp4rZr0CU0Qta0ecJ3kn
I4zI7lKclAzy4v0e8fdnOsxaG1+86BabQwYbovBPR/smnEAIpUqlopdu/GXLRNJJ
rovQMYF/t4QNsWAFEkx4eArJ+6UnG9Hf7HKkMVs21cKsqmR0NPGtYoOkTnxwn14E
fnyhH6MDkQpMkIeK16HA+rlpsVdWgnKmtMO6oc7BiMAlexDuMvGPgpMYV4WNjQGe
mm3y65tCfGRiT9FEsg5v0cYPr4wmqWkCLyyDE3p/zmRHqGipJVhTiAKZA7q6qmD8
SvFcpsjUhKsdPSKl6fVItMpMf9XY8UZdLjM7Nu4hli/JAcBIYFJzjgaHFxXmaH+2
ZygcGpXahXAq8NTNVEkX
=cy70
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
