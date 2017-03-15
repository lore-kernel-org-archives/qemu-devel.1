Received: from eggs.gnu.org ([2001:4830:134:3::10]:54577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnwyl-0006Y5-1w
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnwyh-00012n-Tm
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnwyh-00011d-KX
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:39:47 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-42-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2468ae56-a6df-787b-bc4c-83084f295518@redhat.com>
Date: Tue, 14 Mar 2017 19:39:42 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-42-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vvcRj8adwhkBPBj4D4XTK5Ka4DinBX9f5"
Subject: Re: [Qemu-devel] [PATCH for-2.9 41/47] qapi: Factor add_name()
 calls out of the meta conditional
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
--vvcRj8adwhkBPBj4D4XTK5Ka4DinBX9f5
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <2468ae56-a6df-787b-bc4c-83084f295518@redhat.com>
Subject: Re: [PATCH for-2.9 41/47] qapi: Factor add_name() calls out of the
 meta conditional
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-42-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-42-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

>  def add_enum(definition, info):
>      global enum_types
> -    name =3D definition['enum']
> -    add_name(name, info, 'enum', 'data' not in definition)

Here, we were passing a potential True for the 'implicit' parameter...


> +        name =3D expr[meta]
> +        add_name(name, info, meta)

=2E..here, we always pass False, but that's okay (an explicit enum always=

has 'data'),

>          if doc and doc.symbol !=3D name:
>              raise QAPISemError(info, "Definition of '%s' follows docum=
entation"
>                                 " for '%s'" % (name, doc.symbol))
> @@ -974,6 +967,7 @@ def check_exprs(exprs):
>          else:
>              continue
>          add_enum({ 'enum': name }, expr_elem['info'])
> +        add_name(name, info, 'enum', implicit=3DTrue)

=2E..and here is the only place that was getting implicit=3DTrue.  Took m=
e a
while to see it, but the refactoring is sane.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vvcRj8adwhkBPBj4D4XTK5Ka4DinBX9f5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyI1OAAoJEKeha0olJ0Nq3XAH/1QDWhAGI/wkmktk3nb7bCj6
tNti/F4VotkQyI/1atzL4C/jNu8rcnmooEZad/YCntPkRIJuBonPR7GVAAAZom2z
Nyfc4A15IfMK3M9DXVoXkHH6Rr9Jdm/bP0Cke8nhVbB2jzmuFvzeR+bSfk17JMSA
QcfCsa9clP4qub0UXMiNxLSgrw/H8g//k7nUSCUBWZ9bK2GEZ7SMRBDAqVxADsDQ
LduoJctnCLoU1TW/LTAXJp78GsMrbVjBAeEypC1CzDIBlIrZwIJ8T9FoBjX/VViS
Wc0xM1QGi6GE1WYtww48AkUPS4fooxe/oLZV2BMAWDNL712SxRZppl3ikCXXr78=
=xTZB
-----END PGP SIGNATURE-----

--vvcRj8adwhkBPBj4D4XTK5Ka4DinBX9f5--
