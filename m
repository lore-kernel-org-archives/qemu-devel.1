Received: from eggs.gnu.org ([2001:4830:134:3::10]:42782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKEZ-0007Xo-3t
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUKEU-0006nq-6f
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:27:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUKET-0006ms-Ty
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:26:58 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-3-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e41f19d3-0a9f-49cf-3f73-bc88b706f38b@redhat.com>
Date: Thu, 19 Jan 2017 15:26:55 -0600
MIME-Version: 1.0
In-Reply-To: <1484859998-25074-3-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qMkkrTusTeOMO14afrmTEvNLtOLi975QE"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qMkkrTusTeOMO14afrmTEvNLtOLi975QE
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <e41f19d3-0a9f-49cf-3f73-bc88b706f38b@redhat.com>
Subject: Re: [PATCH v3 2/4] compiler: rework BUG_ON using a struct
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
 <1484859998-25074-3-git-send-email-mst@redhat.com>
In-Reply-To: <1484859998-25074-3-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 03:07 PM, Michael S. Tsirkin wrote:
> There are theoretical concerns that some compilers might not trigger
> build failures on attempts to define an array of size -1 and make it a
> variable sized array instead.

Rather, the concern is that if someone changes code so that the 'x' of
QEMU_BUILD_BUG_ON(x) is no longer a compile time constant, we want a
compile-time failure rather than a runtime variable-sized array that may
or may not crash.

> Let rewrite using a struct with a negative
> bit field size instead as there are no dynamic bit field sizes.  This i=
s
> similar to what Linux does.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

I don't know if you want to tweak the commit wording, but I'm okay with
the patch itself.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qMkkrTusTeOMO14afrmTEvNLtOLi975QE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgS8fAAoJEKeha0olJ0Nqb6MH/RaBwePHh1F0zZHhyjgufLbK
CynWSx/jgryfL4mLTZgThYP6aerraAfm0RGWQhnXQU+ASih6MTaPZvFcvZG4N/y3
O0hnPp+N9DLc4H99oEDcoiYwbWmnIo26dAm+aj3qOXj78n97HLw078ljF3IhO8ya
Stqtop0awk6Eyx5ywAJBXRfWpWWZVRt8bVnCiF+JnhNaIkwqs9eXt+55bebAB4yv
vwIPUnCFDCbtz0CUYKonX1W8JrFdaU4FmJ3Rd0OT5I2Gx2xZ3+61F66onj8wifaO
bwYi1TqIiZlUjzqa2+ItAId7OGl9hB4ByvYbOmgOEbFLLo+Gf3nthi3dn48nAoo=
=mybL
-----END PGP SIGNATURE-----

--qMkkrTusTeOMO14afrmTEvNLtOLi975QE--
