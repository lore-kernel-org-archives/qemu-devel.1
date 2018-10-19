Received: from eggs.gnu.org ([2001:4830:134:3::10]:39708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1gDQSY-0001au-1Q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1gDQSX-0006HZ-4X
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:48:41 -0400
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-3-eric.auger@redhat.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <872eeab2-7f0d-6cba-fd05-c75a32aac81b@arm.com>
Date: Fri, 19 Oct 2018 09:49:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181018143042.29588-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 02/16] linux-headers: header update for
 KVM/ARM KVM_ARM_GET_MAX_VM_PHYS_SHIFT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com

Hi Eric,

On 10/18/2018 03:30 PM, Eric Auger wrote:
> This is a header update against kvmarm next branch
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm kvmarm/next
> 
> to get the KVM_ARM_GET_MAX_VM_PHYS_SHIFT ioctl. This allows to retrieve
> the IPA address range KVM supports.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - update against kvmarm next
> ---
>   linux-headers/linux/kvm.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 83ba4eb571..9647ce4fcb 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -750,6 +750,15 @@ struct kvm_ppc_resize_hpt {
>   
>   #define KVM_S390_SIE_PAGE_OFFSET 1
>   
> +/*
> + * On arm64, machine type can be used to request the physical
> + * address size for the VM. Bits[7-0] are reserved for the guest
> + * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> + * value 0 implies the default IPA size, 40bits.
> + */
> +#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
> +#define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
> +	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>   /*
>    * ioctls for /dev/kvm fds:
>    */
> @@ -953,6 +962,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_NESTED_STATE 157
>   #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
>   #define KVM_CAP_MSR_PLATFORM_INFO 159
> +#define KVM_CAP_ARM_VM_IPA_SIZE 160 /* returns maximum IPA bits for a VM */

Please be aware that there have been multiple merge conflicts with
the kvmarm-tree onto kvm tree upstream and the numbers have changed.
I assume that you will be rebasing this to mainline anyways.

Cheers
Suzuki
