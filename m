Received: from eggs.gnu.org ([2001:4830:134:3::10]:54720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp65l-0001p4-GC
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp65i-0006Zf-Ar
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:12:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fp65i-0006ZX-4f
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:12:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-19-armbru@redhat.com>
	<d2dd81e0-c8d0-a934-d750-c8b97e8010cf@redhat.com>
	<877ekyl2df.fsf@dusky.pond.sub.org>
	<adc532d8-1bba-a925-6025-b74c2c0cf0f2@redhat.com>
Date: Mon, 13 Aug 2018 08:12:30 +0200
In-Reply-To: <adc532d8-1bba-a925-6025-b74c2c0cf0f2@redhat.com> (Eric Blake's
	message of "Fri, 10 Aug 2018 10:02:54 -0500")
Message-ID: <87bma6dcc1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 18/56] json: Revamp lexer documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2018 09:31 AM, Markus Armbruster wrote:
>
>>>> + *
>>>> + * [Numbers:]
>>>
>>> Worth also calling out:
>>>
>>> [Objects:]
>>>        object = begin-object [ member *( value-separator member ) ]
>>>                 end-object
>>>
>>>        member = string name-separator value
>>> [Arrays:]
>>>     array = begin-array [ value *( value-separator value ) ] end-array
>>>
>>> so as to completely cover the RFC grammar?
>>
>> Should this go into json-parser.c?
>
> Perhaps. After all, the lexer does nothing special for any of those
> constructs; they are where we really have moved into the parser phase.
>
>
>>>> + * - Interpolation:
>>>> + *   interpolation = %((l|ll|I64)[du]|[ipsf])
>>>
>>> Not in your series, but we recently discussed adding %% (only inside
>>> strings); coupled with enforcing that all other interpolation occurs
>>> outside of strings.  I guess we can update this comment at that time.
>>
>> Message-ID: <87bmaoszf0.fsf@dusky.pond.sub.org>
>> https://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg05844.html
>>
>> I meant to do that in this series, but got overwhelmed by all the other
>> stuff, and forgot.  Thanks for the reminder.  I may still do it in v2.
>> If not, we can do it on top.
>
> Here's where I first attempted it, if it helps.
>
> https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg00603.html

Thanks.  I'll see what I can steal from it.
