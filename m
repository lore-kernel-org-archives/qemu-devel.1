Received: from eggs.gnu.org ([209.51.188.92]:59269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkqC-0003co-1r
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkqB-0000je-87
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:52 -0500
From: David Hildenbrand <david@redhat.com>
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-4-david@redhat.com>
	<4f8ff92c-9770-b69a-0857-2b85a87090f1@linaro.org>
	<b44d3dde-fdc0-3ba5-051d-255723d9c71c@redhat.com>
Message-ID: <e4edc49b-4024-fffa-72fa-2d599d1bc611@redhat.com>
Date: Fri, 1 Mar 2019 17:16:46 +0100
MIME-Version: 1.0
In-Reply-To: <b44d3dde-fdc0-3ba5-051d-255723d9c71c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/32] s390x/tcg: Utilities for vector
 instruction helpers
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

On 01.03.19 17:13, David Hildenbrand wrote:
> On 01.03.19 17:09, Richard Henderson wrote:
>> On 3/1/19 3:53 AM, David Hildenbrand wrote:
>>> +#ifndef S390X_VEC_H
>>> +#define S390X_VEC_H
>>> +
>>> +typedef union S390Vector {
>>> +    uint64_t doubleword[2];
>>> +    uint32_t word[4];
>>> +    uint16_t halfword[8];
>>> +    uint8_t byte[16];
>>> +} S390Vector;
>>> +
>>> +uint8_t s390_vec_read_element8(const S390Vector *v, uint8_t enr);
>>> +uint16_t s390_vec_read_element16(const S390Vector *v, uint8_t enr);
>>> +uint32_t s390_vec_read_element32(const S390Vector *v, uint8_t enr);
>>> +uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr);
>>> +void s390_vec_write_element8(S390Vector *v, uint8_t enr, uint8_t data);
>>> +void s390_vec_write_element16(S390Vector *v, uint8_t enr, uint16_t data);
>>> +void s390_vec_write_element32(S390Vector *v, uint8_t enr, uint32_t data);
>>> +void s390_vec_write_element64(S390Vector *v, uint8_t enr, uint64_t data);
>>> +
>>
>> These, I think, should be static inline.  Certainly I think they're too small
>> to warrant a real call across modules, as you appear to be preparing for...
> 
> I'm wondering, won't link-time optimization properly handle this? (so
> far the theory I know of)
> 
> But I can move these completely into the head.

Just checked the binary, definetly not optimized during link time. Will
make them static inline. Thanks!

-- 

Thanks,

David / dhildenb
