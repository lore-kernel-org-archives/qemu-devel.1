Received: from eggs.gnu.org ([2001:4830:134:3::10]:47894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dEBci-0001S1-86
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dEBce-0000qv-9T
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:33:32 -0400
References: <20170526014614.19840-1-maozy.fnst@cn.fujitsu.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62e6e879-04d5-5549-e2e6-a3e45735b449@redhat.com>
Date: Fri, 26 May 2017 11:33:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170526014614.19840-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi/lsi53c895a: Remove unused lsi_mem_*()
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>



On 26/05/2017 03:46, Mao Zhongyi wrote:
> lsi_mem_read/write() always return 0 about which their
> callers actually don't care. Change the function type
> to void.
> 
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/scsi/lsi53c895a.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 595c260..3e56ab2 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -408,27 +408,25 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val);
>  static void lsi_execute_script(LSIState *s);
>  static void lsi_reselect(LSIState *s, lsi_request *p);
>  
> -static inline int lsi_mem_read(LSIState *s, dma_addr_t addr,
> +static inline void lsi_mem_read(LSIState *s, dma_addr_t addr,
>                                 void *buf, dma_addr_t len)
>  {
>      if (s->dmode & LSI_DMODE_SIOM) {
>          address_space_read(&s->pci_io_as, addr, MEMTXATTRS_UNSPECIFIED,
>                             buf, len);
> -        return 0;
>      } else {
> -        return pci_dma_read(PCI_DEVICE(s), addr, buf, len);
> +        pci_dma_read(PCI_DEVICE(s), addr, buf, len);
>      }
>  }
>  
> -static inline int lsi_mem_write(LSIState *s, dma_addr_t addr,
> +static inline void lsi_mem_write(LSIState *s, dma_addr_t addr,
>                                  const void *buf, dma_addr_t len)
>  {
>      if (s->dmode & LSI_DMODE_DIOM) {
>          address_space_write(&s->pci_io_as, addr, MEMTXATTRS_UNSPECIFIED,
>                              buf, len);
> -        return 0;
>      } else {
> -        return pci_dma_write(PCI_DEVICE(s), addr, buf, len);
> +        pci_dma_write(PCI_DEVICE(s), addr, buf, len);
>      }
>  }
>  
> 

Cc: qemu-trivial@nongnu.org
