Received: from eggs.gnu.org ([2001:4830:134:3::10]:47471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fW1G0-0002Io-M8
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fW1Fw-0005lg-Mq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:12:20 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fW1Fw-0005lA-FD
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:12:16 -0400
Received: by mail-wm0-x230.google.com with SMTP id p11-v6so6797418wmc.4
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:12:16 -0700 (PDT)
References: <20180621062605.941-1-alex.bennee@linaro.org>
	<CAFEAcA8dug5h=NeMKt+8bz_X_r=FaeXz9oKr4QWxttpc5VmdsA@mail.gmail.com>
	<87in6curdy.fsf@linaro.org>
	<ccd49bcc-1a67-064e-7508-5c8bb723fd59@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <ccd49bcc-1a67-064e-7508-5c8bb723fd59@amsat.org>
Date: Thu, 21 Jun 2018 16:12:14 +0100
Message-ID: <87h8lwuqb5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/57] add check-tcg and associated
 machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 06/21/2018 11:48 AM, Alex Benn=C3=A9e wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 21 June 2018 at 07:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>>>> The following changes since commit 46012db666990ff2eed1d3dc199ab800643=
9a93b:
>>>>
>>>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' in=
to staging (2018-06-20 09:51:30 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-2=
10618-2
>>>>
>>>> for you to fetch changes up to 65b26da485540ffcc1c46c9a0898f01912ee6b7=
a:
>>>>
>>>>   .travis.yml: add check-tcg test (2018-06-20 22:13:39 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Add check-tcg machinary
>>>>
>>>> This restores the ability to run TCG smoke tests by using our docker
>>>> infrastructure to support cross building simple tests. It represents
>>>> the first step to making better cross-architecture testing available
>>>> straight from the source tree ;-)
>>>>
>>>> v2
>>>>   - fix quoting of target_compiler
>>>>   - make docker.py Py3 safe
>>>>   - tweak .travis.yml recipe
>>>>   - don't probe docker when HAVE_USER_DOCKER not set
>>>
>>> Weird build failure for linux/x86:
>>>
>>> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/a=
lldbg'
>>> Makefile:90: rules.mak: No such file or directory
>>> Makefile:439: tests/Makefile.include: No such file or directory
>>> cat: VERSION: No such file or directory
>>> Makefile:1056: tests/docker/Makefile.include: No such file or directory
>>> Makefile:1057: tests/vm/Makefile.include: No such file or directory
>>> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/al=
ldbg'
>>> make: *** No rule to make target 'tests/vm/Makefile.include'. Stop.
>>>
>>> like it's failed to figure out the source directory.
>>>
>>> This is my '--cc=3Dccache gcc' '--enable-debug' '--python=3Dpython3'
>>> build, and it's also the one I do a 'make clean' on -- perhaps
>>> build from clean has broken?
>>
>> Hmm I can't reproduce this. I've built a fresh 16.04 server image with
>> and with:
>>
>>   # Configured with: './configure' '--cc=3Dccache gcc' '--enable-debug' =
'--python=3Dpython3'
>>
>> both:
>>   make
>>
>> and:
>>   make check-tcg
>>
>> Work for me :-/
>
> Did you try rebuilding after a 'make clean'?

Yep, both make clean, configure, make and make clean, make


--
Alex Benn=C3=A9e
