Received: from eggs.gnu.org ([2001:4830:134:3::10]:46159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cPQJ8-0006By-PP
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cPQJ5-0007yR-IG
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:55:30 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:52334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cPQJ5-0007v6-9Y
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:55:27 -0500
References: <20170106083956.53d08923@thl530>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <edd5bc48-4893-5fb0-3381-e3c83ebc9b5a@vivier.eu>
Date: Fri, 6 Jan 2017 09:55:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170106083956.53d08923@thl530>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] m68k: Remove PCI and USB from config file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, QEMU Developers <qemu-devel@nongnu.org>

Le 06/01/2017 à 08:39, Thomas Huth a écrit :
> None of the ColdFire boards that we currently support has a PCI or
> USB bus (and AFAIK the upcoming q800 machine does not support PCI
> and USB either), so we do not need these settings the config file.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  default-configs/m68k-softmmu.mak | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
> index d9552df..60f7cdf 100644
> --- a/default-configs/m68k-softmmu.mak
> +++ b/default-configs/m68k-softmmu.mak
> @@ -1,6 +1,4 @@
>  # Default configuration for m68k-softmmu
>  
> -include pci.mak
> -include usb.mak
>  CONFIG_COLDFIRE=y
>  CONFIG_PTIMER=y
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

I apply it to m68k-for-2.9 branch.

Thanks,
Laurent
