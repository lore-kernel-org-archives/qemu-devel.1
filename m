Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cVjy4-0006X3-I6
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cVjy1-0004RX-CJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:07:52 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1cVjy1-0004Qj-4w
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:07:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so28596643wmr.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:07:47 -0800 (PST)
Reply-To: marcel@redhat.com
References: <1484859633-24889-1-git-send-email-mst@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <f6751d6e-9cbe-6b28-abc1-8d13efea2e3e@gmail.com>
Date: Mon, 23 Jan 2017 21:07:41 +0200
MIME-Version: 1.0
In-Reply-To: <1484859633-24889-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: mark ROMs read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

On 01/19/2017 11:00 PM, Michael S. Tsirkin wrote:
> Looks like we didn't mark PCI ROMs as RO allowing
> mischief such as guests writing there.
> Further, e.g. vhost gets confused trying to allocate
> enough space to log writes there. Fix it up.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 637d545..eaac185 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2199,7 +2199,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>          snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
>      }
>      pdev->has_rom = true;
> -    memory_region_init_ram(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
> +    memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
>      vmstate_register_ram(&pdev->rom, &pdev->qdev);
>      ptr = memory_region_get_ram_ptr(&pdev->rom);
>      load_image(path, ptr);
>


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>


Thanks,
Marcel
