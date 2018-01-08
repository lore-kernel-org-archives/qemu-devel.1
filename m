Received: from eggs.gnu.org ([2001:4830:134:3::10]:42463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eYTkL-0004yA-Vq
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eYTkH-00026B-Uc
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eYTkH-00025A-OT
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:29:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-22-git-send-email-mjc@sifive.com>
	<4e3bcfa2-c511-3ffb-44ab-be4567f2fb17@redhat.com>
	<CAHNT7Ntz2C84DYMf+BM8WZ7kwMTuZ3Q5D+VfUxG0O87H6j94XQ@mail.gmail.com>
	<108446a9-e18b-b81a-66a0-058793a32953@redhat.com>
Date: Mon, 08 Jan 2018 10:29:25 +0100
In-Reply-To: <108446a9-e18b-b81a-66a0-058793a32953@redhat.com> (Eric Blake's
	message of "Fri, 5 Jan 2018 08:49:09 -0600")
Message-ID: <87d12kaebu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

Eric Blake <eblake@redhat.com> writes:

> On 01/05/2018 12:47 AM, Michael Clark wrote:
>
>>>
>>>> +##
>>>> +{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
>>>
>>> Should this be 'uint64' or other specific type, rather than the generic
>>> 'int' (which happens to be 64 bits, but signed)?  Other architectures
>>> use 'int' because of history, but we could use this chance to improve
>>> things if desired.
>>>
>> 
>> I'll have to defer to your better judgement as to whether we need to change
>> this. I like consistency. Is it a change that needs to be made to multiple
>> arches? It sounds relatively low risk. You decide.
>> 
>> QAPI Schema
>> M: Eric Blake <eblake@redhat.com>
>> M: Markus Armbruster <armbru@redhat.com>
>
> I'm fine if this patch uses 'int' for consistency, and will wait for

Me too.

> Markus to chime in on whether changing CpuInfo to use specific integer
> types in general is worth a separate series later on.

I guess it is.
