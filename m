Received: from eggs.gnu.org ([209.51.188.92]:37086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ24w-0006p2-8i
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ24p-0004fZ-93
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ24o-0004Wp-Tu
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:31:39 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<e2359b84-622b-d7ad-c9cf-92121934e123@redhat.com>
	<6206270f-2994-ae8d-db89-346a06a684f1@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3dcf1500-f684-0c83-f96c-2ebf2647c94b@redhat.com>
Date: Tue, 23 Apr 2019 22:31:26 +0200
MIME-Version: 1.0
In-Reply-To: <6206270f-2994-ae8d-db89-346a06a684f1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/38] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 23.04.19 22:26, Richard Henderson wrote:
> On 4/23/19 12:15 PM, David Hildenbrand wrote:
>> On 20.04.19 09:34, Richard Henderson wrote:
>>> Based-on: tcg-next, which at present is only tcg_gen_extract2.
>>>
>>> The dupm patches have been on list before, with a larger context
>>> of supporting tcg/ppc.  The rest of the set was written to support
>>> David's s390 vector patches.  In particular:
>>>
>>> (1) Add vector absolute value.
>>> (2) Add vector shift by non-constant scalar.
>>> (3) Add vector shift by vector.
>>> (4) Add vector select.
>>
>> Remind me, is this for VECTOR SELECT on s390x where we already added a
>> vector variant? At least VECTOR SELECT on s390x works on bit, not
>> element granularity.
> 
> 
> No, this was more for implementing _vec helpers, where we can
> reasonably use element granularity (since that's all x86 has).
> 
> I thought about adding a bitsel alongside cmpsel, to work on
> bits like this, but haven't yet.
> 

Makes sense, thanks!


-- 

Thanks,

David / dhildenb
