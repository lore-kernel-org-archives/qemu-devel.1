Received: from eggs.gnu.org ([2001:4830:134:3::10]:57315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTpB7-0004g4-8b
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gTpB6-0006sF-8G
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:26:29 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
	<28cbfc9d-c734-835e-7e0c-5524af733453@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9082a92e-45cf-9e31-4ce0-4e4711799b57@redhat.com>
Date: Mon, 3 Dec 2018 15:26:11 +0100
MIME-Version: 1.0
In-Reply-To: <28cbfc9d-c734-835e-7e0c-5524af733453@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MgiedUMVOceAtzANq570FKLKUNonJmtlJ"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mirror dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MgiedUMVOceAtzANq570FKLKUNonJmtlJ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com"
 <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Message-ID: <9082a92e-45cf-9e31-4ce0-4e4711799b57@redhat.com>
Subject: Re: [PATCH v2 0/2] mirror dead-lock
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
 <28cbfc9d-c734-835e-7e0c-5524af733453@virtuozzo.com>
In-Reply-To: <28cbfc9d-c734-835e-7e0c-5524af733453@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.12.18 15:13, Vladimir Sementsov-Ogievskiy wrote:
> 03.12.2018 16:59, Max Reitz wrote:
>> On 29.11.18 11:17, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> v2: add fix:)
>>>
>>> We've faced the following mirror bug:
>>>
>>> Just run mirror on qcow2 image more than 1G, and qemu is in dead lock=
=2E
>>
>> So because apparently there is going to be an rc4 anyway (like basical=
ly
>> always...), I'd really like to bring this fix into it, unless there ar=
e
>> any objections from anyone (though all of you are more than welcome to=

>> explicitly agree, too :-)).
>>
>> Do you have any plans for the iotest?  Right now, I'd rather just take=

>> patch 1 as-is and add the test later, but then again, adding a patch f=
or
>> rc4 without a test is not so nice either, I suppose.
>>
>> Max
>>
>=20
> I think, everything is better with test:) I can't say that I really lik=
e your
> additions, because it's anyway a kind of cheating, less real-life,

You mean like all iotests? ;-)

iotests usually only test a single specific thing and not a full
real-life case.

>                                                                    but =
on the
> other hand, as I understand, allocating a lot of disk space in iotests =
is a bad
> thing too.
>=20
> May be it should be a kind of parameter, with default to your variant, =
something
> like ./check --big-disk-allocations-allowed :).

As I said, we would need to add a new group (e.g. "big-disk-allocation")
and then probably disable that group in check by default.  You could run
those tests with ./check -g big-disk-allocation.

> But let's commit at least the test with your additions.

I mean, we can also add both tests.  But I should say that your version
did not fail on tmpfs before this fix, and I usually run tests on tmpfs,
so...  It wouldn't be very indicative of the issue for me.

Max


--MgiedUMVOceAtzANq570FKLKUNonJmtlJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwFPQMACgkQ9AfbAGHV
z0ClSAf/Y2reAMkeClWiHDNLnumxq9dmsBrbzBhRSxB6F3einWX2s56+YonOh/lI
mIsVcR/5I3JHUD+9cckha9gT/0rYYay7D5BrSY+k7cgWB4QaPEt/ivqqKTsELScr
aktlz7RZCHhmuLnfARFvJpBiuf2bNDjmXFpQCZVv+xe9OptrZWoPDrl0F8Q03SJf
EGT/ZCVJcF0sg8XBoTHAKMpip7614lblBZY7VomY8RvPeGP/hJFFSk4ZnSL8dyVE
+top0GKtXSpPoVjs9kP52nT8WMOdRaaZyQ/olAwCedp0yWwn2tPMIq4VNGz0uJmm
mQYuNXzMqfRHJwzs8tkbpmlakWl5jQ==
=HEvP
-----END PGP SIGNATURE-----

--MgiedUMVOceAtzANq570FKLKUNonJmtlJ--
