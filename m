Received: from eggs.gnu.org ([2001:4830:134:3::10]:58612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYF7w-0000Rj-EI
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYF7r-0006xf-SQ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:48:24 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7bf56bb5-8840-616e-b271-3cc15f2c38a6@redhat.com>
Date: Mon, 30 Jan 2017 10:48:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170126110435.2777-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ogBoURnw5uph65lsjc2EScHC9DkGw0NKV"
Subject: Re: [Qemu-devel] [PATCH v1 1/6] qemu-img: add support for --object
 with 'dd' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ogBoURnw5uph65lsjc2EScHC9DkGw0NKV
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <7bf56bb5-8840-616e-b271-3cc15f2c38a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/6] qemu-img: add support for --object
 with 'dd' command
References: <20170126110435.2777-1-berrange@redhat.com>
 <20170126110435.2777-2-berrange@redhat.com>
In-Reply-To: <20170126110435.2777-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2017 05:04 AM, Daniel P. Berrange wrote:
> The qemu-img dd command added --image-opts support, but missed
> the corresponding --object support. This prevented passing
> secrets (eg auth passwords) needed by certain disk images.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ogBoURnw5uph65lsjc2EScHC9DkGw0NKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj25NAAoJEKeha0olJ0NqxqoH/35MXznlxWgpafmScdSsRx4I
jywB09+QOYGZdOz1r8/8l5HeK/2UvGxku4slahU689iY9LWr+dKaNBbSjjwNRSkn
pAKQ6rMnl08jshtq/WoSIbo/EhB1gXsHzsRuG/EXuTZ82vbavu3VajGGPXmuk/xL
cGSSAyf9hSD+bFkv2UC2jXIVG+4eSa73ycN3+zdKvBvmTL3fY8HmF0vctR+TFLaX
m7j+Vwf5NWtUu1Z993UFlk78s7CewhADLeNn+R4RIv70KYfDY0vRShQxeD6ujfjz
u86AGbyDLdSYrkwxlxs/8WlhBaZCHT78oxFC3G0DANfucR5aevawXwjXIIjhgjU=
=uOoD
-----END PGP SIGNATURE-----

--ogBoURnw5uph65lsjc2EScHC9DkGw0NKV--
