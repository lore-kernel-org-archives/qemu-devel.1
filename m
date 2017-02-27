Received: from eggs.gnu.org ([2001:4830:134:3::10]:50017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciORP-0001QG-Mu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciORM-0005Ez-Kg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:46:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciORM-0005En-E6
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:46:24 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A9028F294
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:46:24 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-14-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <539cdb2c-1b5e-df6f-7b02-811b741e5706@redhat.com>
Date: Mon, 27 Feb 2017 10:46:22 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-14-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vqPS9LNF22B0vgfUrxjjhPOjONAfsD1FE"
Subject: Re: [Qemu-devel] [PATCH v2 13/26] qapi: Drop string input visitor
 method optional()
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
--vqPS9LNF22B0vgfUrxjjhPOjONAfsD1FE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <539cdb2c-1b5e-df6f-7b02-811b741e5706@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/26] qapi: Drop string input visitor
 method optional()
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> visit_optional() is to be called only between visit_start_struct() and
> visit_end_struct().  Visitors that don't support struct visits,
> i.e. don't implement start_struct(), end_struct(), have no use for it.
> Clarify documentation.
>=20
> The string input visitor doesn't support struct visits.  Its
> parse_optional() is therefore useless.  Drop it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/visitor-impl.h |  4 ++--
>  qapi/string-input-visitor.c | 13 -------------
>  2 files changed, 2 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vqPS9LNF22B0vgfUrxjjhPOjONAfsD1FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtFfeAAoJEKeha0olJ0NqqBIH+wfs+sXrUDpxyjUGcWcxjGGn
ti9smYLvEY3v1lPoSzt5eYW4zLaeiclrn28HdHE/StjDK0qMQqEj5r3kcOzoLEWv
HcYRMy04Fx4UqPb4Fu0aPt9o8TZuLqqqAfpmaRFY0KfPLAP1FOMkmyKj2spOSQXp
sVFi3e7iOfEKbXilGtd+Pc+RGHKtf54SJC3p3ArxQBGagUDmS6i5ksH+PZxxFive
WJes1TAklB+MFKlze/KlodcRGtkQKJLA4qSlle2wzgGgXKCdko6TEv0ycQ2ug/kT
Hv8brhjd70CctmoCxqnCizT5b0zCeA2IiebdHWjyWqiWeFJY5GzSYb/d17wcQ9o=
=dOF4
-----END PGP SIGNATURE-----

--vqPS9LNF22B0vgfUrxjjhPOjONAfsD1FE--
