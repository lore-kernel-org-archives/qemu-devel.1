Received: from eggs.gnu.org ([2001:4830:134:3::10]:33029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkQPp-0000SC-6K
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkQPl-0005iy-V7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dkQPl-0005iZ-Lo
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:49:25 -0400
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
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
Date: Wed, 23 Aug 2017 09:49:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170823091650.48e7c44e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] make check speed (was: Re: [PATCH for-2.10]
 boot-serial-test: prefer tcg accelerator)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23.08.2017 09:16, Cornelia Huck wrote:
> On Wed, 23 Aug 2017 10:29:07 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
>> On Tue, Aug 22, 2017 at 01:48:15PM +0200, Cornelia Huck wrote:
>>> On Tue, 22 Aug 2017 21:20:46 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>  =20
>>>> Obviously it's not a thing to fix right now, but I've really been
>>>> thinking that none of the tests should use this "TCG or KVM" stuff.
>>>> They should instead be run with *both* options - or at least the one=
s
>>>> that are available on the host. =20
>>>
>>> Having one test as a 'smoke test' that is run for everything availabl=
e
>>> sounds like a good idea, and the boot-serial test may be a good
>>> candidate for that.
>>>
>>> I would not want to run every test with every accelerator, however, a=
s
>>> this makes 'make check' even slower than it is now. (Although it may =
be
>>> useful to be able to trigger 'run everything' tests on some dedicated
>>> test machines.) =20
>>
>> I'd be fine with only running the full matrix on a "make check-harder"
>> or whatever, target.  But I'd like the option to be there.  Sometimes
>> (like when preparing a pull request) a slower check is an acceptable
>> cost for better coverage.
>=20
> make check with one smoke test + make check-harder (like the name :)
> sounds like a good combination.

While we're at it: I'd like to have a "make check-fast", too. Sometimes
the normal "make check" is already too slow, e.g. while developing new
patches, I sometimes just want to do a very quick sanity test to see
whether I broke some basic things or not, and only do the "make check"
before I submit my patches.
So we would get three stages:

- make check-fast =3D> For very, very quick sanity tests only

- make check =3D> E.g. has to be run before submitting patches

- make check-harder =3D> might run a very long time, so best suited for
                       nightly regression tests etc.?

Does that sound reasonable? And the crucial question: Who is going to
implement the basic framework for this?

 Thomas
