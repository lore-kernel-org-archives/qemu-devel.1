Received: from eggs.gnu.org ([209.51.188.92]:35257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAwts-0001Je-QN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAwtr-00064B-M0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:22:56 -0400
References: <20190330150702.11687-1-eblake@redhat.com>
	<20190401130416.GC4935@localhost.localdomain>
	<20190401131641.GJ3524@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b1b86e0-f465-8bfa-f248-50cdf976f4bc@redhat.com>
Date: Mon, 1 Apr 2019 08:22:45 -0500
MIME-Version: 1.0
In-Reply-To: <20190401131641.GJ3524@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5d1qX4WflEfb3SdMzd4RGCgl2LiFvPQta"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Saner printing of large file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, rjones@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5d1qX4WflEfb3SdMzd4RGCgl2LiFvPQta
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, rjones@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Message-ID: <4b1b86e0-f465-8bfa-f248-50cdf976f4bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Saner printing of large file sizes
References: <20190330150702.11687-1-eblake@redhat.com>
 <20190401130416.GC4935@localhost.localdomain>
 <20190401131641.GJ3524@redhat.com>
In-Reply-To: <20190401131641.GJ3524@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/1/19 8:16 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Apr 01, 2019 at 03:04:16PM +0200, Kevin Wolf wrote:
>> Am 30.03.2019 um 16:07 hat Eric Blake geschrieben:
>>> Disk sizes close to INT64_MAX cause overflow, for some pretty
>>> ridiculous output:
>>>
>>>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info=
 $nbd'
>>>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>>>   file format: raw
>>>   virtual size: -8388607T (9223372036854775296 bytes)
>>>   disk size: unavailable
>>>

>> This is quite obviously a bug fix for some cases. This suggests that w=
e
>> want it in 4.0.
>>
>> It is also an output change for other cases, like going from "8M" to
>> "8 MiB". We probably can't tell for sure whether some tools expect the=

>> spelling "8M" (even if this is supposed to be the human interface and
>> tools should be using JSON) or feed the change back to qemu-img or
>> qemu-io (which accept "8M", but not "8 MiB" as sizes in most places).
>> This suggests that we shouldn't make this change as late as -rc2.
>=20
> If it breaks our own tests, then it is possible to break other tools
> too.
>=20
>> So what is the conclusion?
>=20
> The safe option is to do the minimal fix for the existing code and look=
 at
> the refactoring in the next dev cycle.

It's not worth fixing the second implementation to match the first in
terms of support for sizes > T with no overflow, but with the existing
format of 8.0M vs. 8 MiB.  I'm happy to defer this patch to 4.1; the bug
is not new to 4.0, so living with it for one more release doesn't hurt.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5d1qX4WflEfb3SdMzd4RGCgl2LiFvPQta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyiEKUACgkQp6FrSiUn
Q2o76gf9FDX3DnM6AiTMzy9+LDWsAhBpAEoN802irhkRmJGXyOhWsfIJVb/Pqg2N
5LW1nlAXaUQr9j551g886iL5DSwSIe1TB4Poum1Pix/EIxkl3neiBXSD1CaTjTDl
H500maptcvKc80Iq+Bt6PSVd6kh7vJz7LBfuRvegRBo56pYJ2kSsu7YWpRy26imK
jE5Z5Bj/YTA3KgjnMsy4Y+Uc3/eVczr4JMa5EMcBIephX5M3VqH6reRirpbMTvu8
slVP2BTFcJ6Dkmln9rAtE5Xrssy9YW77bcdCaUMpxnnC+1oXLdhinoxlNl/POGca
I66RCHO2JBlhTbn2LH+53pKz9X1FUA==
=83X2
-----END PGP SIGNATURE-----

--5d1qX4WflEfb3SdMzd4RGCgl2LiFvPQta--
