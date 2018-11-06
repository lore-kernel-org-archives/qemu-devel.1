Received: from eggs.gnu.org ([2001:4830:134:3::10]:49711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJqfg-0002eD-4y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 21:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJqQr-0003jq-K6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 20:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gJqQp-0003PV-Mf
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 20:45:29 -0500
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-2-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a412ed2c-bcf2-8825-c2bc-45fad8b99d1f@redhat.com>
Date: Tue, 6 Nov 2018 02:45:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bt0aUNdzUyuNpk8lxuScLX6v4X5s8kI1z"
Subject: Re: [Qemu-devel] [PATCH 1/4] scsi-generic: keep VPD page list sorted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bt0aUNdzUyuNpk8lxuScLX6v4X5s8kI1z
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <a412ed2c-bcf2-8825-c2bc-45fad8b99d1f@redhat.com>
Subject: Re: [PATCH 1/4] scsi-generic: keep VPD page list sorted
References: <20181029173437.32559-1-pbonzini@redhat.com>
 <20181029173437.32559-2-pbonzini@redhat.com>
In-Reply-To: <20181029173437.32559-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.10.18 18:34, Paolo Bonzini wrote:
> Block limits emulation is just placing 0xb0 as the final byte of the
> VPD pages list.  However, VPD page numbers must be sorted, so change
> that to an in-place insert.  Since I couldn't find any disk that trigge=
red
> the loop more than once, this was tested by adding manually 0xb1
> at the end of the list and checking that 0xb0 was added before.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--bt0aUNdzUyuNpk8lxuScLX6v4X5s8kI1z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvg8ioACgkQ9AfbAGHV
z0BY7Qf8CZ3E6wElGU2l8sJ4fDPZHD9lPVxdmmGW96YpxSYGebfkND3863m7C3Fd
uFETejGv7iWscMl0xC4Wn9PwxAlNytEAS3msN7AlCG1hhJnEh6QxMFrUhLZUVTxJ
7wnKCsWNs2Z24Zw0nJ/xhJRwMOAbGgoABW0FplCGH7LlllRP64x5XdvgYAazx8kc
aSa8I7/uXteGbxXDU2kAae4fFGWGAu2VjJWB8hND/jnuxfv1+T4elswKdS+A0uH+
m40LX73qfJRQa7ZjRqZdloA7t6l9IKgQ9JLAHyMs3CPkEPaxAgQVYqCLEX8CHgOR
xK0TpP8R1jSo2fqV+a377otgQGbRnw==
=fn51
-----END PGP SIGNATURE-----

--bt0aUNdzUyuNpk8lxuScLX6v4X5s8kI1z--
