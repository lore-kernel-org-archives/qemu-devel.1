Received: from eggs.gnu.org ([2001:4830:134:3::10]:33153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eavcv-0006M8-1a
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eavcr-0005ZP-2H
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:40:01 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eavcq-0005Yo-Ss
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:39:57 -0500
Received: by mail-pg0-x242.google.com with SMTP id i196so7382942pgd.0
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 19:39:56 -0800 (PST)
References: <20180110190049.5389.12984.stgit@gimli.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8b8016fc-8177-424d-5370-b14e05011072@ozlabs.ru>
Date: Mon, 15 Jan 2018 14:39:52 +1100
MIME-Version: 1.0
In-Reply-To: <20180110190049.5389.12984.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] vfio/pci: MSI-X MMIO relocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, eric.auger@redhat.com

On 11/01/18 06:01, Alex Williamson wrote:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03350.html
> 
> See patch 5/5 for a thorough description.  v2 changes the 'auto'
> behavior as we've determined that there's no algorithm which has even
> a likely chance of success.  Instead, auto is now a placeholder for
> a device/platform lookup for known good combinations (though if I'm
> pessimistic, even that might depend on guest and driver versions).
> Thanks,



Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> 
> Alex
> 
> ---
> 
> Alex Williamson (5):
>       vfio/pci: Fixup VFIOMSIXInfo comment
>       vfio/pci: Add base BAR MemoryRegion
>       vfio/pci: Emulate BARs
>       qapi: Create DEFINE_PROP_OFF_AUTO_PCIBAR
>       vfio/pci: Allow relocating MSI-X MMIO
> 
> 
>  hw/core/qdev-properties.c    |   11 +++
>  hw/vfio/pci.c                |  175 ++++++++++++++++++++++++++++++++++++++----
>  hw/vfio/pci.h                |    6 +
>  hw/vfio/trace-events         |    2 
>  include/hw/qdev-properties.h |    4 +
>  qapi/common.json             |   26 ++++++
>  6 files changed, 206 insertions(+), 18 deletions(-)
> 


-- 
Alexey
