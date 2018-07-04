Received: from eggs.gnu.org ([2001:4830:134:3::10]:57377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fajsL-0006a9-A9
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fajsH-0003Qb-DZ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:39:25 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fajsH-0003PZ-5S
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:39:21 -0400
Received: by mail-wm0-x241.google.com with SMTP id 69-v6so6407042wmf.3
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 08:39:21 -0700 (PDT)
References: <20180703151732.29843-1-richard.henderson@linaro.org>
	<87y3er84ud.fsf@linaro.org>
	<DC601B7F-5DCF-4005-8233-858B547C877E@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <DC601B7F-5DCF-4005-8233-858B547C877E@gmail.com>
Date: Wed, 04 Jul 2018 16:39:18 +0100
Message-ID: <87woub80yh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/7] target/ppc fp cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au


Programmingkid <programmingkidx@gmail.com> writes:

>> On Jul 4, 2018, at 10:15 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>>
>>> Anyway, all of this has been broken long enough that it'll need to
>>> wait til next devel cycle before anything further gets done.
>>
>> When it gets done should we add some explicit ppc tests to tests/tcg/ppc
>> like we did with arm64 fcvt or would it be worth spending more time on
>> the general purpose FP test suite Emilio was working on as part of his
>> hard-float series?
>
> My vote goes to adding PowerPC specific tests. I already made some and se=
nt them to the list a couple of days ago. A general purpose floating point =
test suite would probably not be able to test things like PowerPC floating =
point flags.
>
> I'm not certain how we would add floating point tests to QEMU. I'm
> guessing it would involve some kind of bootable image file that would
> load and run the tests. Hopefully there is an easier way to implement
> testing.

You don't need system tests - this is all testable from linux-user. See
tests/tcg/arm/fcvt.c and the .ref files in arm and aarch64 directories.
Assuming the test isn't insane (like test-i386-fprem) we can just add a
reference output recorded on know good hardware.

--
Alex Benn=C3=A9e
