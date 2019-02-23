Received: from eggs.gnu.org ([209.51.188.92]:50763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxevJ-0000bk-5u
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxevH-00006F-9B
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:33:29 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-10-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02137829-6f3e-2332-0188-a89212d40d68@redhat.com>
Date: Sat, 23 Feb 2019 15:33:14 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/10] blockdev: remove unused paio
 parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/22/19 6:06 PM, John Snow wrote:
> This field isn't present anymore.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/blockdev.c b/blockdev.c
> index 1aaadb6128..cbce44877d 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1255,7 +1255,6 @@ out_aio_context:
>   * @node: The name of the BDS node to search for bitmaps
>   * @name: The name of the bitmap to search for
>   * @pbs: Output pointer for BDS lookup, if desired. Can be NULL.
> - * @paio: Output pointer for aio_context acquisition, if desired. Can be NULL.
>   * @errp: Output pointer for error information. Can be NULL.
>   *
>   * @return: A bitmap object on success, or NULL on failure.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
