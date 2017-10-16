Received: from eggs.gnu.org ([2001:4830:134:3::10]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e47CB-0002zW-EU
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e47C6-0006Dg-PR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e47C6-0006Cp-Fs
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:20:42 -0400
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d957ed9-0430-927c-ec78-672c39f11682@redhat.com>
Date: Mon, 16 Oct 2017 10:20:38 -0500
MIME-Version: 1.0
In-Reply-To: <5548e41a5668ec0cba9543139327e035@hostfission.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QLbwHwDCq22tDCWiU7LmRkLhx3ws2s8A1"
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: geoff@hostfission.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QLbwHwDCq22tDCWiU7LmRkLhx3ws2s8A1
From: Eric Blake <eblake@redhat.com>
To: geoff@hostfission.com, qemu-devel@nongnu.org
Message-ID: <4d957ed9-0430-927c-ec78-672c39f11682@redhat.com>
Subject: Re: [Qemu-devel] ivshmem Windows Driver
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
In-Reply-To: <5548e41a5668ec0cba9543139327e035@hostfission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/15/2017 04:32 AM, geoff--- via Qemu-devel wrote:
> Hi All,
>=20
> I am writing some code that needs to share a block of ram between a
> Windows guest and Linux host. For this I am using the ivshmem device an=
d
> I have written a very primitive driver for windows that allows a single=

> application to request to memory map the pci bar (shared memory) into
> the program's context using DeviceIoControl.

Note that upstream support of ivshmem is rather lackluster.  Very often,
the first question in response to someone saying "I need ivshmem", is
"Why? and can we accomplish the same task using a better device
instead?"  Without knowing the full use case, it's hard to argue that
ivshmem is the right device to fit the use case.

There have been efforts to propose a better specified and better
structured replacement for ivshmem, such as vhost-pci, but I'm not sure
what status those patches are in, or if it would be a better fit for
your needs.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QLbwHwDCq22tDCWiU7LmRkLhx3ws2s8A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnkzkYACgkQp6FrSiUn
Q2pv4QgAhquQ9B6UMssKC4tIncMMhKYhw3sA/BHfeTdMtu3RDKHSLugLsg0LYqUE
jbMpeRHgcQhaWOGDO7vjJ8gfOfHmg3003QpIM5fO1r5IYbZigCEpCNYy3EIStj/I
L/E8Iy03rVB+PkU1Pk1v9Y0mX7XLeBYAY7xvb9SwWbdP9OTCTusOxBpaJf3gdI6a
50Inw1tRfjn8Hn0Jp+AYLueLT0Cd8hog391sfX+vsGDMgR9CGJshWw0MOuNRXkgW
2EGMFhPn3I8Rrksn8maXOCAn6V4FBinzxDX3fjMPgjYzQQT3fenSomXLP/NUpsQ2
E0tIfM8wxIeTJSGj6le6lH4FBea6eg==
=VJLT
-----END PGP SIGNATURE-----

--QLbwHwDCq22tDCWiU7LmRkLhx3ws2s8A1--
