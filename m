Received: from eggs.gnu.org ([2001:4830:134:3::10]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAkCH-0003CI-Fk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 17:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAkCD-0001y8-Es
	for qemu-devel@nongnu.org; Tue, 16 May 2017 17:40:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAkCD-0001y0-5P
	for qemu-devel@nongnu.org; Tue, 16 May 2017 17:39:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3FCBC04B92C
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 21:39:55 +0000 (UTC)
References: <20170516205351.12101-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2776e729-5ac8-a905-790e-59bf4f6370b5@redhat.com>
Date: Tue, 16 May 2017 16:39:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170516205351.12101-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XeBehHofOJvIIowFNnMs6Ddqx9QWFG4Cv"
Subject: Re: [Qemu-devel] [PATCH] qapi-schema: Remove obsolete note from
 ObjectTypeInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XeBehHofOJvIIowFNnMs6Ddqx9QWFG4Cv
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <2776e729-5ac8-a905-790e-59bf4f6370b5@redhat.com>
Subject: Re: [PATCH] qapi-schema: Remove obsolete note from ObjectTypeInfo
References: <20170516205351.12101-1-ehabkost@redhat.com>
In-Reply-To: <20170516205351.12101-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/16/2017 03:53 PM, Eduardo Habkost wrote:
> The "This command is experimental" note in ObjectTypeInfo is obsolete
> since 2012.  Commit 5192082097549c5b3aa7c913c6853d97a68172cb removed th=
e
> warning from the qom-list-types command documentation, but we forgot to=

> remove the warning from ObjectTypeInfo.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi-schema.json | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 80603cfc51..e6da88585a 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3035,8 +3035,6 @@
>  # @name: the type name found in the search
>  #
>  # Since: 1.1
> -#
> -# Notes: This command is experimental and may change syntax in future =
releases.
>  ##
>  { 'struct': 'ObjectTypeInfo',
>    'data': { 'name': 'str' } }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XeBehHofOJvIIowFNnMs6Ddqx9QWFG4Cv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZG3GgAAoJEKeha0olJ0NqLVQH+wZ24LYVFyWD5XrZH7ixqUXN
gkQSzM/mG80IDKYphDURhymKCZ109PY+O/tQLGxG7o7JGwrBh726eb10UyMEnzsK
GueeUVI312Lo9g1Yo4YtWZAY/O872QrhytNKJ2t/S2iRI0Zh+NtHQ9id6/DNu5Rf
oX7KR/R9hUIN3i3TSYNH2y8ZeOUa+x7tXQ/sOfW2tB5hJc+xBVGCRGQZgAgKMZ4y
G2TVB7+6o1w9LW53OTyTbwTMl1VYK1I/W0qrVbJ9GqhRMiD229KOSfZ02YyCWz4A
VUuc7nWgEyGylJc1E3GQKMDrlgyf/lh4Ed8AjwZ89OCjCAajFWByolIOZ8e0EiQ=
=no5a
-----END PGP SIGNATURE-----

--XeBehHofOJvIIowFNnMs6Ddqx9QWFG4Cv--
