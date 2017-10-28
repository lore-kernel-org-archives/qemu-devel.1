Received: from eggs.gnu.org ([2001:4830:134:3::10]:49751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8KAF-0000Fo-Jy
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8KAE-00085X-SN
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:00:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e8KAE-00083w-K3
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:00:10 -0400
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
Date: Sat, 28 Oct 2017 08:00:05 +0200
MIME-Version: 1.0
In-Reply-To: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G3IARhkR8PQvS341oXbFg6XgoU585O79G"
Subject: Re: [Qemu-devel] drive_add: file names with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G3IARhkR8PQvS341oXbFg6XgoU585O79G
From: Eric Blake <eblake@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>,
 "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Message-ID: <38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
Subject: Re: [Qemu-devel] drive_add: file names with spaces
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
In-Reply-To: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/28/2017 06:44 AM, Programmingkid wrote:
> I'm trying to use an image file that has spaces in its file name (and s=
ometimes in the path) to be used as a USB flash drive. When I try adding =
the image file using the drive_add command I see this error: drive_add: e=
xtraneous characters at the end of the line
>=20
> I have tried using single and double quotes around the file name but th=
is does not help. Is there a way to use files that have spaces in it's na=
me with drive_add?

Not in HMP, which lacks quoting.  (Unless you want to patch HMP to learn
quoting)

But using spaces in filenames works fine in QMP.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--G3IARhkR8PQvS341oXbFg6XgoU585O79G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln0HOUACgkQp6FrSiUn
Q2oEEwf/cOpriml4koJjgm3y46QFnWvTERtx3ZO1bZY+nnqJCIWRJQhPfjT1G9HP
q00K60ugCBJv/xr4xf59JYl9NZ6x65F2NPs8/OVYRzzsoG35PWbSChksxrMPXYEl
7z1xmBCpenOjU4EZXpSM8Lx/4LoREUhjNlZmOhHu/Ukxu6v/+S81WbDsPZ2Qd2VX
8SYXqPi6tH1I2KBLYRJQp4UJBVNXo8fsQmXnfjZzfNvhD5/eydtXMtA4dbWhEYn9
hPGyqO2uFo0eVnjOVfJbYo7V1VIDYC6K+XhOxI7A/dmYy0y8q6hQoC2p5xNSt1l1
9iDgTCOjq+N6ab3b6RwkPk9zeBMIzA==
=udYz
-----END PGP SIGNATURE-----

--G3IARhkR8PQvS341oXbFg6XgoU585O79G--
