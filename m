Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4UmP-0001eR-5A
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4UmO-0000JA-6c
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:04:01 -0400
References: <20180406164108.26118-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <edb3c0fd-c1fd-e9ba-e081-eef19297f3c7@redhat.com>
Date: Fri, 6 Apr 2018 12:03:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180406164108.26118-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SntvYZZ6BzHwtEGBqRZMBazS6jMXsl3wI"
Subject: Re: [Qemu-devel] [PATCH] iotests: Split 214 off of 122
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SntvYZZ6BzHwtEGBqRZMBazS6jMXsl3wI
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <edb3c0fd-c1fd-e9ba-e081-eef19297f3c7@redhat.com>
Subject: Re: [PATCH] iotests: Split 214 off of 122
References: <20180406164108.26118-1-mreitz@redhat.com>
In-Reply-To: <20180406164108.26118-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2018 11:41 AM, Max Reitz wrote:
> Commit abd3622cc03cf41ed542126a540385f30a4c0175 added a case to 122
> regarding how the qcow2 driver handles an incorrect compressed data
> length value.  This does not really fit into 122, as that file is
> supposed to contain qemu-img convert test cases, which this case is not=
=2E
> So this patch splits it off into its own file; maybe we will even get
> more qcow2-only compression tests in the future.
>=20
> Also, that test case does not work with refcount_bits=3D1, so mark that=

> option as unsupported.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Kind of a v2 for "iotests: 122 needs at least two refcount bits now"
> (fulfills the same purpose, but also splits the case into its own file
>  so you can still run 122 with refcount_bits=3D1 [Eric]).
>=20
> I was a bit lost what to do about the copyright text, since this test
> case was written by Berto.  I figured I'd drop the "owner" variable (it=

> isn't used anyway), but I put "Red Hat" into the copyright line --
> currently every test has copyright information, so I decided it'd be
> difficult to leave that out, and I figured I simply cannot claim
> copyright for Igalia.  So, here we go.

Yeah, you'll want Berto's Signed-off-by if you tweak that line, or at
least his Reviewed-by otherwise :)

But you can have mine,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SntvYZZ6BzHwtEGBqRZMBazS6jMXsl3wI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHqGoACgkQp6FrSiUn
Q2oCEAf/RtpoX9oNzDyg5JZeMeXo+A/Mwya9TTmMMYminfmYTwtFoOaje9USLg0i
mx6U5+p8XIccdiLod79e2vSVSNA8KIboaROUCCC6h2I7POStlLGG1ihjR6LmbE4F
J0F2r//iQp0snstehLh1hGlgs5XkT/dv+2nMUJzm9iWN7KGRz7TvGYpEEeBHKwUP
1G+4mcNV5CjKV4m25hgAFCMEuQM3BJw+xAr5Pe4sZ0GLC9o0C8R7K7JohXMY0w25
jCaMZbB2bDFpYhlGI0ghG775HAFL16kay3iKJ3gHL3nwmLH8eBkEdMjuxX6LIvPr
0ViUEP6Vca3CNFMi6FH5aI7FwcgQ3g==
=x3bY
-----END PGP SIGNATURE-----

--SntvYZZ6BzHwtEGBqRZMBazS6jMXsl3wI--
