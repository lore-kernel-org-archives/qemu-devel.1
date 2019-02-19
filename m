Received: from eggs.gnu.org ([209.51.188.92]:49404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwBrI-0005EZ-6D
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwBrH-0000mE-Ep
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:19:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwBrH-0000le-AU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:19:15 -0500
Received: by mail-qk1-f194.google.com with SMTP id i5so481367qkd.13
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:19:13 -0800 (PST)
Date: Tue, 19 Feb 2019 15:19:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190219151825-mutt-send-email-mst@kernel.org>
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550592459-7286-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pci/pci-stub: Add msi_enabled() and
 msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com

On Tue, Feb 19, 2019 at 05:07:39PM +0100, Thomas Huth wrote:
> Some machines have an AHCI adapter, but no PCI. To be able to
> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
> functions msi_enabled() and msi_notify() for linking.
> This is required for the upcoming Kconfig-like build system, if
> a user wants to compile a QEMU binary with just one machine that
> has AHCI, but no PCI, like the ARM "cubieboard" for example.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Do you want me to merge this or do you prefer to
merge it with kconfig patches?

> ---
>  hw/pci/pci-stub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index b941a0e..c04a5df 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -53,3 +53,14 @@ uint16_t pci_requester_id(PCIDevice *dev)
>      g_assert(false);
>      return 0;
>  }
> +
> +/* Required by ahci.c */
> +bool msi_enabled(const PCIDevice *dev)
> +{
> +    return false;
> +}
> +
> +void msi_notify(PCIDevice *dev, unsigned int vector)
> +{
> +    g_assert_not_reached();
> +}
> -- 
> 1.8.3.1
