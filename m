Received: from eggs.gnu.org ([209.51.188.92]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw97D-0006bF-1b
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw97B-0003Id-70
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:23:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw97A-0003Fs-Bk
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:23:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so8449337wre.10
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:23:27 -0800 (PST)
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c633e9de-7219-57a8-0530-079034e4e6f2@redhat.com>
Date: Tue, 19 Feb 2019 18:23:25 +0100
MIME-Version: 1.0
In-Reply-To: <1550592459-7286-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, yang.zhong@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On 2/19/19 5:07 PM, Thomas Huth wrote:
> Some machines have an AHCI adapter, but no PCI. To be able to
> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
> functions msi_enabled() and msi_notify() for linking.
> This is required for the upcoming Kconfig-like build system, if
> a user wants to compile a QEMU binary with just one machine that
> has AHCI, but no PCI, like the ARM "cubieboard" for example.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
> 
