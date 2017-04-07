Received: from eggs.gnu.org ([2001:4830:134:3::10]:46637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUL1-0002XI-F5
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwUL0-0006PF-Ef
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:54:07 -0400
References: <1491561165-12415-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71657ad0-5d2f-5d26-1c42-854e50e6786c@redhat.com>
Date: Fri, 7 Apr 2017 08:53:59 -0500
MIME-Version: 1.0
In-Reply-To: <1491561165-12415-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f9gmRpJs0gcngxQOsitoes97vJbgR6mCr"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Don't check permissions for
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
Cc: mreitz@redhat.com, rjones@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f9gmRpJs0gcngxQOsitoes97vJbgR6mCr
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, rjones@redhat.com, qemu-devel@nongnu.org
Message-ID: <71657ad0-5d2f-5d26-1c42-854e50e6786c@redhat.com>
Subject: Re: [PATCH for-2.9] block: Don't check permissions for copy on read
References: <1491561165-12415-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491561165-12415-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2017 05:32 AM, Kevin Wolf wrote:
> The assertion is currently failing. We can't require callers to have
> write permissions when all they are doing is a read, so comment it out.=

> Add a FIXME comment in the code so that the check is re-enabled when
> copy on read is refactored into its own filter driver.
>=20
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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

s/separat/separate/

> +     * the copy-on-read code doesn't have its own BdrvChild, however, =
for which
> +     * it could request permissions. Therefore we have to bypass the p=
ermission
> +     * system for the moment. */
> +    // assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE=
));

Makes checkpatch.pl unhappy - but that's intentional.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f9gmRpJs0gcngxQOsitoes97vJbgR6mCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY55n3AAoJEKeha0olJ0NqT3UH/iKk4m/dpgWzgYdrbWYgWfDw
mEezP6t2/STdvXWxkxtKetODkEeCuUtr1qexOy0+UWrrKcT4RVPS0MAuyCjepGrw
VRHgwuw+gBDAzg6VHqXLqvlqLpwmhc9PKhBynKU1epr34ai4AUALxdrkbOcJBgDG
RdKty2qMzse50EiaVxLd/ms5C/ErvszlfInCl5Uhr9ATWjSneUjSCGNl3GBeCTe+
YMlhb/Rnd1nozWQvlYC7K/lXwGTHnLojo2u84jPXREd37lL9U/EJ0gyF5cV1q/oZ
6bwNkzkuq7iFlmMXMF0LBs1Xn2ntXFfzlzYIfioKcWglp/piEj232XxEaGCPoc0=
=CNyE
-----END PGP SIGNATURE-----

--f9gmRpJs0gcngxQOsitoes97vJbgR6mCr--
