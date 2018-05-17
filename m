Received: from eggs.gnu.org ([2001:4830:134:3::10]:43581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJIr4-0000uY-9V
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJIqz-0001uq-H3
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:22:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fJIqz-0001ue-C0
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:21:57 -0400
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1526029534-35771-2-git-send-email-anton.nefedov@virtuozzo.com>
	<877eo6nm99.fsf@dusky.pond.sub.org>
	<1839ed60-ffd9-42c1-bf52-6d6121abb224@redhat.com>
	<87h8n9l7wq.fsf@dusky.pond.sub.org>
	<95ab24a5-d600-67b5-9c7e-e5290f42f520@redhat.com>
	<87a7t0u8az.fsf@dusky.pond.sub.org>
	<419b57a2-157e-b18c-944e-96ecdb391711@virtuozzo.com>
	<87fu2qogew.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5230c5b-0675-2611-d10f-51a05f730869@redhat.com>
Date: Thu, 17 May 2018 08:21:55 -0500
MIME-Version: 1.0
In-Reply-To: <87fu2qogew.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: allow flat unions with empty
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On 05/17/2018 03:05 AM, Markus Armbruster wrote:
>>>>>>> QAPI language design alternatives:
>>>>>>>
>>>>>>> 1. Having unions cover all discriminator values explicitly is useful.
>>>>
>>>>>>> 2. Having unions repeat all the discriminator values explicitly is not
>>>>>>> useful.  All we need is replacing the code enforcing that by code
>>>>>>> defaulting missing ones to the empty type.
>>>>>>>

>> I think I'd vote for 2 (never enforce all-branches coverage) as well.
> 
> Eric, what do you think?

I'm sold. Let's go ahead and make the change that for any flat union, a 
branch not listed defaults to the empty type (no added fields) rather 
than being an error, then simplify a couple of the existing flat unions 
that benefit from that.

> 
> One more thought: if we ever get around to provide more convenient flat
> union syntax so users don't have to enumerate the variant names twice,
> we'll need a way to say "empty branch".  Let's worry about that problem
> when we have it.

In other words, our current "simple" unions act in a manner that 
declares an implicit enum type - if we ever add an implicit enum to a 
flat union (where you don't have to declare a pre-existing enum type), 
then you need some syntax to declare additional acceptable enum values 
that form an empty branch.  Indeed, not a problem to be solved right now.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
