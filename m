Received: from eggs.gnu.org ([2001:4830:134:3::10]:58509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lip-0004bV-2x
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6lio-0005Kd-0U
	for qemu-devel@nongnu.org; Fri, 05 May 2017 18:29:11 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-8-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8f2da61a-850f-8059-5361-bc925da17d4e@redhat.com>
Date: Sat, 6 May 2017 00:29:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AUWtIDPKOXkJjbCAeCDlaNxbadXpPNbsF"
Subject: Re: [Qemu-devel] [PATCH v12 07/10] iotests: Add test 179 to cover
 write zeroes with unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AUWtIDPKOXkJjbCAeCDlaNxbadXpPNbsF
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <8f2da61a-850f-8059-5361-bc925da17d4e@redhat.com>
Subject: Re: [PATCH v12 07/10] iotests: Add test 179 to cover write zeroes
 with unmap
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-8-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> No tests were covering write zeroes with unmap.  Additionally,
> I needed to prove that my previous patches for correct status
> reporting and write zeroes optimizations actually had an impact.
>=20
> The test works for cluster_size between 8k and 2M (for smaller
> sizes, it fails because our allocation patterns are not contiguous
> with small clusters - in part, the largest consecutive allocation
> we tend to get is often bounded by the size covered by one L2
> table).
>=20
> Note that testing for zero clusters is tricky: 'qemu-io map'
> reports whether data comes from the current layer of the image
> (useful for sniffing out which regions of the file have
> QCOW_OFLAG_ZERO) - but doesn't show which clusters have mappings;
> while 'qemu-img map' sees "zero":true for both unallocated and
> zero clusters for any qcow2 with no backing layer (so less useful
> at detecting true zero clusters), but reliably shows mappings.
> So we have to rely on both queries side-by-side at each point of
> the test.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: probe the map in more places, to make test easier to follow
> v11: reserved for blkdebug half of v10
> v10: drop any changes to v2 files, rewrite test to work with updates
> earlier in the series, add a blkdebug probe
> v9: new patch
> ---
>  tests/qemu-iotests/179     | 132 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/179.out | 160 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 293 insertions(+)
>  create mode 100755 tests/qemu-iotests/179
>  create mode 100644 tests/qemu-iotests/179.out

[...]

> +wrote 2097152/2097152 bytes at offset 20971520
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 2097152/2097152 bytes at offset 20971520
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 2097152/2097152 bytes at offset 29360128
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Failed to flush the L2 table cache: Input/output error
> +Failed to flush the refcount block cache: Input/output error
> +wrote 2097152/2097152 bytes at offset 0
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

Maybe we should drop this last test that blkdebug works. It fails (for
me) on tmpfs (because the write itself fails there), and with -c unsafe
(because it doesn't flush the refcount cache). I'd be fine with just
believing blkdebug that it does its job...

Max

> +*** done


--AUWtIDPKOXkJjbCAeCDlaNxbadXpPNbsF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM/K0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Auc0H/2PuzF15GY4TafWJiMiN9X2dXgEXn2dG
uhxlFg1ePkyMYAnOO4Tu3yu0Bs1b3JqoIC09r9UtQkrhhvfWtc/BcDaDXYVifzuk
ee4QbZqwtbT2Zp30RSikzGc43fmMw7P7YYDalqwEw+ab6Ithk4Wd7J+vM/oWKR5m
t5c1tnvzwJFlruIr/kcdbY1xs17CJzufVKWE3j+3jQTabEnrI5mPstPqeSfz898K
PiXYYba+TlxXdgnIjFzqqlVs+LA8z8X9wvKiBwl1QGA+H1OxU+GrjscbAOiQEkQ/
WzWf8QK8VSKHfjunCwjr0LV5DbDuKYoH5Li+mFXD3/jmSl/GDYtpatw=
=asrG
-----END PGP SIGNATURE-----

--AUWtIDPKOXkJjbCAeCDlaNxbadXpPNbsF--
