Received: from eggs.gnu.org ([209.51.188.92]:45566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqiFk-0005mH-At
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqiFj-0002JN-9z
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:41:52 -0500
References: <20190204154406.16122-1-david@redhat.com>
	<b477cf45-50d2-049d-0f80-befa70e74ffd@redhat.com>
	<20190204183756.5bbf0782.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1affa165-8432-2923-ec5e-900986885c53@redhat.com>
Date: Mon, 4 Feb 2019 18:41:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190204183756.5bbf0782.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/tcg: Don't model FP registers as
 globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

>>> Reading/writing a floating point register means reading/writing memory now.
>>>
>>> Break up ugly in2_x2() handling that modifies both, in1 and in2 into
>>> in1_x2l and in2_x2h. This makes things more readable. Also, in1_x1() is  
>>
>> s/in1_x2l/in2_x2l/
>> s/in1_x2h/in2_x2h/
> 
> Confused... it's already in2_x2h, I suppose that one should stay like
> it is?

Yes, I guess I am the confused one ;)

> 
>>
>>
>> Sorry Conny, I assume when you pick this up, you can fix this up :)
> 
> I would recommend a spell checker, only it would not help for the last
> case :)

I once tried to add a pre-commit hook  for that, but it didn't work that
reliably. And if it's not automated, I guess I will forget it again.

... as long as the code is not in a similar shape, we're fine ;)

-- 

Thanks,

David / dhildenb
