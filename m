Received: from eggs.gnu.org ([2001:4830:134:3::10]:57361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eg7Lm-0005Cg-Ms
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eg7Lj-0005Hx-Cq
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:11:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eg7Lj-0005GC-4H
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 06:11:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C69BC0568E3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 11:11:41 +0000 (UTC)
References: <1516958370-3955-1-git-send-email-thuth@redhat.com>
	<7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
	<64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77de61ce-ec1c-3f37-747b-7d0e1c61eb68@redhat.com>
Date: Mon, 29 Jan 2018 12:11:39 +0100
MIME-Version: 1.0
In-Reply-To: <64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add "Understanding QEMU devices"
 blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 26/01/2018 15:46, Eric Blake wrote:
> On 01/26/2018 06:40 AM, Paolo Bonzini wrote:
>> On 26/01/2018 10:19, Thomas Huth wrote:
>>> Last July, Eric Blake wrote a nice summary for newcomers about what
>>> QEMU has to do to emulate devices for the guests. So far, we missed
>>> to integrate this somewhere into the QEM web site or wiki, so let's
>>> publish this now as a nice blog post for the users.
>>
>> It's very nice!  Some proofreading and corrections follow.
> 
> Thanks for digging up my original email, and enhancing it (I guess the
> fact that I don't blog very often, and stick to email, means that I rely
> on others helping to polish my gems for the masses).
> 
>>> +++ b/_posts/2018-01-26-understanding-qemu-devices.md
>>> @@ -0,0 +1,139 @@
>>> +---
>>> +layout: post
>>> +title:  "Understanding QEMU devices"
>>> +date:   2018-01-26 10:00:00 +0100
> 
> That's when you're posting it online, but should it also mention when I
> first started these thoughts in email form?
> 
>>> +author: Eric Blake
>>> +categories: blog
>>> +---
>>> +Here are some notes that may help newcomers understand what is actually
>>> +happening with QEMU devices:
>>> +
>>> +With QEMU, one thing to remember is that we are trying to emulate what
>>> +an OS would see on bare-metal hardware.  All bare-metal machines are
>>
>> s/All/Most/ (s390 anyone? :))
> 
> Also, s/OS/Operating System (OS)/ to make the acronym easier to follow
> in the rest of the document.
> 
>>
>>> +basically giant memory maps, where software poking at a particular
>>> +address will have a particular side effect (the most common side effect
>>> +is, of course, accessing memory; but other common regions in memory
>>> +include the register banks for controlling particular pieces of
>>> +hardware, like the hard drive or a network card, or even the CPU
>>> +itself).  The end-goal of emulation is to allow a user-space program,
>>> +using only normal memory accesses, to manage all of the side-effects
>>> +that a guest OS is expecting.
>>> +
>>> +As an implementation detail, some hardware, like x86, actually has two
>>> +memory spaces, where I/O space uses different assembly codes than
>>> +normal; QEMU has to emulate these alternative accesses.  Similarly, many
>>> +modern hardware is so complex that the CPU itself provides both
>>> +specialized assembly instructions and a bank of registers within the
>>> +memory map (a classic example being the management of the MMU, or
>>> +separation between Ring 0 kernel code and Ring 3 userspace code - if
>>> +that's not crazy enough, there's nested virtualization).
>>
>> I'd say the interrupt controllers are a better example so:
>>
>> Similarly, many modern CPUs provide themselves a bank of CPU-local
>> registers within the memory map, such as for an interrupt controller.
> 
> Is it still worth a mention of nested virtualization?

No, nested virtualization is just two layers of doing the same thing. :)

Paolo
