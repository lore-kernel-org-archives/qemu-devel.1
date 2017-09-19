Received: from eggs.gnu.org ([2001:4830:134:3::10]:35386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duGGM-0004B9-7b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duGGG-0007Bz-QG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:00:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170919094841.29522-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6f240142-ff0f-cfb0-730a-a6e7499345e0@amsat.org>
Date: Tue, 19 Sep 2017 08:00:06 -0300
MIME-Version: 1.0
In-Reply-To: <20170919094841.29522-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] nvme: fix cmbuf leak on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org

Hi Stefan,

On 09/19/2017 06:48 AM, Stefan Hajnoczi wrote:
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/block/nvme.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 9aa32692a3..513ec7065d 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1057,6 +1057,7 @@ static void nvme_exit(PCIDevice *pci_dev)
>       g_free(n->namespaces);
>       g_free(n->cq);
>       g_free(n->sq);
> +    g_free(n->cmbuf);

I'd move it 1 line below,

>       if (n->cmbsz) {

here:
             g_free(n->cmbuf);

>           memory_region_unref(&n->ctrl_mem);
>       }
> 

Anyway g_free() handles NULL, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
