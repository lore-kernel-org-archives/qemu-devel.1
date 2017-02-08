Received: from eggs.gnu.org ([2001:4830:134:3::10]:44697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbXo3-0006AZ-Ak
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbXny-0004RZ-FS
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:21:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cbXny-0004Qw-6a
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:21:26 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A59FB80488
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 19:21:24 +0000 (UTC)
References: <1486569864-17005-1-git-send-email-armbru@redhat.com>
	<1486569864-17005-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6aa70c19-2c6a-a865-756d-3c10f47bbd35@redhat.com>
Date: Wed, 8 Feb 2017 13:21:22 -0600
MIME-Version: 1.0
In-Reply-To: <1486569864-17005-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eVCKt0ANaerf1GiqA072lhgeQHblp2NtH"
Subject: Re: [Qemu-devel] [PATCH 1/2] numa: Turn simple union NumaOptions
 into a flat union
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
--eVCKt0ANaerf1GiqA072lhgeQHblp2NtH
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6aa70c19-2c6a-a865-756d-3c10f47bbd35@redhat.com>
Subject: Re: [PATCH 1/2] numa: Turn simple union NumaOptions into a flat union
References: <1486569864-17005-1-git-send-email-armbru@redhat.com>
 <1486569864-17005-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1486569864-17005-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/08/2017 10:04 AM, Markus Armbruster wrote:
> Simple unions are simpler than flat unions in the schema, but more
> complicated in C and on the QMP wire: there's extra indirection in C
> and extra nesting on the wire, both pointless.  They're best avoided
> in new code.
>=20
> NumaOptions isn't new, but it's only used internally, not in QMP.
> Convert it to a flat union.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  numa.c           | 4 ++--
>  qapi-schema.json | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20

> +++ b/qapi-schema.json
> @@ -5545,6 +5545,12 @@
>              'events' : [ 'InputEvent' ] } }
> =20
>  ##
> +# @NumaOptionsType:
> +##

Do we want a 'Since: 2.1' designation (since the enum has effectively
existed, even if implicitly, for as long as NumaOptions has been around)?=


With or without that extra line,
Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eVCKt0ANaerf1GiqA072lhgeQHblp2NtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYm2+yAAoJEKeha0olJ0NqvfUIAKq+1bmGXr+Ew5RcAeoDl47S
fmS9AusguTRnw9Ffl60BtNU2ET+xPxearaIs51m0nFPWTqsIHI0sWK/TwAiMj75U
FMdX2THlwA7DI/hQslB60yAe7dHGuHiKLyvFskD84f+eC7FO2llawSFKMog+5mq7
a2nh00hyXO0unlQy6GGsg2ThCY+KM9cZBnRpSigiLORuiv117Y9iPP4FTxe/OvPS
uE3l/SSZcFomS3E/yyB8zxQpbY+/Luu6+e4peXo58vJIGNBXD0OlMu+fmg5//Nyv
LIr8qXngRagT54uaIoS66/MqIUF2NfwYIEWupl3o63F3Jl9UfNbX0ulkgcoBirE=
=JbDU
-----END PGP SIGNATURE-----

--eVCKt0ANaerf1GiqA072lhgeQHblp2NtH--
