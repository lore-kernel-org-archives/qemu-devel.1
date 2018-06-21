Received: from eggs.gnu.org ([2001:4830:134:3::10]:39476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fW0tU-00052w-BJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fW0tQ-0001jb-8s
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:49:04 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:46334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fW0tP-0001jK-W8
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:49:00 -0400
Received: by mail-wr0-x22b.google.com with SMTP id v13-v6so3484179wrp.13
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 07:48:59 -0700 (PDT)
References: <20180621062605.941-1-alex.bennee@linaro.org>
	<CAFEAcA8dug5h=NeMKt+8bz_X_r=FaeXz9oKr4QWxttpc5VmdsA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8dug5h=NeMKt+8bz_X_r=FaeXz9oKr4QWxttpc5VmdsA@mail.gmail.com>
Date: Thu, 21 Jun 2018 15:48:57 +0100
Message-ID: <87in6curdy.fsf@linaro.org>
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

Hmm I can't reproduce this. I've built a fresh 16.04 server image with
and with:

  # Configured with: './configure' '--cc=3Dccache gcc' '--enable-debug' '--=
python=3Dpython3'

both:
  make

and:
  make check-tcg

Work for me :-/

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
