Received: from eggs.gnu.org ([2001:4830:134:3::10]:51676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deot6-0004Yn-GS
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deot1-00047i-Ov
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:44:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170807203007.19033-1-eblake@redhat.com>
	<20170807203007.19033-4-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b5e019e-9ac1-4fe6-ad04-edd9060b7be7@amsat.org>
Date: Mon, 7 Aug 2017 17:44:13 -0300
MIME-Version: 1.0
In-Reply-To: <20170807203007.19033-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] qcow2: Drop debugging dump_refcounts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/07/2017 05:30 PM, Eric Blake wrote:
> It's been #if 0'd since its introduction in 2006, commit 585f8587.
> We can revive dead code if we need it, but in the meantime, it has
> bit-rotted (for example, not checking for failure in bdrv_getlength()).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> --- >   block/qcow2.c | 21 ---------------------
>   1 file changed, 21 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index d7c600b5a2..99407403ea 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3798,27 +3798,6 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>       return spec_info;
>   }
> 
> -#if 0
> -static void dump_refcounts(BlockDriverState *bs)
> -{
> -    BDRVQcow2State *s = bs->opaque;
> -    int64_t nb_clusters, k, k1, size;
> -    int refcount;
> -
> -    size = bdrv_getlength(bs->file->bs);
> -    nb_clusters = size_to_clusters(s, size);
> -    for(k = 0; k < nb_clusters;) {
> -        k1 = k;
> -        refcount = get_refcount(bs, k);
> -        k++;
> -        while (k < nb_clusters && get_refcount(bs, k) == refcount)
> -            k++;
> -        printf("%" PRId64 ": refcount=%d nb=%" PRId64 "\n", k, refcount,
> -               k - k1);
> -    }
> -}
> -#endif
> -
>   static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
>                                 int64_t pos)
>   {
> 
