Received: from eggs.gnu.org ([2001:4830:134:3::10]:35780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXW7-0007aU-Gh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXW6-0005on-PM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:29:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXW6-0005oc-Gn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DA252E6058
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:29:13 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-6-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bfae4dc1-ba50-385a-1c8e-7c760b34da88@redhat.com>
Date: Mon, 27 Mar 2017 18:29:10 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o7rV8XTOp6a7TEmXMlxSXphODG5xaxR6b"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 05/11] rbd: Don't accept
 -drive driver=rbd, keyvalue-pairs=...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o7rV8XTOp6a7TEmXMlxSXphODG5xaxR6b
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <bfae4dc1-ba50-385a-1c8e-7c760b34da88@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 05/11] rbd: Don't accept -drive
 driver=rbd,keyvalue-pairs=...
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
> The way we communicate extra key-value pairs from
> qemu_rbd_parse_filename() to qemu_rbd_open() exposes option parameter
> "keyvalue-pairs" on the command line.  It's not wanted there.  Hack:
> rename the parameter to "=3Dkeyvalue-pairs" to make it inaccessible.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

(Or you could just use x- like blkdebug does...)

Max


--o7rV8XTOp6a7TEmXMlxSXphODG5xaxR6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZPdYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoLcH/1M+CXSfHHBSQlTtjX3ut9Z+bCe8S1c7
7i9ZQ831MILLciSgz12+p6Wc25KtM8AlYn3fNhZSCmSOZm0dhxWvx/2DRlPfEEGl
OnP6OKDSU5gwdxDnv0itKQF8e9BSY5CMrFXIDXecDtvj4gCZKy9p4T1N7+bST2zq
OVeNW4RZNsRxsyMTgjkmeMfxLpgyXQxanf81hXQiPlDQqhhXijJkbYN5z+xBhb73
s+tVgjhX7Ojl51+dOUmcncH+ORw7fIPdyPYW4UXksIz/9WCNFw6iaWcnhmRrh/fU
BJvip45ukOV8BUEb1q220hxM+fg8gW4wBo+pn+ziqY8HLmG4v/Shfa8=
=tw6C
-----END PGP SIGNATURE-----

--o7rV8XTOp6a7TEmXMlxSXphODG5xaxR6b--
