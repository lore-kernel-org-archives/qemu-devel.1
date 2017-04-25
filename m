Received: from eggs.gnu.org ([2001:4830:134:3::10]:55738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d2sjj-0005MH-1N
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d2sjf-0000Fp-Ki
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:10:03 -0400
References: <58FEB4A2.8070900@huawei.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <047de7e9-36fe-4633-6e52-b3000699d2f8@redhat.com>
Date: Tue, 25 Apr 2017 08:09:53 +0300
MIME-Version: 1.0
In-Reply-To: <58FEB4A2.8070900@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: deassert intx when pci device
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "wangxinxin.wang@huawei.com >> wangxin (U)" <wangxinxin.wang@huawei.com>

On 04/25/2017 05:29 AM, Herongguang (Stephen) wrote:
> If a pci device is not reset by VM (by writing into config space)
> and unplugged by VM, after that when VM reboots, qemu may assert:
> pcibus_reset: Assertion `bus->irq_count[i] == 0' failed
>
> Signed-off-by: herongguang <herongguang.he@huawei.com>
> ---
>  hw/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 259483b..98ccc27 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1083,6 +1083,7 @@ static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
>          pc->exit(pci_dev);
>      }
>
> +    pci_device_deassert_intx(pci_dev);
>      do_pci_unregister_device(pci_dev);
>  }
>
> --
> 1.7.12.4



Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
