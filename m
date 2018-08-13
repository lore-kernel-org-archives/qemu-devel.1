Received: from eggs.gnu.org ([2001:4830:134:3::10]:46022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpEDU-0003JA-Af
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpEDP-0003i6-IF
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:53:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpEDP-0003hs-C2
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:53:03 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-12-armbru@redhat.com>
	<26ff5c67-abfa-bc5d-7c26-3f08ffbdc57b@redhat.com>
	<87k1oyl2y4.fsf@dusky.pond.sub.org>
	<faf9bd30-5d2a-a68f-e6b4-c9dc8c369466@redhat.com>
	<87ftzidcef.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3606e6f-6880-0647-f6f0-284142e06ab8@redhat.com>
Date: Mon, 13 Aug 2018 09:53:00 -0500
MIME-Version: 1.0
In-Reply-To: <87ftzidcef.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/56] check-qjson: Cover UTF-8 in single
 quoted strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On 08/13/2018 01:11 AM, Markus Armbruster wrote:

>>>> Technically, Unicode ends at U+10FFFF (21 bits). Anything beyond that
>>>> is not valid Unicode, even if it IS a valid interpretation of UTF-8
>>>> encoding.
>>>
>>> Correct.  Testing how we handle such sequences makes sense all the same.
>>>
>>>>>             {
>>>>> -            "\"\xF7\xBF\xBF\xBF\"",
>>>>> +            "\xF7\xBF\xBF\xBF",
>>>>>                 NULL,               /* bug: rejected */
>>
>> So, maybe all the more we need to do is remove the comment (as we WANT
>> to reject these)?
> 
> Is PATCH 20 doing what you suggest?

Yes, I think you get there in the end, it was more a question of churn 
in the meantime.

> 
>>>>
>>>> The conversion of the initializer looks sane (well, mechanical).  Ergo:
>>>>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>> Thanks!
>>
>> Of course, playing games with the pre-existing comments on
>> out-of-range behavior is probably better for a separate patch, and you
>> do have some churn on these tests in later patches. I'll leave it up
>> to you what to do (or leave put).
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
