Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK56c-0002VV-TR
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK56b-0001Lw-OU
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:21:02 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <074d9978-e217-0dc4-a42b-6b3a401b3be1@redhat.com>
Date: Wed, 29 Nov 2017 10:20:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/17] block/vmdk: Fix , instead of ;
 at end of line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On 11/22/2017 08:08 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/vmdk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

No semantic difference as far as I can tell, but avoiding needless use 
of the comma operator is always a win in my book.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index c665bcc977..1ae47b1c2e 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1398,7 +1398,7 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
>           qemu_iovec_concat(&local_qiov, qiov, qiov_offset, n_bytes);
>       }
>   
> -    write_offset = cluster_offset + offset_in_cluster,
> +    write_offset = cluster_offset + offset_in_cluster;
>       ret = bdrv_co_pwritev(extent->file, write_offset, n_bytes,
>                             &local_qiov, 0);
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
