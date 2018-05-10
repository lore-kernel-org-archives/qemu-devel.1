Received: from eggs.gnu.org ([2001:4830:134:3::10]:49336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGliU-0006Xk-J6
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGliQ-0005oC-BR
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:34:42 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:39183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGliQ-0005nn-4w
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:34:38 -0400
Received: by mail-wr0-x234.google.com with SMTP id q3-v6so2052299wrj.6
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 06:34:38 -0700 (PDT)
References: <20180510094206.15354-1-alex.bennee@linaro.org>
	<CAFEAcA88-EFYN3y-sU=YbzeT-eXCBk7md-y2rEQfpJtZ+MF-wQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA88-EFYN3y-sU=YbzeT-eXCBk7md-y2rEQfpJtZ+MF-wQ@mail.gmail.com>
Date: Thu, 10 May 2018 14:34:35 +0100
Message-ID: <87k1sbvdlg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/5] refactor float-to-float and fix AHP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 10 May 2018 at 10:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> Hi,
>>
>> Hi,
>>
>> I've not included the test case in the series but you can find it in
>> my TCG fixup branch:
>>
>>   https://github.com/stsquad/qemu/blob/testing/tcg-tests-revival-v4/test=
s/tcg/arm/fcvt.c
>>
>> Some of the ARMv7 versions are commented out as they where not
>> supported until later revs. I do have a build that includes that but
>> unfortunately the Debian compiler it too old to build it.
>>
>> : patch 0001/fpu softfloat int_to_float ensure r fully initial.patch nee=
ds review
>> : patch 0004/target arm convert conversion helpers to fpst ahp.patch nee=
ds review
>> : patch 0005/target arm squash FZ16 behaviour for conversions.patch need=
s review
>
> This still seems to regress the NaN conversion case I mentioned
> in review of the previous series:
>
> (3) Here's a NaN case we get wrong now: 64 to IEEE-16 conversion,
> input is 0x7ff0000000000001 (an SNaN), we produce
> 0x7c00 (infinity) but should produce 0x7e00 (a QNaN).

Hmm I had added the test case but due to another bug it never actually
ran :-/

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
