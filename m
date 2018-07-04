Received: from eggs.gnu.org ([2001:4830:134:3::10]:40913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fakZJ-0005Jn-IK
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fakZF-0001KI-Gc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:23:49 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <87woub80yh.fsf@linaro.org>
Date: Wed, 4 Jul 2018 12:23:42 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <36142D7E-604F-428F-BF51-4AE9DC64FC0B@gmail.com>
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<87y3er84ud.fsf@linaro.org>
	<DC601B7F-5DCF-4005-8233-858B547C877E@gmail.com>
	<87woub80yh.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/7] target/ppc fp cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au


> On Jul 4, 2018, at 11:39 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
>=20
> Programmingkid <programmingkidx@gmail.com> writes:
>=20
>>> On Jul 4, 2018, at 10:15 AM, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> wrote:
>>>=20
>>>=20
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>=20
>>>>=20
>>>> Anyway, all of this has been broken long enough that it'll need to
>>>> wait til next devel cycle before anything further gets done.
>>>=20
>>> When it gets done should we add some explicit ppc tests to =
tests/tcg/ppc
>>> like we did with arm64 fcvt or would it be worth spending more time =
on
>>> the general purpose FP test suite Emilio was working on as part of =
his
>>> hard-float series?
>>=20
>> My vote goes to adding PowerPC specific tests. I already made some =
and sent them to the list a couple of days ago. A general purpose =
floating point test suite would probably not be able to test things like =
PowerPC floating point flags.
>>=20
>> I'm not certain how we would add floating point tests to QEMU. I'm
>> guessing it would involve some kind of bootable image file that would
>> load and run the tests. Hopefully there is an easier way to implement
>> testing.
>=20
> You don't need system tests - this is all testable from linux-user. =
See
> tests/tcg/arm/fcvt.c and the .ref files in arm and aarch64 =
directories.
> Assuming the test isn't insane (like test-i386-fprem) we can just add =
a
> reference output recorded on know good hardware.

My hope is to make testing the floating point unit as easy as 'make =
test' or maybe 'make fp-test'.=20
