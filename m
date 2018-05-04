Received: from eggs.gnu.org ([2001:4830:134:3::10]:38605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fETSp-0000IR-T3
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fETSm-00057Q-QI
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:41:03 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fETSm-00055S-JN
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:41:00 -0400
Received: by mail-wr0-x244.google.com with SMTP id p18-v6so19752709wrm.1
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:41:00 -0700 (PDT)
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-58-git-send-email-mst@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ab437005-0e09-c5fb-c482-72bafda7a508@gmail.com>
Date: Fri, 4 May 2018 08:40:55 +0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-58-git-send-email-mst@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 57/67] kvm: use include "kvm_i386.h"
 consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 05/03/2018 10:51 PM, Michael S. Tsirkin wrote:
> Some places include kvm_i386.h, others target/i386/kvm_i386.h.
> Let's be consistent.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/i386/kvm/apic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
> index 1df6d26..ce43c3c 100644
> --- a/hw/i386/kvm/apic.c
> +++ b/hw/i386/kvm/apic.c
> @@ -16,7 +16,7 @@
>   #include "hw/pci/msi.h"
>   #include "sysemu/hw_accel.h"
>   #include "sysemu/kvm.h"
> -#include "target/i386/kvm_i386.h"
> +#include "kvm_i386.h"
>   
>   static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
>                                       int reg_id, uint32_t val)

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
