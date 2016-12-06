Received: from eggs.gnu.org ([2001:4830:134:3::10]:42092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENn8-0001CW-Qm
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENn7-0007lX-UX
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:00:50 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
Date: Tue, 6 Dec 2016 23:00:36 +0100
MIME-Version: 1.0
In-Reply-To: <20161202192223.15153-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wWJtX43SPq06BXTXlnfIjADI9n3jThTxo"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wWJtX43SPq06BXTXlnfIjADI9n3jThTxo
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
Subject: Re: [PATCH v3 2/5] blkdebug: Add pass-through write_zero and discard
 support
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-3-eblake@redhat.com>
In-Reply-To: <20161202192223.15153-3-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.12.2016 20:22, Eric Blake wrote:
> In order to test the effects of artificial geometry constraints
> on operations like write zero or discard, we first need blkdebug
> to manage these actions.  It also allows us to inject errors on
> those operations, just like we can for read/write/flush.
>=20
> We can also test the contract promised by the block layer; namely,
> if a device has specified limits on alignment or maximum size,
> then those limits must be obeyed (for now, the blkdebug driver
> merely inherits limits from whatever it is wrapping, but the next
> patch will further enhance it to allow specific limit overrides).
>=20
> This patch intentionally refuses to service requests smaller than
> the requested alignments; this is because an upcoming patch adds
> a qemu-iotest to prove that the block layer is correctly handling
> fragmentation, but the test only works if there is a way to tell
> the difference at artificial alignment boundaries when blkdebug is
> using a larger-than-default alignment.  If we let the blkdebug
> layer always defer to the underlying layer, which potentially has
> a smaller granularity, the iotest will be thwarted.
>=20
> Tested by setting up an NBD server with export 'foo', then invoking:
> $ ./qemu-io
> qemu-io> open -o driver=3Dblkdebug blkdebug::nbd://localhost:10809/foo
> qemu-io> d 0 15M
> qemu-io> w -z 0 15M
>=20
> Pre-patch, the server never sees the discard (it was silently
> eaten by the block layer); post-patch it is passed across the
> wire.  Likewise, pre-patch the write is always passed with
> NBD_WRITE (with 15M of zeroes on the wire), while post-patch
> it can utilize NBD_WRITE_ZEROES (for less traffic).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v3: rebase to byte-based read/write, improve docs on why no
> partial write zero passthrough
> v2: new patch
> ---
>  block/blkdebug.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 81 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--wWJtX43SPq06BXTXlnfIjADI9n3jThTxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHNQUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9CYH+NURC1NZFLnC+Rpaj08cyUV+HOA37mNx
iDsURFYbUeGQCCr/3+6BfCWdoaf/8S7rsCQKSJ7xx1FRiJydWFi8vBVqWNvrinEd
dC13Ytgv4la7aC1YXOvitOzEnfVPDjnjeXcl8GVI3aSxKCO6s+g3PEAQL+/YfaWd
lKhBM2Ea/dl3OPO2LnJmvNJzXe0iE5+5x9naRtezrl5C4p++sjqho032K2C0U8Wd
10G/u9IUNS+Jd2fZihQiuBNyOua+dHgde1X9T6PKL6SU//o6uZfBMaMSWwwuKhEk
mIkqNGq4LYK0hJZbu+WslbsBHAXW3b86hc1KzXmEK7Euxq3G/nTEMw==
=+0Ze
-----END PGP SIGNATURE-----

--wWJtX43SPq06BXTXlnfIjADI9n3jThTxo--
