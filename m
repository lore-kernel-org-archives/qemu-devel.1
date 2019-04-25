Received: from eggs.gnu.org ([209.51.188.92]:45823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnQ1-0000sq-M0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnH9-0002fU-2q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:55:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJnH7-0002b9-0m
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:55:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so1660362wrs.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 15:55:28 -0700 (PDT)
References: <20190419075625.24251-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c0ce7a39-9e9f-a7be-c73b-a9c2c05da3af@redhat.com>
Date: Fri, 26 Apr 2019 00:55:25 +0200
MIME-Version: 1.0
In-Reply-To: <20190419075625.24251-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 0/2] Fix ohci_die() and move PCI
 code to separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Hi Thomas,

On 4/19/19 9:56 AM, Thomas Huth wrote:
> First patch fixes a problem with ohci_die(), second patch moves PCI code into
> a separate file, so that the sysbus OHCI device can also be used without
> the dependency on the PCI code.
> 
> v2: Split the patch into two patches, one for the ohci_die() fix and one
>     for the PCI code movement.

Way cleaner. I wonder why you don't use a typedef for the void
(*ohci_die_fn)(struct OHCIState *) prototype.
Anyway to this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Thomas Huth (2):
>   hw/usb/hcd-ohci: Do not use PCI functions with sysbus devices in
>     ohci_die()
>   hw/usb/hcd-ohci: Move PCI-related code into a separate file
> 
>  hw/sh4/Kconfig        |   2 +-
>  hw/usb/Kconfig        |   6 +-
>  hw/usb/Makefile.objs  |   1 +
>  hw/usb/hcd-ohci-pci.c | 163 +++++++++++++++++++++++++++++++
>  hw/usb/hcd-ohci.c     | 219 ++++--------------------------------------
>  hw/usb/hcd-ohci.h     | 104 ++++++++++++++++++++
>  6 files changed, 293 insertions(+), 202 deletions(-)
>  create mode 100644 hw/usb/hcd-ohci-pci.c
>  create mode 100644 hw/usb/hcd-ohci.h
> 
