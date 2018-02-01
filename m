Received: from eggs.gnu.org ([2001:4830:134:3::10]:47294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehEbD-0002Kw-6z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehEb9-0001B8-0r
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:08:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehEb8-0001Aa-NB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:08:14 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-2-armbru@redhat.com>
	<fd604c0a-bf97-edba-f648-820294447fa5@redhat.com>
	<87fu6lrxoc.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0ac1a47-2878-74d0-fe3a-f2974d876e6b@redhat.com>
Date: Thu, 1 Feb 2018 07:08:11 -0600
MIME-Version: 1.0
In-Reply-To: <87fu6lrxoc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vkiw24sOEbfoNK3ZjdccPE0aXkdqbqYbX"
Subject: Re: [Qemu-devel] [PATCH v2 01/19] Use #include "..." for our own
 headers, <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vkiw24sOEbfoNK3ZjdccPE0aXkdqbqYbX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org
Message-ID: <d0ac1a47-2878-74d0-fe3a-f2974d876e6b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/19] Use #include "..." for our own
 headers, <...> for others
References: <20180131144846.31697-1-armbru@redhat.com>
 <20180131144846.31697-2-armbru@redhat.com>
 <fd604c0a-bf97-edba-f648-820294447fa5@redhat.com>
 <87fu6lrxoc.fsf@dusky.pond.sub.org>
In-Reply-To: <87fu6lrxoc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2018 01:12 AM, Markus Armbruster wrote:

>>> +
>>>  #include "qemu/osdep.h"
>>> +#include <memory.h>
>>
>> <memory.h> is an obsolete spelling for the now-universal <string.h>.  =
We
>> should NEVER need to include it; scripts/clean-includes should be taug=
ht
>> to blacklist this one.
>=20
> "Programming today is a race between software engineers striving to
> build bigger and better idiot-proof programs, and the Universe trying t=
o
> produce bigger and better idiots.  So far, the Universe is winning."
>=20
> My point is: if we extended our tooling every time we see a mistake,
> we'll drown in tooling.  I think we should limit ourselves to *common*
> mistakes.  Is this one common?

Perhaps not; a tendency when writing a new file is to copy-and-paste a
list of includes from another file, then add more if things still don't
compile.  Since adding memory.h never changes whether compilation will
work (unless you forgot osdep.h in the first place, and thereby missed
string.h), and if we eradicate all current uses of memory.h, new uses
won't have the bad example to copy from.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vkiw24sOEbfoNK3ZjdccPE0aXkdqbqYbX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpzETsACgkQp6FrSiUn
Q2rzAAgAhCindnIv47Me+zL+b2sc4cgPe1LGVOJb9mYTpsrmbWWwAJjHkApihC1m
U1akd1YdJ1NrFM7PAHeheElsTq/1FZuARwEIyuuu4VZg3RyiL1qu2ijgcLkYWZuB
YudNiqM2+T6uYEqMK8tj+eMpnPZTRRrdGS6it2LB50zmD/LCkzc6+e3X2zqWZg0x
0ND5NmulDcwMC39FQOXiDZMBYH9B6Hu6gZkRuBfpIGivXqpWdZ4+CV7J1amPh8DA
I84VWVizj85Pb59kIA4wntPxGG7WlhcC20vM/RR6Pq59DOKr4tL2Ue6AZxGCuo8V
YhH5itMjcN2I/p42KqjtqIR6VUJxXw==
=Jiy5
-----END PGP SIGNATURE-----

--vkiw24sOEbfoNK3ZjdccPE0aXkdqbqYbX--
