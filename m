Received: from eggs.gnu.org ([209.51.188.92]:59701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkrl-0004na-KQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzkrl-000246-1p
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:18:29 -0500
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-4-david@redhat.com>
	<4f8ff92c-9770-b69a-0857-2b85a87090f1@linaro.org>
	<b44d3dde-fdc0-3ba5-051d-255723d9c71c@redhat.com>
	<89c00071-7a4d-a34a-50d0-f09de72fd139@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <03f12c9b-64cb-0add-a741-0b3506ad2304@redhat.com>
Date: Fri, 1 Mar 2019 17:18:25 +0100
MIME-Version: 1.0
In-Reply-To: <89c00071-7a4d-a34a-50d0-f09de72fd139@linaro.org>
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

On 01.03.19 17:16, Richard Henderson wrote:
> On 3/1/19 8:13 AM, David Hildenbrand wrote:
>>> These, I think, should be static inline.  Certainly I think they're too small
>>> to warrant a real call across modules, as you appear to be preparing for...
>>
>> I'm wondering, won't link-time optimization properly handle this? (so
>> far the theory I know of)
> 
> It would, but who does that?  It's certainly not in -O2.

I know that GCC and LLVM do it, but as you correctly state, most
probably not for O2.

-- 

Thanks,

David / dhildenb
