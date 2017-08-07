Received: from eggs.gnu.org ([2001:4830:134:3::10]:36852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degGC-0005HC-L3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degG7-00086G-Mn
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:31:48 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d11b533-b0d9-3246-7c48-340e65b25783@redhat.com>
Date: Mon, 7 Aug 2017 06:31:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vBOHkWMM6CoP08JN26wMnSfASkiLEeQ00"
Subject: Re: [Qemu-devel] [PATCH 01/17] nbd/client: fix nbd_opt_go
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vBOHkWMM6CoP08JN26wMnSfASkiLEeQ00
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <7d11b533-b0d9-3246-7c48-340e65b25783@redhat.com>
Subject: Re: [PATCH 01/17] nbd/client: fix nbd_opt_go
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Do not send NBD_OPT_ABORT to the broken server. After sending
> NBD_REP_ACK on NBD_OPT_GO server is most probably in transmission
> phase, when option sending is finished.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

But buggy servers aren't a severe enough problem to warrant this being
in 2.10.  I'll save this for 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vBOHkWMM6CoP08JN26wMnSfASkiLEeQ00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIT5EACgkQp6FrSiUn
Q2qWrwf+KB7UQjCDTeF+vC+ZcODWBc6frxnTS1q6jHTEFRXcZJE7/ExAYIaI5XXY
iMV3FYNS3dKttmfhxZ9obYzw1yR0AHz02jHHWxvVk79GuGQc84DDbN0Vv008sIuM
N+FbhmXpvO4mZlGwAL/nEZq9gKyd0BaU8ROVqaOQVfORCn2e96x9yI7gKGJjo8IF
UN4w4Z4cU1j5enRV6HouLgGhKiwnOt5gO6INDaD6MtK5YgaWhF1uBWGSvz1trD7M
ruwQ9fposBJeFxeByjcvyvT0EtNVVnILfDEJwce1Lp59G/Z23KPndLBs3pdJBnmk
oLtm3XTtlviHjuW653CqpKmTRIHmFA==
=fSyV
-----END PGP SIGNATURE-----

--vBOHkWMM6CoP08JN26wMnSfASkiLEeQ00--
