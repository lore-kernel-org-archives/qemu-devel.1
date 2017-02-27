Received: from eggs.gnu.org ([2001:4830:134:3::10]:54147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOdQ-0003uK-8y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOdL-00019w-G6
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:58:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciOdL-00019m-7Q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:58:47 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48880C00828B
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:58:47 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-15-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90dc346a-aeca-5e85-4ff2-782799f08174@redhat.com>
Date: Mon, 27 Feb 2017 10:58:45 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-15-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UfF2orcpXaFUInLiVchMn4cQwqbWuX0Qw"
Subject: Re: [Qemu-devel] [PATCH v2 14/26] qapi: Make string input and opts
 visitor require non-null input
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
--UfF2orcpXaFUInLiVchMn4cQwqbWuX0Qw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <90dc346a-aeca-5e85-4ff2-782799f08174@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/26] qapi: Make string input and opts
 visitor require non-null input
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-15-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> The string input visitor tries to cope with null input.  Null input
> isn't used anywhere, and isn't covered by tests.  Unsurprisingly, it
> doesn't fully work: start_list() crashes because it passes the input
> via parse_str() to strtoll() unchecked.
>=20
> Make string_input_visitor_new() assert its argument isn't null, and
> drop the code trying to deal with null input.
>=20
> The opts visitor crashes when you try to actually visit something with
> null input.  Make opts_visitor_new() assert its argument isn't null,
> mostly for clarity.
>=20
> qobject_input_visitor_new() already asserts its argument isn't null.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/opts-visitor.c         |  1 +
>  qapi/string-input-visitor.c | 54 ++++++++++++++-----------------------=
--------
>  2 files changed, 18 insertions(+), 37 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UfF2orcpXaFUInLiVchMn4cQwqbWuX0Qw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtFrFAAoJEKeha0olJ0NqsVYH/1xX0VGMkxye2l09/dLQzqXX
V+668/FBf778WSmxorRBY72jnxqlrw0gqsapPaxLwSsNsibFKNycjG6ByqPBSHjk
g+8RdfR3ZdWRZPKgOpDXElFSgjTsDQHma6Ra6mNwUiFGiGos+vyHc2KFKaBkAn0y
o+no/WLxtjEQleX2uc0iZgw3slkLiA/LUwji+YS+dJHHWxVejp6PbdZH0ZuMEc/N
2swZqzPGs4JDxh5pfa19pVL2NGO34XyLTPEaoK9pfI/Cgyif1x7ugoYOXje3isIt
BNOD0qAFh4aefqZY8wDssNYbBKSZV2QaJEge9/xniXMlHdf0EHCGDl538/lodNY=
=2KVi
-----END PGP SIGNATURE-----

--UfF2orcpXaFUInLiVchMn4cQwqbWuX0Qw--
