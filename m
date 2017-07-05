Received: from eggs.gnu.org ([2001:4830:134:3::10]:45814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dSkvI-0006sF-VP
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dSkvF-0000P5-0n
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:04:56 -0400
Received: from mail-eopbgr30094.outbound.protection.outlook.com
	([40.107.3.94]:30676
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1dSkvE-0000Nw-Hw
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:04:52 -0400
References: <20170615163813.7255-1-stefanha@redhat.com>
	<27a724bc-95c0-9d9f-ea90-015fcdf7dc92@virtuozzo.com>
	<20170705125517.GB1280@stefanha-x1.localdomain>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <193c7fd3-d9e1-8dd7-c15b-6fc46870f92f@virtuozzo.com>
Date: Wed, 5 Jul 2017 17:04:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170705125517.GB1280@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] qemu-iotests: test savevm/loadvm
 iothread (and make it work!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Roman Kagan <rkagan@virtuozzo.com>

On 05.07.2017 15:55, Stefan Hajnoczi wrote:
> On Mon, Jun 19, 2017 at 03:26:56PM +0300, Pavel Butsykin wrote:
>> On 15.06.2017 19:38, Stefan Hajnoczi wrote:
>>> This series extends qemu-iotests 068 to also run with iothread enabled.  Doing
>>> so was harder than expected because:
>>>
>>> 1. ioeventfd is disabled without -M accel=kvm even though it should work
>>> 2. loadvm still has an iothread bug
>>>
>>> Instead of adding a ./check -iothread option I decided to always run the test.
>>> Kevin recently recommended this approach; the advantage is that iothread *will*
>>> always be tested iothread mode whereas people won't run ./check -iothread.
>>
>> Why not just add -iothread option in check-block.sh? We can do an
>> additional run with -iothread, as it is done for different block
>> formats.
>>
>> Because all the test cases already exist, we can just reuse them.
> 
>  From the email:
> 
>    "the advantage is that iothread *will* always be tested iothread mode
>    whereas people won't run ./check -iothread"
> 
> Both approaches have pros and cons.

Yeah, it'd just be nice to add iothread support for all iotests.

> If we decide to use ./check -iothread then it's necessary to figure out
> which tests -iothread even applies to.  Tests that use qemu-img/qemu-io
> do not use iothread.  Only tests that launch QEMU can take advantage of
> iothread today.

Well, for tests which don't support the -iothread option we can define
something like this:

_unsupported_iothread

or

_unsupported_opts "iothread"

But overall it looks like a separate patch series, which can be done in
the future.

> Stefan
> 
