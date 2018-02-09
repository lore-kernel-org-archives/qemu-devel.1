Received: from eggs.gnu.org ([2001:4830:134:3::10]:51314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek7H2-0000sn-CG
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek7Gx-0000yH-HU
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:55:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ek7Gx-0000xw-AL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:55:19 -0500
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
	<CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
	<CAKmqyKNN_ysFP0pwDaccc1T+znoMfNtTXPzhLE-nsB7pCqmctg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b726592-1078-1ac8-37b1-9227122d2429@redhat.com>
Date: Fri, 9 Feb 2018 12:55:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNN_ysFP0pwDaccc1T+znoMfNtTXPzhLE-nsB7pCqmctg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] "make check -j4" hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Klim Kireev <klim.kireev@virtuozzo.com>

On 08/02/2018 22:54, Alistair Francis wrote:
> On Thu, Feb 8, 2018 at 1:12 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 8 February 2018 at 19:13, Thomas Huth <thuth@redhat.com> wrote:
>>> I'm currently facing some issues with "make check -j4" (i.e. running the
>>> tests in parallel). Git bisect blames this commit - though I'm not sure
>>> whether this is really the right one ... Starting with this commit, I
>>> saw hangs in test-filter-redirector, but git master rather seems to hang
>>> with vhost-user-test instead.
>>> Stefan also had issues with "make check -j4" today, so it's apparently
>>> not only me ... can somebody else reproduce the problem with the git
>>> master branch?
>>
>> Yeah, I was seeing odd make check hangs with parallelization enabled
>> too, on vhost-user-test... (my builds for merge tests are almost
>> all non-parallelized I think).
> 
> I don't only see hangs I also am seeing this:
> 
> qemu-system-i386: -chardev
> socket,id=chr-test,path=/tmp/vhost-test-wxuOIX/test.sock: Failed to
> connect socket /tmp/vhost-test-wxuOIX/test.sock: No such file or
> directory
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:tests/libqtest.c:218:qtest_init_without_qmp_handshake: assertion
> failed: (s->fd >= 0 && s->qmp_fd >= 0)
> GTester: last random seed: R02Sa67ba85090274c01deb9c2d15b044c10
> 
> It isn't 100% reproducible though.

It may be something like commit 8f6d701044bc87197aac8aa2a627d70ce8471726.

In the meanwhile we should revert it.

Paolo
