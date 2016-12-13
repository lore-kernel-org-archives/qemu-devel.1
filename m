Received: from eggs.gnu.org ([2001:4830:134:3::10]:34825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cGijk-0006MH-IK
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cGijg-0005a7-MU
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:47:00 -0500
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
	<1481585316-31612-4-git-send-email-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27f08088-fbfa-848b-ff25-a373918a48e4@redhat.com>
Date: Tue, 13 Dec 2016 09:46:51 +0100
MIME-Version: 1.0
In-Reply-To: <1481585316-31612-4-git-send-email-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] libqos: fix spapr qpci_map()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

A short patch description would be nice here.

On 13.12.2016 00:28, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  tests/libqos/pci-spapr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
> index 1e5d015..2043f1e 100644
> --- a/tests/libqos/pci-spapr.c
> +++ b/tests/libqos/pci-spapr.c
> @@ -193,8 +193,8 @@ QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
>      ret->pio.size = SPAPR_PCI_IO_WIN_SIZE;
>  
>      /* 32-bit portion of the MMIO window is at PCI address 2..4 GiB */
> -    ret->mmio32_cpu_base = SPAPR_PCI_BASE + SPAPR_PCI_MMIO32_WIN_SIZE;
> -    ret->mmio32.pci_base = 0x80000000; /* 2 GiB */
> +    ret->mmio32_cpu_base = SPAPR_PCI_BASE;
> +    ret->mmio32.pci_base = SPAPR_PCI_MMIO32_WIN_SIZE;
>      ret->mmio32.size = SPAPR_PCI_MMIO32_WIN_SIZE;

Not sure whether it is really right to use SPAPR_PCI_MMIO32_WIN_SIZE for
the pci_base? I mean, the WIN_SIZE could also be 1G for example, but the
base could still be at 2G ? IMHO it's better to keep the old value for
pci_base here.

 Thomas
