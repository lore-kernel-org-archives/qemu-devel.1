Received: from eggs.gnu.org ([2001:4830:134:3::10]:52183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVyip-0000HJ-Qh
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVyim-00038b-Kh
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:29:55 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVyim-00037y-Bz
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:29:52 -0400
Received: by mail-wm0-x22e.google.com with SMTP id j15-v6so5779404wme.0
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 05:29:52 -0700 (PDT)
References: <20180621062605.941-1-alex.bennee@linaro.org>
	<CAFEAcA8dug5h=NeMKt+8bz_X_r=FaeXz9oKr4QWxttpc5VmdsA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8dug5h=NeMKt+8bz_X_r=FaeXz9oKr4QWxttpc5VmdsA@mail.gmail.com>
Date: Thu, 21 Jun 2018 13:29:49 +0100
Message-ID: <87k1qsuxtu.fsf@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 21 June 2018 at 07:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a=
93b:
>>
>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into=
 staging (2018-06-20 09:51:30 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-210=
618-2
>>
>> for you to fetch changes up to 65b26da485540ffcc1c46c9a0898f01912ee6b7a:
>>
>>   .travis.yml: add check-tcg test (2018-06-20 22:13:39 +0100)
>>
>> ----------------------------------------------------------------
>> Add check-tcg machinary
>>
>> This restores the ability to run TCG smoke tests by using our docker
>> infrastructure to support cross building simple tests. It represents
>> the first step to making better cross-architecture testing available
>> straight from the source tree ;-)
>>
>> v2
>>   - fix quoting of target_compiler
>>   - make docker.py Py3 safe
>>   - tweak .travis.yml recipe
>>   - don't probe docker when HAVE_USER_DOCKER not set
>
> Weird build failure for linux/x86:
>
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all=
dbg'
> Makefile:90: rules.mak: No such file or directory
> Makefile:439: tests/Makefile.include: No such file or directory
> cat: VERSION: No such file or directory
> Makefile:1056: tests/docker/Makefile.include: No such file or directory
> Makefile:1057: tests/vm/Makefile.include: No such file or directory
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alld=
bg'
> make: *** No rule to make target 'tests/vm/Makefile.include'. Stop.
>
> like it's failed to figure out the source directory.
>
> This is my '--cc=3Dccache gcc' '--enable-debug' '--python=3Dpython3'
> build, and it's also the one I do a 'make clean' on -- perhaps
> build from clean has broken?

And you called a plain make to build it?

Let me see if I can reproduce.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
