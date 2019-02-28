Received: from eggs.gnu.org ([209.51.188.92]:44925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHzx-0002Jq-27
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHzu-0002dZ-1R
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:29:00 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-34-david@redhat.com>
	<9c8913f5-76b6-1175-5574-19f19d1e8eef@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c37a7e69-934c-ab2e-08a1-c67cb3e156c5@redhat.com>
Date: Thu, 28 Feb 2019 10:28:44 +0100
MIME-Version: 1.0
In-Reply-To: <9c8913f5-76b6-1175-5574-19f19d1e8eef@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 33/33] s390x/tcg: Implement VECTOR
 UNPACK *
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

On 28.02.19 01:03, Richard Henderson wrote:
> On 2/26/19 3:39 AM, David Hildenbrand wrote:
>> Combine all variant in a single handler. As source and destination
>> have different element sizes, we can't use gvec expansion. Expand
>> manually. Also watch out for overlapping source and destination and
>> use a temporary register in that case.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/insn-data.def      |  8 +++++++
>>  target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
>>  2 files changed, 49 insertions(+)
> 
> This works as is, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> But the same comment applies wrt iteration order and not needing a temporary.
> High unpack can iterate backward, while low unpack can iterate forward, with no
> lost data.

I'll fix that right away. I guess vector pack cannot be handled like this.

The only way to get rid of the temporary would be to load both elements
from v2 and v3 and then writing the two (half sized) elements in v1.

I'll have a look.

Thanks!

-- 

Thanks,

David / dhildenb
