Received: from eggs.gnu.org ([209.51.188.92]:37388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVFQ-000650-EE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVFO-0006pl-Pz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:15:36 -0400
References: <20190405191635.25740-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ef529c2-714e-0764-d259-7bf65e8cd273@redhat.com>
Date: Fri, 5 Apr 2019 14:38:49 -0500
MIME-Version: 1.0
In-Reply-To: <20190405191635.25740-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="395omYHbbIFfEXpopBKmqDW2bfbacP0l7"
Subject: Re: [Qemu-devel] [PATCH for-4.1] qemu-nbd: Look up flag names in
 array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--395omYHbbIFfEXpopBKmqDW2bfbacP0l7
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6ef529c2-714e-0764-d259-7bf65e8cd273@redhat.com>
Subject: Re: [PATCH for-4.1] qemu-nbd: Look up flag names in array
References: <20190405191635.25740-1-mreitz@redhat.com>
In-Reply-To: <20190405191635.25740-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 2:16 PM, Max Reitz wrote:
> The existing code to convert flag bits into strings looks a bit strange=

> now, and if we ever add more flags, it will look even stranger.  Preven=
t
> that from happening by making it look up the flag names in an array.

At one point, I even considered using a QAPI type and expressing things
in a way where we could add an --output=3Djson and/or use our existing
QObject-to-human-readable formatters instead of open-coding things in
qemu-nbd.  But this patch is worthwhile in the meantime.

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Looking at the diff stat I can't claim this patch really improves
> anything by much, but the current code just pains me so.
> ---
>  include/block/nbd.h | 38 +++++++++++++++++++++++++------------
>  qemu-nbd.c          | 46 +++++++++++++++++----------------------------=

>  2 files changed, 43 insertions(+), 41 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Will apply through my NBD tree for 4.1 (no semantic change, so -rc3 is
indeed too late for taking this into 4.0)

Hmm. nbdkit uses a generated header that scrapes the definitions of
various bit values and produces automated value-to-name lookup
functions, rather than having to open-code the lookup functions. Perhaps
we could consider doing similar in qemu for even less code to maintain.


> +                [NBD_FLAG_SEND_CACHE_BIT]           =3D "cache",
> +            };
> +
>              printf("  size:  %" PRIu64 "\n", list[i].size);
>              printf("  flags: 0x%x (", list[i].flags);
> -            if (list[i].flags & NBD_FLAG_READ_ONLY) {
> -                printf(" readonly");
> -            }

I'm also wondering if I should have added another nbd_*_lookup()
function in nbd/common.c to do this lookup (even if we still like the
array approach over open-coding, and whether or not we like the idea of
generating things from the .h, having all of the lookup functions in one
place and style makes more sense than special-casing NBD_FLAG_ lookups
to just live in qemu-nbd.c).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--395omYHbbIFfEXpopBKmqDW2bfbacP0l7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlynrskACgkQp6FrSiUn
Q2q5Qwf8DJuVUGdyefrbTX4TnxssiYEz9M51TzaSGAuGnK+CjYnbLoncC53CPWmt
GaA+nVEE7sJkXENuQzcRIimdZC1KOV0WT7ZOqkHXdLbmZVwitNt9IzfiYa9KNkg1
2WjaySejpS0rI6DXZZupDP0Kame83aI3J5kVr7yD64pvB+S7Lb+xEPolof67TM/f
/3CYAAEKhrkDvCQj7LKaYkG/p+GICxOQR5KZo9HGNZgsKHo+Xup8alwnDmoz85yu
0psNZyi5S8F/UccKChI01smHf0lcO8xfBxY1Wo9i6XljCdEGH9kunFFyER9FSBWs
Diw+A0AlFbaNPiVlyNB/hHqwSBEHXA==
=YN/h
-----END PGP SIGNATURE-----

--395omYHbbIFfEXpopBKmqDW2bfbacP0l7--
