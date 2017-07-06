Received: from eggs.gnu.org ([2001:4830:134:3::10]:39953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTA1T-0007SF-Gq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTA1S-0007wb-KZ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:52:59 -0400
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5dc42ddc-7705-59d4-5de7-4b94a9d14c93@redhat.com>
Date: Thu, 6 Jul 2017 11:52:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170706163828.24082-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1VBkbtfnPxh6g27GDFc36pnAccARA8S2b"
Subject: Re: [Qemu-devel] [PATCH 02/11] block: make write-threshold
 thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1VBkbtfnPxh6g27GDFc36pnAccARA8S2b
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org
Message-ID: <5dc42ddc-7705-59d4-5de7-4b94a9d14c93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/11] block: make write-threshold
 thread-safe
References: <20170706163828.24082-1-pbonzini@redhat.com>
 <20170706163828.24082-3-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2017 11:38 AM, Paolo Bonzini wrote:
> For simplicity, use bdrv_drained_begin/end to avoid concurrent
> writes to the write threshold, or reading it while it is being set.
> qmp_block_set_write_threshold is protected by the BQL.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/write-threshold.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1VBkbtfnPxh6g27GDFc36pnAccARA8S2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXmreAAoJEKeha0olJ0NqexcIAIGZbOGLrftsvyL/m+Nqi6TY
D7rOfiaJwdvJu2WabJXoT2np5VS46JOomtNEQgv85d3rs10tEvXOsvDVXhpBZQ/t
fl8SfKluqPzXLpbkbDua2uzUdpJH3Ipt8nofoMMleomQxVLmwhyy+cvla6p7hBEp
xEayMu+TX2Bjx8ZKJlTyh/YlaEFIhHOYjqvvHBjNvJ44ZoHGNZUAi2s+9rQV5FUS
EDIFaxOaE+OgCWTq3UiiYy7Um5RzZaRl+qwAIdtV6ZBwKiR8JTh6eqEcRfhyh+bo
xuNdD1zqOU87DaJ9Oo1DT+985yloYfEXZwwEcNJrcjYLlwc1biCVTpQwzKUWcdA=
=9VzO
-----END PGP SIGNATURE-----

--1VBkbtfnPxh6g27GDFc36pnAccARA8S2b--
