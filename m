Received: from eggs.gnu.org ([2001:4830:134:3::10]:44186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUv2U-0002Vz-Ex
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUv2T-0003h0-EI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:17:18 -0400
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
	<87poddk583.fsf@dusky.pond.sub.org>
	<6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
	<87a84c6476.fsf@dusky.pond.sub.org>
	<704969af-283c-d22b-f0d2-e7bf0a7b609a@redhat.com>
	<87y3rvjjip.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <27f963d3-46f3-d497-2bb6-eca05e808983@redhat.com>
Date: Tue, 11 Jul 2017 15:17:02 +0200
MIME-Version: 1.0
In-Reply-To: <87y3rvjjip.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8EspLBIgpWi8S6VtrBr7l90cwmqj9wpdX"
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
--8EspLBIgpWi8S6VtrBr7l90cwmqj9wpdX
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <27f963d3-46f3-d497-2bb6-eca05e808983@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
References: <20170705190404.22449-1-mreitz@redhat.com>
 <20170705190404.22449-3-mreitz@redhat.com>
 <87poddk583.fsf@dusky.pond.sub.org>
 <6a1740fd-2a8c-f338-6ce1-e0f4bbade407@redhat.com>
 <87a84c6476.fsf@dusky.pond.sub.org>
 <704969af-283c-d22b-f0d2-e7bf0a7b609a@redhat.com>
 <87y3rvjjip.fsf@dusky.pond.sub.org>
In-Reply-To: <87y3rvjjip.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-11 13:33, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> First of all, OK, you don't want QNum(42.0) to equal QNum(42) at all (=
at
>> least not right now and in the foreseeable future).
>> You're the maintainer, so you decide, so I'll go along with it. :-)
>>
>> Now, let's follow up with my therefore rather useless commentary:
>>
>> (Feel free to disregard, because honestly, I can see how replying to
>> most of the points I'm asking isn't really worth the time...)
>=20
> When I use the authority entrusted to maintainers, I feel obliged to at=

> least explain my reasoning.  Besides, putting my reasoning in words
> tends to lead me to new insights.

And I am indeed very grateful for that. :-)

>> On 2017-07-10 11:17, Markus Armbruster wrote:
>>> Max Reitz <mreitz@redhat.com> writes:
>>>
>>>> On 2017-07-06 16:30, Markus Armbruster wrote:

[...]

>>> The only way to add unsigned integers without breaking QMP compatibil=
ity
>>> is to make them interchangeable with signed integers.  That doesn't m=
ean
>>> you get to make floating-point numbers interchangeable with integers
>>> now.
>>
>> Again, begs the question why QNum covers floating point numbers then a=
nd
>> why this very fact is not documented in qnum.c.
>=20
> What kind of documentation would you like to see?

It would be good to note that the QNum type is not meant to be a
completely uniform way to handle JSON numbers (e.g. if the user provides
something with a decimal point but you need an integer, QNum will not do
that conversion for you).

It is (English indirect speech is broken badly) just meant to
encapsulate the different variants a number can be represented in, but
you're still generally supposed to read it out the way it was put in
(exceptions apply, see signed/unsigned and qnum_get_double()).

Max


--8EspLBIgpWi8S6VtrBr7l90cwmqj9wpdX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZM/OEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGan
B/43FBMymoRZB3Zq5MkDmA2uG78E2R9GijyYJAkMEpPZJIi1P/ugFMvLwtOzSGQB
+BO73cZOj0OW1bctDCOk8YWxlKxz020RMpob8ZTzIBVb+VNaBXxjMWxgV+yX0S+l
SL7H/7MRRUPtnd7sy51xtogZxLxtQJI1uy6AXjQpN4XLcJn2LNQxfmFFMF9YsmBQ
KBd5qzJNS2BfvvYwsik/EEibL1AUBFu8daZjOrKewpY09s4uWsW8a9fNDw3EwrOK
cHnGvUrPK2vngdVvaB1Djw/JCEl3ZBT1ERg6W5E34IIYJYlw+skc0/GCid1gqbLF
3unB2pBrgsUrBKfylKa4kbRa
=qv/F
-----END PGP SIGNATURE-----

--8EspLBIgpWi8S6VtrBr7l90cwmqj9wpdX--
