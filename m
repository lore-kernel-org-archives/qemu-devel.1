Received: from eggs.gnu.org ([2001:4830:134:3::10]:34414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKR4x-0005xy-PD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKR4u-000271-19
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:53:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gKR4t-00022o-Pw
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 11:53:15 -0500
References: <20181030191620.32168-1-armbru@redhat.com>
	<CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	<87sh0eyzb0.fsf@dusky.pond.sub.org> <20181107025628.GB17134@xz-x1>
	<CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92c2ae1e-a081-4cce-53c5-d8fd3222d3c1@redhat.com>
Date: Wed, 7 Nov 2018 10:53:08 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11/7/18 5:21 AM, Peter Maydell wrote:
> On 7 November 2018 at 02:56, Peter Xu <peterx@redhat.com> wrote:
>> Strange, "make check -j8" failed on my hosts (I tried two) with either
>> Markus's pull tree or qemu master:
>>
>> hw/core/ptimer.o: In function `timer_new_tl':
>> /home/xz/git/qemu/include/qemu/timer.h:536: undefined reference to `timer_init_tl'
>> collect2: error: ld returned 1 exit status
>> make: *** [/home/xz/git/qemu/rules.mak:124: tests/ptimer-test] Error 1
>>
>> Is that only happening on my hosts?
> 
> Commit 89a603a0c80ae3 changed things so that there is no
> timer_new_tl() or timer_init_tl() any more, so if you have
> an object file that's referring to it then it's probably
> stale. Try a make clean.

I ran into it as well:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00876.html

Wonder what makefile dependency we are missing that is resulting in 
stale .o files being picked up?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
