Received: from eggs.gnu.org ([209.51.188.92]:56716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hB0dz-0001pI-1D
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hB0dy-0006H0-5S
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:22:47 -0400
References: <20190213225311.17876-1-mreitz@redhat.com>
	<20190213225311.17876-2-mreitz@redhat.com>
	<20190319131600.GE6569@dhcp-200-226.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e16bddfd-cce0-bed0-3949-3ec1e30130e4@redhat.com>
Date: Mon, 1 Apr 2019 19:22:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190319131600.GE6569@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hVmmoR7Ms7Y0UozaDllUX0ZoCYGB0QpqF"
Subject: Re: [Qemu-devel] [PATCH v3 01/12] block: Mark commit and mirror as
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hVmmoR7Ms7Y0UozaDllUX0ZoCYGB0QpqF
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Message-ID: <e16bddfd-cce0-bed0-3949-3ec1e30130e4@redhat.com>
Subject: Re: [PATCH v3 01/12] block: Mark commit and mirror as filter drivers
References: <20190213225311.17876-1-mreitz@redhat.com>
 <20190213225311.17876-2-mreitz@redhat.com>
 <20190319131600.GE6569@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190319131600.GE6569@dhcp-200-226.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.03.19 14:16, Kevin Wolf wrote:
> Am 13.02.2019 um 23:53 hat Max Reitz geschrieben:
>> The commit and mirror block nodes are filters, so they should be marke=
d
>> as such.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> Then we need to update the definition of a filter:
>=20
>     /* set to true if the BlockDriver is a block filter. Block filters =
pass
>      * certain callbacks that refer to data (see block.c) to their bs->=
file if
>      * the driver doesn't implement them. Drivers that do not wish to f=
orward
>      * must implement them and return -ENOTSUP.
>      */
>     bool is_filter;
>=20
> This talks about bs->file specifically, and commit and mirror nodes use=

> bs->backing instead. Most places that check bs->in_filter do so to chec=
k
> whether they can forward stuff to bs->file, and they don't consider
> bs->backing.
>=20
> I think the latter will be fixed after patch 3, but the definition in
> the comment is still wrong at the end of the series.

Right, I forgot this comment.

(Interesting how Quorum has already ignored this definition for a long
time.) O:-)


Max


--hVmmoR7Ms7Y0UozaDllUX0ZoCYGB0QpqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyiSNkACgkQ9AfbAGHV
z0D0+Af9HAz44Poz8k+TPO8Kon7gO9lLEfF2Kzuel82e1s2/MW0z0QpdO3YG8TaA
awaQ8tx8hW+CPZHo0xSFUzuUIA6EMHxB8RTK7323Ntg4bCWF68VXsvaJHvHkn+9d
u4tRAGXNzc9OG6g/uwTfMg7V67MCNrMGkG8FnVlEFKRDPgahGqXIW8CidYr4by9w
9wbHYbosUx5xyge0eAAC2WiwH10HxsQcJmQuNnoK64ie9mLvPP/eGer+ibIxwkdw
xYidphpyWD7UBLIt1p6OewWu1uWjFly83QZLm5b+NA8Dvay0M4Jj4F+nioJp0X1K
aanW3kUpgiwEPHrXsnfcOT5hpln+QQ==
=9Y4j
-----END PGP SIGNATURE-----

--hVmmoR7Ms7Y0UozaDllUX0ZoCYGB0QpqF--
