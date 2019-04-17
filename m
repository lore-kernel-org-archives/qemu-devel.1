Received: from eggs.gnu.org ([209.51.188.92]:55034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGiOY-0003nF-Uy
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGiOW-0005jd-J6
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:06:26 -0400
References: <20190416185301.25344-1-david@redhat.com>
	<20190417095456.741383a7.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <44418310-c106-15cd-f4cd-11701f4aa47f@redhat.com>
Date: Wed, 17 Apr 2019 13:06:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190417095456.741383a7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/41] s390x/tcg: Vector Instruction
 Support Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 17.04.19 09:54, Cornelia Huck wrote:
> On Tue, 16 Apr 2019 20:52:20 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> This is the second part of vector instruction support for s390x. It is
>> based on the series soon to land upstream:
>>     [PATCH 0/9] tcg: Add tcg_gen_extract2_{i32,i64}
>>
>> Part 1: Vector Support Instructions
>> Part 2: Vector Integer Instructions
>> Part 3: Vector String Instructions
>> Part 4: Vector Floating-Point Instructions
>>
>> The current state can be found at (kept updated):
>>     https://github.com/davidhildenbrand/qemu/tree/vx
>>
>> With the current state I can boot Linux kernel + user space compiled with
>> SIMD support. This allows to boot distributions compiled exclusively for
>> z13, requiring SIMD support. Also, it is now possible to build a complete
>> kernel using rpmbuild as quite some issues have been sorted out.
>>
>> In this part, all Vector Integer Instructions introduced with the
>> "Vector Facility" are added. Some instructions part of the Vector Extension
>> Facilities are also added.
>>
>> v1 -> v2:
>> - Many suggestions and fixes as outlined by Richard H.
>> -- Mostly avoid oom helpers for 128-bit add/sub variants
>> -- New vector helpers are not considered for now
> 
> FWIW, I'd prefer a pull request for that over picking 41 patches :)
> (I'm unlikely to be able to provide more insightful review anyway ;)

Will do once the required patches are upstream and you rebased your
branch. Thanks!

-- 

Thanks,

David / dhildenb
