Received: from eggs.gnu.org ([2001:4830:134:3::10]:59383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cgBOc-0002V4-5v
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cgBOZ-0000BO-74
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:26:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cgBOZ-0000B4-1K
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:26:23 -0500
Date: Tue, 21 Feb 2017 16:26:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170221161840-mutt-send-email-mst@kernel.org>
References: <20170221122920.16245-1-pbonzini@redhat.com>
	<20170221122920.16245-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170221122920.16245-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] update Linux headers to 4.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, cornelia.huck@de.ibm.com

On Tue, Feb 21, 2017 at 01:29:20PM +0100, Paolo Bonzini wrote:
> diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
> index e5a2e68..174d114 100644
> --- a/include/standard-headers/linux/pci_regs.h
> +++ b/include/standard-headers/linux/pci_regs.h
> @@ -23,6 +23,14 @@
>  #define LINUX_PCI_REGS_H
>  
>  /*
> + * Conventional PCI and PCI-X Mode 1 devices have 256 bytes of
> + * configuration space.  PCI-X Mode 2 and PCIe devices have 4096 bytes of
> + * configuration space.
> + */
> +#define PCI_CFG_SPACE_SIZE	256
> +#define PCI_CFG_SPACE_EXP_SIZE	4096
> +

Oh nice, we can drop PCI_CONFIG_SPACE_SIZE and PCIE_CONFIG_SPACE_SIZE now.


> +/*
>   * Under PCI, each device has 256 bytes of configuration address space,
>   * of which the first 64 bytes are standardized as follows:
>   */
