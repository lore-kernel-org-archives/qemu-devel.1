Received: from eggs.gnu.org ([2001:4830:134:3::10]:59245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1deha3-0000EF-Nz
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dehZy-0005nt-Sk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:56:23 -0400
References: <cover.1502109078.git.jcody@redhat.com>
	<e6f9362b49ae3837a0b20171cc2223aef2aa2e9a.1502109078.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efb922c9-56ea-ac74-8ab7-f66ac2a858bd@redhat.com>
Date: Mon, 7 Aug 2017 07:55:57 -0500
MIME-Version: 1.0
In-Reply-To: <e6f9362b49ae3837a0b20171cc2223aef2aa2e9a.1502109078.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2BxGvUmX45ctW0pW2wXa6Mo5Ock35XApc"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 4/4] block/vhdx: check error
 return of bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2BxGvUmX45ctW0pW2wXa6Mo5Ock35XApc
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com
Message-ID: <efb922c9-56ea-ac74-8ab7-f66ac2a858bd@redhat.com>
Subject: Re: [PATCH v2 for-2.10 4/4] block/vhdx: check error return of
 bdrv_truncate()
References: <cover.1502109078.git.jcody@redhat.com>
 <e6f9362b49ae3837a0b20171cc2223aef2aa2e9a.1502109078.git.jcody@redhat.com>
In-Reply-To: <e6f9362b49ae3837a0b20171cc2223aef2aa2e9a.1502109078.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:38 AM, Jeff Cody wrote:
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/vhdx-log.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/vhdx-log.c b/block/vhdx-log.c
> index a27dc05..14b724e 100644
> --- a/block/vhdx-log.c
> +++ b/block/vhdx-log.c
> @@ -558,7 +558,11 @@ static int vhdx_log_flush(BlockDriverState *bs, BD=
RVVHDXState *s,
>                      ret =3D -EINVAL;
>                      goto exit;
>                  }
> -                bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_O=
FF, NULL);
> +                ret =3D bdrv_truncate(bs->file, new_file_size, PREALLO=
C_MODE_OFF,
> +                                    NULL);
> +                if (ret < 0) {
> +                    goto exit;
> +                }
>              }
>          }
>          qemu_vfree(desc_entries);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2BxGvUmX45ctW0pW2wXa6Mo5Ock35XApc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIY10ACgkQp6FrSiUn
Q2rCRAf+K9uwhlUUwfSxZSiqsZEQxXYzYQudUwoG6My4Ts2xdTZAZustDQSuKjVX
uxvtY1Rcv2UEj3BG7yoij3dCfvAJtx6kBL6B/LFhHh5fjtRwH/bkfNKamUNjE8A4
ZNt4GIJF8ToxQ9HbjmxuHsFsSjlbMCkFtB3DZlWTg+PCKdbfWDg0vW79TiFa5Yh7
sDoR7Am2X4epBl8HC1nvC/ptsQzJiFCr3u8KUXKTaa4+ytkkS5vnxxo8HdvJg2A7
+ebdyrA6TWkXV3NB8rcVc2/rQYWJ7gCTYdNnoTTfLUfV1ObQYXTcZ2ypWSQ4MIyR
HIWvbPmUfQsUIuINOocp/ANhC5qpMw==
=Hj4O
-----END PGP SIGNATURE-----

--2BxGvUmX45ctW0pW2wXa6Mo5Ock35XApc--
