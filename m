Received: from eggs.gnu.org ([2001:4830:134:3::10]:58530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d32nG-0003lt-MZ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d32nD-0000sY-Kt
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:54:22 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d32nD-0000s1-Bt
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:54:19 -0400
Received: by mail-wr0-x229.google.com with SMTP id l50so37559013wrc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:54:19 -0700 (PDT)
References: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
	<20170425145823.GL21129@redhat.com> <87bmrkbjdp.fsf@linaro.org>
	<20170425153206.GM21129@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170425153206.GM21129@redhat.com>
Date: Tue, 25 Apr 2017 16:54:45 +0100
Message-ID: <878tmobhyy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>


Daniel P. Berrange <berrange@redhat.com> writes:

> On Tue, Apr 25, 2017 at 04:24:18PM +0100, Alex Bennée wrote:
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
>> > I'm curious how much speed difference there is in seeding the git submodules
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
> it would be slow, but presumably fast thereafter, and any time the submodule
> gets new updates, those would get cached too

Maybe but I think the cwd of the build (and therefor the git tree) is
user and project name dependent, e.g.:

  PWD=/home/travis/build/stsquad/testcases

But we could certainly try.

>
> Regards,
> Daniel


--
Alex Bennée
