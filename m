Received: from eggs.gnu.org ([2001:4830:134:3::10]:42332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elMNO-0002J5-Hv
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elMNL-0003uh-ED
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:15:06 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:43967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1elMNL-0003tv-7D
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:15:03 -0500
Received: by mail-wr0-f178.google.com with SMTP id b52so16726332wrd.10
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 14:15:03 -0800 (PST)
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
	<CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
	<CAKmqyKNN_ysFP0pwDaccc1T+znoMfNtTXPzhLE-nsB7pCqmctg@mail.gmail.com>
	<4b726592-1078-1ac8-37b1-9227122d2429@redhat.com>
	<ac7cca9f-24f7-6b04-acbd-e63c99df9136@virtuozzo.com>
	<8ad4b5f9-eced-3a3f-64b3-494624e3c369@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <544f32aa-fac2-3b4c-d5c3-95e69296f272@redhat.com>
Date: Mon, 12 Feb 2018 23:14:58 +0100
MIME-Version: 1.0
In-Reply-To: <8ad4b5f9-eced-3a3f-64b3-494624e3c369@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] "make check -j4" hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, klim <klim.kireev@virtuozzo.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>

On 12/02/2018 20:30, Thomas Huth wrote:
> On 12.02.2018 15:42, klim wrote:
> [...]
>> I just have reverted my 2 commits and
>>
>> after that make check -j32 hangs
>>
>> with
>>
>> GTester: last random seed: R02Sb95a3bf6ab4c05540cec188081a7cc2a
>>
>> in vhost-user-test
>>
>> so it is not my fault
> 
> You're right. I've bisected the issue again, and this time I've applied
> 8f6d701044b ("tests/test-filter-redirector: move close()") on top of
> each step if necessary, and indeed, the "vhost-user-test" problem has
> nothing to do with your patches, Klim, but with the one from Marc-André.
> According to git bisect, this is the commit that introduced the problem:
> 
> 	commit 7e49f5e8e508ed020c96798b3f7083e24e0e425b
> 	tests: use memfd in vhost-user-test
> 
> Peter, since this is quite annoying if "make check" is not working
> reliably, could you please revert that commit until a proper solution is
> found?

I was about to send one when Klim answered.  I'll send it tomorrow, with
Marc-André's patch reverted.

Paolo
