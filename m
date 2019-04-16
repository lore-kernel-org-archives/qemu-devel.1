Received: from eggs.gnu.org ([209.51.188.92]:43322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK6t-0002y3-Vx
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK6t-0002vp-1E
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:10:35 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-16-david@redhat.com>
	<1365cc84-fdb6-3a36-9b5f-6921f04423e0@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <190241b2-efbe-c700-32dd-180ac0d25150@redhat.com>
Date: Tue, 16 Apr 2019 11:10:30 +0200
MIME-Version: 1.0
In-Reply-To: <1365cc84-fdb6-3a36-9b5f-6921f04423e0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 15/41] s390x/tcg: Implement VECTOR
 GALOIS FIELD MULTIPLY SUM (AND ACCUMULATE)
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

On 13.04.19 01:44, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> A galois field multiplication in field 2 is like binary multiplication,
>> however instead of doing ordinary binary additions, xor's are performed.
>> So no carries are considered.
>>
>> Implement all variants via helpers. s390_vec_sar() and s390_vec_shr()
>> will be reused later on.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h           |   8 ++
>>  target/s390x/insn-data.def      |   4 +
>>  target/s390x/translate_vx.inc.c |  38 ++++++++
>>  target/s390x/vec_int_helper.c   | 168 ++++++++++++++++++++++++++++++++
>>  4 files changed, 218 insertions(+)
> 
> FYI, this is now the 4th copy of this operation.
> 
>   arm: pmull
>   x86: pclmulqdq
>   ppc: vpmsum[bhwd]
> 
> We really should promote this to generic.  But that can come later,

huh, I tried my best to search for anything related to galois, but seems
like only s390x uses that terminology.  :) Well at least I learned how
it is supposed to be calculated.

Thanks!

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
