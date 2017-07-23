Received: from eggs.gnu.org ([2001:4830:134:3::10]:52685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dZJmB-0004dS-5g
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dZJm8-0001dc-1h
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:30:39 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dZJm7-0001dH-SS
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:30:35 -0400
Received: by mail-qk0-x241.google.com with SMTP id q66so8126723qki.1
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:30:35 -0700 (PDT)
Date: Sun, 23 Jul 2017 12:30:33 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170723163033.GB28883@morn.lan>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-4-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500761510-1556-4-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/4] pci: add QEMU-specific PCI
 capability structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, marcel@redhat.com, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com

On Sun, Jul 23, 2017 at 01:11:49AM +0300, Aleksandr Bezzubikov wrote:
> On PCI init PCI bridge devices may need some
> extra info about bus number to reserve, IO, memory and
> prefetchable memory limits. QEMU can provide this
> with special vendor-specific PCI capability.
> 
> This capability is intended to be used only
> for Red Hat PCI bridges, i.e. QEMU cooperation.
> 
> Sizes of limits match ones from 
> PCI Type 1 Configuration Space Header,
> number of buses to reserve occupies only 1 byte 
> since it is the size of Subordinate Bus Number register.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  src/hw/pci_cap.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 src/hw/pci_cap.h
> 
> diff --git a/src/hw/pci_cap.h b/src/hw/pci_cap.h
> new file mode 100644
> index 0000000..1382b0b
> --- /dev/null
> +++ b/src/hw/pci_cap.h
> @@ -0,0 +1,23 @@
> +#ifndef _PCI_CAP_H
> +#define _PCI_CAP_H
> +
> +#include "types.h"
> +
> +struct vendor_pci_cap {
> +    u8 id;
> +    u8 next;
> +    u8 len;
> +};

Thanks.  If you respin this series, please add this header to the
src/fw/ directory instead of src/hw/.  Also, I'd prefer to avoid a
"pci_" prefix on the header as it makes it seem similar to the
existing pci_regs.h and pci_ids.h headers which are a bit different -
how about src/fw/dev-pci.h instead?

-Kevin
