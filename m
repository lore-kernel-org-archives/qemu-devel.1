Received: from eggs.gnu.org ([2001:4830:134:3::10]:34793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7zY4-0002nB-1n
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7zY0-0008Eq-3T
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:27:08 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7zXz-0008ET-Ts
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:27:04 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 142so90214576wma.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 00:27:03 -0700 (PDT)
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508233918.9043-2-f4bug@amsat.org>
Date: Tue, 09 May 2017 08:27:47 +0100
Message-ID: <87mvam8p70.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/11] hw/net: removed obsolete comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/net/pcnet-pci.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
> index 0acf8a4879..bdb533436e 100644
> --- a/hw/net/pcnet-pci.c
> +++ b/hw/net/pcnet-pci.c
> @@ -38,14 +38,6 @@
>
>  #include "pcnet.h"
>
> -//#define PCNET_DEBUG
> -//#define PCNET_DEBUG_IO
> -//#define PCNET_DEBUG_BCR
> -//#define PCNET_DEBUG_CSR
> -//#define PCNET_DEBUG_RMD
> -//#define PCNET_DEBUG_TMD
> -//#define PCNET_DEBUG_MATCH
> -

I guess - although I notice there are some #if 0's in the file that
could be converted to proper non-bitrotting debug prints or removed as well.

>  #define TYPE_PCI_PCNET "pcnet"
>
>  #define PCI_PCNET(obj) \
> @@ -239,8 +231,6 @@ static const VMStateDescription vmstate_pci_pcnet = {
>      }
>  };
>
> -/* PCI interface */
> -

Was this intentional?

>  static const MemoryRegionOps pcnet_mmio_ops = {
>      .old_mmio = {
>          .read = { pcnet_mmio_readb, pcnet_mmio_readw, pcnet_mmio_readl },


--
Alex Bennée
