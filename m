Received: from eggs.gnu.org ([2001:4830:134:3::10]:49808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB0AE-0003AS-RR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB0AD-0005sP-Gz
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:19:46 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b68bd971-8da0-fb03-2943-c8fa370ba240@redhat.com>
Date: Fri, 12 Oct 2018 11:19:33 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] block: Update flags in
 bdrv_set_read_only()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/12/18 6:55 AM, Kevin Wolf wrote:
> To fully change the read-only state of a node, we must not only change
> bs->read_only, but also update bs->open_flags.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block.c b/block.c
> index 0d6e5f1a76..d7bd6d29b4 100644
> --- a/block.c
> +++ b/block.c
> @@ -281,6 +281,13 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
>       }
>   
>       bs->read_only = read_only;
> +
> +    if (read_only) {
> +        bs->open_flags &= ~BDRV_O_RDWR;
> +    } else {
> +        bs->open_flags |= BDRV_O_RDWR;
> +    }
> +
>       return 0;
>   }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
