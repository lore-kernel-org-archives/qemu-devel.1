Received: from eggs.gnu.org ([2001:4830:134:3::10]:38325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntIA-0001iE-MH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntI6-0006UX-4G
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntI5-0006U4-Rc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:43:34 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-33-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63740e61-afee-ced9-3f14-c4918238d3b4@redhat.com>
Date: Tue, 14 Mar 2017 15:43:30 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-33-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hMHDfA1JjJKUg23g0c2iVuFrnt2Rgecjs"
Subject: Re: [Qemu-devel] [PATCH for-2.9 32/47] qapi: Move detection of doc
 / expression name mismatch
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
--hMHDfA1JjJKUg23g0c2iVuFrnt2Rgecjs
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <63740e61-afee-ced9-3f14-c4918238d3b4@redhat.com>
Subject: Re: [PATCH for-2.9 32/47] qapi: Move detection of doc / expression
 name mismatch
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-33-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-33-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Move the check whether the doc matches the expression name from
> check_definition_doc() to check_exprs().  This changes the error
> location from the comment to the expression.  Makes sense as the
> message talks about the expresion: "Definition of '%s' follows

s/expresion/expression/

> documentation for '%s'".  It's also a step towards getting rid of
> check_docs().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py                      | 28 ++++++++++++++++++----------=

>  tests/qapi-schema/doc-bad-symbol.err |  2 +-
>  2 files changed, 19 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hMHDfA1JjJKUg23g0c2iVuFrnt2Rgecjs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFXyAAoJEKeha0olJ0NqR6UH/0j3DKafnkY1q7LnzMUe8cec
DElp9RqPfxMSxp0jadZw98bH/DMdo7zvDW1p4lkt4PkUOWWylmqlgSpmNxTiJTYd
v1h071ruh6o9ckcnfPayTFicGPaunEwwGpLm4P5Sc9NDyMdgiFCrdNidqYhiGeTQ
71ptwj4qml8V1rHCHdj/+B5XSODhY0Dpr+cE4QFeWzQjSFCldb6YXN9rXiwJrBJG
mFTSziOAe+Hys0ltZSB5ydUhTKildU0wD04TU6RMcxFKva1kvODt2EJhDYlbZipu
dtRwaoNgjgqb6oir1ZEmFDw7ReaMgwAuhvYdLieV8MrAjpcasKxfp9HGnEpL0xU=
=8wIn
-----END PGP SIGNATURE-----

--hMHDfA1JjJKUg23g0c2iVuFrnt2Rgecjs--
