Received: from eggs.gnu.org ([2001:4830:134:3::10]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOokO-0004bd-I2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOokJ-0003Al-95
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:49:08 -0500
References: <20170104145624.2849-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37786c56-11a5-3fa8-9eea-ecc61ffda5d0@redhat.com>
Date: Wed, 4 Jan 2017 10:49:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170104145624.2849-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vOBrfASNDvVBRDe94lPplg7xAQa7UFWiL"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: remove dead check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vOBrfASNDvVBRDe94lPplg7xAQa7UFWiL
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <37786c56-11a5-3fa8-9eea-ecc61ffda5d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: remove dead check
References: <20170104145624.2849-1-pbonzini@redhat.com>
In-Reply-To: <20170104145624.2849-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 08:56 AM, Paolo Bonzini wrote:
> options must be non-NULL here, because it has been checked before.
> Reported by Coverity.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu-img.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(not shown in the diff, but several lines earlier, is:

    if (!options) {
        error_exit("Must specify options (-o)");
    }
)


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vOBrfASNDvVBRDe94lPplg7xAQa7UFWiL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbSd8AAoJEKeha0olJ0NqaoMH/A27Tpkm7oBb/SnJQ/1BYzZy
GBOTaV6kWPVkA/fWsbge+Uxcx9/88r9tVfzkFGvXvbeoyIi4VA+uKvsZ9vxLZEM/
ri7AhZOXkbHm3QaiGPszF47lD7rnmc4WXZvMHjRVreI2tXDJN+DHwL1RybdjHMvh
JNyjWfuzZeCJktYiAPQA51Y3Bnleu4+5K5xLoBasYLo4lMaBKuaKUqXvuVQrfkyv
7d2nPfTGbq90YSdockhOml05ilWOvMnh+fIA6oaiZSEkVYd3li6cSSj9AAZ84M7P
yReTBrC6c8M8ToRVv6RhLlhhToWboMyfjh+ALVeN/iy3iHNZawo1odiGz5XFxYA=
=1mH+
-----END PGP SIGNATURE-----

--vOBrfASNDvVBRDe94lPplg7xAQa7UFWiL--
