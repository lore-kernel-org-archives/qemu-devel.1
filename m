Received: from eggs.gnu.org ([2001:4830:134:3::10]:57942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEebB-0005KD-UX
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEeb9-00049k-Bv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:34:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fEeb9-00049W-1J
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:34:23 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
	<20180502075904.GF3308@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5353d5cb-9aa4-0666-201c-2ace213a8393@redhat.com>
Date: Fri, 4 May 2018 19:34:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180502075904.GF3308@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lk6d2YMRZnTudNu2Q7jgYR001NgGZZQq9"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Liviu Ionescu <ilg@livius.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lk6d2YMRZnTudNu2Q7jgYR001NgGZZQq9
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <5353d5cb-9aa4-0666-201c-2ace213a8393@redhat.com>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
 <20180430103312.GH3249@redhat.com>
 <20180430132107.0a37704d.cohuck@redhat.com>
 <ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
 <20180502093326.2fbec55f.cohuck@redhat.com>
 <CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
 <20180502075904.GF3308@redhat.com>
In-Reply-To: <20180502075904.GF3308@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 09:59, Daniel P. Berrang=C3=A9 wrote:
> On Wed, May 02, 2018 at 12:43:10AM -0700, Liviu Ionescu wrote:
>> On 2 May 2018 at 10:38:09, Cornelia Huck (cohuck@redhat.com) wrote:
>>
>>>>>>> a) Bump major version once a year, so we'll have 3.0, 3.1,
>>> 3.3,
>>>>>> 4.0, 4.1, 4.2, 5.0, ...etc We missed the first release this
>>>>>> year, so we would only have 3.0 and 3.1 this year.
>>>>>>
>>>>>> b) Bump major release when minor version gets double-digits.
>>>>>> eg 3.0, 3.1, ...., 3.9, 3.9, 4.0, ...., 4.9, 5.0...
>>>>
>>>> It's just a matter of taste, but I think I'd prefer variant b).
>>> That
>>>> will bump the major release approx. every three years which
>>> sounds like
>>>> a good time frame for me.
>>>
>>> I think anything that keeps release numbers in ascending order
>>> would
>>> basically work :)
>>
>> not really.
>>
>> I suggest you use semantic versioning:
>>
>> https://semver.org
>=20
> No, not semver. It is not a good match for the way QEMU is handling
> incompatible changes. Our deprecation policy lets us include incompatib=
le
> changes in *any* release. So with semver that would force a major versi=
on
> bump on every release which is madness.

FWIW, I think that just means that our deprecation policy is weird.

As a developer, it's great, of course.  You can break everything, just
put up a heads-up two versions in advance.

But I'm grateful I'm not a direct user of qemu (i.e. without libvirt).
I imagine it to be pretty stressful if I have to check on every (or
every second...) release that qemu doesn't show up new deprecation
notices for something I'm using.

Maybe it would make sense to collect things we want to deprecate and
then have a major release every year where we do that deprecation.  As a
user, I'd much prefer that to the possibility of everything changing all
the time.

Max


--lk6d2YMRZnTudNu2Q7jgYR001NgGZZQq9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrsmZIACgkQ9AfbAGHV
z0B89AgAl/u7NeDiUvtaJnTnqHOlFsM7JgN8hFcgpbZDdSXf+Vr83zBhW0ArxLiy
B9yaIwsKU9G8C2vxGKcm6J5EIJUEIiiC1FJqDrNn7jJcsstzc0pXcPVDmIjTu6qo
OXmKrR06RHbro16gDvuAhWLrEdieZh/wyz6NPYhrTT1blg1zgJrrD5do88KdCbTv
BZ52viyfv/qZvE2gN/O5PR9UPd7VOBayrZ0yb/DQ07hcAkkVxxRkkhdcYmN6s7fl
R5w5gin623hy/ST+k/dO5c9JFhziewjTkIvP/WFOILGny0SUUaN1uiw/dIZhD0rr
Xmz5b53dNdi5wPE4M21zazxlC8J4tw==
=Ns65
-----END PGP SIGNATURE-----

--lk6d2YMRZnTudNu2Q7jgYR001NgGZZQq9--
