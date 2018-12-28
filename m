Received: from eggs.gnu.org ([208.118.235.92]:33785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gcpXJ-0000DR-1n
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 05:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gcpNL-00018a-4q
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 05:28:22 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gcpNK-000155-Mh
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 05:28:19 -0500
Received: by mail-wm1-x344.google.com with SMTP id f81so19365710wmd.4
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 02:28:18 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-5-alex.bennee@linaro.org>
	<CAL1e-=hfFv1TsG_viYi6-0z0qN8GnTP-70ZLMrDMmLVz9iBWQA@mail.gmail.com>
	<87imzpa4gx.fsf@linaro.org>
	<CAL1e-=hyKFR=9PHSnNdqFd=XFo2PoQK7qVrtM9GNM3V47V=2Mg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAL1e-=hyKFR=9PHSnNdqFd=XFo2PoQK7qVrtM9GNM3V47V=2Mg@mail.gmail.com>
Date: Fri, 28 Dec 2018 10:28:15 +0000
Message-ID: <878t0aq728.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/13] tests/tcg/mips: enable
 mips32-dsp/mips32-dspr2/mipsr5900 linux-user (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "shorne@gmail.com" <shorne@gmail.com>, "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "michael@walle.cc" <michael@walle.cc>, Stefan Markovic <smarkovic@wavecomp.com>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> HI, Alex, just a heads up that I plan to submit directory and file
> reorganization of tests/tcg/mips mini patch series today or tomorrow.
> Aleksandar

My current tree state is:

  https://github.com/stsquad/qemu/tree/testing/enable-system-tcg-tests-v2

But I'm still having trouble generating nicely linked no-pic code. But
I'll happily re-base after you've re-organised the tree. Will you be
testing the build as is with the current Makefiles?

>
> On Wednesday, December 19, 2018, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>
>>
>> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>>
>> > On Dec 10, 2018 4:29 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> w=
rote:
>> >>
>> >> Convert the existing tests to use our common cross build
>> >> infrastructure.
>> >>
>> >> [WIP: mips32r2 disabled to avoid name clash]
>> >> [WIP: mipsr5900 disabled due to clashing build flags]
>> >>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> ---
>> >>  tests/tcg/mips/Makefile.target       |  15 ++-
>> >>  tests/tcg/mips/mips32-dsp/Makefile   | 166 +++++--------------------=
--
>> >>  tests/tcg/mips/mips32-dspr2/Makefile |  83 +++-----------
>> >>  tests/tcg/mips/mipsr5900/Makefile    |  40 +++----
>> >>  4 files changed, 75 insertions(+), 229 deletions(-)
>> >>
>> >
>> > Alex,
>> >
>> > How about reorganizing directories in tests/tcg/mips altogether, and m=
ake
>> > it less confusing, and easier for future developers to approach an work
>> on?
>> >
>> > Let's say like this:
>> >
>> > tests/tcg/mips
>> >     user
>> >         isa
>> >             r5900
>> >         ase
>> >             dsp
>> >             dsp_r2
>> >     system
>> >         isa   =E3=80=8Afor now empty=E3=80=8B
>> >         ase
>> >             dsp
>> >             dsp_r2
>>
>> Yeah sounds like a plan. I'm going to do the same with cris (bare and
>> libc).
>>
>> >
>> > Thanks,
>> > Aleksandar
>>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e
