Received: from eggs.gnu.org ([2001:4830:134:3::10]:38700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUR7-0001lR-1L
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUR2-00050q-4g
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:20:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPUR1-00050E-Up
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:19:56 -0500
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
	<1483692945-9866-15-git-send-email-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16e56a60-87f8-fb42-0052-8ac25bfee965@redhat.com>
Date: Fri, 6 Jan 2017 07:19:53 -0600
MIME-Version: 1.0
In-Reply-To: <1483692945-9866-15-git-send-email-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sQLbgV7StlsMlVTLcBmqeadsm6LOlFgOF"
Subject: Re: [Qemu-devel] [PATCH 14/17] wctablet: misc cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sQLbgV7StlsMlVTLcBmqeadsm6LOlFgOF
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com
Message-ID: <16e56a60-87f8-fb42-0052-8ac25bfee965@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/17] wctablet: misc cleanups
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
 <1483692945-9866-15-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-15-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 02:55 AM, Gerd Hoffmann wrote:
> Some codestyle fixes, place comments first,
> turn lengts into #defines, delete unused stuff.

s/lengts/lengths/

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  backends/wctablet.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Again, should this be squashed into 1/17?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sQLbgV7StlsMlVTLcBmqeadsm6LOlFgOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb5l5AAoJEKeha0olJ0NqqQsH/RoZ8LYnZgQ0BdzJcuNLD99I
HfG22OvWp3faMjbFEeHH+En+idjx93j4INthDThQzj3k5NyavXnw3awzRoGo+Jje
d2A4Xt3T9npqSEdiMw6cLd1m5blkSTaULwltLWFLkHARujuySIolfrug4D6WiMZ6
vr5yQqfiVmT0rugY2OLZcWQ69IcwE0PpkjHqxKqyRGexunqZRCoFkyOCyUDJm84H
2rNVBp8INcE6wmZSWdhIwjRpfv65gpLecacdTj/XgVw0bBciQNw7UzoVPJaIuUD+
EPhztvzOZqYN7/dVYGwi/rdH17WDf2jfU8DCdGwQf9epuQOh3m4ljX/wdWBqwPg=
=a67C
-----END PGP SIGNATURE-----

--sQLbgV7StlsMlVTLcBmqeadsm6LOlFgOF--
