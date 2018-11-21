Received: from eggs.gnu.org ([2001:4830:134:3::10]:37996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWFX-0003Dq-PU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWFU-0004Rf-5L
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:25:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPWFT-0004PX-UA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:25:12 -0500
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-3-david@redhat.com>
	<7d8d4e4f-bb70-5047-4e37-ed3672c89e02@redhat.com>
	<87va4r7aou.fsf@dusky.pond.sub.org>
	<64d0f403-2dd3-2841-b346-7634f37cf5b8@redhat.com>
	<8dc6889b-eed7-34f2-8bef-c03b11dc435a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84a4efa6-05c6-d6dd-fb26-0833085ace2d@redhat.com>
Date: Wed, 21 Nov 2018 11:25:04 -0600
MIME-Version: 1.0
In-Reply-To: <8dc6889b-eed7-34f2-8bef-c03b11dc435a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/9] cutils: Fix qemu_strtosz() &
 friends to reject non-finite sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 11/21/18 4:44 AM, David Hildenbrand wrote:

>>>>> @@ -206,20 +206,18 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>>>>>      * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
>>>>
>>>> Pre-existing, but since you're touching this area: the second 'Return'
>>>> is unusual capitalization for being mid-sentence.  You could even
>>>> s/Return/of/
>>>
>>> "of"?
>>
>> "or" (ouch - wrong time for my fingers to be slipping on the keyboard)
> 
> Shouldn't that be "and" and s/Return/Returns/
> 
> 
> "Returns -ERANGE on overflow and -EINVAL on other errors".
> 
> I can include that fixup (whetever version you guys prefer)

I was thinking:

Return -ERANGE on overflow, or -EINVAL on other errors.

'Return', not 'Returns', because of imperative mood.  The choice of 
'and' vs. 'or' is less of a sticking point; both sound fine to my native 
ear, especially since the word 'other' makes it apparent that you won't 
have both overflow and a conversion error at the same time (my initial 
choice of 'or' rather than 'and' was solely because you can't have two 
return values at once; but using 'and' seems okay at implying a sense of 
prioritization where overflow trumps other detected errors).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
