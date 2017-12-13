Received: from eggs.gnu.org ([2001:4830:134:3::10]:55405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePD1j-0006bR-HF
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePD1g-0007QZ-Cb
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:49:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePD1g-0007QC-2K
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:49:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C5CF2D1EC7
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 19:49:07 +0000 (UTC)
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-32-marcandre.lureau@redhat.com>
	<87lgi6gbak.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <315eff5b-0508-0dcb-8118-cf3eb5395ba4@redhat.com>
Date: Wed, 13 Dec 2017 13:49:03 -0600
MIME-Version: 1.0
In-Reply-To: <87lgi6gbak.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ssrsl67RSE4SC6ah4kxPKqhseeO9A3nww"
Subject: Re: [Qemu-devel] [PATCH v3 31/50] docs: document schema
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ssrsl67RSE4SC6ah4kxPKqhseeO9A3nww
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <315eff5b-0508-0dcb-8118-cf3eb5395ba4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 31/50] docs: document schema configuration
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
 <20170911110623.24981-32-marcandre.lureau@redhat.com>
 <87lgi6gbak.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgi6gbak.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/2017 04:41 AM, Markus Armbruster wrote:
> Cc: Eric for an additional pair of eyeballs.
>=20
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> +
>> +Members can be exploded as dictionnary with 'type' & 'if' keys:
>=20
> dictionary
>=20
> I get what you mean by "can be exploded", but can we phrase this more
> clearly?
>=20
> In section "Struct types", we have
>=20
>     A struct is a dictionary containing a single 'data' key whose value=
 is
>     a dictionary; the dictionary may be empty.  This corresponds to a
>     struct in C or an Object in JSON. Each value of the 'data' dictiona=
ry
>     must be the name of a type, or a one-element array containing a typ=
e
>     name.
>=20
> The part "must be the name of a type, or a one-element array containing=

> a type" name is now wrong.

Maybe:

Where a member can normally be defined with a single string value as its
type, it is also possible to supply a dictionary with both 'type' and
'if' keys.  The generated code will then guard the inclusion of that
member in the larger struct or command with #if IFCOND, where IFCOND is
the value of the 'if' key.

>> +
>> +{ 'struct': 'IfStruct', 'data':
>> +  { 'foo': 'int',
>> +    'bar': { 'type': 'int', 'if': 'defined(IF_STRUCT_BAR)'} } }
>=20
> Perhaps add something like
>=20
>     Code generated for such conditional members will be guarded with #i=
f
>     IFCOND, where IFCOND is the value of the 'if' key.
>=20

>=20
> Hmm.  If enumeration documentation profits from an example, it stands t=
o
> reason that the previous two would, too.
>=20
> Should we (additionally?) add examples of 'if' in section "Code
> generation"?

It makes the examples longer, but may be worthwhile.

>=20
>> +
>> +Please note that you are responsbile to ensure that the C code will

s/responsbile/responsible/

>> +compile with an arbitrary combination of conditions, since the
>> +generators are unable to check it at this point.
>> +
>>  =3D=3D Client JSON Protocol introspection =3D=3D
>> =20
>>  Clients of a Client JSON Protocol commonly need to figure out what
>=20
> Do we need to update section "Client JSON Protocol introspection"?

It doesn't affect what the client can do with what it introspects, but
may indeed be worth mentioning that the presence of 'if' keys in the
schema is reflected through to the introspection output.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ssrsl67RSE4SC6ah4kxPKqhseeO9A3nww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloxhDAACgkQp6FrSiUn
Q2pRZAf+PHntcTosruc7XYD0hJ4fD1Hv36ArG4K4Ha6PgpsO5Y77tgRWdjJ1767Q
nokSbHecwFx6+u28rCT66KZ3VADJN/HPVJ4IUEkorH8pDq/DNY3sMJ0MhYtyC6ZX
611/D6pDgK69ZGv7qUMTsn2cbi1Hb3JRVEylAL4V1USp3eyICwBNc+Blzdl4EdHk
u4iqOrM+ehsEk6jtxVlTKAh6rODf/gFPruQJH1t3lAY+7PZmR8rP7zE6bCS9YuWy
3uWCFmj2SFyZOG1udZBQ2dN/8ORgWbm2+f6Ga9DmI1iGRjRgRaZE3+03244aFPkr
ItSzyrrpeTdE87U9lCLZCMDUahrIrw==
=pAui
-----END PGP SIGNATURE-----

--Ssrsl67RSE4SC6ah4kxPKqhseeO9A3nww--
