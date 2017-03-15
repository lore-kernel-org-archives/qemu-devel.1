Received: from eggs.gnu.org ([2001:4830:134:3::10]:48533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAJ1-0005pK-3V
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAIx-0006uB-6m
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coAIw-0006u2-Un
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:53:35 -0400
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
	<1489582656-31133-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <441d44c7-feae-c49d-36f7-5b4c18d4b76d@redhat.com>
Date: Wed, 15 Mar 2017 09:53:31 -0500
MIME-Version: 1.0
In-Reply-To: <1489582656-31133-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wf3c3SmARlBirBV9sHelNDrgxQt6G1kae"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 06/47] qapi: Have each QAPI
 schema declare its name rule violations
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
--wf3c3SmARlBirBV9sHelNDrgxQt6G1kae
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <441d44c7-feae-c49d-36f7-5b4c18d4b76d@redhat.com>
Subject: Re: [PATCH v2 for-2.9 06/47] qapi: Have each QAPI schema declare its
 name rule violations
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
 <1489582656-31133-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 07:56 AM, Markus Armbruster wrote:
> qapi.py has a hardcoded white-list of type names that may violate the
> rule on use of upper and lower case.  Add a new pragma directive
> 'name-case-whitelist', and use it to replace the hard-coded
> white-list.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wf3c3SmARlBirBV9sHelNDrgxQt6G1kae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyVVrAAoJEKeha0olJ0NqC/oH/0QEPyavG6LT2phGMdyIriEO
Sylt7Nwk1QfZT3tcm/+Yzs/vdPCcZCFpGcNq6qtabxcFbs30Hq/49Q3J4xB+wbl5
5sEyO5gNoZQIHdmqmL8X43i6DxpMrN2Mo29gcqYeGFj1kFxjV0HN8HnIGS82lNvH
22D50dtWSDxrGNm9XdbuVy40ol4i4jjE74YahUmpFfxafVKAKU4JNia1Gzd6v/JF
oN3XxOr+FNEYBjJOuNW+AZRVdNP0lKbz4YlQJ92aSWLnDO3pqRf+08kBxj+5+7GE
g9KhbtRtT46i448bauj6pOzPdWi5DknWi84OveCby71eD0CO+9g1bqRTmAHUxms=
=3Vxa
-----END PGP SIGNATURE-----

--wf3c3SmARlBirBV9sHelNDrgxQt6G1kae--
