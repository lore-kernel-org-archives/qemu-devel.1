Received: from eggs.gnu.org ([2001:4830:134:3::10]:47447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg8Lr-0003Lj-Mz
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg8Lq-0000hw-6r
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:43:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
	<CAFEAcA_n88x0w1cVirQ61h+NOrvX1V7bXD1LCASVGyUZU=qDgg@mail.gmail.com>
	<20170811085157.GY13670@umbus.fritz.box>
	<CAFEAcA91j7zA2ptiLrcYL+cVF41_SJ2p0hL8Z=ejBiaqjfA--Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8f2f258e-6c14-a1df-8172-d20e51a70354@amsat.org>
Date: Fri, 11 Aug 2017 08:43:27 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA91j7zA2ptiLrcYL+cVF41_SJ2p0hL8Z=ejBiaqjfA--Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/6] ppc patch queue 2017-08-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi David, Peter,

On 08/11/2017 05:59 AM, Peter Maydell wrote:
> On 11 August 2017 at 09:51, David Gibson <david@gibson.dropbear.id.au> wrote:
>> On Thu, Aug 10, 2017 at 01:47:03PM +0100, Peter Maydell wrote:
>>> On 9 August 2017 at 08:03, David Gibson <david@gibson.dropbear.id.au> wrote:
>>>> I haven't completed a Travis build for this, which is part of my usual
>>>> test regime, since the first dozen or so Travis builds are failing
>>>> more often than not on master as well.  I don't know why this is -
>>>> seems to be failing some of the x86 tests.
>>>
>>> Doesn't look much worse than usual to me -- of the last 24 travis
>>> builds for master 4 failed and 20 passed.
>>
>> Uh.. that's not been my experience.  I was a bit unclear in my
>> description, though.  Until maybe a week and a half ago I found the
>> Travis build was fairly reliable, though there were occasional
>> transien failures.  Now, essentially every Travis build is failing for
>> me.  Specifically most of the first dozen or so of the batch of build
>> configurations on Travis fail (that's "X" not "!").  These seem to be
>> transient failures in the sense that if I rebuild enough times they'll
>> eventually pass, but unlike earlier when the builds would suceed most
>> of the time, they now seem to succeed at best around 1/3 of the time
>> (that's ~1/3 of the time for each configuration sub-build, so with a
>> dozen or so apparently affected that means a complete passing build
>> essentially never).
>>
>> See for example https://travis-ci.org/dgibson/qemu/builds/263312174
>> where 5 subbuilds have failed (which is relatively few).  In each case
>> the failing error seems to be something like:
>>
>> ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process (/i386/vhost-user/connect-fail/subprocess [55883]) failed unexpectedly
>>
>> Seems to be i386 in some cases and x86_64 in others.

Yes, I'm experiencing the same (but a bit more frequent with i386 than 
x86_64).

> Weird. https://travis-ci.org/qemu/qemu/builds is the master
> build history and as you can see it's mostly greens.
> Not sure why your setup would be significantly worse:
> maybe one of the travis submaintainers has an idea.
> It could just be our vhost-user-test is flaky but I don't
> know why that should hit you much more than master...

No clue, I started to think repositories with less frequent builds are 
deployed on faster hardware.

Will keep the list informed if there are some improvements.

Regards,

Phil.
