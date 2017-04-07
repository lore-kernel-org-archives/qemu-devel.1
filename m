Received: from eggs.gnu.org ([2001:4830:134:3::10]:55282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUbg-0008E2-Ts
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUbc-0002rq-U0
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:11:20 -0400
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
	<1491572865-8549-8-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dabe6c7e-c777-a0dc-2ba1-e5b594a7b18c@redhat.com>
Date: Fri, 7 Apr 2017 09:11:11 -0500
MIME-Version: 1.0
In-Reply-To: <1491572865-8549-8-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GEJi0fx97so8faBv62HxJ3mG9XQdOGorW"
Subject: Re: [Qemu-devel] [PULL 07/10] block: Don't check permissions for
 copy on read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GEJi0fx97so8faBv62HxJ3mG9XQdOGorW
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <dabe6c7e-c777-a0dc-2ba1-e5b594a7b18c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/10] block: Don't check permissions for copy
 on read
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
 <1491572865-8549-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-8-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 08:47 AM, Kevin Wolf wrote:
> The assertion is currently failing. We can't require callers to have
> write permissions when all they are doing is a read, so comment it out.=

> Add a FIXME comment in the code so that the check is re-enabled when
> copy on read is refactored into its own filter driver.
>=20
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  block/io.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 2709a70..7321dda 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -945,7 +945,14 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(B=
drvChild *child,
>      size_t skip_bytes;
>      int ret;
> =20
> -    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));=

> +    /* FIXME We cannot require callers to have write permissions when =
all they
> +     * are doing is a read request. If we did things right, write perm=
issions
> +     * would be obtained anyway, but internally by the copy-on-read co=
de. As
> +     * long as it is implemented here rather than in a separat filter =
driver,

Is there time to fix the typo before the pull happens?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GEJi0fx97so8faBv62HxJ3mG9XQdOGorW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY553/AAoJEKeha0olJ0NqcqYH/2YKFUO8HEazxgmPRNtBoQwu
+NFsLVEPdL2+uilwKaGGLuH3eq6/IgAgbOTdNrTNaNctVVr7khZkBs5cdiK0+auN
WurpcL5SVUlRs2LnN8mrc0/qZ3iDJDalnbzu0y0XrH1PbvcofRMZR+6cHfUzIAE4
cpGIUOZx0n07gSLYzK6NWx4p6N0JVJz3zSE3Y2FNFFQOzJsVz5esQ/EC9QI7f060
T3imFaEyQ2lAStMjaDNBwqrZVsWmNQk1kR4zn8mUVYWDCgZWGbdxvFvYvbQaLg0L
c2mv6aJoeOROo4UUdtNJYei2AMCXkvTu1xIlndoj3LFeWvcRB+U0wFY3C3Sdxhw=
=UDIw
-----END PGP SIGNATURE-----

--GEJi0fx97so8faBv62HxJ3mG9XQdOGorW--
