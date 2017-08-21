Received: from eggs.gnu.org ([2001:4830:134:3::10]:39952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1djpQG-0001ns-DZ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1djpQB-00033v-QF
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:19:28 -0400
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
	<87poddk583.fsf@dusky.pond.sub.org>
	<6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
	<87a84c6476.fsf@dusky.pond.sub.org>
	<704969af-283c-d22b-f0d2-e7bf0a7b609a@redhat.com>
	<87y3rvjjip.fsf@dusky.pond.sub.org>
	<27f963d3-46f3-d497-2bb6-eca05e808983@redhat.com>
	<87bmnih60w.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1c873dce-d068-38c7-8aae-635d88ac618d@redhat.com>
Date: Mon, 21 Aug 2017 18:12:00 +0200
MIME-Version: 1.0
In-Reply-To: <87bmnih60w.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ab2qDUuDwSoSRwToxasgcdMBSUPgXuSf6"
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ab2qDUuDwSoSRwToxasgcdMBSUPgXuSf6
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <1c873dce-d068-38c7-8aae-635d88ac618d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
References: <20170705190404.22449-1-mreitz@redhat.com>
 <20170705190404.22449-3-mreitz@redhat.com>
 <87poddk583.fsf@dusky.pond.sub.org>
 <6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
 <87a84c6476.fsf@dusky.pond.sub.org>
 <704969af-283c-d22b-f0d2-e7bf0a7b609a@redhat.com>
 <87y3rvjjip.fsf@dusky.pond.sub.org>
 <27f963d3-46f3-d497-2bb6-eca05e808983@redhat.com>
 <87bmnih60w.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmnih60w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-14 11:07, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 2017-07-11 13:33, Markus Armbruster wrote:
>>> Max Reitz <mreitz@redhat.com> writes:
>>>
>>>> First of all, OK, you don't want QNum(42.0) to equal QNum(42) at all=
 (at
>>>> least not right now and in the foreseeable future).
>>>> You're the maintainer, so you decide, so I'll go along with it. :-)
>>>>
>>>> Now, let's follow up with my therefore rather useless commentary:
>>>>
>>>> (Feel free to disregard, because honestly, I can see how replying to=

>>>> most of the points I'm asking isn't really worth the time...)
>>>
>>> When I use the authority entrusted to maintainers, I feel obliged to =
at
>>> least explain my reasoning.  Besides, putting my reasoning in words
>>> tends to lead me to new insights.
>>
>> And I am indeed very grateful for that. :-)
>>
>>>> On 2017-07-10 11:17, Markus Armbruster wrote:
>>>>> Max Reitz <mreitz@redhat.com> writes:
>>>>>
>>>>>> On 2017-07-06 16:30, Markus Armbruster wrote:
>>
>> [...]
>>
>>>>> The only way to add unsigned integers without breaking QMP compatib=
ility
>>>>> is to make them interchangeable with signed integers.  That doesn't=
 mean
>>>>> you get to make floating-point numbers interchangeable with integer=
s
>>>>> now.
>>>>
>>>> Again, begs the question why QNum covers floating point numbers then=
 and
>>>> why this very fact is not documented in qnum.c.
>>>
>>> What kind of documentation would you like to see?
>>
>> It would be good to note that the QNum type is not meant to be a
>> completely uniform way to handle JSON numbers (e.g. if the user provid=
es
>> something with a decimal point but you need an integer, QNum will not =
do
>> that conversion for you).
>>
>> It is (English indirect speech is broken badly) just meant to
>> encapsulate the different variants a number can be represented in, but=

>> you're still generally supposed to read it out the way it was put in
>> (exceptions apply, see signed/unsigned and qnum_get_double()).
>=20
> Can we distill this into text that could become an actual patch?  Let m=
e
> try.
>=20
>     QNum encapsulates how our dialect of JSON fills in the blanks left
>     by the JSON specification (RFC 7159) regarding numbers.
>=20
>     Conceptually, we treat number as an abstract type with three
>     concrete subtypes: floating-point, signed integer, unsigned integer=
=2E
>     QNum implements this a discriminated union of double, int64_t,
>     uint64_t.
>=20
>     The JSON parser picks the subtype as follows.  If the number has a
>     decimal point or an exponent, it is floating-point.  Else if it fit=
s
>     into int64_t, it's signed integer.  Else if it first into uint64_t,=

>     it's unsigned integer.  Else it's floating-point.
>=20
>     Any number can serve as double: qnum_get_double() converts under th=
e
>     hood.
>=20
>     An integer can serve as signed / unsigned integer as long as it is
>     in range: qnum_get_try_int() / qnum_get_try_uint() check range and
>     convert under the hood.
>=20
> What do you think?

Sounds very good to me, thanks!

Max


--ab2qDUuDwSoSRwToxasgcdMBSUPgXuSf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmbBlASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AsIgH/ij7l+/BGOYkfBSOrsRHZQe0hU0zYUPx
VxLjsY+mtzS9oKdlPAHpAOVtRXeqj66o+nRs42q5CACqC/di8yGLLvFGTz6OhOQV
sEMrau4eN/JrgA3QonUb5BQ/RoMiKWmBBE0yALzdusH6fi4GirFxVYHn5JbZfWpA
VWdR9LJ7Y6dsId+/bG1UerUECpSTDTp9pPD2pw7U5Pe2WVD9GJX+8P8k5ro/9uFL
69GX5neg44NURA/G5sCOQyHozB3QK4lBxvieHbl6fYRIDXNUOyJHhy7100eUrs6K
T85+GJpz2iGB8O7vcJC571vi7eTOlBx/cIN66F7bwkiXjDrRzXzR3D4=
=K2BN
-----END PGP SIGNATURE-----

--ab2qDUuDwSoSRwToxasgcdMBSUPgXuSf6--
