Received: from eggs.gnu.org ([2001:4830:134:3::10]:43827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYJ7-0002uZ-Va
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYJ4-0001xm-Ne
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:35:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAYJ4-0001wJ-GQ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:35:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so9084166wrb.6
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 03:35:02 -0700 (PDT)
References: <20181011082508.29014-1-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e8a3e14b-3bac-603f-74c5-fa77b1bc26c2@redhat.com>
Date: Thu, 11 Oct 2018 12:34:59 +0200
MIME-Version: 1.0
In-Reply-To: <20181011082508.29014-1-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pci_bridge: fix typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 11/10/2018 10:25, Mao Zhongyi wrote:
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/pci/pci_bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 90f7208856..da8daa3ff2 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -399,7 +399,7 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
>  
>  /*
>   * before qdev initialization(qdev_init()), this function sets bus_name and
> - * map_irq callback which are necessry for pci_bridge_initfn() to
> + * map_irq callback which are necessary for pci_bridge_initfn() to
>   * initialize bus.
>   */
>  void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
> 
