Received: from eggs.gnu.org ([2001:4830:134:3::10]:48906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIzbx-0003sP-0e
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIzbv-0002m5-UT
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:49:09 -0400
References: <20180516161034.27440-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ac43126-279f-899d-7cd0-729230b33b97@redhat.com>
Date: Wed, 16 May 2018 11:49:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180516161034.27440-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nfs: Fix error path in
 nfs_options_qdict_to_qapi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 05/16/2018 11:10 AM, Kevin Wolf wrote:
> Don't throw away local_err, but propagate it to errp.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/nfs.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/nfs.c b/block/nfs.c
> index d6364d28bb..3349b67a76 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -571,6 +571,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
>       qobject_unref(crumpled);
>   
>       if (local_err) {
> +        error_propagate(errp, local_err);
>           return NULL;
>       }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
