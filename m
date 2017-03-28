Received: from eggs.gnu.org ([2001:4830:134:3::10]:52200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csqvf-0002Oj-N1
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csqvc-0001y6-EC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:12:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csqvc-0001xi-5s
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:12:52 -0400
References: <20170328072130.17142-1-vfeenstr@redhat.com>
	<CAJ+F1CK0n7m+mPBeUOOD0TXNroogjK3iMWthyQhdDVwd=3G8fA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b481c70f-3e0b-0b0f-a8f0-620b75e18a6d@redhat.com>
Date: Tue, 28 Mar 2017 08:12:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK0n7m+mPBeUOOD0TXNroogjK3iMWthyQhdDVwd=3G8fA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="25hnuaXgdiIh3MDvcgNVAT0262rg6KmPf"
Subject: Re: [Qemu-devel] [PATCH v1] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--25hnuaXgdiIh3MDvcgNVAT0262rg6KmPf
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <b481c70f-3e0b-0b0f-a8f0-620b75e18a6d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] qga: Add 'guest-get-users' command
References: <20170328072130.17142-1-vfeenstr@redhat.com>
 <CAJ+F1CK0n7m+mPBeUOOD0TXNroogjK3iMWthyQhdDVwd=3G8fA@mail.gmail.com>
In-Reply-To: <CAJ+F1CK0n7m+mPBeUOOD0TXNroogjK3iMWthyQhdDVwd=3G8fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2017 04:34 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Mar 28, 2017 at 9:22 AM Vinzenz 'evilissimo' Feenstra <
> vfeenstr@redhat.com> wrote:
>=20
>> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>>
>> A command that will list all currenctly logged in users having running=


s/currenctly/currently/

>> processes.

Do you also want to include how long the user has been logged in, if
available? (a 'num' for floating-point seconds may be the best unit for
that).


>> +++ b/qga/qapi-schema.json
>> @@ -1042,3 +1042,24 @@
>>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>>                 '*input-data': 'str', '*capture-output': 'bool' },
>>    'returns': 'GuestExec' }
>> +
>> +##
>> +# @GuestUser:
>> +# @user:      Username
>> +# @domain:    Logon domain (windows only)
>>
>=20
> Or use a flat union? (like suggested for get-osinfo)

Here, I don't see much benefit to a flat union. The field is present
only when the guest can supply it, and there is no obvious discriminator
to mention whether the field must be present.  I think the structure is
just fine as proposed, unless you want to also add a duration parameter
for how long the user has been logged in.


>> +##
>> +# @guest-get-users:
>> +# Retrieves a list of currently active user accounts on the VM.

Accounts that exist even if no one is logged in at the moment, or
accounts that currently have someone logged in?

>> +#
>> +# Returns: A unique list of users.
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'command': 'guest-get-users',
>> +  'returns': ['GuestUser'] }
>> --
>> 2.9.3
>>
>>
>> --
> Marc-Andr=C3=A9 Lureau
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--25hnuaXgdiIh3MDvcgNVAT0262rg6KmPf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2mFQAAoJEKeha0olJ0NqKBEIAIewFHqmBBToEa1l4xH+nifD
iTUu4xac8RyEC12GSXV/JjeyRlESGDofoNbsnNKC7uKFNiAKj+67H2awvzNQWr4o
8OyLp/QAw+bmDlwYuMlwcwXzUurPNzeEtEoHqlfXC4rixlPwFLOoA4ho6GP1jjVN
1uwuo/GvcjeOsw4q8f9LF4pS/sofL/5HY7mnvwFpROLApXJZAP9sTmVjy8LI45iy
9C+nYyD3HFMC4uwLb8da6Za9xtMcLn+oPTsr4ORCwQQLfIolGUv5qEN0Wv3hQ0e3
BIixG40Acf+coYybeScKVAG+LVnwkQ1stYD6gWMOyTJH0rMuEMJZDqOrPDHFUic=
=M9H6
-----END PGP SIGNATURE-----

--25hnuaXgdiIh3MDvcgNVAT0262rg6KmPf--
