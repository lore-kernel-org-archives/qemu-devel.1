Received: from eggs.gnu.org ([2001:4830:134:3::10]:36990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJZ9L-00029C-6b
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJZ9H-00077L-65
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:45:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJZ9H-00076v-0h
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:45:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1526029534-35771-2-git-send-email-anton.nefedov@virtuozzo.com>
	<877eo6nm99.fsf@dusky.pond.sub.org>
	<1839ed60-ffd9-42c1-bf52-6d6121abb224@redhat.com>
	<87h8n9l7wq.fsf@dusky.pond.sub.org>
	<95ab24a5-d600-67b5-9c7e-e5290f42f520@redhat.com>
	<87a7t0u8az.fsf@dusky.pond.sub.org>
	<419b57a2-157e-b18c-944e-96ecdb391711@virtuozzo.com>
	<87fu2qogew.fsf@dusky.pond.sub.org>
	<e5230c5b-0675-2611-d10f-51a05f730869@redhat.com>
Date: Fri, 18 May 2018 08:45:53 +0200
In-Reply-To: <e5230c5b-0675-2611-d10f-51a05f730869@redhat.com> (Eric Blake's
	message of "Thu, 17 May 2018 08:21:55 -0500")
Message-ID: <878t8hihr2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 05/17/2018 03:05 AM, Markus Armbruster wrote:
>>>>>>>> QAPI language design alternatives:
>>>>>>>>
>>>>>>>> 1. Having unions cover all discriminator values explicitly is useful.
>>>>>
>>>>>>>> 2. Having unions repeat all the discriminator values explicitly is not
>>>>>>>> useful.  All we need is replacing the code enforcing that by code
>>>>>>>> defaulting missing ones to the empty type.
>>>>>>>>
>
>>> I think I'd vote for 2 (never enforce all-branches coverage) as well.
>>
>> Eric, what do you think?
>
> I'm sold. Let's go ahead and make the change that for any flat union,
> a branch not listed defaults to the empty type (no added fields)
> rather than being an error, then simplify a couple of the existing
> flat unions that benefit from that.

Anton, would you like to give this a try?

[...]
