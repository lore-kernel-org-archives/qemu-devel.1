Received: from eggs.gnu.org ([2001:4830:134:3::10]:33384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dMtgU-0000uE-69
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dMtgQ-0003oK-7I
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dMtgQ-0003mg-0c
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:13:22 -0400
References: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
	<419cb616b32171046db02617863b55dec93fdc3f.1497272778.git.maozy.fnst@cn.fujitsu.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <5b1cbb1a-8762-3af3-ba8e-9fac2c60d13d@redhat.com>
Date: Mon, 19 Jun 2017 13:13:13 +0300
MIME-Version: 1.0
In-Reply-To: <419cb616b32171046db02617863b55dec93fdc3f.1497272778.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/9] pci: Add comment for
 pci_add_capability2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, armbru@redhat.com

On 12/06/2017 16:48, Mao Zhongyi wrote:
> Comments for pci_add_capability2() to explain the return
> value. This may help to make a correct return value check
> for its callers.
> 
> Cc: mst@redhat.com
> Cc: marcel@redhat.com
> Cc: armbru@redhat.com
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>   hw/pci/pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 53566b8..b73bfea 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2276,6 +2276,12 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>       return ret;
>   }
>   
> +/*
> + * On success, pci_add_capability2() returns a positive value
> + * that the offset of the pci capability.
> + * On failure, it sets an error and returns a negative error
> + * code.
> + */
>   int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
>                          uint8_t offset, uint8_t size,
>                          Error **errp)
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
