Received: from eggs.gnu.org ([2001:4830:134:3::10]:56346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNkh-0006Em-0T
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNkd-0003wy-0L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:44:35 -0400
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
	<20180309182202.31206-3-farosas@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <83b54f4d-9a24-0ced-73f6-576048036f5c@redhat.com>
Date: Mon, 12 Mar 2018 14:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180309182202.31206-3-farosas@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F25E2tKsR2REMD6WLa1rwsQOnUJAMJQWV"
Subject: Re: [Qemu-devel] [PATCH 2/5] block/quorum: Remove protocol-related
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F25E2tKsR2REMD6WLa1rwsQOnUJAMJQWV
From: Max Reitz <mreitz@redhat.com>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Alberto Garcia <berto@igalia.com>
Message-ID: <83b54f4d-9a24-0ced-73f6-576048036f5c@redhat.com>
Subject: Re: [PATCH 2/5] block/quorum: Remove protocol-related fields
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
 <20180309182202.31206-3-farosas@linux.vnet.ibm.com>
In-Reply-To: <20180309182202.31206-3-farosas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 19:21, Fabiano Rosas wrote:
> The quorum driver is not a protocol so it should implement bdrv_open
> instead of bdrv_file_open and not provide a protocol_name.
>=20
> Attempts to invoke this driver using protocol syntax
> (i.e. quorum:<filename:options:...>) will now fail gracefully:
>=20
>   $ qemu-img info quorum:foo
>   qemu-img: Could not open 'quorum:foo': Unknown protocol 'quorum'
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> ---
>  block/quorum.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--F25E2tKsR2REMD6WLa1rwsQOnUJAMJQWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmhC4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AOwUH/A9H3bwj9qEIjcT7M6Lkdgv1C2aRrd2u
Mpb3ECytbIkXiS/jpMFxsJxfbQGa8zULSp1rxUz+eT5ZVcaDLEq8PY3TeKsad/OH
2RpekwRKrza2vW2sc/5SBDGIzbz5Iw7HwsZ1I5fri90gePf10DVSVCY1M3ysPe7g
oaf/c22eDqTcO2jLgpT9rxAnGyTug+xxsio507hZidDbYR2Wlpcw7ux5SvThMCwr
oac8KKocs1nHW14NPmNg4kPjsxQ9WZQTM7GFoM6/tJKtEBP3IL2OCnmPCGYSV9uD
Xm6zCKXHpWj7ZMKecfTd0qTYDOqQpb98LbQfGsJbBghjTJnpbIr2RYs=
=ihP9
-----END PGP SIGNATURE-----

--F25E2tKsR2REMD6WLa1rwsQOnUJAMJQWV--
