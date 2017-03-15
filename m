Received: from eggs.gnu.org ([2001:4830:134:3::10]:52034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxvC-00027T-Eo
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnxv8-0007Be-Fo
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnxv8-0007B2-6w
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:40:10 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-35-git-send-email-armbru@redhat.com>
	<8737ehlmog.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04ef49b9-938c-7b6f-f811-710c6611b42d@redhat.com>
Date: Tue, 14 Mar 2017 20:40:07 -0500
MIME-Version: 1.0
In-Reply-To: <8737ehlmog.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aRuPseMChJCSbwV1pCGWCGjJO8Vqjokio"
Subject: Re: [Qemu-devel] [PATCH for-2.9 34/47] qapi: Move empty doc section
 checking to doc parser
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
--aRuPseMChJCSbwV1pCGWCGjJO8Vqjokio
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <04ef49b9-938c-7b6f-f811-710c6611b42d@redhat.com>
Subject: Re: [PATCH for-2.9 34/47] qapi: Move empty doc section checking to
 doc parser
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-35-git-send-email-armbru@redhat.com>
 <8737ehlmog.fsf@dusky.pond.sub.org>
In-Reply-To: <8737ehlmog.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:23 AM, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
>> Results in a more precise error location, but the real reason is
>> emptying out check_docs() step by step.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>=20
> Perhaps we should simply drop this error condition.  Are empty sections=

> this a mistake users make accidentally?

Parse error; did you mean "empty sections _like_ this"?

I'm okay with keeping the error; especially if we can't guarantee that
the generator copes gracefully with an empty section (different than an
omitted section).  On the other hand, even if we remove the error,
you're probably right that anyone proposing a patch for incorporation
that adds an empty section will have to explain themselves, whether or
not the parser flagged it, and if the error is cheap to maintain in the
parser, then it saves some review cycles.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aRuPseMChJCSbwV1pCGWCGjJO8Vqjokio
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyJt3AAoJEKeha0olJ0NquqAIAKGQ1WLclHJZBVA/3SkJMXiA
r0Rfp0nM8xLqkG1UYoSLhWtUiUReYQfZ5CB88bVa3y6uo21FEEepx2ZCwTlyd5VR
axAZ9a10AIvipS6JkMavtyfsov6bX9vS/Za8d2MmNeAfrGBKXZ0PMsU5rpIecb7k
zVMEiKDN4x1A8s7QK+kwhpK7JcDhbOhfg25H6gBzJ3RUVsrOP87VMRZJJZLZJSdG
7aWFZ8R0g5FOJ/zcy8m70u1ajRC/R4fohrQ488SqQuc31VAVXpiJjDPEZXfB46iY
XmEB2KScnhYSyeuOeOuuDlIwN0XWFi+R5Cl67dNMxJdFhSdKsFPWZHDLQ2FUxpk=
=YoEI
-----END PGP SIGNATURE-----

--aRuPseMChJCSbwV1pCGWCGjJO8Vqjokio--
