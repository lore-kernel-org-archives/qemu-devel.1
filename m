Received: from eggs.gnu.org ([2001:4830:134:3::10]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRwy-0002uh-Eu
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRwx-0001Fc-IU
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:25:40 -0400
References: <20180315035157.6929-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7bcc631c-b52b-d098-a19e-661534d53057@redhat.com>
Date: Thu, 15 Mar 2018 07:25:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180315035157.6929-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Fix leak of ignore_children in
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/14/2018 10:51 PM, Fam Zheng wrote:
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block.c b/block.c
> index 75a9fd49de..c1fda9fd57 100644
> --- a/block.c
> +++ b/block.c
> @@ -3671,12 +3671,12 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
>           GSList *ignore_children = g_slist_prepend(NULL, c);
>           bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
>                                  ignore_children, &local_err);
> +        g_slist_free(ignore_children);
>           if (local_err) {
>               ret = -EPERM;
>               error_report_err(local_err);
>               goto exit;
>           }
> -        g_slist_free(ignore_children);
>   
>           /* If so, update the backing file path in the image file */
>           if (c->role->update_filename) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
