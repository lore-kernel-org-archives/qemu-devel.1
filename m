Received: from eggs.gnu.org ([2001:4830:134:3::10]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dHs9w-0004w9-L8
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dHs9t-0005FL-IZ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:35:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dHs9t-0005EM-DQ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:35:01 -0400
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<28378a4dc27a2694dfacf5254813d59175cda4e6.1496387804.git.maozy.fnst@cn.fujitsu.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <37b5f59f-8714-236e-a9b3-d57d96a0a143@redhat.com>
Date: Mon, 5 Jun 2017 16:34:53 +0300
MIME-Version: 1.0
In-Reply-To: <28378a4dc27a2694dfacf5254813d59175cda4e6.1496387804.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] pci: Add comment for
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

On 02/06/2017 10:54, Mao Zhongyi wrote:
> Add a comment for pci_add_capability2() to explain the return
> value. This may help to make a correct return value check for
> its callers.
> 
> Cc: mst@redhat.com
> Cc: marcel@redhat.com
> Cc: armbru@redhat.com
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>   hw/pci/pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 53566b8..9810d5f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2276,6 +2276,10 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>       return ret;
>   }
>   
> +/*
> + * On success, pci_add_capability2() returns a positive value.

Hi,
I would specify what is the return value: the offset of the pci capability.

Thanks,
Marcel

> + * On failure, it sets an error and returns a negative value.
> + */
>   int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
>                          uint8_t offset, uint8_t size,
>                          Error **errp)
> 
