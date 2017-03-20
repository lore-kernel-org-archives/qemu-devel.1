Received: from eggs.gnu.org ([2001:4830:134:3::10]:48257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvUr-0001ct-GX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvUq-0003nU-PE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:29:09 -0400
Date: Mon, 20 Mar 2017 11:29:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320112900.GN17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Content-Disposition: inline
In-Reply-To: <20170313214117.27350-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 14/16] block/qcow2:
 falloc/full preallocating growth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:41:15PM +0100, Max Reitz wrote:
> Implement the preallocation modes falloc and full for growing qcow2
> images.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 80fb815b15..b6b08d70da 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2604,7 +2604,9 @@ static int qcow2_truncate(BlockDriverState *bs, int=
64_t offset,
>      int64_t new_l1_size;
>      int ret;
> =20
> -    if (prealloc !=3D PREALLOC_MODE_OFF && prealloc !=3D PREALLOC_MODE_M=
ETADATA) {
> +    if (prealloc !=3D PREALLOC_MODE_OFF && prealloc !=3D PREALLOC_MODE_M=
ETADATA &&
> +        prealloc !=3D PREALLOC_MODE_FALLOC && prealloc !=3D PREALLOC_MOD=
E_FULL)

Now all cases are covered so this if statement can be dropped.  If you
are worried about new preallocation modes being added in the future then
the error_setg() can be moved into the switch statement's default case.

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7z8AAoJEJykq7OBq3PIRugH/i8EZMRDzU+HBV+CN9gcrphN
OvUA3kH9Kv/lyHy0PEwxaLXaABh1hKmZz2Veyug70zq62EEwkmkZgrcV22bTT5nI
UcEK4N3CbWfRbLy+jmfRjGk9vTUWcNRAIga2S58SbEZgWtgFblqPsTStCQ9M7rOl
NozRQ+gCLwFho9CRc+Dj3kNlgOla3hVeVod08zAAokNiftQdhx3EpKqdUH+FSNS9
qdgpNuE6xgnzeaxp8DDuC/kdeacsYwab+XljCbdvOQtNFg4t1bNI9rl8Xxa35w1l
+6bXxWXlzsiFsRVk/H8Ck56cyXlpa7TWPLYbNnU8giGO6NtpBkdcQIknARzsG6k=
=h7xt
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--
