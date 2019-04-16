Received: from eggs.gnu.org ([209.51.188.92]:38354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJjZ-0008Pj-Eg
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJjY-0005Ed-Ix
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:46:29 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-4-david@redhat.com>
	<50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
	<0fdae81c-eecb-90cd-26f8-b52964d375a3@redhat.com>
	<b0567193-e353-d391-b438-e5b580d699a4@linaro.org>
	<0d400fda-85a7-6c5d-a693-1d0bfec63ce3@redhat.com>
	<9f632efd-37b9-5aaf-fe81-7c332ad51d7a@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3f8eb0e0-be2a-d67f-7b3a-9fec65fc52da@redhat.com>
Date: Tue, 16 Apr 2019 10:46:25 +0200
MIME-Version: 1.0
In-Reply-To: <9f632efd-37b9-5aaf-fe81-7c332ad51d7a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 16.04.19 10:43, Richard Henderson wrote:
> On 4/15/19 10:33 PM, David Hildenbrand wrote:
>>>>
>>>> Indeed, I didn't really explore vector operations yet. This is more
>>>> compact than I expected :)
>>>
>>> :-)
>>>
>>> That said, in implementing vector variable shifts today,
>>> I've come up with a representational problem here.
>>> You may want to hold off on these until I can address them.
>>
>> I assume you mean vector helpers *in general* in this file. Yes, we can
>> add them later.
>>
>> What exact problem are you dealing with?
> 
> The .opc field lets you only specify one opcode which is optional in the
> backend on which you depend.  In writing support for AArch64 USHL, I find that
> I needed 3 optional opcodes.

I was asking myself this exact thing when looking at the opc field in
the example you gave ("which instruction is one supposed to indicate
here") :)

> 
> I'm thinking of a mass change whereby .opc becomes a pointer to an array with
> terminator.  But then, for debugging purposes, I think I need to validate that
> array, so that it's not missing things that ought to be specified, but which
> happen to be supported by the current host.

Makes sense!

-- 

Thanks,

David / dhildenb
