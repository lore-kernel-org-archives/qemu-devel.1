Received: from eggs.gnu.org ([209.51.188.92]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQl9-0001t4-5P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQl8-0005lU-AB
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:40:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hDQl6-0005kK-RR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:40:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id y7so15473686wrn.11
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:40:08 -0700 (PDT)
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-7-armbru@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0e6fed9f-a8c6-6dad-b27f-4eb62db8dd7e@gmail.com>
Date: Mon, 8 Apr 2019 11:41:07 +0300
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 06/15] pci: Report fatal errors with
 error_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>



On 4/8/19 11:36 AM, Markus Armbruster wrote:
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/pci/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 35451c1e99..a74995b596 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -927,7 +927,7 @@ static uint16_t pci_req_id_cache_extract(PCIReqIDCache *cache)
>           result = PCI_BUILD_BDF(bus_n, 0);
>           break;
>       default:
> -        error_printf("Invalid PCI requester ID cache type: %d\n",
> +        error_report("Invalid PCI requester ID cache type: %d",
>                        cache->type);
>           exit(1);
>           break;

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel
