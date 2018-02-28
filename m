Received: from eggs.gnu.org ([2001:4830:134:3::10]:33346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1er5h5-000273-Qv
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1er5h2-0004Ws-Nr
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:39:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1er5h2-0004WS-Hv
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:39:04 -0500
Date: Wed, 28 Feb 2018 18:38:13 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20180228173813.GA8418@flask>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519439425-27883-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target/i386: Fix a minor typo found
 while reviwing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pixo@polepetko.eu, Gary.Hook@amd.com

2018-02-23 21:30-0500, Babu Moger:
> Changed KVM_CPUID_FLAG_SIGNIFCANT_INDEX to KVM_CPUID_FLAG_SIGNIFICANT_INDEX
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  linux-headers/asm-x86/kvm.h | 2 +-
>  target/i386/kvm.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index f3a9604..6aec661 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -220,7 +220,7 @@ struct kvm_cpuid_entry2 {
>  	__u32 padding[3];
>  };
>  
> -#define KVM_CPUID_FLAG_SIGNIFCANT_INDEX		(1 << 0)

The typo is in the original kernel header and we periodically copy it
over with scripts/update-linux-headers.sh, so this change would only add
overhead in the long run.

I'd keep the typo.

(The alternative is to add KVM_CPUID_FLAG_SIGNIFICANT_INDEX to the linux
 header, so there would be both variants and use the correct one here.)

Thanks.

> +#define KVM_CPUID_FLAG_SIGNIFICANT_INDEX	(1 << 0)
>  #define KVM_CPUID_FLAG_STATEFUL_FUNC		(1 << 1)
>  #define KVM_CPUID_FLAG_STATE_READ_NEXT		(1 << 2)
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ad4b159..85856b6 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -844,7 +844,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                      break;
>                  }
>                  c->function = i;
> -                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +                c->flags = KVM_CPUID_FLAG_SIGNIFICANT_INDEX;
>                  c->index = j;
>                  cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
>  
> -- 
> 1.8.3.1
> 
