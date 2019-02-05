Received: from eggs.gnu.org ([209.51.188.92]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqqG1-0005QX-8x
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqqFy-0006iF-AD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 21:14:39 -0500
References: <20190204225542.5597-1-eblake@redhat.com>
	<9a93a2a0-f352-1fb6-eb27-49f607cd0b97@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <283d1622-7304-575c-5692-f4b7da983a45@redhat.com>
Date: Mon, 4 Feb 2019 20:14:22 -0600
MIME-Version: 1.0
In-Reply-To: <9a93a2a0-f352-1fb6-eb27-49f607cd0b97@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A7dL0YhAzlYqpJe2yV6RWGjaUI6ZVev31"
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: Flag suspicious attribution
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A7dL0YhAzlYqpJe2yV6RWGjaUI6ZVev31
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org
Message-ID: <283d1622-7304-575c-5692-f4b7da983a45@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: Flag suspicious attribution
 lines
References: <20190204225542.5597-1-eblake@redhat.com>
 <9a93a2a0-f352-1fb6-eb27-49f607cd0b97@redhat.com>
In-Reply-To: <9a93a2a0-f352-1fb6-eb27-49f607cd0b97@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 5:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/4/19 11:55 PM, Eric Blake wrote:
>> Flag commit attribution tags that are unusual (often because they
>> were a typo), but only as a warning (because sometimes a humorous
>> or otherwise useful tag is intentionally supplied).
>>
>> This picks the 6-most popular tags, each with 700 or more uses (well,
>> S-o-b was already checked for case-sensitivity and typos, leaving
>> only 5 new tags being checked), as determined by:
>> $ git log | sed -n 's/^ *\([A-Za-z-]*-by:\).*/\1/p' | \
>>   sort | uniq -c | sort -k1,1n | tail

Use of [bB][yY] finds a few more interesting spellings...

>>
>> Most of the rejected lines were obvious typos (among others, we've
>> had 4 cases of someone being burnt, based on Singed-off-by; and 2
>> cases of list-reading via an e-reader, based on eviewed-by; there
>> are also lines forgetting a space after the ':') or otherwise
>> tongue-in-check (3 Approximately-suggested-by). A few lines not
>> whitelisted here may be legitimate, but as they are orders of
>> magnitude rarer, it is therefore not worth worrying about
>> (7 Requested-by, 3 Co-authored-by, 1 Inspired-by, etc.).

Among others, 48 Reviewed-By.


>> @@ -1470,6 +1470,10 @@ sub process {
>>  				ERROR("space required after Signed-off-by:\n" .
>>  					$herecurr);
>>  			}
>> +		} elsif($line =3D~ /^\s*([A-Za-z-]*)-by:/ &&
>=20
> I guess we don't mind about angry typewriters who Ack-BY ;)

I can send a v3 that makes this line case-insensitive,

>=20
>> +			($1 !~ /(Suggest|Report|Test|Ack|Review)ed/ ||
>> +			 $line !~ /^\s*[a-z-]*-by:\s/i)) {

although making this line require lower-case '-by' gets a bit trickier.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--A7dL0YhAzlYqpJe2yV6RWGjaUI6ZVev31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxY8X4ACgkQp6FrSiUn
Q2rmOAf8DSftPF+mM2fLrosehgT8sbO6ktZZc/xRIT0eUkVQxzcvcQWDR+m1EbhH
4zLPl1vu/nYG8renqZCzoEpdyxZFqu7rZC7dbtiCG5AtKOypjYFnUyJr8ODJSLop
B2Tz7z3aghBnRb/yo76ST0xb8R0LfS1tMZcUUlv6FetGCH3LSX0noW44GmJGEPeN
dKjQ80JH/OhKwKGMVCgb8c3df+uJULSus+tHbOm6RPMz6N3SiNnm1mYnIu8XCBpw
CxlQHlyzYk/z+/flZEj0mltd6OxIHGq1olYrRPi3ufi/CynMs2Ap42b5uVCQ2Kez
jDuam9gXRuRSvO+6oB3gxX2K6B+Gfg==
=GARM
-----END PGP SIGNATURE-----

--A7dL0YhAzlYqpJe2yV6RWGjaUI6ZVev31--
