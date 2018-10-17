Received: from eggs.gnu.org ([2001:4830:134:3::10]:33540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gCnMw-0007Ej-1U
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gCnMs-0005yo-JD
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gCnMs-0005wM-8A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:04:14 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <1539795177-21038-2-git-send-email-peng.hao2@zte.com.cn>
References: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
	<1539795177-21038-2-git-send-email-peng.hao2@zte.com.cn>
Date: Wed, 17 Oct 2018 17:04:06 +0200
Message-ID: <87woqgr4wp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V6 1/5] target/i386 : add coalesced pio
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com

Peng Hao <peng.hao2@zte.com.cn> writes:

> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 83ba4eb..b5d4289 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -420,13 +420,19 @@ struct kvm_run {
>  struct kvm_coalesced_mmio_zone {
>  	__u64 addr;
>  	__u32 size;
> -	__u32 pad;
> +	union {
> +		__u32 pad;
> +		__u32 pio;
> +	};
>  };

I was just passing by, but what's the point in keeping 'pad'?

>  
>  struct kvm_coalesced_mmio {
>  	__u64 phys_addr;
>  	__u32 len;
> +	unino {

'union' I would guess? How does it compile?

>  	__u32 pad;
> +	__u32 pio;
> +	};
>  	__u8  data[8];
>  };
>  
> @@ -953,6 +959,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_NESTED_STATE 157
>  #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
>  #define KVM_CAP_MSR_PLATFORM_INFO 159
> +#define KVM_CAP_COALESCED_PIO 160
>  
>  #ifdef KVM_CAP_IRQ_ROUTING

-- 
Vitaly
