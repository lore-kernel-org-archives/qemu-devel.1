Received: from eggs.gnu.org ([2001:4830:134:3::10]:59130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKk76-0008Js-T4
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKk72-00049q-IM
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:12:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKk71-0003o2-TG
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:12:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so21190493wrv.6
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 05:12:39 -0800 (PST)
References: <20181108122102.9915-1-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1898dc23-c512-88bd-cb73-5a2cffccd176@redhat.com>
Date: Thu, 8 Nov 2018 14:12:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181108122102.9915-1-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pci_bridge: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, "qemu-trivial@nongnu.org >> QEMU Trivial" <qemu-trivial@nongnu.org>

Cc'ing qemu-trivial@

On 8/11/18 13:21, Mao Zhongyi wrote:
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/pci/pci_bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index ee9dff2d3a..da8daa3ff2 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -310,7 +310,7 @@ void pci_bridge_reset(DeviceState *qdev)
>   
>       /*
>        * the default values for base/limit registers aren't specified
> -     * in the PCI-to-PCI-bridge spec. So we don't thouch them here.
> +     * in the PCI-to-PCI-bridge spec. So we don't touch them here.
>        * Each implementation can override it.
>        * typical implementation does
>        * zero base/limit registers or
> 
