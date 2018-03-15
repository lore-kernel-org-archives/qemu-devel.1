Received: from eggs.gnu.org ([2001:4830:134:3::10]:55358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRwT-0002aK-DU
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRwP-0000AZ-In
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:25:09 -0400
References: <20180315034507.6341-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f785963-825f-3512-d53f-e00010940499@redhat.com>
Date: Thu, 15 Mar 2018 07:24:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180315034507.6341-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vvfat: Fix inherit_options flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/14/2018 10:45 PM, Fam Zheng wrote:
> Overriding flags violates the precedence rules of
> bdrv_reopen_queue_child. Just like the read-only option, no-flush should
> be put into the options. The same is done in bdrv_temp_snapshot_options.
> 
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block/vvfat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/vvfat.c b/block/vvfat.c
> index 4a17a49e12..1569783b0f 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -3129,7 +3129,7 @@ static void vvfat_qcow_options(int *child_flags, QDict *child_options,
>                                  int parent_flags, QDict *parent_options)
>   {
>       qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "off");
> -    *child_flags = BDRV_O_NO_FLUSH;
> +    qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
>   }
>   
>   static const BdrvChildRole child_vvfat_qcow = {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
