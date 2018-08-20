Received: from eggs.gnu.org ([2001:4830:134:3::10]:37200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frn9s-0007s1-Lf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frn9r-0001FR-R2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:36:00 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
	<f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
	<8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
	<7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
	<c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cc79c692-8f1b-1bb1-e926-89ee73327f31@redhat.com>
Date: Mon, 20 Aug 2018 18:35:44 +0200
MIME-Version: 1.0
In-Reply-To: <c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qBa1HKmKF0aamZoUAyp21VUVjUydvBkXm"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qBa1HKmKF0aamZoUAyp21VUVjUydvBkXm
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com,
 kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <cc79c692-8f1b-1bb1-e926-89ee73327f31@redhat.com>
Subject: Re: [PATCH v2 1/3] qapi: add x-query-block-graph
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
 <20180817180440.49687-1-vsementsov@virtuozzo.com>
 <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
 <f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
 <8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
 <7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
 <c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
In-Reply-To: <c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 17:13, Vladimir Sementsov-Ogievskiy wrote:
> 20.08.2018 16:44, Max Reitz wrote:
>> On 2018-08-20 12:20, Vladimir Sementsov-Ogievskiy wrote:

[...]

>>> My goal is to get graphviz representation of block graph with all the=

>>> parents for debugging. And I'm absolutely ok to do it with x-debug-.
>>> Then we shouldn't care about enum for role type now. So, it the patch=
 ok
>>> for you with x-debug- prefix?
>> Actually, no, because I'm not sure whether using points for the IDs is=
 a
>> good idea.=C2=A0 That may defeat ASLR, and that would be a problem eve=
n with
>> x-debug-.
>=20
> Good point, agree.
>=20
>>
>> So I'd prefer using e.g. a hash map to map pointers to freshly generat=
ed
>> IDs (just incrementing integers).

(By the way, that would also improve the speed of checking whether a
certain node needs to be added to the @nodes list still.)

>> In any case, I'll take a further look at the patch later, but another
>> thing that I've just seen is that using the opaque pointers to identif=
y
>> a parent is something that doesn't look like it's guaranteed to work.
>=20
> Hm, isn't it a bug? Can you point to an example?

Ah, no, it's OK.  Well, kind of.  It's OK in the sense that it is unique
when set.  I didn't notice that you only use it for the non-node
parents, sorry.

Still, it probably would be better to just use the BdrvChild object, as
that should be unique as well, and it is obviously non-NULL.
(BdrvChild.opaque may be NULL, even though it isn't in practice.)

Max


--qBa1HKmKF0aamZoUAyp21VUVjUydvBkXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt67eAACgkQ9AfbAGHV
z0BA8wgAkZQipyubdl+AehqhlRNgHaJUWfkM+sxcuHbFIuYZepzG9sQLj/0NAldR
cjZZ2IWRxlHEx//84vg2bgOCBdoaqKeQ3vyHlqB8LirT12x4/jkSATMr65h1U2iq
wtadJrsaQca3OUjyS0xvwplodIMq1/StHoLtrLvPYAtaxLaVHY6HImte7DcAagre
bRyq051B393x0p8MnzW4tu/ObKo3l5BVDBASIUgj1ZJsp56L07PYuyGlcUa+Xn60
N1/PMCx7yPFV+g7+gYIskQNTI3o7sHg8IYTUwQr+HK/d5CBgyTH7xO3DcZr8kNUI
G3JW1QaZ7hsI54Xx0MVSUD0Ytzqxqg==
=AO4K
-----END PGP SIGNATURE-----

--qBa1HKmKF0aamZoUAyp21VUVjUydvBkXm--
