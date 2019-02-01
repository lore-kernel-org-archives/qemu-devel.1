Received: from eggs.gnu.org ([209.51.188.92]:53853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpftL-0002FC-1W
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpftF-0005R7-52
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:58:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gpftC-0005Lj-RH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 15:58:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so7445321wmh.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 12:58:15 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-43-git-send-email-pbonzini@redhat.com>
	<a67e6380-daf5-62d1-0f37-45f7015cc0fa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe78d357-c2aa-64a7-4199-27351fe67167@redhat.com>
Date: Fri, 1 Feb 2019 21:58:12 +0100
MIME-Version: 1.0
In-Reply-To: <a67e6380-daf5-62d1-0f37-45f7015cc0fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 42/52] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhong@intel.com, thuth@redhat.com

On 01/02/19 16:05, Philippe Mathieu-Daudé wrote:
> This lacks a DISPLAY dependency?
> 
> $ i386-softmmu/qemu-system-i386 -M q35
> qemu-system-i386: Unknown device 'VGA' for bus 'PCIE'
> Aborted (core dumped)

If you build --without-default-devices, you pretty much have to do one
of two things: 1) enable some devices yourself; 2) always run QEMU with
-nodefaults.

Paolo

> PCIDevice *pci_vga_init(PCIBus *bus)
> {
>     switch (vga_interface_type) {
>     case VGA_CIRRUS:
>         return pci_create_simple(bus, -1, "cirrus-vga");
>     case VGA_QXL:
>         return pci_create_simple(bus, -1, "qxl-vga");
>     case VGA_STD:
>         return pci_create_simple(bus, -1, "VGA");
>     case VGA_VMWARE:
>         return pci_create_simple(bus, -1, "vmware-svga");
>     case VGA_VIRTIO:
>         return pci_create_simple(bus, -1, "virtio-vga");
>     case VGA_NONE:
>     default: /* Other non-PCI types. Checking for unsupported types is
> already
>                 done in vl.c. */
>         return NULL;
>     }
> }
> 
> If so, how to express "at least one of *TYPE"?
> 
