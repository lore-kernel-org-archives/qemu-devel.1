Received: from eggs.gnu.org ([209.51.188.92]:42118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHlT-0005cv-Tf
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHlR-0005f0-VD
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:14:03 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-33-david@redhat.com>
	<27f4869b-5fb0-0b26-8980-5a5819386f43@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ba1e9659-6bec-9d70-14b0-0ad7880782ea@redhat.com>
Date: Thu, 28 Feb 2019 10:13:54 +0100
MIME-Version: 1.0
In-Reply-To: <27f4869b-5fb0-0b26-8980-5a5819386f43@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 32/33] s390x/tcg: Implement VECTOR STORE
 WITH LENGTH
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

On 28.02.19 00:49, Richard Henderson wrote:
> On 2/26/19 3:39 AM, David Hildenbrand wrote:
>> Very similar to VECTOR LOAD WITH LENGTH, just the opposite direction.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h           |  1 +
>>  target/s390x/insn-data.def      |  2 ++
>>  target/s390x/translate_vx.inc.c | 13 +++++++++++++
>>  target/s390x/vec_helper.c       | 15 +++++++++++++++
>>  4 files changed, 31 insertions(+)
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll also add a fast path for storing with lengths >= 16.

Thanks.

> r~
> 
> 


-- 

Thanks,

David / dhildenb
