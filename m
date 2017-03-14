Received: from eggs.gnu.org ([2001:4830:134:3::10]:41956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsX2-0004Cy-DP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsWx-0004Ug-TV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnsWx-0004Sj-Kc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:54:51 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-29-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a65779c-0b82-fcfe-707f-222ba3cb024d@redhat.com>
Date: Tue, 14 Mar 2017 14:54:47 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-29-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iIX8DmTI1xUWse2P6EABX9EEN0bntj3qI"
Subject: Re: [Qemu-devel] [PATCH for-2.9 28/47] qapi2texi: Generate
 descriptions for simple union tags
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
--iIX8DmTI1xUWse2P6EABX9EEN0bntj3qI
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <4a65779c-0b82-fcfe-707f-222ba3cb024d@redhat.com>
Subject: Re: [PATCH for-2.9 28/47] qapi2texi: Generate descriptions for simple
 union tags
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-29-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-29-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Simple union tags carry no type information, because their type is
> implicit.  Their description should make up for it, but many have
> none.  Generate one automatically then.
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Simple Union: ImageInfoSpecific
>=20
>       A discriminated record of image format specific information
>       structures.
>=20
>       Members:
>       'type'
> -          Not documented
> +          One of "qcow2", "vmdk", "luks"

Yes, that's nicer.

>       'data: ImageInfoSpecificQCow2' when 'type' is "qcow2"
>       'data: ImageInfoSpecificVmdk' when 'type' is "vmdk"
>       'data: QCryptoBlockInfoLUKS' when 'type' is "luks"
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iIX8DmTI1xUWse2P6EABX9EEN0bntj3qI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyEqHAAoJEKeha0olJ0NqMWQH/AkBhvRXe875sLXA0w+kX6/8
rSQLfyChcGHaTe8ST70M3zL44Yuz1M7XX4eBQBQONLB3pIrS5/p1+gRp/PTKus9h
RD491f6P0zHOCeIg86qdpIRHNh9Fh6S08Tf7yjPnt1DiTZQxbw5oe6p4hS1gByWV
gNYDx4vUh2pRDQj/LiF/EHcocv6YK6gPkLTKee2U0Ce1vMn6MKXeTjOjGy83W9Tt
/rlRI+BC8XctQWLvGP4b0KSogBqkRic9nUqs2AF3kji5sJJ/+BYX0XWKyrR78UhG
YdDDq8EQjO6yKLViAmg2/wKpYyr8KOrXN5RFgc6Q0XEJUt3uegVCl4R5v2dWgo8=
=y6hb
-----END PGP SIGNATURE-----

--iIX8DmTI1xUWse2P6EABX9EEN0bntj3qI--
