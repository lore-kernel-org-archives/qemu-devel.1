Received: from eggs.gnu.org ([2001:4830:134:3::10]:55208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcT8-0001Qr-OG
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAcT2-0006Jt-Ve
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:01:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAcT2-0006Gt-N9
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:01:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id y11-v6so9319742wma.3
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 08:01:33 -0700 (PDT)
References: <20181011144451.38042-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <309fcca7-47bb-56a2-3bfb-1b4a4b540603@redhat.com>
Date: Thu, 11 Oct 2018 17:01:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181011144451.38042-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] piix_pci: change the i440fx data sheet link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org

Hi Li,

On 11/10/2018 16:44, Li Qiang wrote:
> Seems the intel link is unavailable, change it to qemu site.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/pci-host/piix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 0e608347c1..e709abeb08 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -40,7 +40,7 @@
>  
>  /*
>   * I440FX chipset data sheet.
> - * http://download.intel.com/design/chipsets/datashts/29054901.pdf
> + * https://wiki.qemu.org/images/b/bb/29054901.pdf

Good idea, but please use: https://wiki.qemu.org/File:29054901.pdf

With this change:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   */
>  
>  #define I440FX_PCI_HOST_BRIDGE(obj) \
> 

Thanks,

Phil.
