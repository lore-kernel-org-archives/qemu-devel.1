Received: from eggs.gnu.org ([2001:4830:134:3::10]:47750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQiZi-0006NJ-0P
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQiZe-0007Jc-30
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:37:58 -0500
Date: Tue, 10 Jan 2017 00:37:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110003733-mutt-send-email-mst@kernel.org>
References: <1482459390-14386-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482459390-14386-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] pcie: remove duplicate assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, qemu-trivial@nongnu.org

On Fri, Dec 23, 2016 at 10:16:30AM +0800, Cao jin wrote:
> "size >= 8" connote "size > 0"
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Isn't the point to check for overflows?

> ---
>  hw/pci/pcie.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 39b10b852d91..f864c5cd5458 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -668,7 +668,6 @@ void pcie_add_capability(PCIDevice *dev,
>      uint16_t next;
>  
>      assert(offset >= PCI_CONFIG_SPACE_SIZE);
> -    assert(offset < offset + size);
>      assert(offset + size <= PCIE_CONFIG_SPACE_SIZE);
>      assert(size >= 8);
>      assert(pci_is_express(dev));
> -- 
> 2.1.0
> 
> 
