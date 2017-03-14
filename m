Received: from eggs.gnu.org ([2001:4830:134:3::10]:55267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnonB-0004IZ-Hv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnon7-0001xu-M2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnon7-0001xh-Dn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:55:17 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1617dab3-b1cd-c24b-5084-e39af4683ed8@redhat.com>
Date: Tue, 14 Mar 2017 10:55:14 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sDfiH9Nh7xPAFKd9bRSfIGTCvXFhG9D3I"
Subject: Re: [Qemu-devel] [PATCH for-2.9 07/47] qapi: Clean up build of
 generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sDfiH9Nh7xPAFKd9bRSfIGTCvXFhG9D3I
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <1617dab3-b1cd-c24b-5084-e39af4683ed8@redhat.com>
Subject: Re: [PATCH for-2.9 07/47] qapi: Clean up build of generated
 documentation
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Rename intermediate qemu-qapi.texi to qemu-qmp-qapi.texi to match its
> user qemu-qmp-ref.texi, just like qemu-ga-qapi.texi matches
> qemu-ga-ref.texi.
>=20
> Build the intermediate .texi next to the sources and the final output
> in docs/ instead of dumping them into the build root.
>=20
> Fix version.texi dependencies so that only the targets that actually
> need it depend on it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  .gitignore             | 10 +++++-----
>  Makefile               | 27 +++++++++++++++------------
>  docs/qemu-qmp-ref.texi |  2 +-
>  rules.mak              |  2 +-
>  4 files changed, 22 insertions(+), 19 deletions(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index 2849d75..0e99e6a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -103,11 +103,11 @@
>  /docs/qemu-ga-ref.txt

[1]

>  /docs/qemu-qmp-ref.html
>  /docs/qemu-qmp-ref.txt
> -docs/qemu-ga-ref.info*
> -docs/qemu-qmp-ref.info*
> -/qemu-ga-qapi.texi
> -/qemu-qapi.texi
> -/version.texi
> +/docs/qemu-ga-ref.info*

worth sorting this line up by [1]?

> +/docs/qemu-qmp-ref.info*
> +/docs/qemu-ga-qapi.texi
> +/docs/qemu-qmp-qapi.texi
> +/docs/version.texi
>  *.tps
>  .stgit-*
>  cscope.*
> @@ -663,25 +663,28 @@ ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
> =20
>  # documentation
>  MAKEINFO=3Dmakeinfo
> -MAKEINFOFLAGS=3D--no-split --number-sections
> +MAKEINFOFLAGS=3D--no-split --number-sections -I docs

Will this cause grief on any older makinfo versions (such as RHEL 6)?  I
didn't test myself on those setups.  I guess if a buildbot doesn't flag
you, it's okay.

The sorting issue is worth fixing, but trivial, so you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sDfiH9Nh7xPAFKd9bRSfIGTCvXFhG9D3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBJiAAoJEKeha0olJ0NqYWwH/3B2uSaegVzftzPLCebZbeen
zYXKVTngCEwvV2aOPXk5OvJkq2k8d3TIUgkYalAQ/wU/heJEyw2LUyE1HCgDKble
tr4Qd6HhBPr0YT7/CTISpvciWeiWDSOXbMySOTc0ozmFmXpQO0vSiXbnHibh3/uh
6ty6QIlciv8kkXIZycKrk/sZ193e4M8vdnHZLV9mqfTikbm6J3Qmd/jid5VUcQtf
sXPa8GSpG3YJMNZG7FZ9aT5yJW4oO5MoJLvGjxpS56mk4GLSd8pT/XeGUYvYhane
zsYwU50Y41fY+eXAFpptKFHdzBYGjxI+JfCV9SVBmRmz9YCb7Mv4YoZKbzBiSxw=
=U72J
-----END PGP SIGNATURE-----

--sDfiH9Nh7xPAFKd9bRSfIGTCvXFhG9D3I--
