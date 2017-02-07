Received: from eggs.gnu.org ([2001:4830:134:3::10]:38980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb7p7-0001Zf-2f
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cb7p4-0003uy-2B
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:36:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cb7p3-0003uF-T5
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:36:50 -0500
References: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b1b880d-8e1f-a447-1d00-a1c9b6cbe44e@redhat.com>
Date: Tue, 7 Feb 2017 09:36:47 -0600
MIME-Version: 1.0
In-Reply-To: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PlMii4OXiSfkEWROjbhJsGtiBi6rRMj0K"
Subject: Re: [Qemu-devel] How to find backing file for qemu-nbd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikolay Ivanets <stenavin@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PlMii4OXiSfkEWROjbhJsGtiBi6rRMj0K
From: Eric Blake <eblake@redhat.com>
To: Nikolay Ivanets <stenavin@gmail.com>, qemu-devel@nongnu.org
Message-ID: <3b1b880d-8e1f-a447-1d00-a1c9b6cbe44e@redhat.com>
Subject: Re: [Qemu-devel] How to find backing file for qemu-nbd?
References: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
In-Reply-To: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/07/2017 08:25 AM, Nikolay Ivanets wrote:
> Is there any way to find source file supplied for qemu-nbd similar to l=
oop
> device:
>=20
> cat /sys/block/loop0/loop/backing_file

qemu-nbd is userspace, so there's no way it will be found in /sys/.  But
since it is userspace, is it not sufficient to just use 'ps' or
/proc/$n/cmdline to determine what command line qemu-nbd was started with=
?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PlMii4OXiSfkEWROjbhJsGtiBi6rRMj0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmemPAAoJEKeha0olJ0Nqj/oIAKxvPgykU2OvLZ0P2noYWYo9
r4CSyG8Mfw82t0wC6RtQGJyRqxQHedtL0x0ogruIzp/32VSHKdfF+Ozrp2nfsu4l
2wzb6D1XtRca48sI2d8VI0AMOdgMHHS6W+cB6apoBceylujoT7+bnit4FqkkTc6A
ACnI2AWurIfF2blG1ng+CRyGZKZIQ1etBcj6uoccGSgwwClVml3CFNvhn/j1UCXu
FH859//DeKa0qjjFcFQVIaBmyaWCvpO/ANgMJPTKHC9GCwggOr6Ie4ZSMwLq1lDM
AfDJ3giCEsMhK3BRNJ+Vi6t1DMe489tXu5MTcyhz+SZ7WaBNoIzFLrz63f2jzBI=
=DS8O
-----END PGP SIGNATURE-----

--PlMii4OXiSfkEWROjbhJsGtiBi6rRMj0K--
