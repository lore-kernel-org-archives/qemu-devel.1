Received: from eggs.gnu.org ([2001:4830:134:3::10]:46369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCtWz-0007Rz-Mw
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCtWy-0000kS-Tt
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:02:17 -0400
References: <20170522195217.12991-1-mreitz@redhat.com>
	<20170522195217.12991-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <67407510-111e-c669-9f4b-dc8ba12c42a3@redhat.com>
Date: Mon, 22 May 2017 15:02:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170522195217.12991-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dax4DDbdsH99s1s8feMocgl4tLGXw8LGc"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/file-*: *_parse_filename()
 and colons
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
--Dax4DDbdsH99s1s8feMocgl4tLGXw8LGc
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <67407510-111e-c669-9f4b-dc8ba12c42a3@redhat.com>
Subject: Re: [PATCH v2 2/3] block/file-*: *_parse_filename() and colons
References: <20170522195217.12991-1-mreitz@redhat.com>
 <20170522195217.12991-3-mreitz@redhat.com>
In-Reply-To: <20170522195217.12991-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 02:52 PM, Max Reitz wrote:
> The file drivers' *_parse_filename() implementations just strip the
> optional protocol prefix off the filename. However, for e.g.
> "file:foo:bar", this would lead to "foo:bar" being stored as the BDS's
> filename which looks like it should be managed using the "foo" protocol=
=2E
> This is especially troublesome if you then try to resolve a backing
> filename based on "foo:bar".
>=20
> This issue can only occur if the stripped part is a relative filename
> ("file:/foo:bar" will be shortened to "/foo:bar" and having a slash
> before the first colon means that "/foo" is not recognized as a protoco=
l
> part). Therefore, we can easily fix it by prepending "./" to such
> filenames.

Slick.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Dax4DDbdsH99s1s8feMocgl4tLGXw8LGc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZI0PAAAoJEKeha0olJ0NqbFIH+wWiYn1E6OyS9bwc081v6Ze3
wBkLeVJ3NDmXKbBU3oK0e3qUegln3i9LTvjcAEy0cA9YgZI2rUIqUKsayvDmd7zp
XVsB37oh83LhYahyJf2YP25FMb6sVrsgfLz/FYcUIVXn8xE7IyFvSlGC2HvBb8V2
BmBygfZJZcN2f12y5ZKPh8713wpG15AAMFpBsSclka8m3Xe+iLcz1r24FAOI3tny
Fgd0q5tanLrMBnQA0Up2fVMhOhohHXyaregZHsJpgjL+nTFB/v4HlRr3/uMVwWcB
HYmPx/bp/auOLUkvcle/zC7zu1RrKZ12hGQP/RZ1l7j8qaVv1c16DTtDuASWNsw=
=3g8o
-----END PGP SIGNATURE-----

--Dax4DDbdsH99s1s8feMocgl4tLGXw8LGc--
