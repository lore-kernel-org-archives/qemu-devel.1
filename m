Received: from eggs.gnu.org ([2001:4830:134:3::10]:40008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9W6O-0005V7-RI
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9W6O-00023R-0N
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:29:24 -0400
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-7-mreitz@redhat.com>
	<w5136zqxoj9.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d6a49888-a052-5436-b7bc-a5a569563098@redhat.com>
Date: Fri, 20 Apr 2018 15:29:05 +0200
MIME-Version: 1.0
In-Reply-To: <w5136zqxoj9.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1KAyU4o8cYlUS9dT7LMgJQ65dKOnwsu30"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 06/13] block: Generalize
 should_update_child() rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1KAyU4o8cYlUS9dT7LMgJQ65dKOnwsu30
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <d6a49888-a052-5436-b7bc-a5a569563098@redhat.com>
Subject: Re: [Qemu-block] [PATCH v4 06/13] block: Generalize
 should_update_child() rule
References: <20180411185425.2461-1-mreitz@redhat.com>
 <20180411185425.2461-7-mreitz@redhat.com>
 <w5136zqxoj9.fsf@maestria.local.igalia.com>
In-Reply-To: <w5136zqxoj9.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-20 10:36, Alberto Garcia wrote:
> On Wed 11 Apr 2018 08:54:18 PM CEST, Max Reitz wrote:
>> index c4dd1d4bb8..8d63a1b0c1 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -616,6 +616,8 @@ struct BdrvChild {
>>      QLIST_ENTRY(BdrvChild) next_parent;
>>  };
>> =20
>> +typedef QLIST_HEAD(BdrvChildList, BdrvChild) BdrvChildList;
>> +
>=20
> I forgot to mention this in a previous e-mail, but what's this used for=
?

Extremely good question.  grep says it isn't used for anything.  I'm
inclined to believe grep (especially considering the fact that
everything compiles without error after removing it).

I suppose I had some local version where I needed such a type (probably
because I didn't deem QLIST_FOREACH_SAFE() to be sufficiently safe, so I
needed to copy the list somewhere else, or I don't know...), and then I
found a way around it, removed the code, but forgot the type in the heade=
r.

Will remove in v5.


Thank you for reviewing!

Max


--1KAyU4o8cYlUS9dT7LMgJQ65dKOnwsu30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrZ6yEACgkQ9AfbAGHV
z0B3zwgAl9sVJuDTQ7zOzjyPt3rp/ZUrLx7u7CoPcxlT3E6fn8RvkLsDKBq93hxW
SGtzy3BTdFuTl6rP/4NtgI51QQ+x1EHH9KPEpLPIHQcxlPJi0SEnUwkTLuSJicnY
a4lGmHLfJU9S7MKfNgI7LB1Z+11ytaERFtAO2vRI9ipTQ3fFOwYs6JDX6CVZea9h
teVqg8Q2n+DQp/qBUihyuzOHu28ZWnRW8N0M56Pf7f9xb+IjkUXdHpodwCYtMZZB
HLFbDSHiWahzWXk1q0ybWGcOa5Enzsv8X3bGS/XVZAdyddUq/sVV2UHmwB+3FllW
OCKgpf5qlW/5WJyU3tdrAMZXgDM+ag==
=mHV1
-----END PGP SIGNATURE-----

--1KAyU4o8cYlUS9dT7LMgJQ65dKOnwsu30--
