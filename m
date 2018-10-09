Received: from eggs.gnu.org ([2001:4830:134:3::10]:51003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g9rtm-0001KT-GG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g9rti-00047s-Gt
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:18:06 -0400
Received: from mail-bgr052101135066.outbound.protection.outlook.com
	([52.101.135.66]:17328
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1g9rth-0003Xi-6J
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:18:01 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue, 9 Oct 2018 13:17:42 +0000
Message-ID: <20181009131738.GE29982@rkaganb.sw.ru>
References: <20181008112726.16140-1-vkuznets@redhat.com>
	<20181008112726.16140-2-vkuznets@redhat.com>
	<20181009122046.GC29982@rkaganb.sw.ru>
	<87va6bqnon.fsf@vitty.brq.redhat.com>
In-Reply-To: <87va6bqnon.fsf@vitty.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <514F3A6423AEB34FAEBB796F0CF4A498@eurprd08.prod.outlook.com>
MIME-Version: 1.0
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Tue, Oct 09, 2018 at 03:01:12PM +0200, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Mon, Oct 08, 2018 at 01:27:25PM +0200, Vitaly Kuznetsov wrote:
> >> This brings us three new defines: KVM_CAP_ARM_INJECT_SERROR_ESR,
> >> KVM_CAP_MSR_PLATFORM_INFO and KVM_CAP_HYPERV_SEND_IPI.
> >> 
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  linux-headers/linux/kvm.h | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> >> index 66790724f1..043f1e58b6 100644
> >> --- a/linux-headers/linux/kvm.h
> >> +++ b/linux-headers/linux/kvm.h
> >> @@ -9,7 +9,7 @@
> >>   */
> >>  
> >>  #include <linux/types.h>
> >> -
> >> +#include <linux/compiler.h>
> >>  #include <linux/ioctl.h>
> >>  #include <asm/kvm.h>
> >>  
> >> @@ -481,7 +481,7 @@ struct kvm_dirty_log {
> >>  	__u32 slot;
> >>  	__u32 padding1;
> >>  	union {
> >> -		void *dirty_bitmap; /* one bit per page */
> >> +		void __user *dirty_bitmap; /* one bit per page */
> >
> > Hmm, I thought "__user" and friends are supposed to get stripped while
> > "make headers_install".
> 
> ... and of course I forgot about this, will send v2, thanks!

Are you trying to say you didn't follow the regular linux header
harvesting process, which is to use scripts/update-linux-headers.sh
(which does 'make headers_install' and then applies further sanitizing,
so that problems like this wouldn't have popped up)?  I think you
should, unless this is an interim patchset pending the merge of the
corresponding KVM changes in the mainline kernel.

Roman.
