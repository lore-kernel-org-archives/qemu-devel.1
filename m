Received: from eggs.gnu.org ([2001:4830:134:3::10]:56446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFN0n-0008OE-61
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFN0m-0003uy-7B
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:55:17 -0400
References: <20170529152316.27647-1-mreitz@redhat.com>
	<20170529152316.27647-2-mreitz@redhat.com>
	<27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
	<a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <683fd2c8-e98e-90e6-bf63-2b0e41236220@redhat.com>
Date: Mon, 29 May 2017 10:55:00 -0500
MIME-Version: 1.0
In-Reply-To: <a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PtmCAQSa8iL3p4hQ3ws21Q3toNGLX1Xuk"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PtmCAQSa8iL3p4hQ3ws21Q3toNGLX1Xuk
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <683fd2c8-e98e-90e6-bf63-2b0e41236220@redhat.com>
Subject: Re: [PATCH v3 1/2] iotests: Use absolute paths for executables
References: <20170529152316.27647-1-mreitz@redhat.com>
 <20170529152316.27647-2-mreitz@redhat.com>
 <27c8dfc9-cef6-9d55-195a-20ef3a9a85e9@redhat.com>
 <a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
In-Reply-To: <a412a3b6-37ec-f321-c6d6-aa754153cfe0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/29/2017 10:46 AM, Max Reitz wrote:

>> If you switch all of these to $(realpath -- "$(type -p "$QEMU_...")"),=

>> you can add:
>=20
> I'd love to, but this is what type -p outputs for me:
>=20
> $ type -p qemu-img
> qemu-img is /usr/bin/qemu-img

Huh? That's plain 'type' output.  Are you sure you're testing 'type -p'?

$ PATH=3D$PATH    # to forcefully clear bash's cache
$ type qemu-img
qemu-img is /usr/bin/qemu-img
$ type -p qemu-img
/usr/bin/qemu-img
$ qemu-img --help >/dev/null   # to repopulate qemu-img into the cache
$ type qemu-img
qemu-img is hashed (/usr/bin/qemu-img)
$ type -p qemu-img
/usr/bin/qemu-img

>=20
> So I would need to parse the result (and it depends on the locale). If
> that is indeed so, I'd rather stay with which, to be honest...

Plain 'type' does have to be parsed, but 'type -p' is required to be
machine-usable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PtmCAQSa8iL3p4hQ3ws21Q3toNGLX1Xuk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLERUAAoJEKeha0olJ0Nq9dAH/jW8C8OIpb6loMGPjqixKwMC
yDKzpQsHGsO1mFmIsQAUEVCyPQ8ZesyyuRDR81gEzHZNsrvAsIOwuab+oWidchm6
chkuV56/8NZYshFfHNymgSHmWbNzMk+g9RJfhN0brMmVJamWB6mSFipt3SOvrWK3
tUuf0oP8MlFpz2I+E4syysmD0qTyLVH8kx7YPGdaoCP0UPbi7ea3ATNhz2EUUgNy
J5Xo27tEDCcSJIQsBR1C+gOtOni4piERdEj7DT9QrWeq2YzaIchS/iNOq9yeNQBd
u5sfX+0FVFVu0uzGIcFUCg7ZdR6uvXdWXE7VL4M0MlKFl7T5W4HnVgGpXGAkIfg=
=8lJk
-----END PGP SIGNATURE-----

--PtmCAQSa8iL3p4hQ3ws21Q3toNGLX1Xuk--
