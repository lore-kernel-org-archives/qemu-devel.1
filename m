Received: from eggs.gnu.org ([2001:4830:134:3::10]:57458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSZx-0001GT-M2
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOSZu-00060V-CI
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:08:53 -0500
References: <20170103160556.9895-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfa039b5-d1df-079e-5a6e-f92e13870a2d@redhat.com>
Date: Tue, 3 Jan 2017 11:08:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170103160556.9895-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E4sHKGxjQBrmcP7RvgK4xkCBmJw2lFtpu"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: record separate timings per
 format, protocol pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E4sHKGxjQBrmcP7RvgK4xkCBmJw2lFtpu
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <cfa039b5-d1df-079e-5a6e-f92e13870a2d@redhat.com>
Subject: Re: [PATCH v2] iotests: record separate timings per format,protocol
 pair
References: <20170103160556.9895-1-berrange@redhat.com>
In-Reply-To: <20170103160556.9895-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 10:05 AM, Daniel P. Berrange wrote:
> The 'check' program records timings for each test that
> is run. These timings are only valid, however, for a
> particular format/protocol combination. So if frequently
> running 'check' with a variety of different formats or
> protocols, the times printed can be very misleading.
>=20
> Instead of having a single 'check.time' file, maintain
> multiple 'check.time-$IMGPROTO-$IMGFMT' files.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> Changed in v2:
>=20
>  - Use a separate file per format/protocol, instead of
>    throwing away data each time format/protocol changes
>    between runs (Eric)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--E4sHKGxjQBrmcP7RvgK4xkCBmJw2lFtpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa9qXAAoJEKeha0olJ0Nq6VoH+QFi3Fw+AhZ8mD4hcQ1j/Lxn
BIhagUmlD+40VYM5h/8bQrRZ51r778PciRgv6P5Bb5BbMa0QBPJQa3cU5vdC2dUh
q6k1tmePgbTud2dOqLg7Dah7e9Kb4dn7+VlM9kDNmfqzxqIrVk5pj3JqEn9Ry70I
I6qiEly3ogVJpjq1JLzyV5+KpTB6zPJoc/NpvTf5Wx/XPJOFCkNWzew9XfB1erqB
mDbK9CdSz5m3/nO8mYJLB6Sv1TYXmLIwgzcB50NtqDhf+Z/bN+S3xodG3kBzIIWI
I+rWAqfr/briDmULTls82HHbHJvvUDtni7eAs4xhUtJwFwG7Zpr+QPAGsqMcc20=
=cfjR
-----END PGP SIGNATURE-----

--E4sHKGxjQBrmcP7RvgK4xkCBmJw2lFtpu--
