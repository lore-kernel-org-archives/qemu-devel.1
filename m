Received: from eggs.gnu.org ([2001:4830:134:3::10]:38380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVCMV-0007aN-3k
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVCMR-00081i-Va
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:23:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gVCMR-00081B-OL
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:23:51 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-17-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <25ed4a45-0680-3c9a-5cb0-bdf538f4bfb2@redhat.com>
Date: Fri, 7 Dec 2018 10:23:46 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-17-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/71] tests/libqos: rename qpci_init_pc
 and qpci_init_spapr functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> Rename qpci_init_pc in qpci_pc_new and qpci_init_spapr in qpci_spapr_new,
> since theese function actually allocate a new pci struct and initialize it.

Matter of taste, I guess ... I'd also be fine if we keep "init" instead
of "new"... it's quite a bit of code churn ...

> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
> index 491eeac..84cc300 100644
> --- a/tests/libqos/pci-pc.h
> +++ b/tests/libqos/pci-pc.h
> @@ -16,7 +16,14 @@
>  #include "libqos/pci.h"
>  #include "libqos/malloc.h"
>  
> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
> +/* qpci_new_pc():
> +* this function creates a new QPCIBusPC object,

... but please add at least a white space at the beginning of the above
line.

> + * and properly initialize its fields.
> + *
> + * returns the QPCIBus *bus field of a newly
> + * allocated QPCIBusPC.
> + */
> +QPCIBus *qpci_new_pc(QTestState *qts, QGuestAllocator *alloc);
>  void     qpci_free_pc(QPCIBus *bus);

I'd prefer to drop this patch, but if you want to keep it:

Reviewed-by: Thomas Huth <thuth@redhat.com>
