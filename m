Received: from eggs.gnu.org ([2001:4830:134:3::10]:47905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEOGj-0005Kv-P0
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEOGi-0007et-Vy
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:31:25 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-5-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61db1c03-4da1-804b-5997-76d57ed070d8@redhat.com>
Date: Tue, 6 Dec 2016 23:31:13 +0100
MIME-Version: 1.0
In-Reply-To: <20161202192223.15153-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4VoeU2duX1DKuHbt2DErwXG848J7DUA1S"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4VoeU2duX1DKuHbt2DErwXG848J7DUA1S
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <61db1c03-4da1-804b-5997-76d57ed070d8@redhat.com>
Subject: Re: [PATCH v3 4/5] blkdebug: Add ability to override unmap geometries
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-5-eblake@redhat.com>
In-Reply-To: <20161202192223.15153-5-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.12.2016 20:22, Eric Blake wrote:
> Make it easier to simulate various unusual hardware setups (for
> example, recent commits 3482b9b and b8d0a98 affect the Dell
> Equallogic iSCSI with its 15M preferred and maximum unmap and
> write zero sizing, or b2f95fe deals with the Linux loopback
> block device having a max_transfer of 64k), by allowing blkdebug
> to wrap any other device with further restrictions on various
> alignments.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v3: improve legibility of bounds checking, improve docs
> v2: new patch
> ---
>  qapi/block-core.json | 27 ++++++++++++++-
>  block/blkdebug.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++=
++++++--
>  2 files changed, 120 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--4VoeU2duX1DKuHbt2DErwXG848J7DUA1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHPDESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQpgH/1j4QrjkiANJyTkmUez/h+Q5+P0L7+zd
2PiKZIos9P6gnwGd+HpsLbT39+h6FkdEsd21JCWPXiwUWEBlZV9ZI6k0vSNa2tHa
eEJo/8fI++pzx6fZ2GEaviDEI2Dy3B+sjsEi9Led6jpJ2OgOCKHdh6YAO64CYISK
KdpOuMPYq6H3VCtKROoeMH6lSTzCDNqyD2GBaN5rQvkFGbmc3h0ibz+q7anjAmQM
9hcAScRIXX0535GOJG1iCA6AlzB8yuMNUDdWMWeKfvZiz0UQYs8ASKb6WnZBZx+x
gEgeVcfT/i+3SHixsckfPPWF5Opb3JAHpRPjsAjdoB+xMXv5Oe1JNg0=
=S09M
-----END PGP SIGNATURE-----

--4VoeU2duX1DKuHbt2DErwXG848J7DUA1S--
