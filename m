Received: from eggs.gnu.org ([2001:4830:134:3::10]:41314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcG7p-0006bN-Lp
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcG7o-0007vf-ND
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:13:09 -0400
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501518125-29851-10-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fca27768-2415-e70a-827d-9fb4016baf96@redhat.com>
Date: Mon, 31 Jul 2017 14:13:00 -0500
MIME-Version: 1.0
In-Reply-To: <1501518125-29851-10-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C9uvvGvbN9cH7XU9dDHoH6HUxQIP86JcE"
Subject: Re: [Qemu-devel] [PATCH v3 09/13] qcow2: move is_zero_sectors() up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C9uvvGvbN9cH7XU9dDHoH6HUxQIP86JcE
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <fca27768-2415-e70a-827d-9fb4016baf96@redhat.com>
Subject: Re: [PATCH v3 09/13] qcow2: move is_zero_sectors() up
References: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1501518125-29851-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501518125-29851-10-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 11:22 AM, Anton Nefedov wrote:
> To be used in the following commit without a forward declaration.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)

This conflicts with my byte-based block status work; do you want to
rebase on top of my posts?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C9uvvGvbN9cH7XU9dDHoH6HUxQIP86JcE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/gTwACgkQp6FrSiUn
Q2rH5Af/TGTPL+wBLVlCglIarg6gQDF6iBuPYBeAylww/agaypOvso0pwgjZlgbo
yR5JU3DTZVoSTfi2YhUaE9o0k+n3oXtLzstTBZ0ygqIarmsms6D5mSExLJD4op6U
C5kHQ+4LduIsUUR7A40W8jicam9+Gd/VHINKlq5/ViT+uoI54X4zs94C8iv2lZiP
vGumhyUjk8CMC8ZRTkXoKHdc3UyfzCo4x77pqzJ736mPvp1g1LeVwOpUhq+Dlpyl
298an/hFkKHxE4RsLtk4H29Ntn54xMNCh7177OpzJ6zfrBcMAqLXppznRR7UPocL
VVcyjPryKE4jvm5flRoeB1ssC0P1qQ==
=bkbE
-----END PGP SIGNATURE-----

--C9uvvGvbN9cH7XU9dDHoH6HUxQIP86JcE--
