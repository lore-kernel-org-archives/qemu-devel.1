Received: from eggs.gnu.org ([2001:4830:134:3::10]:47690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1did8R-0005wL-2n
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1did8N-0003Q5-Cb
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:00:07 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1did8N-0003OQ-6X
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:00:03 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 49so55791592wrw.2
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 02:00:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87shgpi800.fsf@linaro.org>
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
	<87shgpi800.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Aug 2017 09:59:41 +0100
Message-ID: <CAFEAcA8S6S_T9d=QhncSb4or09HqRoZQNtxWDo3vj8OA9+pb-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1706296] Re: Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bug 1706296 <1706296@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On 18 August 2017 at 09:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
>
> John Arbuckle <programmingkidx@gmail.com> writes:
>
>> Using '-cpu 486' gets past the assertion error. I guess Windows NT 4.0
>> is not compatible with newer Intel processors.
>
> It might be related. The assertion error is caused by the fact an
> exception has occurred and processor is trying to dump a stack frame that
> overlaps from RAM into device memory. As the IRQ/exception handling is
> already under the BQL (as it changes machine state) we get the assertion
> when it tries to take the BQL a second time when accessing device
> memory.

This sounds worrying -- lots and lots of target backend code
does writes to memory. Is it all going to cause assertions if
it happens to be pointing at a device?

thanks
-- PMM
