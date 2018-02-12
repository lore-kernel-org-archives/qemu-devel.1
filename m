Received: from eggs.gnu.org ([2001:4830:134:3::10]:38437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1elFJk-0000sA-Gi
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1elFJh-0007X7-5Z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:42:52 -0500
Received: from mail-he1eur01on0127.outbound.protection.outlook.com
	([104.47.0.127]:14408
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1elFJg-0007Va-97
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:42:49 -0500
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
	<CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
	<CAKmqyKNN_ysFP0pwDaccc1T+znoMfNtTXPzhLE-nsB7pCqmctg@mail.gmail.com>
	<4b726592-1078-1ac8-37b1-9227122d2429@redhat.com>
From: klim <klim.kireev@virtuozzo.com>
Message-ID: <ac7cca9f-24f7-6b04-acbd-e63c99df9136@virtuozzo.com>
Date: Mon, 12 Feb 2018 17:42:41 +0300
MIME-Version: 1.0
In-Reply-To: <4b726592-1078-1ac8-37b1-9227122d2429@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] "make check -j4" hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>

On 02/09/2018 02:55 PM, Paolo Bonzini wrote:
> On 08/02/2018 22:54, Alistair Francis wrote:
>> On Thu, Feb 8, 2018 at 1:12 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 8 February 2018 at 19:13, Thomas Huth <thuth@redhat.com> wrote:
>>>> I'm currently facing some issues with "make check -j4" (i.e. running the
>>>> tests in parallel). Git bisect blames this commit - though I'm not sure
>>>> whether this is really the right one ... Starting with this commit, I
>>>> saw hangs in test-filter-redirector, but git master rather seems to hang
>>>> with vhost-user-test instead.
>>>> Stefan also had issues with "make check -j4" today, so it's apparently
>>>> not only me ... can somebody else reproduce the problem with the git
>>>> master branch?
>>> Yeah, I was seeing odd make check hangs with parallelization enabled
>>> too, on vhost-user-test... (my builds for merge tests are almost
>>> all non-parallelized I think).
>> I don't only see hangs I also am seeing this:
>>
>> qemu-system-i386: -chardev
>> socket,id=chr-test,path=/tmp/vhost-test-wxuOIX/test.sock: Failed to
>> connect socket /tmp/vhost-test-wxuOIX/test.sock: No such file or
>> directory
>> socket_accept failed: Resource temporarily unavailable
>> **
>> ERROR:tests/libqtest.c:218:qtest_init_without_qmp_handshake: assertion
>> failed: (s->fd >= 0 && s->qmp_fd >= 0)
>> GTester: last random seed: R02Sa67ba85090274c01deb9c2d15b044c10
>>
>> It isn't 100% reproducible though.
> It may be something like commit 8f6d701044bc87197aac8aa2a627d70ce8471726.
>
> In the meanwhile we should revert it.
>
> Paolo

I just have reverted my 2 commits and

after that make check -j32 hangs

with

GTester: last random seed: R02Sb95a3bf6ab4c05540cec188081a7cc2a

in vhost-user-test

so it is not my fault
