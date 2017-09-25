Received: from eggs.gnu.org ([2001:4830:134:3::10]:49589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwVxV-0001QO-Pk
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwVxQ-0003ZL-5h
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:10:13 -0400
References: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <759768e1-9acb-c14b-7136-743cba166ef0@redhat.com>
Date: Mon, 25 Sep 2017 11:10:05 -0500
MIME-Version: 1.0
In-Reply-To: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HnrK0Jq9WXGxGU4G71aMBsKaH9idn1heh"
Subject: Re: [Qemu-devel] [PATCH 2/2] thunk.h uses TARGET_ABI_BITS without
 including abitypes.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Loffgren <daniel@loffgren.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HnrK0Jq9WXGxGU4G71aMBsKaH9idn1heh
From: Eric Blake <eblake@redhat.com>
To: Daniel Loffgren <daniel@loffgren.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <759768e1-9acb-c14b-7136-743cba166ef0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] thunk.h uses TARGET_ABI_BITS without
 including abitypes.h
References: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
In-Reply-To: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/24/2017 08:02 PM, Daniel Loffgren wrote:
>=20
> Signed-off-by: Daniel Loffgren <daniel@loffgren.org>
> ---
>  include/exec/user/thunk.h | 1 +
>  1 file changed, 1 insertion(+)

meta-comment: your patch is titled 2/2, but was sent as its own
top-level thread (it is missing In-Reply-To: and References: headers).
When sending 2 patches as a series, it is important to include a 0/2
cover letter, and to properly thread things so that both 1/2 and 2/2 are
in-reply-to the 0/2 cover letter.  'git send-email' is probably the
easiest way to get this to work.  More patch submission hints at:

https://wiki.qemu.org/Contribute/SubmitAPatch

>=20
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index f19ef4b230..12b5449d8c 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -19,6 +19,7 @@
>  #ifndef THUNK_H
>  #define THUNK_H
> =20
> +#include "abitypes.h"
>  #include "cpu.h"
> =20
>  /* types enums definitions */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HnrK0Jq9WXGxGU4G71aMBsKaH9idn1heh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJKl0ACgkQp6FrSiUn
Q2rrGwgAj31yX/3yjvXmms6OP+Bj+LASQpfjsh6Lwr/70AY2T4cuhPk18gO/HhmC
0ANYDicLd1emZzqyrjApNsl12QBx5UEShC3Ak6nSz2mx/sgOrdPjANErbiIluKIN
anirSW/cVq1O6zVJCfHd1WxVVwrz3kgzbWvBPbXLTh8ivAQCKvMJYDEGzPXE52NW
MNs3K3deWdNCvd7UCBIh+48kVRJtEpWaovdz0q2ispF6OHRiMIM5yE7CMT70zKub
zR1J8Oxsy7ZxEUU4ftKfioTZAU3vOXgzEwLbbw5dJoggDMAsS/mwvvwtWMqcKGOr
0WodizLeJ0pwIYiuqNvsbZPNB7iPkg==
=11HH
-----END PGP SIGNATURE-----

--HnrK0Jq9WXGxGU4G71aMBsKaH9idn1heh--
