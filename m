Received: from eggs.gnu.org ([2001:4830:134:3::10]:41685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYI2k-0003Si-8l
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYI2f-0005t5-Le
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYI2f-0005so-Bh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:27:25 -0400
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-3-eblake@redhat.com>
	<87mv7zmo50.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <682ac740-10d5-3125-2105-7ada258e5f92@redhat.com>
Date: Thu, 20 Jul 2017 15:27:17 -0500
MIME-Version: 1.0
In-Reply-To: <87mv7zmo50.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9vPsdR8MjQ681fktocfWVF6EThXmnTmNf"
Subject: Re: [Qemu-devel] [PATCH 2/5] tests: Enhance qobject output to cover
 partial visit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9vPsdR8MjQ681fktocfWVF6EThXmnTmNf
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <682ac740-10d5-3125-2105-7ada258e5f92@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] tests: Enhance qobject output to cover
 partial visit
References: <20170714190827.4083-1-eblake@redhat.com>
 <20170714190827.4083-3-eblake@redhat.com> <87mv7zmo50.fsf@dusky.pond.sub.org>
In-Reply-To: <87mv7zmo50.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 04:52 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Add a test that proves (at least when run under valgrind) that
>> we are correctly handling allocated memory even when a visit
>> is aborted in the middle for whatever other reason.
>>
>> See commit f24582d "qapi: fix double free in
>> qmp_output_visitor_cleanup()" for a fix that was lacking
>> testsuite exposure prior to this patch.
>>

>> +
>> +    /*
>> +     * Abort in the middle of an alternate. Alternates can't be
>> +     * virtually visited, so we get to inline the first half of
>> +     * visit_type_UserDefAlternate().
>> +     */
>=20
> Not exactly inline.  Perhaps:
>=20
>        /*
>         * Abort in the middle of an alternate.  Since alternates don't
>         * support virtual visits, we perform a real one, similar to wha=
t
>         * visit_type_UserDefAlternate() would do.
>         */

Sounds reasonable, if we go with it.

>=20
> Hmm, what would visit_type_UserDefAlternate() do for @uda?  Could we
> simply call it here and be done?

Sounds even better; I'll do that for v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9vPsdR8MjQ681fktocfWVF6EThXmnTmNf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxEiUACgkQp6FrSiUn
Q2pBQgf/X8+jwugztLe+MEu8lW47o0lYrJm8GBXb0fyQXfHhVPdcT/KIXkbvDKou
A9Py/DiamZwzMo+o5dp95PGwADwWBUe+nNqCEk5vFHnKHOjdRTgShcf62edziVNV
Y49SnOdkjD54dmKgBKYgojV5ohcAIziUuhkfKd64NsYCcI5VnhKM2DIsUeyih84T
UGQkAEVHZwX+fJHP5di0j8TGfNDaIGqudWmaRxLktkN3TDAczOhnJyUzF2zXAE8j
JBAP6rUYTupRI+Xh23ukxB5JrcO6LNEgQK54jakO5UgXW/YzYdmjP90FLTXCKPto
GyrCHuAHhBDyXDZKRudmSSkYGrxwtw==
=1Sc1
-----END PGP SIGNATURE-----

--9vPsdR8MjQ681fktocfWVF6EThXmnTmNf--
