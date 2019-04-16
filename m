Received: from eggs.gnu.org ([209.51.188.92]:45016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKCx-00070B-JS
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGKCw-00066G-7b
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:16:51 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-18-david@redhat.com>
	<baebe333-5e28-9fd3-adef-7027c166a599@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2b89fec6-a270-f6f5-5ff8-1f40f0b9a7a5@redhat.com>
Date: Tue, 16 Apr 2019 11:16:43 +0200
MIME-Version: 1.0
In-Reply-To: <baebe333-5e28-9fd3-adef-7027c166a599@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 17/41] s390x/tcg: Implement VECTOR LOAD
 POSITIVE
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

On 13.04.19 01:50, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> Similar to VECTOR LOAD COMPLEMENT but unfortunately we don't have a
>> gvec helper.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h           |  2 ++
>>  target/s390x/insn-data.def      |  2 ++
>>  target/s390x/translate_vx.inc.c | 40 +++++++++++++++++++++++++++++++++
>>  target/s390x/vec_int_helper.c   | 14 ++++++++++++
>>  4 files changed, 58 insertions(+)
> 
> I would be happy to add ABS as a gvec primitive, if you like.
> Expandable with MAX or CMP on hosts without ABS.

Sure, that would be great. Once you have that one implemented we can
throw most of this stuff away (either before or after merging). Thanks!

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
