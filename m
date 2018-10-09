Received: from eggs.gnu.org ([2001:4830:134:3::10]:45620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9rdm-0004z5-4o
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9rdg-0001My-Hn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:01:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1g9rde-0001Bd-4N
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:01:27 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20181009122046.GC29982@rkaganb.sw.ru>
References: <20181008112726.16140-1-vkuznets@redhat.com>
	<20181008112726.16140-2-vkuznets@redhat.com>
	<20181009122046.GC29982@rkaganb.sw.ru>
Date: Tue, 09 Oct 2018 15:01:12 +0200
Message-ID: <87va6bqnon.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-headers: update to pre-4.20
 (kvm/queue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Mon, Oct 08, 2018 at 01:27:25PM +0200, Vitaly Kuznetsov wrote:
>> This brings us three new defines: KVM_CAP_ARM_INJECT_SERROR_ESR,
>> KVM_CAP_MSR_PLATFORM_INFO and KVM_CAP_HYPERV_SEND_IPI.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  linux-headers/linux/kvm.h | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index 66790724f1..043f1e58b6 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -9,7 +9,7 @@
>>   */
>>  
>>  #include <linux/types.h>
>> -
>> +#include <linux/compiler.h>
>>  #include <linux/ioctl.h>
>>  #include <asm/kvm.h>
>>  
>> @@ -481,7 +481,7 @@ struct kvm_dirty_log {
>>  	__u32 slot;
>>  	__u32 padding1;
>>  	union {
>> -		void *dirty_bitmap; /* one bit per page */
>> +		void __user *dirty_bitmap; /* one bit per page */
>
> Hmm, I thought "__user" and friends are supposed to get stripped while
> "make headers_install".

... and of course I forgot about this, will send v2, thanks!

>  Does it build like this?

depends on what you've done to your build system)

-- 
Vitaly
