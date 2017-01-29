Received: from eggs.gnu.org ([2001:4830:134:3::10]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXsDV-0005UO-9c
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 11:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXsDT-0003Qd-Qf
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 11:20:37 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-19-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a315c1c0-77e8-1a18-47f4-2a55d72643d1@redhat.com>
Date: Sun, 29 Jan 2017 17:20:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-19-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8NaRuBsOKFhjdIkpmnwWCXmCerDsVD9iS"
Subject: Re: [Qemu-devel] [PATCH 18/24] qmp: add
 x-debug-block-dirty-bitmap-sha256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8NaRuBsOKFhjdIkpmnwWCXmCerDsVD9iS
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <a315c1c0-77e8-1a18-47f4-2a55d72643d1@redhat.com>
Subject: Re: [PATCH 18/24] qmp: add x-debug-block-dirty-bitmap-sha256
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-19-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-19-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         |  5 +++++
>  blockdev.c                   | 29 +++++++++++++++++++++++++++++
>  include/block/dirty-bitmap.h |  2 ++
>  include/qemu/hbitmap.h       |  8 ++++++++
>  qapi/block-core.json         | 27 +++++++++++++++++++++++++++
>  tests/Makefile.include       |  2 +-
>  util/hbitmap.c               | 11 +++++++++++
>  7 files changed, 83 insertions(+), 1 deletion(-)

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2c0aa1f44d..956b69567d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1289,6 +1289,33 @@
>    'data': 'BlockDirtyBitmap' }
> =20
>  ##
> +# @BlockDirtyBitmapSha256:
> +#
> +# SHA256 hash of dirty bitmap data
> +#
> +# @sha256: ASCII representation of SHA256 bitmap hash
> +#
> +# Since: 2.9
> +##
> +  { 'struct': 'BlockDirtyBitmapSha256',
> +    'data': {'sha256': 'str'} }
> +
> +##
> +# @x-debug-block-dirty-bitmap-sha256:
> +#
> +# Get bitmap SHA256
> +#
> +# Returns: BlockDirtyBitmapSha256 on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found or if hashing is failed, GenericError=
 with an

s/hashing is failed/hashing has failed/

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +#          explanation
> +#
> +# Since: 2.9
> +##
> +  { 'command': 'x-debug-block-dirty-bitmap-sha256',
> +    'data': 'BlockDirtyBitmap', 'returns': 'BlockDirtyBitmapSha256' }


--8NaRuBsOKFhjdIkpmnwWCXmCerDsVD9iS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliOFkgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIfIIAL5j7oqjXKaWTmCSskftxR8p/gcL984r
Dw2ZG3EHrrs2YEkJ2G5vQ+MqYEoGu3q2KW2EQyo4KEKQOOfS/IlOzfkScl+0z8Ga
RJT7J66ipaa2tUtGnRP+YNYJvAjli1gV3Z7jmc6AQ3OZFysFPmKWnr4COIaMGsKi
hMsov42rzckzNXiYdJvv4+aIQKzakzf+Dh9ccLSCd/gCWTbS8aNKE0XxV94QOvpc
d0TQjYRbUMWdABUxRSCyHAZX8/UP7tr9MHAe8jqafLen1LfsYZP+wKTcGcaNuy+1
a0VTR8tKT04DAWxJ1oP5DSIIkShSAMAt5ASEU7wYOHpj8wWWJnTeclc=
=XIFN
-----END PGP SIGNATURE-----

--8NaRuBsOKFhjdIkpmnwWCXmCerDsVD9iS--
