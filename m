Received: from eggs.gnu.org ([2001:4830:134:3::10]:38581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <codyprime@gmail.com>) id 1d33C4-0008P6-Vm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <codyprime@gmail.com>) id 1d33C3-0004qa-Mj
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:20:00 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <codyprime@gmail.com>) id 1d33C3-0004qQ-Fb
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:19:59 -0400
Received: by mail-it0-x230.google.com with SMTP id g66so22153191ite.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 09:19:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878tmobhyy.fsf@linaro.org>
References: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
	<20170425145823.GL21129@redhat.com> <87bmrkbjdp.fsf@linaro.org>
	<20170425153206.GM21129@redhat.com> <878tmobhyy.fsf@linaro.org>
From: Jeff Cody <codyprime@gmail.com>
Date: Tue, 25 Apr 2017 12:19:57 -0400
Message-ID: <CAJ8Q05n+pq0E0vvJLt+gnLQik0SjQefXjLnu-0Xr1BO=awS0cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU travis builds: can we move the preseed
 tarball to qemu.org ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: jcody@redhat.com, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Apr 25, 2017 11:55 AM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote=
:


Daniel P. Berrange <berrange@redhat.com> writes:

> On Tue, Apr 25, 2017 at 04:24:18PM +0100, Alex Benn=C3=A9e wrote:
>>
>> Daniel P. Berrange <berrange@redhat.com> writes:
>>
>> > On Tue, Apr 25, 2017 at 03:51:17PM +0100, Peter Maydell wrote:
>> >> Hi; a recent travis build failure made me notice that our .travis.yml
>> >> config references a preseed tarball from here:
>> >> http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz
>> >>
>> >> I think this is a bit less than ideal -- we should really be hosting
>> >> this on qemu.org. Can we arrange to move it?
>> >
>> > I'm curious how much speed difference there is in seeding the git
submodules
>> > in this way vs letting git pull down from git.qemu.org directly ?
>>
>> It was quite high from what I recall, exacerbated by the fact we have
>> quite so many submodules. Unfortunately it doesn't seem that easy to go
>> back in the history of the tests to find out so I'll have to re-run the
>> test:
>>
>>   https://travis-ci.org/stsquad/qemu/builds/225648653
>>
>> So roughly 62s without a seed vs 15s with. I presume the seed is also
>> cached by Travis's web-caching.
>
> Wow, yes, that is quite a difference !
>
> I wonder if Travis' arbitrary sub-dir caching feature would help us to
> the same extent, while avoiding need to manually maintain the preseed.
>
>   https://docs.travis-ci.com/user/caching/
>
> It just caches entire content of a given subdir between runs. First time
> it would be slow, but presumably fast thereafter, and any time the
submodule
> gets new updates, those would get cached too

Maybe but I think the cwd of the build (and therefor the git tree) is
user and project name dependent, e.g.:

  PWD=3D/home/travis/build/stsquad/testcases

But we could certainly try.

>
> Regards,
> Daniel


--
Alex Benn=C3=A9e


I do currently have an async script that runs for qemu.git, that is
triggered by a post-receive hook.   Currently, it just does a push to
GitHub, so that the mirror is updated in real-time.  It would be pretty
trivial to have it also compose a tarball as well.

Jeff
