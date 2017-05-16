Received: from eggs.gnu.org ([2001:4830:134:3::10]:33867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAfZ0-0008EJ-Gi
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAfYx-0005ph-D0
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAfYx-0005pV-7D
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:43:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 124B68050D
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 16:43:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-3-quintela@redhat.com>
	<87shk4g9yb.fsf@dusky.pond.sub.org> <87o9usdg6e.fsf@secure.mitica>
	<87h90kbxmd.fsf@dusky.pond.sub.org>
	<09f00bd1-df05-c6b3-8423-cb790feddcc2@redhat.com>
Date: Tue, 16 May 2017 18:42:55 +0200
In-Reply-To: <09f00bd1-df05-c6b3-8423-cb790feddcc2@redhat.com> (Eric Blake's
	message of "Tue, 16 May 2017 11:08:35 -0500")
Message-ID: <87k25g92i8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 05/16/2017 11:00 AM, Markus Armbruster wrote:
>
>>>>>  #          periodic mode. (Since 2.8)
>>>>>  #
>>>>> +# @block-incremental: enable block incremental migration (Since 2.10)
>>>>> +#
>>>>
>>>> What's "block incremental migration" and why should I care?
>>>
>>> This is good, I will try.
>>>
>>> "block incremental migration assumes that we have a base image in both
>>> sides, and then we continue writting in one of the sides.  This way we
>>> need to only migrate the changes since the previous state where it was
>>> the same in both sides".
>>>
>>> I am not sure what to put there, really.
>> 
>> Well, to suggest something, I'd first have to figure out WTF incremental
>> block migration does.  Your text helps me some, but not enough.  What
>> exactly is being migrated, and what exactly is assumed to be shared
>> between source and destination?
>> 
>> Block migration is scandalously underdocumented.
>
> If I have:
>
> base <- active
>
> on the source, then:
>
> block migration without incremental creates:
>
> active
>
> on the destination (the entire disk contents are migrated).  Conversely,
> block migration WITH incremental assumes that I have pre-created 'base'
> on the destination (easy to do, since base is read-only so it can be
> copied prior to starting the migration), and the migration results in:
>
> base <- active
>
> on the destination, where only the contents of active were transferred
> by qemu.

Can you draft a documentation comment for @block-incremental?
