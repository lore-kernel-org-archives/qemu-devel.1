Received: from eggs.gnu.org ([209.51.188.92]:56577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=912916edc=Andrew.Cooper3@citrix.com>)
	id 1gjpjz-0002ZE-E7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=912916edc=Andrew.Cooper3@citrix.com>)
	id 1gjpXW-0000CA-Lv
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:03:47 -0500
References: <20190116121350.23863-1-alex.bennee@linaro.org>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <c8f655ea-3c3b-290e-1bc2-8f7bb755f4af@citrix.com>
Date: Wed, 16 Jan 2019 18:03:20 +0000
MIME-Version: 1.0
In-Reply-To: <20190116121350.23863-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] hw/block/xen: use proper
 format string for printing sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On 16/01/2019 12:13, Alex Bennée wrote:
> The %lu format string is different depending on the host architecture
> which causes builds like the debian-armhf-cross build to fail. Use the
> correct PRi64 format string.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/block/xen-block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index be28b63442..a636487b3e 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -215,7 +215,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
>  
>      xen_device_backend_printf(xendev, "sector-size", "%u",
>                                conf->logical_block_size);
> -    xen_device_backend_printf(xendev, "sectors", "%lu",
> +    xen_device_backend_printf(xendev, "sectors", "%"PRIi64,

PRIu64.

You've changed the signed-ness of what gets printed.

~Andrew
