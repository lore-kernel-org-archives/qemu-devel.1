Received: from eggs.gnu.org ([209.51.188.92]:34127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj06f-0000id-Rr
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj06f-0003kF-7m
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:08:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj06d-0003Vb-8Z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:08:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so8386463wmc.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 03:08:26 -0800 (PST)
References: <20190111020849.22674-1-liq3ea@gmail.com>
	<20190111020849.22674-2-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c166eb4e-eb85-8e6d-c0ee-32ad74e40031@redhat.com>
Date: Mon, 14 Jan 2019 12:08:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190111020849.22674-2-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] nvme: use TYPE_NVME instead of
 constant string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 1/11/19 3:08 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 7c8c63e8f5..f206391e8e 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1381,7 +1381,7 @@ static void nvme_instance_init(Object *obj)
>  }
>  
>  static const TypeInfo nvme_info = {
> -    .name          = "nvme",
> +    .name          = TYPE_NVME,
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(NvmeCtrl),
>      .class_init    = nvme_class_init,
> 
