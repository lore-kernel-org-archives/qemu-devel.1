Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbXpV-000789-Lu
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbXpQ-0004xB-Q7
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:23:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cbXpQ-0004wn-Hb
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:22:56 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0BA4C05AA41
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 19:22:56 +0000 (UTC)
References: <1486569864-17005-1-git-send-email-armbru@redhat.com>
	<1486569864-17005-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <933f91ec-9c2f-2135-f30c-a49a5081c32d@redhat.com>
Date: Wed, 8 Feb 2017 13:22:54 -0600
MIME-Version: 1.0
In-Reply-To: <1486569864-17005-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mLSBDsDgXNhDhWjRd9jHcxRU0j9V17HEB"
Subject: Re: [Qemu-devel] [PATCH 2/2] net: Turn simple union
 NetLegacyOptions into a flat union
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mLSBDsDgXNhDhWjRd9jHcxRU0j9V17HEB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <933f91ec-9c2f-2135-f30c-a49a5081c32d@redhat.com>
Subject: Re: [PATCH 2/2] net: Turn simple union NetLegacyOptions into a flat
 union
References: <1486569864-17005-1-git-send-email-armbru@redhat.com>
 <1486569864-17005-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1486569864-17005-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/08/2017 10:04 AM, Markus Armbruster wrote:
> Simple unions are simpler than flat unions in the schema, but more
> complicated in C and on the QMP wire: there's extra indirection in C
> and extra nesting on the wire, both pointless.  They're best avoided
> in new code.
>=20
> NetLegacyOptions isn't new, but it's only used internally, not in QMP.
> Convert it to a flat union.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  net/net.c        | 44 ++++++++++++++++++++++----------------------
>  qapi-schema.json |  9 +++++++++
>  2 files changed, 31 insertions(+), 22 deletions(-)
>=20

> +++ b/qapi-schema.json
> @@ -3934,6 +3934,13 @@
>      'opts':  'NetLegacyOptions' } }
> =20
>  ##
> +# @NetLegacyOptionsType:
> +##

Same question as previous patch about a 'Since: 1.2' designation.  Same
end result of:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--mLSBDsDgXNhDhWjRd9jHcxRU0j9V17HEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYm3AOAAoJEKeha0olJ0NqDoMH/08TpDQmBSw7gzQI16O39aX3
/I91PUMIhLMfjVLoMT/x2490R89Zh6zUupM1ofgGMtfEuwEJuDsMtJMuxJv7OG8u
A8J44dHhPg/jGJ+7KASUGPyVaBQCdg95FLcBrg0cejjvGmsO5ufv559KWIOxGQKm
5FxzZ66njkwMhfQAP0AW9/yYJStObact4N4LVCiSBW//oaocgWN5mKjyaVAh5ZOJ
vcI2n+bWUiVN3qVDL2zrmJESDOYLJcMgDhfow5HMPyJ8uoT+EbANjvQmmEzSoiPv
CAO3BTx1kIeh9EugmzoiD6JuN2SmIEN+0w1+ggDkUzXXN9N9u68S/oBFarnDyQU=
=H0IY
-----END PGP SIGNATURE-----

--mLSBDsDgXNhDhWjRd9jHcxRU0j9V17HEB--
