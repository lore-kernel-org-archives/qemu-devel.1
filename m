Received: from eggs.gnu.org ([2001:4830:134:3::10]:43477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhfC-0000Fg-7w
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZhf7-0001Ui-Es
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dZhf7-0001US-8I
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:00:57 -0400
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-5-david@redhat.com>
	<f1c1a29b-c249-0cb1-98a4-78c91147c405@twiddle.net>
	<41378209-643c-b76a-4f7d-c3843f3fb95e@redhat.com>
	<2fea3168-1789-b22b-c3c5-f2be8512809e@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8dec30d6-9cca-4256-a45f-d7d4344f104f@redhat.com>
Date: Mon, 24 Jul 2017 20:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <2fea3168-1789-b22b-c3c5-f2be8512809e@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/6] target/s390x: move wrap_address to
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 24.07.2017 20:00, Richard Henderson wrote:
> On 07/24/2017 10:38 AM, David Hildenbrand wrote:
>> On 24.07.2017 06:40, Richard Henderson wrote:
>>> On 07/21/2017 05:56 AM, David Hildenbrand wrote:
>>>> Signed-off-by: David Hildenbrand<david@redhat.com>
>>>> ---
>>>>    target/s390x/cpu.h        | 14 ++++++++++++++
>>>>    target/s390x/mem_helper.c | 14 --------------
>>>>    2 files changed, 14 insertions(+), 14 deletions(-)
>>>
>>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>>
>>> Although another header, private to the helpers, might be better...
>>>
>>
>> Question is if we should have a new header for stuff really only used
>> locally in target/s390x - in contrast to say cpu.h, which is included
>> from various other places. So not only a header for helpers, but also
>> used for e.g. kvm.c.
>>
>> This header could e.g. be called cpu_helper.h and would not included in
>> cpu.h
> 
> C.f. target/arm/internals.h, which is a bit better as a name, I think.
> Perhaps something to wait for 2.11 tree though, and we'll do it proper.
> 
> 
> r~
> 

Sounds good to me.

-- 

Thanks,

David
