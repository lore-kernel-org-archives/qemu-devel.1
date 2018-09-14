Received: from eggs.gnu.org ([2001:4830:134:3::10]:59948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0pik-00026I-MK
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0pig-0003zo-Fq
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0pig-0003zF-7j
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:09:18 -0400
References: <1536901871-2729-1-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ecb463a8-fa41-be60-0b28-2814e50333ea@redhat.com>
Date: Fri, 14 Sep 2018 17:09:15 +0200
MIME-Version: 1.0
In-Reply-To: <1536901871-2729-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: edu: replace device name with macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, jslaby@suse.cz
Cc: qemu-devel@nongnu.org

On 14/09/2018 07:11, Li Qiang wrote:
> Just as other devices do.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/misc/edu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index df26a4d046..0687ffd343 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -30,7 +30,8 @@
>  #include "qemu/main-loop.h" /* iothread mutex */
>  #include "qapi/visitor.h"
>  
> -#define EDU(obj)        OBJECT_CHECK(EduState, obj, "edu")
> +#define TYPE_PCI_EDU_DEVICE "edu"
> +#define EDU(obj)        OBJECT_CHECK(EduState, obj, TYPE_PCI_EDU_DEVICE)
>  
>  #define FACT_IRQ        0x00000001
>  #define DMA_IRQ         0x00000100
> @@ -414,7 +415,7 @@ static void pci_edu_register_types(void)
>          { },
>      };
>      static const TypeInfo edu_info = {
> -        .name          = "edu",
> +        .name          = TYPE_PCI_EDU_DEVICE,
>          .parent        = TYPE_PCI_DEVICE,
>          .instance_size = sizeof(EduState),
>          .instance_init = edu_instance_init,
> 

Queued, thanks.

Paolo
