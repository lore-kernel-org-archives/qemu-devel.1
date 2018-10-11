Received: from eggs.gnu.org ([2001:4830:134:3::10]:60448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAW3D-0003tQ-KM
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAW3C-000725-QD
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:10:31 -0400
References: <20181003193931.18096-1-richard.henderson@linaro.org>
	<20181009185154.GA21860@flamenco>
From: David Hildenbrand <david@redhat.com>
Message-ID: <98581f37-2daf-ff8b-8a46-f90fd61209a9@redhat.com>
Date: Thu, 11 Oct 2018 10:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181009185154.GA21860@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 0/9] tcg: Reorg 128-bit
 atomic operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 09/10/2018 20:51, Emilio G. Cota wrote:
> On Wed, Oct 03, 2018 at 14:39:22 -0500, Richard Henderson wrote:
> (snip)
>> Richard Henderson (9):
>>   tcg: Split CONFIG_ATOMIC128
>>   target/i386: Convert to HAVE_CMPXCHG128
>>   target/arm: Convert to HAVE_CMPXCHG128
>>   target/arm: Check HAVE_CMPXCHG128 at translate time
>>   target/ppc: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
>>   target/s390x: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
>>   target/s390x: Split do_cdsg, do_lpq, do_stpq
>>   target/s390x: Skip wout, cout helpers if op helper does not return
>>   target/s390x: Check HAVE_ATOMIC128 and HAVE_CMPXCHG128 at translate
> 
> Cc'ing ppc/s390x maintainers -- I'm not sure they've seen this series.
> Link to this thread (v3):
>   https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00598.html
> 
> I'm eager to get this merged, particularly for i386 where it is
> fixing unnecessary exits via exec_atomic for cmpxchg16 emulation.
> 
> Thanks,
> 
> 		Emilio
> 

Thanks for the CC, I indeed haven't seen it.

-- 

Thanks,

David / dhildenb
