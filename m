Received: from eggs.gnu.org ([2001:4830:134:3::10]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafwb-0005Qq-8A
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafwX-0005Zj-S4
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cafwX-0005Za-LF
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:50:41 -0500
References: <20170131114054.276.62201.stgit@PASHA-ISP>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9e89b38-c964-8c9d-19e0-ae8e88486d7b@redhat.com>
Date: Mon, 6 Feb 2017 10:50:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170131114054.276.62201.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] apic: reset apic_delivered global variable
 on machine reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: mst@redhat.com



On 31/01/2017 12:40, Pavel Dovgalyuk wrote:
> This patch adds call to apic_reset_irq_delivered when the virtual
> machine is reset.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  hw/intc/apic_common.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 17df24c..cda3e9c 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -251,6 +251,8 @@ static void apic_reset_common(DeviceState *dev)
>      s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
>      s->id = s->initial_apic_id;
>  
> +    apic_reset_irq_delivered();
> +
>      s->vapic_paddr = 0;
>      info->vapic_base_update(s);
>  
> 

Queued, thanks.

Paolo
