Received: from eggs.gnu.org ([2001:4830:134:3::10]:42712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9ia-0005hK-DY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9iV-0000fg-QX
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db9iV-0000fM-H9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:10:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AC706AA3D
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 18:10:26 +0000 (UTC)
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
	<1501249552-788-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <17d849ae-e99c-0f8a-5f38-374e8938cbe5@redhat.com>
Date: Fri, 28 Jul 2017 13:10:25 -0500
MIME-Version: 1.0
In-Reply-To: <1501249552-788-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qdor59RwVR9EsoObm0GupUqqwMMmeidEa"
Subject: Re: [Qemu-devel] [PATCH 3/3] block: Remove unused
 BlockDeviceMapEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qdor59RwVR9EsoObm0GupUqqwMMmeidEa
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17d849ae-e99c-0f8a-5f38-374e8938cbe5@redhat.com>
Subject: Re: [PATCH 3/3] block: Remove unused BlockDeviceMapEntry
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
 <1501249552-788-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1501249552-788-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:45 AM, Markus Armbruster wrote:
> BlockDeviceMapEntry has never been used.  It was added in commit
> facd6e2 "so that it is published through the introspection mechanism."
> What exactly introspecting types that aren't used for anything could
> accomplish isn't clear.  What "introspection mechanism" to use is also
> nebulous.  To the best of my knowledge, there has never been one that
> covered this type.  Certainly not query-qmp-schema, which includes
> only types that are actually used in QMP.
>=20
> Not being able to introspect BlockDeviceMapEntry hasn't bothered
> anyone enough to complain in almost four years.  Get rid of it.

This type is the schema for 'qemu-img map --output=3Djson'.  And I had a
patch once (that I need to revive) that added a JSON Output visitor; at
which point I fixed qemu-img to convert from QAPI to JSON instead of
open-coding its construction of its output string, at which point the
QAPI generated code for this type is useful.

But that's a revert away for when I rebase my series to actually use it;
and in the meantime, pruning unused types isn't hurting anything.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qdor59RwVR9EsoObm0GupUqqwMMmeidEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7fhEACgkQp6FrSiUn
Q2pD7QgAlA/WpelTbaPWHg/Yerg3TjwvJ81l0UaghHBDk02eazUAopyXljJwIWGA
SqDmnzZ/tcoO5fUstnN9/OxWEQoFYk1tzWGyyrFvgqmQwj9ioTdipPhMFZUjD8Wb
+xiLGT2D6u2nYPWM42CQ81THsvBGWOsbBGI4mYtEQfa4PEbnjx/kUjaMk1Q2t8qr
Gvp7psGO2KZ9COOVyzT6pPFuj6GJvo766tsjlUeR4Tl+zHUXjKyZQ6GCvsHfZpr/
IOJF+pq1GR8pyUXka6T2oHP9qbTSak5eVc90ljtU0uQUsxF7ERPABtaOjMewOHEW
AvkpUYMvMc20RA9GAcauKKngsCFZ6w==
=ps/V
-----END PGP SIGNATURE-----

--qdor59RwVR9EsoObm0GupUqqwMMmeidEa--
