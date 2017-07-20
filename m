Received: from eggs.gnu.org ([2001:4830:134:3::10]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDx5-0004N7-Qa
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDx4-0002In-Dy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:05:23 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-11-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc13b2a9-82be-e3d8-5a6b-4d29814c70e4@redhat.com>
Date: Thu, 20 Jul 2017 11:05:13 -0500
MIME-Version: 1.0
In-Reply-To: <1500560441-5670-11-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="avk5gNTNrkQEnKwsePAbOeI0pJp1FC3HP"
Subject: Re: [Qemu-devel] [PATCH V4 10/10] block/qcow2: add compress info to
 image specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--avk5gNTNrkQEnKwsePAbOeI0pJp1FC3HP
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <cc13b2a9-82be-e3d8-5a6b-4d29814c70e4@redhat.com>
Subject: Re: [PATCH V4 10/10] block/qcow2: add compress info to image specific
 info
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
 <1500560441-5670-11-git-send-email-pl@kamp.de>
In-Reply-To: <1500560441-5670-11-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 09:20 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/qcow2.c        | 9 +++++++++
>  qapi/block-core.json | 6 +++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 9eb76df..9310715 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -68,6 +68,9 @@
>  # @encrypt: details about encryption parameters; only set if image
>  #           is encrypted (since 2.10)
>  #
> +# @compress: details about parameters for compressed clusters; only se=
t if
> +#            the compress format header extension is present (since 2.=
10)

Would it be possible/wise to ALWAYS output compression information, even
if it is the older style zlib with small window and default level?  Made
easier if you can represent all tunables of zlib (where you special-case
writing the qcow2 header to omit the extension header when the user has
requested the defaults).

This is a new feature, and unfortunately we've missed soft freeze for
2.10.  You'll want to update your series to uniformly state since 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--avk5gNTNrkQEnKwsePAbOeI0pJp1FC3HP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw1LkACgkQp6FrSiUn
Q2r1Nwf+ILZYVphQJZLIXxtHpWuesNby0MoJKpi5h+7z1k+xANxHLBbqHH390Nff
r7e77CF9n0wm6JlZZl9zWgg4a0cxXA1WZQLkIH0gVqQzVaLKIxPWibh9l34tZ94C
iOxHLOFj8OAUppJzDgZBfv36rb4dI1frlIGkJnMzNgWefzZYdbULVtsXTva+uAcl
bpre8861gDOn/fOQfZuGSrCf3wVHxUQDnP3VpXQQytKbGZ8pdqPEPzeBt701K+rL
EdH4IMlpGH99u06kBLqKHDqrmEpgKahDMji3zys9N/A8+X8dKSH19NPkv/ETb1iU
mxeQnbiryuBno+XeKouK68kV9BFIwA==
=nQ17
-----END PGP SIGNATURE-----

--avk5gNTNrkQEnKwsePAbOeI0pJp1FC3HP--
