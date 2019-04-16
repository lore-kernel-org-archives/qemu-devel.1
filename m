Received: from eggs.gnu.org ([209.51.188.92]:47296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKN4-0003Qs-VN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKN4-00055q-1s
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:27:18 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-28-david@redhat.com>
	<0f53d073-92ba-87e3-2dd4-4e4629ead801@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0ab17af4-e96c-8550-9b93-3d1a6fb2a231@redhat.com>
Date: Tue, 16 Apr 2019 11:27:14 +0200
MIME-Version: 1.0
In-Reply-To: <0f53d073-92ba-87e3-2dd4-4e4629ead801@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 27/41] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE LEFT LOGICAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13.04.19 02:15, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +#define DEF_ROTL(BITS)                                                         \
>> +static uint##BITS##_t rotl##BITS(uint##BITS##_t a, uint8_t count)            \
>> +{                                                                            \
>> +    count &= BITS - 1;                                                       \
>> +    return (a << count) | (a >> (BITS - count));                             \
>> +}
>> +DEF_ROTL(8)
>> +DEF_ROTL(16)
> 
> We already have rol8 and rol16 in <qemu/bitops.h> for this.
> Otherwise,
> 

Thanks, missed these helpers!

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This does point out that I should go ahead and fill out the
> variable shift and rotate patterns in gvec...
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
