Received: from eggs.gnu.org ([2001:4830:134:3::10]:45742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqK35-0007O6-KI
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqK32-000757-JK
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:42:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqK32-00074f-9K
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49B5331B31A
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 13:42:04 +0000 (UTC)
References: <20170316112016.26450-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5aeb775b-a59e-3a0a-4c02-a5ef2a951943@redhat.com>
Date: Tue, 21 Mar 2017 08:42:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170316112016.26450-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kxiIvLoKuTqo3P0FourahnW9iP9M1mb48"
Subject: Re: [Qemu-devel] [PATCH] List SASL config file under the
 cryptography maintainer's realm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kxiIvLoKuTqo3P0FourahnW9iP9M1mb48
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5aeb775b-a59e-3a0a-4c02-a5ef2a951943@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] List SASL config file under the cryptography
 maintainer's realm
References: <20170316112016.26450-1-berrange@redhat.com>
In-Reply-To: <20170316112016.26450-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 06:20 AM, Daniel P. Berrange wrote:
> No one is listed as maintainer for qemu.sasl. It is used by the
> VNC server for SASL auth, but since it is cryptography related,
> list it under the crytography maintainer's realm, rather than
> under the UI maintainer.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf1aafb..ecf8273 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1462,6 +1462,7 @@ S: Maintained
>  F: crypto/
>  F: include/crypto/
>  F: tests/test-crypto-*
> +F: qemu.sasl
> =20
>  Coroutines
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kxiIvLoKuTqo3P0FourahnW9iP9M1mb48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0S2oAAoJEKeha0olJ0NqzEcH/1R6L3NSEk3uVKF9qwCK/9hi
RhsYde8aFR6Mypq3paRvVYxuKzPW7TGZpmO1m/ds+tQecFhAPv9/yqOyfZFwDCBm
bAoKZL+IyfNO9XFZC8I3tQuwTVIbbU2PGalAPlvi9Ec4wFGaiyLJJFgVUxo/MwPW
4ezdyjdZ+Q2Yxt0gC3VdJozUNjjyBQdot8nBWGF0uhX0M8OAivd/tP7pe8AF8kEd
Io1TfrYPDfuSU3s50GfSDckLjbWx+SmxysvRWW6bfwdgKkVvhUzPocLZfKQIqQ4L
xhFjUv3ICKMIC7MXR8CM7SIl6+vtMPiwLACFi5qw3gdtNLznSdfn09Nya0PdtHU=
=FwJX
-----END PGP SIGNATURE-----

--kxiIvLoKuTqo3P0FourahnW9iP9M1mb48--
