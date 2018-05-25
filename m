Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKPJ-0008Ge-O3
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKPG-0002NB-L8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:37:53 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKPG-0002Mk-H6
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:37:50 -0400
Received: by mail-qt0-x241.google.com with SMTP id q6-v6so8312497qtn.3
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 14:37:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-9-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e8b29543-149b-7d27-cb0c-f54e878ecc04@amsat.org>
Date: Fri, 25 May 2018 18:37:46 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-9-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/20] ioapic: fix up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> include files shouldn't have the "include/" part,
> that is implied.
> 
> Also, drop an unused include.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/ioapic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 36139a4..c45f073 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -28,9 +28,8 @@
>  #include "hw/i386/apic.h"
>  #include "hw/i386/ioapic.h"
>  #include "hw/i386/ioapic_internal.h"
> -#include "include/hw/pci/msi.h"
> +#include "hw/pci/msi.h"
>  #include "sysemu/kvm.h"
> -#include "target/i386/cpu.h"
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/i386/x86-iommu.h"
>  #include "trace.h"
> 
