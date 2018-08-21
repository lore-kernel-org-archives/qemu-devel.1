Received: from eggs.gnu.org ([2001:4830:134:3::10]:39074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs6yd-0005uo-KB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs6ya-0000Ic-FY
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:45:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fs6ya-000090-48
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F57B87A82
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 13:45:32 +0000 (UTC)
References: <1534858452-37519-1-git-send-email-pbonzini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2e715fc1-755d-cea2-3cf1-7123d9cd5d04@redhat.com>
Date: Tue, 21 Aug 2018 15:45:31 +0200
MIME-Version: 1.0
In-Reply-To: <1534858452-37519-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] KVM: cleanup unnecessary #ifdef KVM_CAP_...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21.08.2018 15:34, Paolo Bonzini wrote:
> The capability macros are always defined, since they come from kernel
> headers that are copied into the QEMU tree.  Remove the unnecessary #ifdefs.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 2 --
>  target/i386/kvm.c   | 8 --------
>  2 files changed, 10 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 38f468d..de12f78 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1639,10 +1639,8 @@ static int kvm_init(MachineState *ms)
>          s->irq_set_ioctl = KVM_IRQ_LINE_STATUS;
>      }
>  
> -#ifdef KVM_CAP_READONLY_MEM
>      kvm_readonly_mem_allowed =
>          (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
> -#endif
>  
>      kvm_eventfds_allowed =
>          (kvm_check_extension(s, KVM_CAP_IOEVENTFD) > 0);
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9313602..0b2a07d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1381,17 +1381,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      int ret;
>      struct utsname utsname;
>  
> -#ifdef KVM_CAP_XSAVE
>      has_xsave = kvm_check_extension(s, KVM_CAP_XSAVE);
> -#endif
> -
> -#ifdef KVM_CAP_XCRS
>      has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
> -#endif
> -
> -#ifdef KVM_CAP_PIT_STATE2
>      has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
> -#endif
>  
>      hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
>  
> 

indeed,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
