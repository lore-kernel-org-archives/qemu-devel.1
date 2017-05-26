Received: from eggs.gnu.org ([2001:4830:134:3::10]:38571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMPN-0002G5-BB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMPM-0004TF-Ac
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:04:29 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdf0cd74-3bf4-78cf-3419-506af1ff3165@redhat.com>
Date: Fri, 26 May 2017 16:04:18 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tMEWlnUBObLSLIKpnRKMq4LC4dfOcsl7C"
Subject: Re: [Qemu-devel] [PATCH 02/29] qed: Make qed_read_table()
 synchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tMEWlnUBObLSLIKpnRKMq4LC4dfOcsl7C
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <bdf0cd74-3bf4-78cf-3419-506af1ff3165@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/29] qed: Make qed_read_table() synchronous
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-table.c | 56 ++++++++++++++++++-----------------------------=
--------
>  1 file changed, 18 insertions(+), 38 deletions(-)
>=20
> diff --git a/block/qed-table.c b/block/qed-table.c
> index b12c298..f330538 100644
> --- a/block/qed-table.c
> +++ b/block/qed-table.c
> @@ -18,59 +18,39 @@
>  #include "qed.h"
>  #include "qemu/bswap.h"

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tMEWlnUBObLSLIKpnRKMq4LC4dfOcsl7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJhSAAoJEKeha0olJ0NqUVsIAJpYaIBqUy+geFfro5B1vj34
VcnSX9EXAZjYAk++TCXbVovpv/jDjQzJbNwdI0lhFcoOaDwJ4+JtIDtIhCmU98JS
q9/MwrSgsbXeXIcyBgncF+P4butv4ixIfkmsBprOApPE4FC88G5FNMsEYEXwZDF8
WPMoGdHMcRZdiLQhGvaGXfeiVGcIQjY4w3Ej3vqLpjL72YJxmHz0MIb6dyzV25oM
llWJ9i5AGweKFbWlrInunAf1PqzIivhyDYErWSHVpLNxbpzaLebcncvI775GThRb
9jb9oGBUVnzSAU2KD6XDxkIylIM0Ve4r1q1+/a23HvZ9pLva7j1+L79vsIb9laA=
=vWYb
-----END PGP SIGNATURE-----

--tMEWlnUBObLSLIKpnRKMq4LC4dfOcsl7C--
