Received: from eggs.gnu.org ([2001:4830:134:3::10]:55060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eGi2p-0001WG-8K
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eGi2l-00087H-7c
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:07:11 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:39817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eGi2l-00086T-3e
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:07:07 -0500
Received: by mail-ua0-f181.google.com with SMTP id 31so267485uaj.6
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 01:07:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1f8754babd990beb90c516d2973b21d3@hostfission.com>
References: <20171115073144.14758-1-lprosek@redhat.com>
	<1f8754babd990beb90c516d2973b21d3@hostfission.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 20 Nov 2017 10:07:03 +0100
Message-ID: <CABdb7363ki8=BroGTP6Z+Shc+WLn3kJjM2e5y3N=R7vL=y4rKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] ivshmem: MSI bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geoffrey McRae <geoff@hostfission.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Sun, Nov 19, 2017 at 9:39 PM,  <geoff@hostfission.com> wrote:
> I just updated to the latest build and applied this patch set, now on VM
> reset the qemu crashes with the following assert:
>
> ivshmem.c:467: ivshmem_add_kvm_msi_virq: Assertion
> `!s->msi_vectors[vector].pdev' failed.

I see asserts too. Even with v1 on top of QEMU v2.10.0 so I must have
missed something.

Looking. And, needless to say, these patches should not be applied just yet :)

Thanks!
Ladi

> On 2017-11-15 18:31, Ladi Prosek wrote:
>>
>> Fixes bugs in the ivshmem device implementation uncovered with the new
>> Windows ivshmem driver:
>>
>> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem
>>
>> v1->v2:
>> * Patch 1 - added reproducer info to commit message (Markus)
>> * Patch 2 - restructured conditionals, fixed comment formatting (Markus)
>> * Patch 3 - added reproducer info to commit message (Markus)
>>
>> Ladi Prosek (3):
>>   ivshmem: Don't update non-existent MSI routes
>>   ivshmem: Always remove irqfd notifiers
>>   ivshmem: Improve MSI irqfd error handling
>>
>>  hw/misc/ivshmem.c | 77
>> +++++++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 58 insertions(+), 19 deletions(-)
>
>
