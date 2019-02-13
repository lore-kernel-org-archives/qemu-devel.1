Received: from eggs.gnu.org ([209.51.188.92]:32946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gu0b2-0002XG-RK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gu0b0-0004Mb-C6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:53:28 -0500
References: <20190213143322.31371-1-david@redhat.com>
	<20190213143322.31371-13-david@redhat.com>
	<634cf76a-f1b9-138a-2ed4-e666c4be35f1@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <99906aad-e22a-8cc3-8c49-4e2a2ce3d0e9@redhat.com>
Date: Wed, 13 Feb 2019 20:53:16 +0100
MIME-Version: 1.0
In-Reply-To: <634cf76a-f1b9-138a-2ed4-e666c4be35f1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/15] s390x/tcg: Implement XxC and
 checks for most FP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

On 13.02.19 20:31, Richard Henderson wrote:
> On 2/13/19 6:33 AM, David Hildenbrand wrote:
>> With the floating-point extension facility
>> - CONVERT FROM LOGICAL
>> - CONVERT TO LOGICAL
>> - CONVERT TO FIXED
>> - CONVERT FROM FIXED
>> - LOAD FP INTEGER
>> have both, a rounding mode specification and the inexact-exception control
>> (XxC). Other instructions will be handled separatly.
>>
>> Check for valid rounding modes and forward also the XxC (via m4). To avoid
>> a lot of boilerplate code and changes to the helpers, combine both, the
>> m3 and m4 field in a combined 32 bit TCG variable. Perform checks at
>> a central place, taking in account if the m3 or m4 field was ignore
>> before the floating-point extension facility was introduced.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +static inline bool xxc_from_m34(uint32_t m34)
>> +{
>> +    /* XxC is bit 1 of m4 */
>> +    return (extract32(m34, 4, 4) & 0x4) != 0;
> 
> Better as extract32(m32, 6, 1);

Is it "better as" that or "better written as" that?

I think "extract32(m34, 4, 4) & 0x4" is slightly easier to understand.
(get m4 field and take the bit number 1)

Thanks!

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
