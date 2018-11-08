Received: from eggs.gnu.org ([2001:4830:134:3::10]:55942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKgkk-0005Y4-BY
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKgkg-00041Q-HE
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:37:27 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKgkf-00040s-Ti
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:37:26 -0500
Received: by mail-ot1-x342.google.com with SMTP id c32so17531706otb.8
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:37:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <35765094-e6ff-1542-6b37-27a0515f0b09@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
	<1539894735-14232-4-git-send-email-pbonzini@redhat.com>
	<01124fd1-83b2-c0c8-21d7-1f031a21ff3b@redhat.com>
	<329ff5d5-77a2-66ba-8930-cce79f4b8085@redhat.com>
	<35765094-e6ff-1542-6b37-27a0515f0b09@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 09:37:04 +0000
Message-ID: <CAFEAcA8z8eeH2F=UP_M8fNOsqhZ+qmL=xfm3Myb_GZ1-0X5e6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 03/48] qemu-timer: introduce timer attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

On 7 November 2018 at 20:21, Eric Blake <eblake@redhat.com> wrote:
> On 11/6/18 3:45 AM, Paolo Bonzini wrote:
>>
>> On 06/11/2018 00:16, Eric Blake wrote:
>>>
>>> On 10/18/18 3:31 PM, Paolo Bonzini wrote:
>>>>
>>>> From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
>>>>
>>>> Attributes are simple flags, associated with individual timers for their
>>>> whole lifetime.  They intended to be used to mark individual timers for
>>>> special handling when they fire.
>
>
>>> git bisect points to this patch as the reason that 'make check' is
>>> failing for me with:
>>
>>
>> I think you have a stale file somewhere, because "git grep timer_init_tl
>> 89a603a0c80ae3d6a8711571550b2ae9a01ea909" shows no occurrences.
>
>
> Indeed a stale file, as 'find -name "*.o' -delete' cleared up the issue -
> but it means we have a missing makefile dependency such that incremental
> builds weren't able to notice that a .o needed to be rebuilt to lose the
> stale reference.

Not clear where, though, because (at least in my build tree)
hw/core/ptimer.d says that hw/core/ptimer.o depends on
include/hw/ptimer.h, and tests/Makefile.inc says that
tests/ptimer-test depends on hw/core/ptimer.o...

thanks
-- PMM
