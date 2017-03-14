Received: from eggs.gnu.org ([2001:4830:134:3::10]:60705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp05-0004fw-Sj
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnp01-0002SL-Sm
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:08:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnp01-0002SE-KB
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:08:37 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-15-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <076124fd-2445-7d9c-a22d-43ef9f80edc2@redhat.com>
Date: Tue, 14 Mar 2017 11:08:35 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-15-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9L3pumos1rrAOg6egUcetN0gUSp1SOBq6"
Subject: Re: [Qemu-devel] [PATCH for-2.9 14/47] qapi: Prepare for requiring
 more complete documentation
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
--9L3pumos1rrAOg6egUcetN0gUSp1SOBq6
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <076124fd-2445-7d9c-a22d-43ef9f80edc2@redhat.com>
Subject: Re: [PATCH for-2.9 14/47] qapi: Prepare for requiring more complete
 documentation
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-15-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> We currently neglect to check all enumeration values, common members
> of object types and members of alternate types are documented.
> Unsurprisingly, many aren't.

And some, like QKeyCode, would be a pain to document.

>=20
> Add the necessary plumbing to find undocumented ones, except for
> variant members of object types.  Don't enforce anything just yet, but
> connect each QAPIDoc.ArgSection to its QAPISchemaMember.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 110 +++++++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 65 insertions(+), 45 deletions(-)
>=20

Lots of plumbing added, but I'm not spotting any obvious omissions.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9L3pumos1rrAOg6egUcetN0gUSp1SOBq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBWDAAoJEKeha0olJ0NqcqwH+wbk3/mJJQ7dMQPXr7o0ITFF
jdu5iY2J+3YxDTr5+sMizA7z3NzRM6fjyTbOiguCBmNqimBZwAoPz4s0I2igRssb
FBbTVblxDb/w9oyHhoVQwEOFGSQES+CVzGEeW0KXUsAcfFunziryHrqtJygMajF7
RniNt0/BxerncwcDJZDr16RF0K/RMp+E/TqZyvtR+k72oucMUmIBn+jO6jmmDLtP
ToyGS1fspQzCW1TcbwAN6lvfXwHz/1faUgZkR40r6z9oB+LCJtqqBPJBkjRahYXR
iTqJ1dWC1Oez7QFfKUJwOb7KdmCXo0hoXK2cwgjCZ2gvtak/GjegG3uJSJ5czv0=
=3zPE
-----END PGP SIGNATURE-----

--9L3pumos1rrAOg6egUcetN0gUSp1SOBq6--
