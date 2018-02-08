Received: from eggs.gnu.org ([2001:4830:134:3::10]:42531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eju9S-0005fr-2T
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eju9R-0001yk-AM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:54:42 -0500
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:37034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eju9R-0001yQ-2F
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 16:54:41 -0500
Received: by mail-lf0-x22e.google.com with SMTP id f137so8495328lfe.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 13:54:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
	<CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Feb 2018 13:54:08 -0800
Message-ID: <CAKmqyKNN_ysFP0pwDaccc1T+znoMfNtTXPzhLE-nsB7pCqmctg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] "make check -j4" hangs (was: Re:
 chardev/char-socket: add POLLHUP handler)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Klim Kireev <klim.kireev@virtuozzo.com>

On Thu, Feb 8, 2018 at 1:12 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 8 February 2018 at 19:13, Thomas Huth <thuth@redhat.com> wrote:
>> I'm currently facing some issues with "make check -j4" (i.e. running the
>> tests in parallel). Git bisect blames this commit - though I'm not sure
>> whether this is really the right one ... Starting with this commit, I
>> saw hangs in test-filter-redirector, but git master rather seems to hang
>> with vhost-user-test instead.
>> Stefan also had issues with "make check -j4" today, so it's apparently
>> not only me ... can somebody else reproduce the problem with the git
>> master branch?
>
> Yeah, I was seeing odd make check hangs with parallelization enabled
> too, on vhost-user-test... (my builds for merge tests are almost
> all non-parallelized I think).

I don't only see hangs I also am seeing this:

qemu-system-i386: -chardev
socket,id=chr-test,path=/tmp/vhost-test-wxuOIX/test.sock: Failed to
connect socket /tmp/vhost-test-wxuOIX/test.sock: No such file or
directory
socket_accept failed: Resource temporarily unavailable
**
ERROR:tests/libqtest.c:218:qtest_init_without_qmp_handshake: assertion
failed: (s->fd >= 0 && s->qmp_fd >= 0)
GTester: last random seed: R02Sa67ba85090274c01deb9c2d15b044c10

It isn't 100% reproducible though.

Alistair

>
> thanks
> -- PMM
>
