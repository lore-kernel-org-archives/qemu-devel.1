Received: from eggs.gnu.org ([2001:4830:134:3::10]:44443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewmiB-00042N-Ed
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ewmi8-0007dO-9T
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:35:47 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1520849818-6915-2-git-send-email-anton.nefedov@virtuozzo.com>
References: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1520849818-6915-2-git-send-email-anton.nefedov@virtuozzo.com>
Date: Fri, 16 Mar 2018 11:35:05 +0100
Message-ID: <w51po44paue.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com

On Mon 12 Mar 2018 11:16:50 AM CET, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/mirror.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/block/mirror.c b/block/mirror.c
> index f5bf620..2fb786f 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1100,6 +1100,15 @@ static BlockDriver bdrv_mirror_top = {
>      .bdrv_child_perm            = bdrv_mirror_top_child_perm,
>  };
>  
> +static void mirror_top_set_supported_flags(BlockDriverState *bs)
> +{
> +    bs->supported_write_flags = BDRV_REQ_FUA &
> +        bs->backing->bs->supported_write_flags;
> +    bs->supported_zero_flags =
> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> +        bs->backing->bs->supported_zero_flags;
> +}
> +

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
