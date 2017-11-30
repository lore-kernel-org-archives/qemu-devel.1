Received: from eggs.gnu.org ([2001:4830:134:3::10]:52146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRCv-00043G-4v
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRCq-0004Vn-GI
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:57:01 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-3-david@redhat.com>
	<09ea70d8-4110-461a-fd9d-5e4220a5e7cb@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2e634659-9c04-cb2b-1fff-2255646f6fe2@redhat.com>
Date: Thu, 30 Nov 2017 16:56:47 +0100
MIME-Version: 1.0
In-Reply-To: <09ea70d8-4110-461a-fd9d-5e4220a5e7cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 for-2.12 02/16] s390x/tcg:
 get rid of runtime_exception()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 30.11.2017 10:10, Thomas Huth wrote:
> On 29.11.2017 21:26, David Hildenbrand wrote:
>> Let's use s390_program_interrupt() instead.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/fpu_helper.c  |  2 +-
>>  target/s390x/int_helper.c  | 14 +++++++-------
>>  target/s390x/internal.h    |  2 --
>>  target/s390x/misc_helper.c | 16 ----------------
>>  4 files changed, 8 insertions(+), 26 deletions(-)
> 
> Is it a disadvantage that runtime_exception() was declared as
> QEMU_NORETURN, and s390_program_interrupt() is not declared as
> QEMU_NORETURN?

We could add that to trigger_pgm_exception instead. But if
cpu_loop_exit() would really return, we would be in more trouble AKA
nothing would work.

So I don't see a problem dropping this.

> 
> At a first glance, I guess it's ok, and in that case:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


-- 

Thanks,

David / dhildenb
