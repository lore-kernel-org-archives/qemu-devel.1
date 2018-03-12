Received: from eggs.gnu.org ([2001:4830:134:3::10]:56456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNl5-0006aH-LP
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNl4-0004iW-Rd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:44:59 -0400
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
	<20180309182202.31206-4-farosas@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a7e0491-deb7-30fd-70ee-84f6f0e02791@redhat.com>
Date: Mon, 12 Mar 2018 14:44:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180309182202.31206-4-farosas@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ou3uz1NgSRIO8tZDQAwoPCsALSrTqPdq"
Subject: Re: [Qemu-devel] [PATCH 3/5] block/throttle: Remove
 protocol-related fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ou3uz1NgSRIO8tZDQAwoPCsALSrTqPdq
From: Max Reitz <mreitz@redhat.com>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <7a7e0491-deb7-30fd-70ee-84f6f0e02791@redhat.com>
Subject: Re: [PATCH 3/5] block/throttle: Remove protocol-related fields
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
 <20180309182202.31206-4-farosas@linux.vnet.ibm.com>
In-Reply-To: <20180309182202.31206-4-farosas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 19:21, Fabiano Rosas wrote:
> The throttle driver is not a protocol so it should implement bdrv_open
> instead of bdrv_file_open and not provide a protocol_name.
>=20
> Attempts to invoke this driver using protocol syntax
> (i.e. throttle:<filename:options:...>) will now fail gracefully:
>=20
>   $ qemu-img info throttle:foo
>   qemu-img: Could not open 'throttle:foo': Unknown protocol 'throttle'
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> ---
>  block/throttle.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7ou3uz1NgSRIO8tZDQAwoPCsALSrTqPdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmhFISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhK0H/jpnQkQGe+HEOEmiaHT0qte8+KA6kE6d
rR12xCGOljwAuauDKpxGlMD+mocCHk4oq5rKhlOzvlegHQLW0FADDzDAFOGpuj5p
YLTBPmRGGywTYu50IUmPGjqKfXqBlB81A3UT8IBjC7tenMAYjdRU8ID7AN8fOmif
IZFzd3tmh5PrFWNFGBw/Ii6j/VgjhgcoU16knUmYY5Z46ZSRRtt9MFP+4FZuGcvQ
E8JRz12UblCC7LeRnB8Ui2kRoCChNeHLOltQR8VEiPK3H7tAxciTO3CBVYaNflfQ
2BKqw+PtPOoyrBnLTN3XFrFjwrJBkbRiKp1nXMe4IWZyzgfRM42u9Xo=
=dUBW
-----END PGP SIGNATURE-----

--7ou3uz1NgSRIO8tZDQAwoPCsALSrTqPdq--
