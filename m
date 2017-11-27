Received: from eggs.gnu.org ([2001:4830:134:3::10]:49698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJPsC-0001y2-Ki
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJPs9-0005Bg-HW
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:19:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eJPs9-0005BM-AQ
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:19:21 -0500
References: <20171127174944.12362-1-vapier@gentoo.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e35413fd-d695-2ae1-4a0a-5cc3ccf7d038@redhat.com>
Date: Mon, 27 Nov 2017 14:19:18 -0600
MIME-Version: 1.0
In-Reply-To: <20171127174944.12362-1-vapier@gentoo.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IcnJXSBQxQ1ing9jjtNJ2IWxSPeFHG9Ar"
Subject: Re: [Qemu-devel] [PATCH] build: fix typo in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Frysinger <vapier@gentoo.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IcnJXSBQxQ1ing9jjtNJ2IWxSPeFHG9Ar
From: Eric Blake <eblake@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
Message-ID: <e35413fd-d695-2ae1-4a0a-5cc3ccf7d038@redhat.com>
Subject: Re: [PATCH] build: fix typo in error message
References: <20171127174944.12362-1-vapier@gentoo.org>
In-Reply-To: <20171127174944.12362-1-vapier@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/27/2017 11:49 AM, Mike Frysinger wrote:
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index 030617b4ac0c..bc7224a27fe3 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -24,7 +24,7 @@ error() {
>      echo "Alternatively you may disable automatic GIT submodule checko=
ut"
>      echo "with:"
>      echo
> -    echo " $ ./configure --disable-git-update'"
> +    echo " $ ./configure --disable-git-update"

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IcnJXSBQxQ1ing9jjtNJ2IWxSPeFHG9Ar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlocc0YACgkQp6FrSiUn
Q2rfYQf/edXzWnYAMd84s786hbirbEWd3FcJ9gEfglxwPkBHcOyyBwMwtZ/ZMPuV
HqC2LtkBY25O8B/0ZCNxibDy3D2WIG8OdtsBj2gwbsbhir7s4DHhVozLwTRR69jF
pEPUcgX1TUz/goEoWqxQbTWtQdKKVVKW/2lYn+oFnUItzibeWz0SytXWEwIV0ES9
3/NFmQjQlyW/CHN61LWtCc5TwWTS3s7Ps95lDkxWfNGmERCFGZSo/s10VCBUbl9d
Vz7pbolQfA3S7yv2LX0ya49bnaEge9ztSLlsHzZyN1yCdTPTYHLvx9HmJzG8KaPT
RdewvzASku4KX1fBqbU/hug3k6tNqQ==
=j4XH
-----END PGP SIGNATURE-----

--IcnJXSBQxQ1ing9jjtNJ2IWxSPeFHG9Ar--
