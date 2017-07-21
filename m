Received: from eggs.gnu.org ([2001:4830:134:3::10]:50257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWmd-00032N-5w
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWmY-0007w0-SF
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:11:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYWmY-0007vU-IR
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:11:46 -0400
References: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea6a3728-f96d-053d-9e90-a2404e193a8c@redhat.com>
Date: Fri, 21 Jul 2017 07:11:39 -0500
MIME-Version: 1.0
In-Reply-To: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9tf588XKITo1QdfOqM5WxsHtSaKC0i2jW"
Subject: Re: [Qemu-devel] [PATCH] block/vpc: fix uninitialised variable
 compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9tf588XKITo1QdfOqM5WxsHtSaKC0i2jW
From: Eric Blake <eblake@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Message-ID: <ea6a3728-f96d-053d-9e90-a2404e193a8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/vpc: fix uninitialised variable
 compiler warning
References: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 03:21 AM, Mark Cave-Ayland wrote:
> Since commit cfc87e00 "block/vpc.c: Handle write failures in
> get_image_offset()" older versions of gcc (in this case 4.7) incorrectl=
y
> warn that "ret" can be used uninitialised in vpc_co_pwritev().
>=20
> Setting ret to 0 at the start of vpc_co_pwritev() prevents the warning
> in gcc 4.7 and enables compilation with -Werror to succeed.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  block/vpc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/vpc.c b/block/vpc.c
> index 10e6519..574879b 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -649,7 +649,7 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t offse=
t, uint64_t bytes,
>      int64_t image_offset;
>      int64_t n_bytes;
>      int64_t bytes_done =3D 0;
> -    int ret;
> +    int ret =3D 0;
>      VHDFooter *footer =3D  (VHDFooter *) s->footer_buf;
>      QEMUIOVector local_qiov;
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9tf588XKITo1QdfOqM5WxsHtSaKC0i2jW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx73sACgkQp6FrSiUn
Q2p7AQgAgBvbiLWeO3SZyInz43cGbb0EPogNdRs8sKl2YuXfnnASjmyGehp004G5
hP7nqrKt+nrJTr2P1RTTmZmcTw30Oibsz9S+Okr/XYgmTiu9tsrkdC3oPIsH5Bh2
AXGEZl2gsZnYPVhVEVgefsynw/Un9SektoJaPyrgXAyr0F2p65iS4fW8KEblysbl
j+Od7Wv7o4iiBGJzt0+rObOrp6D4AthwLkvbaxutXrg7yCOaR9TAfaBEl1VeKc2p
/ufWJsP7TJcQuAokUFoPsoR0mnJg1szafs2tKRfzc4KCH9oBbEdvcm+SbwUuZfeV
e4757CBAE3UnzKPVtZmOml3+pEG6hg==
=YhYV
-----END PGP SIGNATURE-----

--9tf588XKITo1QdfOqM5WxsHtSaKC0i2jW--
