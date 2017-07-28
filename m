Received: from eggs.gnu.org ([2001:4830:134:3::10]:59016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbCCS-0000WQ-3h
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbCCR-000210-9m
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 16:49:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728131151.4802-1-olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a965a76e-3a63-e69c-18f1-dbfdc569cafd@amsat.org>
Date: Fri, 28 Jul 2017 17:49:21 -0300
MIME-Version: 1.0
In-Reply-To: <20170728131151.4802-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] xen-disk: use g_new0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>

Hi Olaf,

On 07/28/2017 10:11 AM, Olaf Hering wrote:
> g_malloc0_n is available since glib-2.24. To allow build with older glib
> versions use the generic g_new0, which is already used in many other
> places in the code.

Can you provide information about which 
distrib/release/version/[packages?] you used? So we might add the same 
setup in QEMU continuous integration system.

Thank,

Phil.

> 
> Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared rings")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>   hw/block/xen_disk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index d42ed7070d..536e2ee735 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice *xendev)
>           return -1;
>       }
>   
> -    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> +    domids = g_new0(uint32_t, blkdev->nr_ring_ref);
>       for (i = 0; i < blkdev->nr_ring_ref; i++) {
>           domids[i] = blkdev->xendev.dom;
>       }
> 
