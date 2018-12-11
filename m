Received: from eggs.gnu.org ([2001:4830:134:3::10]:56109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWgz6-0002BI-6C
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWgz2-0005eP-VA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:17:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:54045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWgz2-0005dG-Nr
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:17:52 -0500
Received: by mail-wm1-x330.google.com with SMTP id y1so1968620wmi.3
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 04:17:52 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-5-alex.bennee@linaro.org>
	<CAL1e-=j1o_Sc0-xsgTq+0wsE1HC+p1_kEA5Op4Ub0D03J7juMA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAL1e-=j1o_Sc0-xsgTq+0wsE1HC+p1_kEA5Op4Ub0D03J7juMA@mail.gmail.com>
Date: Tue, 11 Dec 2018 12:17:50 +0000
Message-ID: <87sgz41clt.fsf@linaro.org>
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
Cc: shorne@gmail.com, amarkovic@wavecomp.com, qemu-devel@nongnu.org, aurelien@aurel32.net, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, michael@walle.cc, Stefan Markovic <smarkovic@wavecomp.com>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On Dec 10, 2018 4:29 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrot=
e:
>>
>> Convert the existing tests to use our common cross build
>> infrastructure.
>>
>> [WIP: mips32r2 disabled to avoid name clash]
>> [WIP: mipsr5900 disabled due to clashing build flags]
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/mips/Makefile.target       |  15 ++-
>>  tests/tcg/mips/mips32-dsp/Makefile   | 166 +++++----------------------
>>  tests/tcg/mips/mips32-dspr2/Makefile |  83 +++-----------
>>  tests/tcg/mips/mipsr5900/Makefile    |  40 +++----
>>  4 files changed, 75 insertions(+), 229 deletions(-)
>>
>
> Thank you Alex for this initiative.
>
> For DSP, following MIPS CPUs in QEMU support DSP:
>
> DSP: 24KEc (MIPS32R2),  34Kf (MIPS32R2), 74Kf (MIPS32R2), mips64dspr2
> (MIPS64R2),
>
> DSP R2: mips64dspr2 (MIPS64R2),

That's why I'm confused by a mips32-dspr2 directory. Does that mean both
of those directories run on the 74Kf processor model (MIPS32R2)?

> (For simplicity, I didn't mention new nanoMIPS architecture, since your g=
cc
> for sure don't support it yet)
>
> In brackets, those are architectures that are usually required to be pass=
ed
> to gcc as its option, and that explains the switch involving MIPS64R2 for
> DSP R2.
>
> Whereas while starting QEMU, CPU name should be specified in -cpu switch.
>
> mips64dspr2 is a virtual cpu (doesn't model any real cpu) made specifical=
ly
> for DSP R2 testings, hence such odd name.
>
> Hopefully this clarifies some of your dilemmas.
>
> What are name clashes that you mention? Are they just related to
> filenames?

I think it is because there are a bunch of names in both mips32-dsp and
mips32-dspr2 that are the same. I thought that should be sorted by the
fact I only set the VPATH to tests/tcg/mips and added the tests
including their dir path but for some reason it wasn't working.

--
Alex Benn=C3=A9e
