Received: from eggs.gnu.org ([2001:4830:134:3::10]:47284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZeKA-0007jy-Bi
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZeK4-0001JS-90
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:03:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gZeK3-0001FN-Dn
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:03:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id m22so7038574wml.3
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 08:03:44 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-5-alex.bennee@linaro.org>
	<CAL1e-=hfFv1TsG_viYi6-0z0qN8GnTP-70ZLMrDMmLVz9iBWQA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAL1e-=hfFv1TsG_viYi6-0z0qN8GnTP-70ZLMrDMmLVz9iBWQA@mail.gmail.com>
Date: Wed, 19 Dec 2018 16:03:42 +0000
Message-ID: <87imzpa4gx.fsf@linaro.org>
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
> Alex,
>
> How about reorganizing directories in tests/tcg/mips altogether, and make
> it less confusing, and easier for future developers to approach an work o=
n?
>
> Let's say like this:
>
> tests/tcg/mips
>     user
>         isa
>             r5900
>         ase
>             dsp
>             dsp_r2
>     system
>         isa   =E3=80=8Afor now empty=E3=80=8B
>         ase
>             dsp
>             dsp_r2

Yeah sounds like a plan. I'm going to do the same with cris (bare and libc).

>
> Thanks,
> Aleksandar


--
Alex Benn=C3=A9e
