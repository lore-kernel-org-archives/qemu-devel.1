Received: from eggs.gnu.org ([2001:4830:134:3::10]:40567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgCWj-0002tS-Ej
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgCWf-0002Hg-DS
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dgCWf-0002HA-48
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:11:05 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-2-david@redhat.com>
	<c9bb3167-3de8-42a3-2815-0851b56f49a5@redhat.com>
	<79f9f850-f0dc-cea7-8a5c-85d23b07842b@redhat.com>
	<c5c6bbd0-e975-76f1-4d18-0618aeaffe60@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <125ba0f4-957a-ce49-8a53-bc4c277968dd@redhat.com>
Date: Fri, 11 Aug 2017 18:11:01 +0200
MIME-Version: 1.0
In-Reply-To: <c5c6bbd0-e975-76f1-4d18-0618aeaffe60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 16:39, Thomas Huth wrote:
> On 11.08.2017 16:21, David Hildenbrand wrote:
>> On 11.08.2017 16:00, Thomas Huth wrote:
>>> On 11.08.2017 09:46, David Hildenbrand wrote:
>>>> cpu.h should only contain what really has to be accessed outside of
>>>> target/s390x/. Add internal.h which can only be used inside target/s390x/.
>>>>
>>>> Move everything that isn't fast enough to run away and restructure it
>>>> right away.
>>>>
>>>> Minor style fixes to avoid checkpatch warning to:
>>>> - struct Lowcore: "{" goes into same line as typedef
>>>> - struct LowCore: add spaces around "-" in array length calculations
>>>> - time2tod() and tod2time(): move "{" to separate line
>>>> - get_per_atmid(): add space between ")" and "?". Move cases by one char.
>>>> - get_per_atmid(): drop extra paremthesis around (1 << 6)
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>> [...]
>>>> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
>>>> new file mode 100644
>>>> index 0000000..9a55271
>>>> --- /dev/null
>>>> +++ b/target/s390x/internal.h
>>>> @@ -0,0 +1,560 @@
>>>> +/*
>>>> + * s390x internal definitions and helpers
>>>> + *
>>>> + *  Copyright (c) 2009 Ulrich Hecht
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * Contributions after 2012-10-29 are licensed under the terms of the
>>>> + * GNU GPL, version 2 or (at your option) any later version.
>>>
>>> Slightly off-topic to your patch, but since you're at it anyway: AFAIK
>>> the above sentence effectively means that we should update the copyright
>>> boiler plate to GPL2+ nowadays. See
>>> https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html section 3.
>>
>> (not a license expert)
>>
>> Do you want me to replace it also in cpu.h?
> 
> No, at least not directly here in this patch series. I think that's
> something for a separate patch (we've got the same issue in cpu.c and
> kvm.c), so just use the correct boilerplate text in internal.h here.
> 

I'll use the following:

/*
 * s390x internal definitions and helpers
 *
 * Copyright (c) 2009 Ulrich Hecht
 *
 * This work is licensed under the terms of the GNU LGPL, version 2.1 or
later.
 * See the COPYING.LIB file in the top-level directory.
 */


-- 

Thanks,

David
