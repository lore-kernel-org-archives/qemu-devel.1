Received: from eggs.gnu.org ([2001:4830:134:3::10]:57410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkUNP-0006n0-2M
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkUNL-000853-4j
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:03:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dkUNK-00084f-Qu
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:03:11 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
	<dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <48906779-cd74-bfe6-1e4a-4678eb2d0a0d@redhat.com>
Date: Wed, 23 Aug 2017 14:01:16 +0200
MIME-Version: 1.0
In-Reply-To: <dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1Chuegs6wevEWtln8QU3wDUS78wmqASAx"
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Chuegs6wevEWtln8QU3wDUS78wmqASAx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.08.2017 13:51, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 23.8.2017 v 10:35 Thomas Huth napsal(a):
>> On 23.08.2017 10:01, Paolo Bonzini wrote:
>>> On 23/08/2017 09:49, Thomas Huth wrote:
>>>> While we're at it: I'd like to have a "make check-fast", too. Someti=
mes
>>>> the normal "make check" is already too slow, e.g. while developing n=
ew
>>>> patches, I sometimes just want to do a very quick sanity test to see=

>>>> whether I broke some basic things or not, and only do the "make chec=
k"
>>>> before I submit my patches.
>>>> So we would get three stages:
>>>>
>>>> - make check-fast =3D> For very, very quick sanity tests only
>>>>
>>>> - make check =3D> E.g. has to be run before submitting patches
>>>>
>>>> - make check-harder =3D> might run a very long time, so best suited =
for
>>>>                        nightly regression tests etc.?
>>>>
>>>> Does that sound reasonable? And the crucial question: Who is going t=
o
>>>> implement the basic framework for this?
>>>
>>> There's already make check-unit or make check-qtest-x86_64 depending =
on
>>> what you're working on.
>>
>> True. And I just learned that you can also already set the SPEED
>> variable to either "quick" or "slow" and that we're already using
>> g_test_quick() and g_test_slow() in a couple of places to check this. =
So
>> the framework for running quick vs. thorough tests is already there ..=
=2E
>> we just might want to add this to some more tests, I guess...
>>
>> Question for the maintainers and the test automation folks: Is anybody=

>> already running "make check SPEED=3Dslow" or is this just rather an
>> unheard-of way of running the tests?
>>
>>> If you have a many-core machine, of course, there's no simpler soluti=
on
>>> than throwing more CPUs at it. :)
>>
>> Is it safe nowadays to run "make check -j4" for example? Last time I
>> tried (maybe 1 or 2 years ago), there were still issues since some tes=
ts
>> were using hard-coded temporary file names, so the parallel tests were=

>> disturbing each other, for example...
>>
>=20
> Actually the `.travis.yml` defines `MAKEFLAGS=3D"-j3"`, which results i=
n `make check` being executed with 3 threads...
>=20
> I was actually looking at the increasing number of failed travis builds=
 and it seems to be related to the fluctuating performance. Running `nice=
 -n 20 make check -j 12` with `nice -n 5 stress -c 20` in background resu=
lts in the same kind of failures:
>=20
>     File '/tmp/qemu/include/qapi/qmp/qobject.h'
>     Lines executed:0.00% of 9
>     **
>     ERROR:tests/prom-env-test.c:42:check_guest_memory: assertion failed=
 (signature =3D=3D MAGIC): (0x7c7f1b78 =3D=3D 0xcafec0de)

I think you're simply running into timeout issues here since you're
likely overloading the host, I guess. Or does your host have that many CP=
Us?
If the timeouts are really an issue here, we simply might have to
increase the timeout values a bit again...

 Thomas


--1Chuegs6wevEWtln8QU3wDUS78wmqASAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZnW6SAAoJEC7Z13T+cC21pE8P/jYxhvNZDiu+8QtRPnxzb29d
rYe8tMLoTBjM3Xw+RtjjZN5iBdabMbW4z7sN6qPjxUfxvq/8YGrpUuITVV3FjJk2
cnZsB9xjJTc472A149zeuSMWnFZ7A+8z4QERUq1c9HFbBDMHL4Y9cxdm9Liwzn/R
yvdOayOlqSGvBbSq9pMsqVDZagBJL4lMMrclvoMeT/q6vny9rMBoU6WzH1xoQXVJ
nhFtZ+ikqsmHhdr1OkV2QFkFsobkEoYn9Tg6p/FiBU8qzVo4CPg0RcofFSF3I5l+
9npzZwdAJ1MP4iHsbKy5DglEZQmqCWtIT2nS/hV9pNrg6ljCPQ77GwWC3nzF5Uj5
bPu/cXc/257QcQHCEFO1VwRdT2nl5BHY2hij/Yn/vhPu/xxkwm7/xWAOgI0c8UdG
j7spbHLwWX8E0N7JDL8ziBmqkIc10Dys8jUwYsPLZSI7KbOZ5Vw336FN8s4mcns4
5tPOgY/5if6sCgOIYu+1J0otxacYhj0RAFy1LUDzaDvrCDNz6hmbtk/WYCytSr/M
iDJwqDE838N+EcOA9KevhUm1te81rKBwRrJRgTasSHOtS5A0ZAMDHDU3j/0cLgLY
tTDc8uKJVLhQz716AADHzBu5lW2znUkFW7sQ1z8C5SF0631drh8haHI94+Jw8CXn
OPm2hi1E59+S5WnSHgJS
=4wQm
-----END PGP SIGNATURE-----

--1Chuegs6wevEWtln8QU3wDUS78wmqASAx--
