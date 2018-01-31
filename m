Received: from eggs.gnu.org ([2001:4830:134:3::10]:49558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyAO-0008Q0-QU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyAO-00029g-0q
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:35:32 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<b846fd188022b961c612a5eb8b4409895824a563.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b370a9d9-06c9-de81-14e2-74516bd8e1ad@redhat.com>
Date: Wed, 31 Jan 2018 20:35:22 +0100
MIME-Version: 1.0
In-Reply-To: <b846fd188022b961c612a5eb8b4409895824a563.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sHlfa3hp77YvysYKSJ1Sa1COr868vpXJK"
Subject: Re: [Qemu-devel] [PATCH v3 08/39] qcow2: Remove BDS parameter from
 qcow2_cache_destroy()
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
--sHlfa3hp77YvysYKSJ1Sa1COr868vpXJK
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <b370a9d9-06c9-de81-14e2-74516bd8e1ad@redhat.com>
Subject: Re: [PATCH v3 08/39] qcow2: Remove BDS parameter from
 qcow2_cache_destroy()
References: <cover.1516978645.git.berto@igalia.com>
 <b846fd188022b961c612a5eb8b4409895824a563.1516978645.git.berto@igalia.com>
In-Reply-To: <b846fd188022b961c612a5eb8b4409895824a563.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> This function was never using the BlockDriverState parameter so it can
> be safely removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cache.c |  2 +-
>  block/qcow2.c       | 16 ++++++++--------
>  block/qcow2.h       |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--sHlfa3hp77YvysYKSJ1Sa1COr868vpXJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyGnoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Az2MIAIp6t/WPiXUXBu9Eci12Whb9bzP8GD58
AyRTEPP8ALAliwoug0XEotUEud3IcIZMc5gvoJ9/XtHt2Ub4xCEn8DaJhz6xxmJZ
TBp+7stSstIJ5jBrX/Hs1xf7NUbiHjmUbNwAEupjnY3Y5ldvASludfLNlnHoDGbL
pJYE2AwIAG0y82UFVNUvBg09Y8LLZQv11/ZMAD4zFZ0CMNCX+AHIYgWUcf0omsGR
QRHUEr9MU6Xr1E5+cLyxCQH7xPUTVRRyUyI4//cMqDch+ieNKbAv7EZRZ4a0QBks
z/+t7jw1pASnNp7RnVwgUlfcNtPy0w10ghpD4EEO2r9xoK6kNnna4bM=
=UQAu
-----END PGP SIGNATURE-----

--sHlfa3hp77YvysYKSJ1Sa1COr868vpXJK--
