Received: from eggs.gnu.org ([2001:4830:134:3::10]:43378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW15a-000448-5M
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW15U-0007uz-GE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:01:34 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:42089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW15U-0007ul-9p
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:01:28 -0400
Received: by mail-qt0-x231.google.com with SMTP id y31-v6so3095954qty.9
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 08:01:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180621062605.941-1-alex.bennee@linaro.org>
	<CAFEAcA8dug5h=NeMKt+8bz_X_r=FaeXz9oKr4QWxttpc5VmdsA@mail.gmail.com>
	<87in6curdy.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ccd49bcc-1a67-064e-7508-5c8bb723fd59@amsat.org>
Date: Thu, 21 Jun 2018 12:01:03 -0300
MIME-Version: 1.0
In-Reply-To: <87in6curdy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

Hi Alex,

On 06/21/2018 11:48 AM, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On 21 June 2018 at 07:25, Alex Bennée <alex.bennee@linaro.org> wrote:
>>> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:
>>>
>>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-210618-2
>>>
>>> for you to fetch changes up to 65b26da485540ffcc1c46c9a0898f01912ee6b7a:
>>>
>>>   .travis.yml: add check-tcg test (2018-06-20 22:13:39 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Add check-tcg machinary
>>>
>>> This restores the ability to run TCG smoke tests by using our docker
>>> infrastructure to support cross building simple tests. It represents
>>> the first step to making better cross-architecture testing available
>>> straight from the source tree ;-)
>>>
>>> v2
>>>   - fix quoting of target_compiler
>>>   - make docker.py Py3 safe
>>>   - tweak .travis.yml recipe
>>>   - don't probe docker when HAVE_USER_DOCKER not set
>>
>> Weird build failure for linux/x86:
>>
>> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg'
>> Makefile:90: rules.mak: No such file or directory
>> Makefile:439: tests/Makefile.include: No such file or directory
>> cat: VERSION: No such file or directory
>> Makefile:1056: tests/docker/Makefile.include: No such file or directory
>> Makefile:1057: tests/vm/Makefile.include: No such file or directory
>> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg'
>> make: *** No rule to make target 'tests/vm/Makefile.include'. Stop.
>>
>> like it's failed to figure out the source directory.
>>
>> This is my '--cc=ccache gcc' '--enable-debug' '--python=python3'
>> build, and it's also the one I do a 'make clean' on -- perhaps
>> build from clean has broken?
> 
> Hmm I can't reproduce this. I've built a fresh 16.04 server image with
> and with:
> 
>   # Configured with: './configure' '--cc=ccache gcc' '--enable-debug' '--python=python3'
> 
> both:
>   make
> 
> and:
>   make check-tcg
> 
> Work for me :-/

Did you try rebuilding after a 'make clean'?
