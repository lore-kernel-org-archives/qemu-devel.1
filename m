Received: from eggs.gnu.org ([2001:4830:134:3::10]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d32Jo-00029o-2Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d32Jk-0001Bi-VF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:23:56 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d32Jk-0001BF-Nl
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:23:52 -0400
Received: by mail-wr0-x231.google.com with SMTP id w50so87576610wrc.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:23:52 -0700 (PDT)
References: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
	<20170425145823.GL21129@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170425145823.GL21129@redhat.com>
Date: Tue, 25 Apr 2017 16:24:18 +0100
Message-ID: <87bmrkbjdp.fsf@linaro.org>
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

> On Tue, Apr 25, 2017 at 03:51:17PM +0100, Peter Maydell wrote:
>> Hi; a recent travis build failure made me notice that our .travis.yml
>> config references a preseed tarball from here:
>> http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz
>>
>> I think this is a bit less than ideal -- we should really be hosting
>> this on qemu.org. Can we arrange to move it?
>
> I'm curious how much speed difference there is in seeding the git submodules
> in this way vs letting git pull down from git.qemu.org directly ?

It was quite high from what I recall, exacerbated by the fact we have
quite so many submodules. Unfortunately it doesn't seem that easy to go
back in the history of the tests to find out so I'll have to re-run the
test:

  https://travis-ci.org/stsquad/qemu/builds/225648653

So roughly 62s without a seed vs 15s with. I presume the seed is also
cached by Travis's web-caching.

--
Alex Bennée
