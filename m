Received: from eggs.gnu.org ([2001:4830:134:3::10]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnYKP-0007eQ-ST
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnYKO-0001nN-V5
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:20:33 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-8-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8d749d12-3d2e-c26f-8aa8-95e016173ed2@redhat.com>
Date: Mon, 13 Mar 2017 23:20:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170308025428.1037-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5N2suFq8FIn8Hiq4U3UjbaTWOsf2ubaJv"
Subject: Re: [Qemu-devel] [PATCH v6 07/10] blkdebug: Add pass-through
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
--5N2suFq8FIn8Hiq4U3UjbaTWOsf2ubaJv
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <8d749d12-3d2e-c26f-8aa8-95e016173ed2@redhat.com>
Subject: Re: [PATCH v6 07/10] blkdebug: Add pass-through write_zero and
 discard support
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-8-eblake@redhat.com>
In-Reply-To: <20170308025428.1037-8-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 03:54, Eric Blake wrote:
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
> v6: tighten check of unaligned requests, rebase on rule check
> refactoring, drop R-b
> v5: include 2017 copyright
> v4: correct error injection to respect byte range, tweak formatting
> v3: rebase to byte-based read/write, improve docs on why no
> partial write zero passthrough
> v2: new patch
> ---
>  block/blkdebug.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 74 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5N2suFq8FIn8Hiq4U3UjbaTWOsf2ubaJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljHGygSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKrMH/iI1Sgii5ruMPlJLE64dxRHB3MYu8uLP
Qk1wuA0mS0t6TR0gg/la/iDRTziVh+50x/a1XQoWK7kZJT+ztReqLhzDC7IupRn3
PNadU9RZA+jZZaGYPrBxpnC8X7yhaVwHmYewgW5a+QZJ0NnT9QUGkCM6MYaku3uo
/TpjkkSJ0P+zcUwLZq64CkI37h0jkXEQ6onZDDmGJ1rseHF6Yxg4MAvWygpMLjxv
I0Tbgw4ubfNRrHhWKEhuBCMYKaXalAwzZbKlXufMV+YgbCpBdzlR9fy2ewwW3GJ/
GSBtAQTjtoXHvP7NZwU9tZv1rSI9Cr3CAgV0NNC/95N9ZSG1aWKQDCc=
=eKxq
-----END PGP SIGNATURE-----

--5N2suFq8FIn8Hiq4U3UjbaTWOsf2ubaJv--
