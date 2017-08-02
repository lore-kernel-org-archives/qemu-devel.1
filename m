Received: from eggs.gnu.org ([2001:4830:134:3::10]:59554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd24W-0002gq-ME
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd24S-0002vt-L7
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dd24S-0002vL-C7
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:24:52 -0400
References: <20170802201512.29142-1-crosa@redhat.com>
	<20170802201512.29142-2-crosa@redhat.com>
	<c9d1d353-855e-40fe-9f43-aecd9d4c34db@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <1fbb4089-b58f-d98c-0fe3-7bc6d1ce2eb5@redhat.com>
Date: Wed, 2 Aug 2017 18:24:45 -0400
MIME-Version: 1.0
In-Reply-To: <c9d1d353-855e-40fe-9f43-aecd9d4c34db@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s9cIDDoTTRKUJtMs68jPisAAPWuTlXXop"
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/tcg/test_path.c: include
 utils/bufferiszero.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s9cIDDoTTRKUJtMs68jPisAAPWuTlXXop
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Message-ID: <1fbb4089-b58f-d98c-0fe3-7bc6d1ce2eb5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/tcg/test_path.c: include
 utils/bufferiszero.c
References: <20170802201512.29142-1-crosa@redhat.com>
 <20170802201512.29142-2-crosa@redhat.com>
 <c9d1d353-855e-40fe-9f43-aecd9d4c34db@amsat.org>
In-Reply-To: <c9d1d353-855e-40fe-9f43-aecd9d4c34db@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/02/2017 05:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cleber,
>=20
> On 08/02/2017 05:15 PM, Cleber Rosa wrote:
>> Which contains one specific function used by iov.c.
>>
>> Without this, "make -C tests/tcg test_path" (and consequently
>> "make -C tests/tcg" or simply "make test") fails quite early.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   tests/tcg/test_path.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
>> index 1c29bce..74dbdaf 100644
>> --- a/tests/tcg/test_path.c
>> +++ b/tests/tcg/test_path.c
>> @@ -3,6 +3,7 @@
>>   #include "util/cutils.c"
>>   #include "util/hexdump.c"
>>   #include "util/iov.c"
>> +#include "util/bufferiszero.c"
>=20
> This fixes the build, however why not take this opportunity to fix it
> through the Makefile instead of including .c?
>=20

Do you mean for all of the .c includes?  I just took a baby step, which
seemed more consistent with the mission (get it to build), without
changing a lot.

> Regards,
>=20
> Phil.
>=20

Thanks for the review!
- Cleber.

>>   #include "util/path.c"
>>   #include "util/qemu-timer-common.c"
>>   #include <stdarg.h>
>>

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--s9cIDDoTTRKUJtMs68jPisAAPWuTlXXop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZglEtAAoJEGV+jTOl8gnzY7sP/RIQWDx4eSc73zWEovNHCSUo
54lCtEKvhzsuD9l2ZAKjX7OgkeXp378Heye2utpeursb3YmaANiQYmjSmoWPsclP
3yR8ZjBBG5BPNjCYvnKpTbFQTwCVGatkRxW9MatOxeWLTzLIBBhmsp33pkHqLfln
TQmw1wyBlUcjLnB+R+La2Nb8Iuq9bn9O58RzffmcvgiHVPssRAVSU5rqTseyfwS+
JSG7aDhgsZJEqzwbryFtmD2KJ5GBSYE7Y0ng+2StclhTrIohAoWEwmn9JxxRWNjZ
KG0umKQyPUsabRzPM500kxEfIukDu+3r8PmvelIG7d1wt3JRx0FqlSe4D4QjnPOF
ppUROuHnsqvUy84gQGWrXFP5mRX14Ky1/ZmAYmRnM/D+f42NMJGWq1crl0MzRoO5
jrgYVv2mXwTe+2HvVumIsGWug56FXlKlqIKq0ZgaP6cRfspQ4+nsB3Xk8oFs32SC
m9VE8dCacNmwPUp1QIqyTnJceGeh+Xjqn4QP/1RNeIbHZcZKbO/e7TQpWv9JNPHZ
HFKMephbD16vXfONtGmh6cGg76usqIZ57tWsJk2My05lLQUUjWk/cSh4KMrLkn5I
nA0VEh5sb0wVvQLF3u3MLeDU4UhnTicEz4CyABciinsgzgro+Leu4QjVrwd+97a/
UwQdFX6/D9vatEpR7q89
=D2zM
-----END PGP SIGNATURE-----

--s9cIDDoTTRKUJtMs68jPisAAPWuTlXXop--
