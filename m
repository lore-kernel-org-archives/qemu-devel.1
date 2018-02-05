Received: from eggs.gnu.org ([2001:4830:134:3::10]:48550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eijgm-0003lT-J5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eijgl-0005Pv-IQ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:32:16 -0500
References: <cover.1517840876.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f441889f-c0a7-8b7b-5125-e9d852896669@redhat.com>
Date: Mon, 5 Feb 2018 17:31:59 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="16qHJOJE3BM38GswpyqLTjrKPX2HUsflB"
Subject: Re: [Qemu-devel] [PATCH v4 00/39] Allow configuring the qcow2 L2
 cache entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--16qHJOJE3BM38GswpyqLTjrKPX2HUsflB
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <f441889f-c0a7-8b7b-5125-e9d852896669@redhat.com>
Subject: Re: [PATCH v4 00/39] Allow configuring the qcow2 L2 cache entry size
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-05 15:33, Alberto Garcia wrote:
> this is the new revision of the patch series to allow configuring the
> entry size of the qcow2 L2 cache. Follow this link for the full
> description from the first version:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2017-10/msg00458.html
>=20
> And here are some numbers showing the performance improvements:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00507.html
>=20
> Regards,
>=20
> Berto

Looks good to me, and all qcow2 iotests pass when the default L2 slice
size is changed (in the code) to 512, so it should be good.

I'll still give it a couple of days for others to protest. :-)

Max


--16qHJOJE3BM38GswpyqLTjrKPX2HUsflB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp4hv8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASFUH/3EPZi1VSClnxoFoo0NkeM+x6UgVr/hF
bQloYlwGA4I5RUwcvl5d/ZjhTEpqGtiXW9wrfiXw1UZPCTnOL//Xl/MiIGrTMsPq
XepD2sNp8+dUa167nT8WangCI3nZFFb9W+vklAbEgsPfgeM3W0YTTjL5y3uOEz6h
rMpHR+Qlqos9xN2jy/7dbternPmSldUYE1eCoueXHQ0sqNu5uyi3lJiBpbtRenti
Zp2nLzohthM2eDozWZwpr47LhEV4z8pXve6G46XT3epAsCRu0tF6Ldi5naf38RR1
nJXRgGZclQRfIAcbKRMTP9AqF/GOzwy+gujwV0ozTviwU1ceNwbzwY0=
=gkSE
-----END PGP SIGNATURE-----

--16qHJOJE3BM38GswpyqLTjrKPX2HUsflB--
