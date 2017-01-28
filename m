Received: from eggs.gnu.org ([2001:4830:134:3::10]:44590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXa3o-00037P-Er
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXa3j-0004bt-RW
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:57:24 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-7-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <09623ba2-e8d9-95c7-8c8f-3d2e79e03ef2@redhat.com>
Date: Sat, 28 Jan 2017 21:57:05 +0100
MIME-Version: 1.0
In-Reply-To: <20161220191523.5779-7-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KC09f97exQEavxBgHDQKT5WQ1cG4IEVvR"
Subject: Re: [Qemu-devel] [PATCH v4 6/7] blkdebug: Add ability to override
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KC09f97exQEavxBgHDQKT5WQ1cG4IEVvR
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:blkdebug" <qemu-block@nongnu.org>
Message-ID: <09623ba2-e8d9-95c7-8c8f-3d2e79e03ef2@redhat.com>
Subject: Re: [PATCH v4 6/7] blkdebug: Add ability to override unmap geometries
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-7-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-7-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.12.2016 20:15, Eric Blake wrote:
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
> v4: relax 512 byte minimum now that blkdebug is byte-based, fix doc typ=
o
> v3: improve legibility of bounds checking, improve docs
> v2: new patch
> ---
>  qapi/block-core.json | 24 +++++++++++++-
>  block/blkdebug.c     | 91 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 113 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6b42216..6561409 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2072,6 +2072,26 @@
>  # @align:           #optional required alignment for requests in bytes=
,
>  #                   must be power of 2, or 0 for default
>  #
> +# @max-transfer:    #optional maximum size for I/O transfers in bytes,=

> +#                   must be multiple of @align

=2E..and the file's request alignment. Should that be noted here?

Max

>                                                 (but need not be a powe=
r of
> +#                   2), or 0 for default (since 2.9)
> +#
> +# @opt-write-zero:  #optional preferred alignment for write zero reque=
sts
> +#                   in bytes, must be multiple of @align (but need not=
 be
> +#                   a power of 2), or 0 for default (since 2.9)
> +#
> +# @max-write-zero:  #optional maximum size for write zero requests in =
bytes,
> +#                   must be multiple of @align (but need not be a powe=
r of
> +#                   2), or 0 for default (since 2.9)
> +#
> +# @opt-discard:     #optional preferred alignment for discard requests=

> +#                   in bytes, must be multiple of @align (but need not=
 be
> +#                   a power of 2), or 0 for default (since 2.9)
> +#
> +# @max-discard:     #optional maximum size for discard requests in byt=
es,
> +#                   must be multiple of @align (but need not be a powe=
r of
> +#                   2), or 0 for default (since 2.9)
> +#
>  # @inject-error:    #optional array of error injection descriptions
>  #
>  # @set-state:       #optional array of state-change descriptions


--KC09f97exQEavxBgHDQKT5WQ1cG4IEVvR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNBaESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHqoIAK89Oio7rrnMN2WoULHQnly41Zghvbbz
ejS1MKtWzthb86bI2I3ewPG4Gus3ERCbh3egCsg6xDLRcTBG2oQgDWRG6EXkMLRx
N5XwVZpQayohzNIvojpqSw6TGYInM9N6jS5kVfCuam+R9VVL44dCtnTVLlHoOL1C
z+VthaTzN4w3E2oITIAtZ7bPYpqmSvJx3N3qvjlVvsrph+xHufluVTobB8ILfS5y
lbteyScF4pH1Gvu5vl4pSlpQZKhTM+pNmZpYU1PD5tSWx287W2lXUoHrzzVUg72C
YqrKOF9PvNNOqWphM9nWg5SuVUAgveyM8NoicfEcXQ9yRqPnC2AHFcM=
=/ToN
-----END PGP SIGNATURE-----

--KC09f97exQEavxBgHDQKT5WQ1cG4IEVvR--
