Received: from eggs.gnu.org ([2001:4830:134:3::10]:43377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF3qK-0007IW-Dy
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF3qJ-00028S-R6
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:59:28 -0500
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
Date: Wed, 15 Nov 2017 20:59:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d4fPHMs4tGj8qrNR2D4hqMKjk3TjPuG8P"
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d4fPHMs4tGj8qrNR2D4hqMKjk3TjPuG8P
From: Max Reitz <mreitz@redhat.com>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
 Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
 <c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
 <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
In-Reply-To: <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 18:44, Gandalf Corvotempesta wrote:
> XVA is a tar archive.
> I don't think would be possible to directly use the image stored inside=

> without extracting and merging each chunks
>=20
> Any random reads would be impossible to do, only a huge sequential dump=
 to
> build the raw image

Well, you can't just add support to qemu-img alone either.  Every image
format supported by qemu-img is one supported by qemu as a whole and
thus needs a proper block driver that needs to support random accesses
as well.

Max


--d4fPHMs4tGj8qrNR2D4hqMKjk3TjPuG8P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMnJMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Auz8H/AsqFcjn5HKIGLF9nxTb/6a0tiunjI2x
PzoFGl9kHOnZRhmpRdqFBlE0cRtywYiRI5lL3G63RSHXsqCuutUs8nrhllZPuA3v
Bzn6O6Dz4rzoKncVebbkiFaD4/pphSR2y78hPBO8gED+BdJ/hNHbhoD1nf/i7yHs
erEL4Z+OIP1IwuHB4E7AsCOsGVFfOGG4XoxlF0GFUBSy6MIi/R+etbbkJK5H8W6L
3enWozz+YDqkLU6jAL8miqjRj+sy+jYphyh9nMbB5FbZSLMMAi4Ex9C0qYs6lc2n
rNmhEMwH44sMT1XNTqES2TLhrtjyd1ozfnQ4wF2PJKfcxDXE3mOYmus=
=ex9i
-----END PGP SIGNATURE-----

--d4fPHMs4tGj8qrNR2D4hqMKjk3TjPuG8P--
