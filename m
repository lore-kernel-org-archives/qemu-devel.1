Received: from eggs.gnu.org ([2001:4830:134:3::10]:60427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjq9U-0006gp-94
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjq9R-0003PJ-4Q
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjq9Q-0003P0-Rz
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:33:53 -0500
References: <148855786023.23661.6584039229850547004.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ddaeaaa-16e0-eb07-6652-1daac5b05696@redhat.com>
Date: Fri, 3 Mar 2017 10:33:50 -0600
MIME-Version: 1.0
In-Reply-To: <148855786023.23661.6584039229850547004.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IqwrRNMffomBiO2M7VbjalVrTBAXDjF4p"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix bogus fd check in local_remove()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IqwrRNMffomBiO2M7VbjalVrTBAXDjF4p
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Message-ID: <6ddaeaaa-16e0-eb07-6652-1daac5b05696@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix bogus fd check in local_remove()
References: <148855786023.23661.6584039229850547004.stgit@bahia>
In-Reply-To: <148855786023.23661.6584039229850547004.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 10:17 AM, Greg Kurz wrote:
> This was spotted by Coverity as a fd leak. This is certainly true, but =
also
> local_remove() would always return without doing anything, unless the f=
d is
> zero, which is very unlikely.
>=20
> (Coverity issue CID1371732)
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index f22a3c3654db..5db7104334d6 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1008,7 +1008,7 @@ static int local_remove(FsContext *ctx, const cha=
r *path)
>      int err =3D -1;
> =20
>      dirfd =3D local_opendir_nofollow(ctx, dirpath);
> -    if (dirfd) {
> +    if (dirfd =3D=3D -1) {
>          goto out;
>      }
> =20
>=20
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IqwrRNMffomBiO2M7VbjalVrTBAXDjF4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJYuZruAAoJEKeha0olJ0NqGmMH+JFpjtZMJx6tkeOKp8Z5DUa5
g+Topj3P0Y3xm/FmWQ02Aeda0nLBylzZBxVhgvd8YB7sF+CHScqrHYisYPRTtI4O
1YoV+OJSJVFCXlijT7eYhrBC1Gtejwsoi2PNTecQPWFPtjBTkz5tgicjySm5HJZf
WNpBnM9XZIOukAVDGbKzg6/bTMs4iiPs6lJhID0ghQCZpfTrYz+GYuX7TLadzlLm
bHiv5PgZ2lrqUfWLDSGD3j1qHuojpVkEoMKoc0TIPnlkZg08ulZ05zwP1HGj5Ypr
hNhBENo0ekTr6PE7fVO3IE6j7mqgdFQGKpHiwEJEWuBhFHej0zvCE5MC96r/ZA==
=9VkF
-----END PGP SIGNATURE-----

--IqwrRNMffomBiO2M7VbjalVrTBAXDjF4p--
